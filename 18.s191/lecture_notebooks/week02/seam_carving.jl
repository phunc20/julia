using Images, ImageView, Statistics

function draw_seam(img, seam)
  img_w_seam = copy(img)
  for i = 1:size(img)[1]
    img_w_seam[i, seam[i]] = RGB(1,1,1)
  end
  return img_w_seam
end

function write_image(img, i: filebase="out")
  save(filebase*lpad(string(i), 5 ,string(0))*".png", img)
end

function brightness(img_element::AbstractRGB)
  return mean(img_element.r, img_element.g, img_element.b)
end

function find_energy(img)
  missing
end

function find_energy_map(energy)
  missing
end

function find_seam(energy)
  missing
end

function remove_seam(img, seam)
  img_resolution = (size(img)[1], size(img)[2]-1)
end


function draw_seam(img, seam)
end


function draw_seam(img, seam)
end

