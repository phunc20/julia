import numpy as np
import matplotlib.pyplot as plt

sobelX = np.array(
    [[1,0,-1],
     [2,0,-2],
     [1,0,-1],
    ],
    dtype=np.int32,
    #dtype=np.float32,
)
sobelY = sobelX.T

def square_window(M, row, col, side=3):
    """
    Instead of constructing the padded ndarray in the energy() function,
    maybe(?) it's more beneficial to construct just the window?
    """
    pass

def energy(M):
    """
    args
    M, ndarray
      is an RGB image, i.e. of shape (h, w, 3)

    return
    E, ndarray
      the energy image of shape (h, w)
    """
    rgb_sum = np.sum(M, axis=-1)
    n_rows, n_cols = rgb_sum.shape
    padded = np.pad(rgb_sum, ((1,1), (1,1)))
    E = np.empty_like(rgb_sum)
    #for i in range(1, n_rows+1):
    for i in range(n_rows):
        #for j in range(1, n_cols+1):
        for j in range(n_cols):
            window = padded[i:i+3, j:j+3]
            xenergy = np.sum(sobelX * window)
            yenergy = np.sum(sobelY * window)
            E[i, j] = np.sqrt(xenergy**2 + yenergy**2)
    return E

def smallest_underneaths(A, row, col):
    """
    By "underneaths", I mean the 2-3 pixels right underneath (i.e. on the row beneath) the pixel A[row, col].
    We shall return the column index of the pixel with smallest value.

    Maybe I should say "entry" instead of "pixel".
    """
    n_rows, n_cols = A.shape
    assert (0 <= row < n_rows - 1 and 0 <= col <= n_cols - 1)
    # collect pairs (column_index, value)
    underneaths = [ (c, A[row+1, c]) for c in range(max(0, col-1), min(col+2, n_cols))]
    # sort them
    ascending_underneaths = sorted(underneaths, key=lambda t: t[1])
    # return the pair with smallest value
    return ascending_underneaths[0]

def minimal_energy_to_bottom(E):
    """
    args
    image, ndarray
      of shape (m,n,3), an RGB image
    E, ndarray
      energy matrix, of shape (h, w)
    """
    if E.ndim == 3:
        E = energy(E)
    #def updated_energy(A, row, col):
    #    n_rows, n_cols = A.shape
    #    underneaths = [ A[row+1, c] for c in range(max(0, col-1), min(col+2, n_cols))]
    #    return A[row, col] + min(underneaths)
    ME = E.copy()
    n_rows, n_cols = E.shape
    for i in range(n_rows-2,-1,-1):
        for j in range(n_cols):
            #ME[i, j] = updated_energy(ME, i, j)
            ME[i, j] += smallest_underneaths(ME, i, j)[1]
    return ME

def find_seam(ME):
    """
    args
    ME, ndarray
      minimal energy matrix, of shape (h, w)

    return
    col_numbers, list
    list of integers which are those column indices to be removed
    """
    n_rows = ME.shape[0]
    #col_numbers = np.empty(n_rows, dtype=np.uint64)
    col_numbers = np.empty(n_rows, dtype=np.int32)
    col_numbers[0] = np.argmin(ME[0])
    for i in range(1, n_rows):
        col_numbers[i] = smallest_underneaths(ME, i-1, col_numbers[i-1])[0]
    return col_numbers

def draw_seam(image, color=[128,0,128]):
    tmp_image = image.copy()
    ME = minimal_energy_to_bottom(tmp_image)
    col_numbers = find_seam(ME)
    tmp_image[list(range(len(col_numbers))), col_numbers] =  color
    plt.imshow(tmp_image)
    #return tmp_image

def rm_in_each_row(image, col_numbers):
    """
    args
      image, ndarray
      of shape (m, n). Think of this as the energy matrix above.

      col_numbers, list
      a list of integers storing the column indices to be removed in each row,
      e.g. for row=j, column col_numbers[j] should removed.

    return
      image_, ndarray
      of shape (m, n-1), which is the same as `image` except that [range(m), col_numbers] are removed

    N.B. To ensure the shape (m, n-1) of `image_`, we have to require that len(col_numbers) equals m
    """
    n_rows, n_cols = image.shape[:2]
    assert (len(col_numbers) == n_rows)
    ## The 1st of the three next lines is the fastest implementation.
    ## The remaining two take almost the same amount of time.
    #image_ = np.empty((n_rows, n_cols-1))
    #image_ = np.empty((n_rows, n_cols-1), dtype=image.dtype)
    image_ = np.empty_like(image)[:, :-1]
    for i, j in enumerate(col_numbers):
        image_[i, :j] = image[i, :j]
        image_[i, j:] = image[i, j+1:]
    return image_


def liquidify(image, n):
    tmp_image = image.copy()
    for _ in range(n):
        ME = minimal_energy_to_bottom(tmp_image)
        col_numbers = find_seam(ME)
        tmp_image = rm_in_each_row(tmp_image, col_numbers)
    plt.figure(figsize=(7,7))
    plt.subplot(2,1,1)
    plt.imshow(image)
    plt.title(f"original: {image.shape[0]}x{image.shape[1]}")
    #plt.axis("off")
    plt.subplot(2,1,2)
    plt.imshow(tmp_image)
    plt.title(f"seam-carved: {tmp_image.shape[0]}x{tmp_image.shape[1]}")

    ## Using subplots()
    ##fig, (ax1, ax2) = plt.subplots(2, 1, sharex=True, figsize=(10,10))
    #fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10,10))
    #plt.tight_layout()
    #ax1.imshow(image)
    #ax2.imshow(tmp_image)




