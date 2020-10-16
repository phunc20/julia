### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ c60d7cd4-0b10-11eb-2963-b9423a51cb57
using Statistics

# ╔═╡ 7dbb6dda-0b15-11eb-213d-b1e201ce502b
using Colors

# ╔═╡ b6e11514-0d3a-11eb-0275-97c49ed16cbe
using LinearAlgebra

# ╔═╡ 83eb9ca0-ed68-11ea-0bc5-99a09c68f867
md"_homework 1, version 4_"

# ╔═╡ ac8ff080-ed61-11ea-3650-d9df06123e1f
md"""

# **Homework 1** - _convolutions_
`18.S191`, fall 2020

This notebook contains _built-in, live answer checks_! In some exercises you will see a coloured box, which runs a test case on your code, and provides feedback based on the result. Simply edit the code, run it, and the check runs again.

_For MIT students:_ there will also be some additional (secret) test cases that will be run as part of the grading process, and we will look at your notebook and write comments.

Feel free to ask questions!
"""

# ╔═╡ 911ccbce-ed68-11ea-3606-0384e7580d7c
# edit the code below to set your name and kerberos ID (i.e. email without @mit.edu)

student = (name = "phunc20", kerberos_id = "coz")

# press the ▶ button in the bottom right of this cell to run your edits
# or use Shift+Enter

# you might need to wait until all other cells in this notebook have completed running. 
# scroll down the page to see what's up

# ╔═╡ 8ef13896-ed68-11ea-160b-3550eeabbd7d
md"""

Submission by: **_$(student.name)_** ($(student.kerberos_id)@mit.edu)
"""

# ╔═╡ 5f95e01a-ee0a-11ea-030c-9dba276aba92
md"_Let's create a package environment:_"

# ╔═╡ 65780f00-ed6b-11ea-1ecf-8b35523a7ac0
begin
	import Pkg
	Pkg.activate(mktempdir())
end

# ╔═╡ 74b008f6-ed6b-11ea-291f-b3791d6d1b35
begin
	Pkg.add(["Images", "ImageMagick"])
	using Images
end

# ╔═╡ 6b30dc38-ed6b-11ea-10f3-ab3f121bf4b8
begin
	Pkg.add("PlutoUI")
	using PlutoUI
end

# ╔═╡ 67461396-ee0a-11ea-3679-f31d46baa9b4
md"_We set up Images.jl again:_"

# ╔═╡ 540ccfcc-ee0a-11ea-15dc-4f8120063397
md"""
## **Exercise 1** - _Manipulating vectors (1D images)_

A `Vector` is a 1D array. We can think of that as a 1D image.

"""

# ╔═╡ 467856dc-eded-11ea-0f83-13d939021ef3
example_vector = [0.5, 0.4, 0.3, 0.2, 0.1, 0.0, 0.7, 0.0, 0.7, 0.9]

# ╔═╡ 680fe220-086b-11eb-39b3-ff3e5123a8da
size(example_vector)

# ╔═╡ 74aded2e-086b-11eb-2732-5dae3a8fca89
size([1;2;3;4])

# ╔═╡ 7f00d2b6-086b-11eb-3f7c-0d23b3e577f0
hcat([1,2,3,4])

# ╔═╡ 859699f8-086b-11eb-32c4-378c0c0cc4b5
hcat([1;2;3;4])

# ╔═╡ 98cbaf2c-086b-11eb-10ee-d3e4d30e7bea
Array([1,2,3,4])

# ╔═╡ a3f5e6c2-086b-11eb-38d3-3d12729a8915
Array([1;2;3;4])

# ╔═╡ ad6a33b0-eded-11ea-324c-cfabfd658b56
md"#### Exerise 1.1
👉 Make a random vector `random_vect` of length 10 using the `rand` function.
"

# ╔═╡ b6a9e1ee-086b-11eb-1782-cb51775e9890
?rand

# ╔═╡ f51333a6-eded-11ea-34e6-bfbb3a69bcb0
#random_vect = random(10)

# ╔═╡ cd4a90ec-086b-11eb-293e-a19aa25d2635
random_vect = rand(10)

# ╔═╡ 4a151564-086c-11eb-380a-a5e96d11e49b
typemin(Int)

# ╔═╡ 74166fd4-086c-11eb-3c4b-356dfdb62c67
typemax(Int8)

# ╔═╡ 6d149262-086c-11eb-3e75-a73466c9815c
typemax(Int8)

# ╔═╡ 53e22386-086c-11eb-2465-7d513d28f3a2
typemin(Float32)

# ╔═╡ 66cc93a0-086c-11eb-308a-37256d25b79f
typemax(Float32)

# ╔═╡ cf738088-eded-11ea-2915-61735c2aa990
md"👉 Make a function `mean` using a `for` loop, which computes the mean/average of a vector of numbers."

# ╔═╡ b551707c-086c-11eb-15b2-01c6288c6832
?length

# ╔═╡ 0ffa8354-edee-11ea-2883-9d5bfea4a236
function mean(x)
    s = 0
    for i in 1:length(x)
        s += x[i]
	end
    return s / length(x)
end

# ╔═╡ 1f104ce4-ee0e-11ea-2029-1d9c817175af
mean([1, 2, 3])

# ╔═╡ 11cd8e30-086d-11eb-3d56-d9e428ac9506
7 / 3

# ╔═╡ 116aa5ca-086d-11eb-39ca-3bf8a5cf18d4
7 ÷ 3

# ╔═╡ 20a41974-086d-11eb-3793-d71d91df3c05
7 // 3

# ╔═╡ 2758613a-086d-11eb-382e-95870f209e6c
7 % 3

# ╔═╡ 1f229ca4-edee-11ea-2c56-bb00cc6ea53c
md"👉 Define `m` to be the mean of `random_vect`."

# ╔═╡ 2a391708-edee-11ea-124e-d14698171b68
m = mean(random_vect)

# ╔═╡ e2863d4c-edef-11ea-1d67-332ddca03cc4
md"""👉 Write a function `demean`, which takes a vector `x` and subtracts the mean from each value in `x`."""

# ╔═╡ 83988c86-086d-11eb-0857-bbba6d29df78
[1,2,3] - 3

# ╔═╡ 896a6382-086d-11eb-2298-77e373745071
[1,2,3] .- 3

# ╔═╡ ec5efe8c-edef-11ea-2c6f-afaaeb5bc50c
function demean(x)
	return x .- mean(x)
end

# ╔═╡ 29e10640-edf0-11ea-0398-17dbf4242de3
md"Let's check that the mean of the `demean(random_vect)` is 0:

_Due to floating-point round-off error it may *not* be *exactly* 0._"

# ╔═╡ 6f67657e-ee1a-11ea-0c2f-3d567bcfa6ea
if ismissing(random_vect)
	md"""
	!!! info
	    The following cells error because `random_vect` is not yet defined. Have you done the first exercise?
	"""
end

# ╔═╡ 73ef1d50-edf0-11ea-343c-d71706874c82
copy_of_random_vect = copy(random_vect); # in case demean modifies `x`

# ╔═╡ 38155b5a-edf0-11ea-3e3f-7163da7433fb
mean(demean(copy_of_random_vect))

# ╔═╡ a5f8bafe-edf0-11ea-0da3-3330861ae43a
md"""
#### Exercise 1.2

👉 Generate a vector of 100 zeros. Change the center 20 elements to 1.
"""

# ╔═╡ 1b8b2e0c-086e-11eb-08cd-1b0b39167cc9
zeros(100)

# ╔═╡ e8e678c2-086e-11eb-3b2d-491c155288ce
rand(10)[3:5]

# ╔═╡ f791ade4-086e-11eb-27ee-b9f2fd4df58d
rand(10)[3:11]

# ╔═╡ fb421d6e-086e-11eb-1780-8b06cb6cbecc
rand(10)[3:10]

# ╔═╡ b6b65b94-edf0-11ea-3686-fbff0ff53d08
function create_bar()
    n = 100
    tmp_vec = zeros(n)
    k = 20
    ind_start = n ÷ 2 - k ÷ 2
    tmp_vec[ind_start: ind_start+k-1] .= 1
	tmp_vec
end

# ╔═╡ 32814b60-086f-11eb-1fab-d9a511a10d23


# ╔═╡ 22f28dae-edf2-11ea-25b5-11c369ae1253
md"""
#### Exercise 1.3

👉 Write a function that turns a `Vector` of `Vector`s into a `Matrix`.
"""

# ╔═╡ ac167180-086f-11eb-158c-bdd827e3ea65
begin
    a = [1, 2]
    b = [3, 4]
    Array([a, b])
end

# ╔═╡ c6bfe0e8-086f-11eb-34f2-218889ba308d
hcat(a, b)

# ╔═╡ 252fd35e-0870-11eb-33eb-0d885bd8368e
vcat(a, b)

# ╔═╡ 46e9df46-0870-11eb-3c84-1fbab587fa76
md"
I kind of **grasp the logic**:

- Vectors like `Int64[1, 2]` are **thought of as column vectors** in Julia, and if we have two such vectors `a` and `b`, then `hcat(a, b)` will put those vectors side by side, i.e. **horizontally**, generating a **`2 by 2` matrix**
- **whereas** `vcat` will concatenate them **vertically**, the result of which is a **`4 by 1` matrix**, or equiv., still **a vector (of length `4` now)**.
"

# ╔═╡ e2b62012-0871-11eb-1f95-d33b1542fd82
?hcat

# ╔═╡ 8c19fb72-ed6c-11ea-2728-3fa9219eddc4
function vecvec_to_matrix(vecvec)
	return hcat(vecvec...)
end

# ╔═╡ c4761a7e-edf2-11ea-1e75-118e73dadbed
vecvec_to_matrix([[1,2], [3,4]])

# ╔═╡ 393667ca-edf2-11ea-09c5-c5d292d5e896
md"""


👉 Write a function that turns a `Matrix` into a `Vector` of `Vector`s .
"""

# ╔═╡ 6642d9ca-0872-11eb-37a7-a5692ac5af45
?reshape

# ╔═╡ 1cdcc732-0872-11eb-361b-69f7289c05ea
reshape([1 2; 3 4], (4))

# ╔═╡ 5ab31a84-0872-11eb-2280-b5efb09bd6d6
reshape([1 2; 3 4], (4,))

# ╔═╡ 605df7b0-0872-11eb-0bb5-5b856f9e70cc
reshape([1 2; 3 4], 4)

# ╔═╡ 85f0afe0-0872-11eb-3f17-d530a17f0074
size([1 2; 3 4])

# ╔═╡ 9f1c6d04-ed6c-11ea-007b-75e7e780703d
md"
```julia
function matrix_to_vecvec(matrix)
	n_rows, n_cols = size(matrix)
	return 
end
```
"

# ╔═╡ dbaf94fa-0872-11eb-1d61-aff3b58d8f77
function matrix_to_vecvec(matrix)
    n_rows, n_cols = size(matrix)
    return [matrix[:,i] for i in 1:n_cols]
end

# ╔═╡ dd65abfe-0872-11eb-0ac6-2fab9c82bb0d


# ╔═╡ 70955aca-ed6e-11ea-2330-89b4d20b1795
matrix_to_vecvec([6 7; 8 9])

# ╔═╡ 5da8cbe8-eded-11ea-2e43-c5b7cc71e133
begin
	colored_line(x::Vector{<:Real}) = Gray.(Float64.((hcat(x)')))
	colored_line(x::Any) = nothing
end

# ╔═╡ 56ced344-eded-11ea-3e81-3936e9ad5777
colored_line(example_vector)

# ╔═╡ b18e2c54-edf1-11ea-0cbf-85946d64b6a2
colored_line(random_vect)

# ╔═╡ d862fb16-edf1-11ea-36ec-615d521e6bc0
colored_line(create_bar())

# ╔═╡ 62559026-0b12-11eb-3ff3-4b942eed65b2
md"#### Stopped here (2020/10/07 15h00)"

# ╔═╡ e083b3e8-ed61-11ea-2ec9-217820b0a1b4
md"""
## **Exercise 2** - _Manipulating images_

In this exercise we will get familiar with matrices (2D arrays) in Julia, by manipulating images.
Recall that in Julia images are matrices of `RGB` color objects.

Let's load a picture of Philip again.
"""

# ╔═╡ c5484572-ee05-11ea-0424-f37295c3072d
#philip_file = download("https://i.imgur.com/VGPeJ6s.jpg")
#philip_file = download("https://i.imgur.com/VGPeJ6s.jpg", "philip_blue_rug.jpg")

#philip_file = "philip_blue_rug.jpg"
# The above line doesn't work while the next line does work!
philip_file = "./philip_blue_rug.jpg"

# ╔═╡ 3deb6ae0-0b0c-11eb-38c4-51c7347c7989
typeof(philip_file)

# ╔═╡ e86ed944-ee05-11ea-3e0f-d70fc73b789c
md"_Hi there Philip_"

# ╔═╡ c54ccdea-ee05-11ea-0365-23aaf053b7d7
md"""
#### Exercise 2.1
👉 Write a function **`mean_colors`** that accepts an object called `image`. It should calculate the mean (average) amounts of red, green and blue in the image and return a tuple `(r, g, b)` of those means.
"""

# ╔═╡ 4f87f44c-0951-11eb-1480-01d3229a6c15
?mean

# ╔═╡ cd9137a2-0b10-11eb-3b40-8b27a3749da7
mean(1:10)

# ╔═╡ 0571a6fa-0b11-11eb-3f7b-d78d36dec3b5
function redify(rgb)
	rgb.r
end

# ╔═╡ 4528db26-0b11-11eb-0e51-0f030f77abd2


# ╔═╡ 48767108-0b11-11eb-0d67-0d8270720f74
function greenify(rgb)
	rgb.g
end

# ╔═╡ 483d3ab4-0b11-11eb-183c-d192271ee63f
function blueify(rgb)
	rgb.b
end

# ╔═╡ f6898df6-ee07-11ea-2838-fde9bc739c11
function mean_colors(image)
	return (mean(redify.(image)), mean(greenify.(image)), mean(blueify.(image)))
end

# ╔═╡ d75ec078-ee0d-11ea-3723-71fb8eecb040
md"
Maybe we can also do the `mean` using **convolution**.
"

# ╔═╡ 51cf16c8-0b12-11eb-0cef-61eb404e851a
md"#### Stopped here (2020/10/10 23h00)"

# ╔═╡ f68d4a36-ee07-11ea-0832-0360530f102e
md"""
#### Exercise 2.2
👉 Look up the documentation on the `floor` function. Use it to write a function `quantize(x::Number)` that takes in a value $x$ (which you can assume is between 0 and 1) and "quantizes" it into bins of width 0.1. For example, check that 0.267 gets mapped to 0.2.
"""

# ╔═╡ f1b0e7d8-0b13-11eb-2d59-7585f58d4314
RGB(0.2, 0.9, 0)

# ╔═╡ 3d757614-0b14-11eb-0531-414e0a643824
floor(0.267; digits=1)

# ╔═╡ 77494994-0b14-11eb-0c4e-f14fcd2e2b44
floor(0.267; digits=2)

# ╔═╡ 7b39552e-0b14-11eb-081c-713738b71a16
floor(0.567; digits=1)

# ╔═╡ f6991a50-ee07-11ea-0bc4-1d68eb028e6a
begin
	function quantize(x::Number)
		return floor(x; digits=1)
	end
	
	function quantize(color::AbstractRGB)
		## Wrong
		#return RGB{Float32}((quantize.(color.r), quantize.(color.g), quantize.(color.b)))
		## Correct: Specifying Float32 or not doesn't matter
		#return RGB(quantize.(color.r), quantize.(color.g), quantize.(color.b))
		return RGB{Float32}(quantize.(color.r), quantize.(color.g), quantize.(color.b))
	end
	
	function quantize(image::AbstractMatrix)		
		return quantize.(image)
	end
end

# ╔═╡ 51ac16be-0bc1-11eb-2ac6-5bce4590297c


# ╔═╡ fac6fdb6-0b14-11eb-1dc0-c37de0a38832
?RGB

# ╔═╡ bfea524a-0b8e-11eb-3b24-2b386cc2396b
?N0f8

# ╔═╡ 1293e99c-0bb8-11eb-061f-11f5b0dca1fb
?N4f12

# ╔═╡ 2d272712-0bb8-11eb-3a63-f97ce1bd5903
?N0f16

# ╔═╡ c539037a-0bb8-11eb-1dbb-85ba87f6e683
md"
#### `N4f12`
Why `4, 12`? What's the logic lying behind?
"

# ╔═╡ a9447ea0-0b8e-11eb-3907-f3461a5ba36e
?FixedPoint

# ╔═╡ f6a655f8-ee07-11ea-13b6-43ca404ddfc7
quantize(0.267), quantize(0.91)

# ╔═╡ f6b218c0-ee07-11ea-2adb-1968c4fd473a
md"""
#### Exercise 2.3
👉 Write the second **method** of the function `quantize`, i.e. a new *version* of the function with the *same* name. This method will accept a color object called `color`, of the type `AbstractRGB`. 

_Write the function in the same cell as `quantize(x::Number)` from the last exercise. 👆_
    
Here, `::AbstractRGB` is a **type annotation**. This ensures that this version of the function will be chosen when passing in an object whose type is a **subtype** of the `AbstractRGB` abstract type. For example, both the `RGB` and `RGBX` types satisfy this.

The method you write should return a new `RGB` object, in which each component ($r$, $g$ and $b$) are quantized.
"""

# ╔═╡ f6bf64da-ee07-11ea-3efb-05af01b14f67
md"""
#### Exercise 2.4
👉 Write a method `quantize(image::AbstractMatrix)` that quantizes an image by quantizing each pixel in the image. (You may assume that the matrix is a matrix of color objects.)

_Write the function in the same cell as `quantize(x::Number)` from the last exercise. 👆_
"""

# ╔═╡ 25dad7ce-ee0b-11ea-3e20-5f3019dd7fa3
md"Let's apply your method!"

# ╔═╡ e0d427be-0bc1-11eb-3ef6-6d5e148ce9b6
dump(RGB(0.2, 0.9, 0))

# ╔═╡ e5ae6d1c-0bc1-11eb-2f95-617389620926
?dump

# ╔═╡ 19e7f80e-0bc3-11eb-10f6-377a304761a5
typeof((0.9, 0.1, 0.2))

# ╔═╡ 27267f7c-0bc3-11eb-2f52-db15681030f1
typeof([0.9, 0.1, 0.2])

# ╔═╡ 3c56e792-0bc3-11eb-2142-292d8ee33d45
typeof(Array(0.9, 0.1, 0.2))

# ╔═╡ 521fb932-0bc3-11eb-0be0-23ecf85ece1b
typeof(RGB(0.9, 0.1, 0.2))

# ╔═╡ f6cc03a0-ee07-11ea-17d8-013991514d42
md"""
#### Exercise 2.5
👉 Write a function `invert` that inverts a color, i.e. sends $(r, g, b)$ to $(1 - r, 1-g, 1-b)$.
"""

# ╔═╡ 63e8d636-ee0b-11ea-173d-bd3327347d55
function invert(color::AbstractRGB)
	return RGB(1-color.r, 1-color.g, 1-color.b)
end

# ╔═╡ 2cc2f84e-ee0d-11ea-373b-e7ad3204bb00
md"Let's invert some colors:"

# ╔═╡ b8f26960-ee0a-11ea-05b9-3f4bc1099050
black = RGB(0.0, 0.0, 0.0)

# ╔═╡ 5de3a22e-ee0b-11ea-230f-35df4ca3c96d
invert(black)

# ╔═╡ 4e21e0c4-ee0b-11ea-3d65-b311ae3f98e9
red = RGB(0.8, 0.1, 0.1)

# ╔═╡ 6dbf67ce-ee0b-11ea-3b71-abc05a64dc43
invert(red)

# ╔═╡ 846b1330-ee0b-11ea-3579-7d90fafd7290
md"Can you invert the picture of Philip?"

# ╔═╡ f6d6c71a-ee07-11ea-2b63-d759af80707b
md"""
#### Exercise 2.6
👉 Write a function `noisify(x::Number, s)` to add randomness of intensity $s$ to a value $x$, i.e. to add a random value between $-s$ and $+s$ to $x$. If the result falls outside the range $(0, 1)$ you should "clamp" it to that range. (Note that Julia has a `clamp` function, but you should write your own function `myclamp(x)`.)
"""

# ╔═╡ 350ecad2-0bc7-11eb-377b-1ba0d5c48b98
max(1.1, 1)

# ╔═╡ 39be88ec-0bc7-11eb-17b9-ab21f4564997
min(-0.9, 0)

# ╔═╡ 71678e16-0bcb-11eb-1106-5318376347f7
?rand

# ╔═╡ 961068b4-0bcb-11eb-1346-2f19eeee0252
rand()

# ╔═╡ 43e87166-0bcc-11eb-08d6-6157d411ec74
begin
	s = 10
	2s
end

# ╔═╡ 7fa37a22-0bcc-11eb-0719-cf4796f11354
typeof(RGB(0.9, 0.9, 0.1))

# ╔═╡ f6e2cb2a-ee07-11ea-06ee-1b77e34c1e91
begin
	function myclamp(x::Number, low=0, high=1)
		return max(low, min(high, x))
	end

	function noisify(x::Number, s)
		noise = (rand() - 0.5)*(2s)
		return myclamp(x + noise)
	end

	function noisify(color::AbstractRGB, s)
		# you will write me in a later exercise!
		#return noisify.(color, s)
		return RGB(noisify.(color.r, s), noisify.(color.g, s), noisify.(color.b, s))
	end

	function noisify(image::AbstractMatrix, s)
		# you will write me in a later exercise!
		return noisify.(image, s)
	end
end


# ╔═╡ f6fc1312-ee07-11ea-39a0-299b67aee3d8
md"""
👉  Write the second method `noisify(c::AbstractRGB, s)` to add random noise of intensity $s$ to each of the $(r, g, b)$ values in a colour. 

_Write the function in the same cell as `noisify(x::Number)` from the last exercise. 👆_
"""

# ╔═╡ 774b4ce6-ee1b-11ea-2b48-e38ee25fc89b
@bind color_noise Slider(0:0.01:1, show_value=true)

# ╔═╡ 7e4aeb70-ee1b-11ea-100f-1952ba66f80f
noisify(red, color_noise)

# ╔═╡ 6a05f568-ee1b-11ea-3b6c-83b6ada3680f


# ╔═╡ f70823d2-ee07-11ea-2bb3-01425212aaf9
md"""
👉 Write the third method `noisify(image::AbstractMatrix, s)` to noisify each pixel of an image.

_Write the function in the same cell as `noisify(x::Number)` from the last exercise. 👆_
"""

# ╔═╡ e70a84d4-ee0c-11ea-0640-bf78653ba102
@bind philip_noise Slider(0:0.01:8, show_value=true)

# ╔═╡ f4475558-0bcd-11eb-1e50-21cfdc41c8b3
md"#### Why not <code>Slider(0:0.01:<b>1</b>, show_value=true)</code>"

# ╔═╡ fc7674b6-0bcd-11eb-18b6-9501c2b84731
md"#### Why not `Slider(0:0.01:1, show_value=true)` but `8`?"

# ╔═╡ 980a6252-0bce-11eb-2e2b-65cfe0d80adb
?N0f8

# ╔═╡ f714699e-ee07-11ea-08b6-5f5169861b57
md"""
👉 For which noise intensity does it become unrecognisable? 

You may need noise intensities larger than 1. Why?

"""

# ╔═╡ bdc2df7c-ee0c-11ea-2e9f-7d2c085617c1
answer_about_noise_intensity = md"""
The image is unrecognisable with intensity `larger than 1, around 2.0`

I think this is because that we have **many many pixels in an image**, and the random noise added when `s` is small, say equals `a`, has **a high chance of being small**, thus **not affecting the recognisability of the image as a whole**.
"""

# ╔═╡ 81510a30-ee0e-11ea-0062-8b3327428f9d


# ╔═╡ e3b03628-ee05-11ea-23b6-27c7b0210532
decimate(image, ratio=5) = image[1:ratio:end, 1:ratio:end]

# ╔═╡ c8ecfe5c-ee05-11ea-322b-4b2714898831
philip = let
	original = Images.load(philip_file)
	decimate(original, 8)
end

# ╔═╡ 2587593c-0b11-11eb-23ab-cfad6e206e4f
redify.(philip)

# ╔═╡ ea6d6a66-0b0c-11eb-3c5b-4d7745cb7967
mean(redify.(philip))

# ╔═╡ 5be9b144-ee0d-11ea-2a8d-8775de265a1d
mean_colors(philip)

# ╔═╡ 9751586e-ee0c-11ea-0cbb-b7eda92977c9
quantize(philip)

# ╔═╡ 586cbf14-0bc4-11eb-2551-5f7f95318bf3
typeof(philip)

# ╔═╡ 943103e2-ee0b-11ea-33aa-75a8a1529931
philip_inverted = invert.(philip)

# ╔═╡ ac15e0d0-ee0c-11ea-1eaf-d7f88b5df1d7
noisify(philip, philip_noise)

# ╔═╡ 5ff81cce-0bce-11eb-3a9d-cb26b239a921
typeof(philip)

# ╔═╡ 9604bc44-ee1b-11ea-28f8-7f7af8d0cbb2
dump(philip[1,1])

# ╔═╡ 6456d684-0bce-11eb-1976-f908096fefcf
philip[1,1].r

# ╔═╡ 8c798bfc-0bce-11eb-0e5e-7b38ee407384
philip[2,1].r

# ╔═╡ 29ec796a-0be0-11eb-2186-7f5f336e014e
md"#### Stopped here (2020/10/11 23h37)"

# ╔═╡ e08781fa-ed61-11ea-13ae-91a49b5eb74a
md"""

## **Exercise 3** - _Convolutions_

As we have seen in the videos, we can produce cool effects using the mathematical technique of **convolutions**. We input one image $M$ and get a new image $M'$ back. 

Conceptually we think of $M$ as a matrix. In practice, in Julia it will be a `Matrix` of color objects, and we may need to take that into account. Ideally, however, we should write a **generic** function that will work for any type of data contained in the matrix.

A convolution works on a small **window** of an image, i.e. a region centered around a given point $(i, j)$. We will suppose that the window is a square region with odd side length $2\ell + 1$, running from $-\ell, \ldots, 0, \ldots, \ell$.

The result of the convolution over a given window, centred at the point $(i, j)$ is a *single number*; this number is the value that we will use for $M'_{i, j}$.
(Note that neighbouring windows overlap.)

To get started let's restrict ourselves to convolutions in 1D.
So a window is just a 1D region from $-\ell$ to $\ell$.

"""

# ╔═╡ 7fc8ee1c-ee09-11ea-1382-ad21d5373308
md"""
---

Let's create a vector `v` of random numbers of length `n=100`.
"""

# ╔═╡ 7fcd6230-ee09-11ea-314f-a542d00d582e
n = 100

# ╔═╡ 7fdb34dc-ee09-11ea-366b-ffe10d1aa845
v = rand(n)

# ╔═╡ 7fe9153e-ee09-11ea-15b3-6f24fcc20734
md"_Feel free to experiment with different values!_"

# ╔═╡ 80108d80-ee09-11ea-0368-31546eb0d3cc
md"""
#### Exercise 3.1
You've seen some colored lines in this notebook to visualize arrays. Can you make another one?

👉 Try plotting our vector `v` using `colored_line(v)`.
"""

# ╔═╡ 01070e28-ee0f-11ea-1928-a7919d452bdd
colored_line(v)

# ╔═╡ 7522f81e-ee1c-11ea-35af-a17eb257ff1a
md"Try changing `n` and `v` around. Notice that you can run the cell `v = rand(n)` again to regenerate new random values."

# ╔═╡ 801d90c0-ee09-11ea-28d6-61b806de26dc
md"""
#### Exercise 3.2
We need to decide how to handle the **boundary conditions**, i.e. what happens if we try to access a position in the vector `v` beyond `1:n`.  The simplest solution is to assume that $v_{i}$ is 0 outside the original vector; however, this may lead to strange boundary effects.
    
A better solution is to use the *closest* value that is inside the vector. Effectively we are extending the vector and copying the extreme values into the extended positions. (Indeed, this is one way we could implement this; these extra positions are called **ghost cells**.)

👉 Write a function `extend(v, i)` that checks whether the position $i$ is inside `1:n`. If so, return the $i$th component of `v`; otherwise, return the nearest end value.
"""

# ╔═╡ 537820ae-0cad-11eb-2d18-f36ea34f1706
1:10

# ╔═╡ 97854cf4-0cad-11eb-3f86-35a33b6d6e7f
v

# ╔═╡ a95fc44a-0cad-11eb-0ab3-090e2754372f
v.length

# ╔═╡ bb5e7830-0cad-11eb-2d92-e1412828b4be
length(v)

# ╔═╡ 802bec56-ee09-11ea-043e-51cf1db02a34
function extend(v, i)
	if i < 1
		return v[1]
	elseif i > length(v)
		return v[end]
	else
		return v[i]
	end
end

# ╔═╡ 956e29bc-0cae-11eb-2c82-193b60071039
md"#### Stopped here (2020/10/13 00h16)"

# ╔═╡ b7f3994c-ee1b-11ea-211a-d144db8eafc2
md"_Some test cases:_"

# ╔═╡ 04cbbab2-0d34-11eb-0e65-0f027e0d4c42
v

# ╔═╡ 17e5beac-0d34-11eb-3ac8-4d898843643e
n, length(v)

# ╔═╡ 1c6a3728-0d34-11eb-032b-39efe36a1efd
v[end], v[n]

# ╔═╡ 803905b2-ee09-11ea-2d52-e77ff79693b0
extend(v, 1)

# ╔═╡ 80479d98-ee09-11ea-169e-d166eef65874
extend(v, -8)

# ╔═╡ 805691ce-ee09-11ea-053d-6d2e299ee123
extend(v, n + 10)

# ╔═╡ 806e5766-ee0f-11ea-1efc-d753cd83d086
md"Extended with 0:"

# ╔═╡ 38da843a-ee0f-11ea-01df-bfa8b1317d36
colored_line([0, 0, example_vector..., 0, 0])

# ╔═╡ 9bde9f92-ee0f-11ea-27f8-ffef5fce2b3c
md"Extended with your `extend`:"

# ╔═╡ 45c4da9a-ee0f-11ea-2c5b-1f6704559137
if extend(v,1) === missing
	missing
else
	colored_line([extend(example_vector, i) for i in -1:12])
end

# ╔═╡ 6781cf0a-0d34-11eb-14f1-a7295b76ba99
example_vector

# ╔═╡ 7b1249aa-0d34-11eb-21ca-ab7b46d4405c
length(example_vector)

# ╔═╡ 80664e8c-ee09-11ea-0702-711bce271315
md"""
#### Exercise 3.3
👉 Write a function `blur_1D(v, l)` that blurs a vector `v` with a window of length `l` by averaging the elements within a window from $-\ell$ to $\ell$. This is called a **box blur**.
"""

# ╔═╡ c4f2702e-0d34-11eb-0bea-5ffe451c46ec
md"""
``\LaTeX`` test

$\TeX$ test

Diff btw ``\quad\ell\quad`` and $\quad l \quad$?
"""

# ╔═╡ ac54dc16-0d35-11eb-3cf4-f1cf7b90e032
zeros(length(example_vector))

# ╔═╡ b6ff3c74-0d35-11eb-15ff-55c704192250
example_vector

# ╔═╡ f05f8b4a-0d35-11eb-1e56-e39a50ab53b7
typeof(example_vector[1])

# ╔═╡ 24b2a8fa-0d36-11eb-173e-c7f182d0ebf5
zeros

# ╔═╡ 807e5662-ee09-11ea-3005-21fdcc36b023
function blur_1D(v, l)
	#v_blur = zeros(T=, length(v))
	#v_blur = zeros(length(v))
	v_blur = copy(v)
	if l != 0
		for i in 1:length(v)
			new_px_value = 0
			for j in -l:l
				new_px_value += extend(v, i+j)
			new_px_value /= 2l
			v_blur[i] = new_px_value
			end
		end
	end
	return v_blur
end

# ╔═╡ 808deca8-ee09-11ea-0ee3-1586fa1ce282
let
	try
		test_v = rand(n)
		original = copy(test_v)
		blur_1D(test_v, 5)
		if test_v != original
			md"""
			!!! danger "Oopsie!"
			    It looks like your function _modifies_ `v`. Can you write it without doing so? Maybe you can use `copy`.
			"""
		end
	catch
	end
end

# ╔═╡ 809f5330-ee09-11ea-0e5b-415044b6ac1f
md"""
#### Exercise 3.4
👉 Apply the box blur to your vector `v`. Show the original and the new vector by creating two cells that call `colored_line`. Make the parameter $\ell$ interactive, and call it `l_box` instead of just `l` to avoid a variable naming conflict.
"""

# ╔═╡ ca1ac5f4-ee1c-11ea-3d00-ff5268866f87
v

# ╔═╡ c8648608-0d36-11eb-15d6-452d813b345a
@bind l_box Slider(0:20, show_value=true)

# ╔═╡ d043c956-0d36-11eb-2d8e-9d0aa9e5d79a
colored_line(blur_1D(v, l_box))

# ╔═╡ d00aa748-0d36-11eb-2dbc-e99d5068c249
colored_line(v)

# ╔═╡ 80ab64f4-ee09-11ea-29b4-498112ed0799
md"""
#### Exercise 3.5
The box blur is a simple example of a **convolution**, i.e. a linear function of a window around each point, given by 

$$v'_{i} = \sum_{n}  \, v_{i - n} \, k_{n},$$

where $\mathbf{k}$ is a vector called a **kernel**.
    
Again, we need to take care about what happens if $v_{i -n }$ falls off the end**s** of the vector.
    
👉 Write a function `convolve_vector(v, k)` that performs this convolution. You need to think of the vector $\mathbf{k}$ as being *centred* on the position $i$. So $n$ in the above formula runs between $-\ell$ and $\ell$, where $2\ell + 1$ is the length of the vector $\mathbf{k}$. You will need to do the necessary manipulation of indices.
"""

# ╔═╡ e0f50170-0d38-11eb-245b-39600406e6be
example_vector[end:1]

# ╔═╡ f9e32a52-0d38-11eb-2b67-6f243577a8d8
reverse(example_vector)

# ╔═╡ 14bf4fb8-0d39-11eb-3847-8157b9af761f
[j for j in 10:-10:-1]

# ╔═╡ 28e20950-ee0c-11ea-0e0a-b5f2e570b56e
function convolve_vector(v, k)
	l = (length(k) - 1) ÷ 2
	vprime = zeros(length(v))
	for i in 1:length(v)
		vprime[i] = [extend(v,i+j) for j in l:-1:-l] ⋅ k
	end
	return vprime
end

# ╔═╡ 74d44d30-0d3a-11eb-3fa9-01387aee71b7
dot([1, 0], [0, 1])

# ╔═╡ c68e7b98-0d3a-11eb-043c-6d2bceb36ebf
[1, 0] ⋅ [0, 1]

# ╔═╡ 93284f92-ee12-11ea-0342-833b1a30625c
test_convolution = let
	v = [1, 10, 100, 1000, 10000]
	k = [0, 1, 0]
	convolve_vector(v, k)
end

# ╔═╡ 5eea882c-ee13-11ea-0d56-af81ecd30a4a
colored_line(test_convolution)

# ╔═╡ cf73f9f8-ee12-11ea-39ae-0107e9107ef5
md"_Edit the cell above, or create a new cell with your own test cases!_"

# ╔═╡ 2a24d1fa-0d3b-11eb-158c-0d8cc274c09d
md"#### Stopped here (2020/10/13 00h16)
And wait...
Why the `Got it! Keep it up!` Congratulations message always shows **differently**?
- (?1) Level of correctness?


"

# ╔═╡ 80b7566a-ee09-11ea-3939-6fab470f9ec8
md"""
#### Exercise 3.6
👉 Write a function `gaussian_kernel`.

The definition of a Gaussian in 1D is

$$G(x) = \frac{1}{\sqrt{2\pi \sigma^2}} \exp \left( \frac{-x^2}{2\sigma^2} \right)$$

We need to **sample** (i.e. evaluate) this at each pixel in a region of size $n^2$,
and then **normalize** so that the sum of the resulting kernel is 1.

For simplicity you can take $\sigma=1$.
"""

# ╔═╡ 12c4d59c-0dda-11eb-0543-7ba2f33f5360
ℯ

# ╔═╡ 585926a8-0dda-11eb-12cf-d309bb4c8386
√9

# ╔═╡ 613815ae-0dda-11eb-1beb-f96e9aad022e
√9+7

# ╔═╡ 6b811306-0dda-11eb-2f97-bfeb63a2e18d
√(9+7)

# ╔═╡ 866c589e-0dda-11eb-2695-b5b6a1766694
function gaussian(x, σ=1)
	1/√(2*π*σ^2) * ℯ^(-x^2/(2σ^2))
end

# ╔═╡ 8aca0e40-0dda-11eb-2be7-6f20eabf4457
gaussian(0)

# ╔═╡ e5b23738-0dda-11eb-0aa3-2df8f3999fdc
example_vector

# ╔═╡ ebe4f570-0dda-11eb-0336-715fbd1a1919
sum(example_vector)

# ╔═╡ 1c8b4658-ee0c-11ea-2ede-9b9ed7d3125e
function gaussian_kernel(n)
	k = [gaussian(x) for x in -n:n]
	return k ./ sum(k)
end

# ╔═╡ f8bd22b8-ee14-11ea-04aa-ab16fd01826e
md"Let's test your kernel function!"

# ╔═╡ 2a9dd06a-ee13-11ea-3f84-67bb309c77a8
gaussian_kernel_size_1D = 3 # change this value, or turn me into a slider!

# ╔═╡ 3cad462a-0de7-11eb-2a39-f79ad1828073
random_vect

# ╔═╡ 38eb92f6-ee13-11ea-14d7-a503ac04302e
test_gauss_1D_a = let
	v = random_vect
	k = gaussian_kernel(gaussian_kernel_size_1D)
	
	if k !== missing
		convolve_vector(v, k)
	end
end

# ╔═╡ b424e2aa-ee14-11ea-33fa-35491e0b9c9d
colored_line(test_gauss_1D_a)

# ╔═╡ 24c21c7c-ee14-11ea-1512-677980db1288
test_gauss_1D_b = let
	v = create_bar()
	k = gaussian_kernel(gaussian_kernel_size_1D)
	
	if k !== missing
		convolve_vector(v, k)
	end
end

# ╔═╡ bc1c20a4-ee14-11ea-3525-63c9fa78f089
colored_line(test_gauss_1D_b)

# ╔═╡ 4ed7a246-0de7-11eb-10b0-b1ec396343c2
create_bar()

# ╔═╡ cc1ea2ac-0de6-11eb-0d9c-0bf9f6831b57
?rawview

# ╔═╡ 096fb31a-0de7-11eb-0faf-ddf11f1a7982
typeof(philip)

# ╔═╡ aee2ebce-0de6-11eb-26f7-711c2bd7acef
rawview(philip)

# ╔═╡ b01858b6-edf3-11ea-0826-938d33c19a43
md"""
 
   
## **Exercise 4** - _Convolutions of images_
    
Now let's move to 2D images. The convolution is then given by a **kernel** matrix $K$:
    
$$M'_{i, j} = \sum_{k, l}  \, M_{i- k, j - l} \, K_{k, l},$$
    
where the sum is over the possible values of $k$ and $l$ in the window. Again we think of the window as being *centered* at $(i, j)$.

A common notation for this operation is $*$:

$$M' = M * K.$$
"""

# ╔═╡ 7c1bc062-ee15-11ea-30b1-1b1e76520f13
md"""
#### Exercise 4.1
👉 Write a function `extend_mat` that takes a matrix `M` and indices `i` and `j`, and returns the closest element of the matrix.
"""

# ╔═╡ cba57002-0de8-11eb-190c-37a1f8678426
max(10,-1)

# ╔═╡ 7c2ec6c6-ee15-11ea-2d7d-0d9401a5e5d1
function extend_mat(M::AbstractMatrix, i, j)
	n_rows, n_cols = size(M)
	ii = min(max(1, i), n_rows)
	jj = min(max(1, j), n_cols)
	return M[ii, jj]
end

# ╔═╡ 9afc4dca-ee16-11ea-354f-1d827aaa61d2
md"_Let's test it!_"

# ╔═╡ cf6b05e2-ee16-11ea-3317-8919565cb56e
small_image = Gray.(rand(5,5))

# ╔═╡ e3616062-ee27-11ea-04a9-b9ec60842a64
md"Extended with `0`:"

# ╔═╡ e5b6cd34-ee27-11ea-0d60-bd4796540b18
[get(small_image, (i, j), Gray(0)) for (i,j) in Iterators.product(-1:7,-1:7)]

# ╔═╡ d06ea762-ee27-11ea-2e9c-1bcff86a3fe0
md"Extended with your `extend`:"

# ╔═╡ e1dc0622-ee16-11ea-274a-3b6ec9e15ab5
[extend_mat(small_image, i, j) for (i,j) in Iterators.product(-1:7,-1:7)]

# ╔═╡ 8500cc02-0df2-11eb-38d7-fbdaef2d75bf
philip_head = philip[250:430,110:230]

# ╔═╡ 345644a2-0df3-11eb-28e9-2f18f49de908
size(philip_head)

# ╔═╡ b52bac08-0df2-11eb-21a1-1b5db8b1592b
Iterators.product(-50:size(philip_head,1)+51, (-50:size(philip_head,2)+51))

# ╔═╡ af53cb96-0df3-11eb-3d02-77cf0adb6386
md"Somewhat like Cartesian product, right?"

# ╔═╡ 584304be-0df2-11eb-2eeb-2bae9d770a30
let
	philip_head = philip[250:430,110:230]
	[extend_mat(philip_head, i, j) for (i,j) in Iterators.product(-50:size(philip_head,1)+51, (-50:size(philip_head,2)+51))]
end

# ╔═╡ dcdabd1e-0df2-11eb-18be-f1ae118c10ab
let
	philip_head = philip[250:430,110:230]
	[extend_mat(philip_head, i, j) for i in -50:size(philip_head,1)+51, j in -50:size(philip_head,2)+51 ]
end

# ╔═╡ 02acf2d4-0df3-11eb-0e5c-d320ca3f12ea
[i+j for i in 1:3, j in 1:3]

# ╔═╡ 8a9993da-0df5-11eb-0e76-ad243bb3d0f1


# ╔═╡ 7c41f0ca-ee15-11ea-05fb-d97a836659af
md"""
#### Exercise 4.2
👉 Implement a function `convolve_image(M, K)`. 
"""

# ╔═╡ 8caaf4e6-0df5-11eb-2ae3-ff75e57068ec
sum([i+j for i in 1:3, j in 1:3])

# ╔═╡ d6b44f92-0df7-11eb-0498-43e0b1a66999
size([i+j for i in 1:3, j in 1:3]) .÷ 2

# ╔═╡ 8b96e0bc-ee15-11ea-11cd-cfecea7075a0
function convolve_image(M::AbstractMatrix, K::AbstractMatrix)
	half_h_K, half_w_K = size(K) .÷ 2
	return [ sum([extend_mat(M,i-k,j-l)*K[k+half_h_K+1,l+half_w_K+1] for k in -half_h_K:half_h_K, l in -half_w_K:half_w_K]) for i in 1:size(M,1), j in 1:size(M,2) ]
end

# ╔═╡ 5a5135c6-ee1e-11ea-05dc-eb0c683c2ce5
md"_Let's test it out! 🎃_"

# ╔═╡ 577c6daa-ee1e-11ea-1275-b7abc7a27d73
test_image_with_border = [get(small_image, (i, j), Gray(0)) for (i,j) in Iterators.product(-1:7,-1:7)]

# ╔═╡ 275a99c8-ee1e-11ea-0a76-93e3618c9588
K_test = [
	0   0  0
	1/2 0  1/2
	0   0  0
]

# ╔═╡ 42dfa206-ee1e-11ea-1fcd-21671042064c
convolve_image(test_image_with_border, K_test)

# ╔═╡ 6e53c2e6-ee1e-11ea-21bd-c9c05381be07
md"_Edit_ `K_test` _to create your own test case!_"

# ╔═╡ e7f8b41a-ee25-11ea-287a-e75d33fbd98b
convolve_image(philip, K_test)

# ╔═╡ 7a7f08fa-0e94-11eb-01f9-49a431944580
md"#### Stopped here (2020/10/14 17h00)"

# ╔═╡ 7c50ea80-ee15-11ea-328f-6b4e4ff20b7e
md"""
#### Exercise 4.3
👉 Apply a **Gaussian blur** to an image.

Here, the 2D Gaussian kernel will be defined as

$$G(x,y)=\frac{1}{2\pi \sigma^2}e^{\frac{-(x^2+y^2)}{2\sigma^2}}$$
"""

# ╔═╡ b3ec7ac2-0e95-11eb-2823-35632ede6889
function gaussian_kernel_2D(n)
	"""
	return
	(2n+1) by (2n+1) matrix
	"""
	k = [gaussian((i^2 + j^2)) for i in -n:n, j in -n:n]
	return k ./ sum(k)
end

# ╔═╡ aad67fd0-ee15-11ea-00d4-274ec3cda3a3
function with_gaussian_blur(image)
	return convolve_image(image, gaussian_kernel_2D(1))
end

# ╔═╡ 8ae59674-ee18-11ea-3815-f50713d0fa08
md"_Let's make it interactive. 💫_"

# ╔═╡ 7c6642a6-ee15-11ea-0526-a1aac4286cdd
md"""
#### Exercise 4.4
👉 Create a **Sobel edge detection filter**.

Here, we will need to create two separate filters that separately detect edges in the horizontal and vertical directions:

```math
\begin{align}

G_x &= \left(\begin{bmatrix}
1 \\
2 \\
1 \\
\end{bmatrix} \otimes [1~0~-1]
\right) * A = \begin{bmatrix}
1 & 0 & -1 \\
2 & 0 & -2 \\
1 & 0 & -1 \\
\end{bmatrix}*A\\
G_y &= \left(
\begin{bmatrix}
1 \\
0 \\
-1 \\
\end{bmatrix} \otimes [1~2~1]
\right) * A = \begin{bmatrix}
1 & 2 & 1 \\
0 & 0 & 0 \\
-1 & -2 & -1 \\
\end{bmatrix}*A
\end{align}
```
Here $A$ is the array corresponding to your image.
We can think of these as derivatives in the $x$ and $y$ directions.

Then we combine them by finding the magnitude of the **gradient** (in the sense of multivariate calculus) by defining

$$G_\text{total} = \sqrt{G_x^2 + G_y^2}.$$

For simplicity you can choose one of the "channels" (colours) in the image to apply this to.
"""

# ╔═╡ bce31dbe-0e97-11eb-0df5-9d5380e77fd0
[1 2 1]'

# ╔═╡ 67643534-0e98-11eb-0569-fd0d8614ad39
[1;2;1]

# ╔═╡ dc6f63ce-0e98-11eb-1d0d-e352ac0593bd
Int64[1,2,1]

# ╔═╡ e6dc98ba-0e98-11eb-10a2-339e154ae101
Array[1,2,1]

# ╔═╡ 6ac0de12-0e98-11eb-2ee8-4f463edf9111
Sx = [1 2 1]'*[1 0 -1]

# ╔═╡ 9eeb876c-ee15-11ea-1794-d3ea79f47b75
function with_sobel_edge_detect(image)
	Sx = [1 2 1]'*[1 0 -1]
	Sy = [1 0 -1]'*[1 2 1]
	Gx = convolve_image(image, Sx)
	Gy = convolve_image(image, Sy)
	G_total = .√(Gx.^2 + Gy.^2)
	return G_total
end

# ╔═╡ 1b85ee76-ee10-11ea-36d7-978340ef61e6
md"""
## **Exercise 5** - _Lecture transcript_
_(MIT students only)_

Please see the Canvas post for transcript document for week 1 [here](https://canvas.mit.edu/courses/5637/discussion_topics/27880).

We need each of you to correct about 100 lines (see instructions in the beginning of the document.)

👉 Please mention the name of the video and the line ranges you edited:
"""

# ╔═╡ 477d0a3c-ee10-11ea-11cf-07b0e0ce6818
lines_i_edited = md"""
Convolution, lines 100-0 (_for example_)
"""

# ╔═╡ 8ffe16ce-ee20-11ea-18bd-15640f94b839
if student.kerberos_id === "jazz"
	md"""
!!! danger "Oops!"
    **Before you submit**, remember to fill in your name and kerberos ID at the top of this notebook!
	"""
end

# ╔═╡ 5516c800-edee-11ea-12cf-3f8c082ef0ef
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Hint", [text]))

# ╔═╡ b1d5ca28-edf6-11ea-269e-75a9fb549f1d
hint(md"You can find out more about any function (like `rand`) by creating a new cell and typing:
	
```
?rand
```

Once the Live Docs are open, you can select any code to learn more about it. It might be useful to leave it open all the time, and get documentation while you type code.")

# ╔═╡ f6ef2c2e-ee07-11ea-13a8-2512e7d94426
hint(md"The `rand` function generates (uniform) random floating-point numbers between $0$ and $1$.")

# ╔═╡ ea435e58-ee11-11ea-3785-01af8dd72360
hint(md"Have a look at Exercise 2 to see an example of adding interactivity with a slider. You can read the [Interactivity](./sample/Interactivity.jl) and the [PlutoUI](./sample/PlutoUI.jl) sample notebooks _(right click -> Open in new tab)_ to learn more.")

# ╔═╡ e9aadeee-ee1d-11ea-3525-95f6ba5fda31
hint(md"`l = (length(k) - 1) ÷ 2`")

# ╔═╡ 649df270-ee24-11ea-397e-79c4355e38db
hint(md"`num_rows, num_columns = size(M)`")

# ╔═╡ 0cabed84-ee1e-11ea-11c1-7d8a4b4ad1af
hint(md"`num_rows, num_columns = size(K)`")

# ╔═╡ 57360a7a-edee-11ea-0c28-91463ece500d
almost(text) = Markdown.MD(Markdown.Admonition("warning", "Almost there!", [text]))

# ╔═╡ dcb8324c-edee-11ea-17ff-375ff5078f43
still_missing(text=md"Replace `missing` with your answer.") = Markdown.MD(Markdown.Admonition("warning", "Here we go!", [text]))

# ╔═╡ 58af703c-edee-11ea-2963-f52e78fc2412
keep_working(text=md"The answer is not quite right.") = Markdown.MD(Markdown.Admonition("danger", "Keep working on it!", [text]))

# ╔═╡ f3d00a9a-edf3-11ea-07b3-1db5c6d0b3cf
yays = [md"Great!", md"Yay ❤", md"Great! 🎉", md"Well done!", md"Keep it up!", md"Good job!", md"Awesome!", md"You got the right answer!", md"Let's move on to the next section."]

# ╔═╡ 5aa9dfb2-edee-11ea-3754-c368fb40637c
correct(text=rand(yays)) = Markdown.MD(Markdown.Admonition("correct", "Got it!", [text]))

# ╔═╡ 74d44e22-edee-11ea-09a0-69aa0aba3281
not_defined(variable_name) = Markdown.MD(Markdown.Admonition("danger", "Oopsie!", [md"Make sure that you define a variable called **$(Markdown.Code(string(variable_name)))**"]))

# ╔═╡ 397941fc-edee-11ea-33f2-5d46c759fbf7
if !@isdefined(random_vect)
	not_defined(:random_vect)
elseif ismissing(random_vect)
	still_missing()
elseif !(random_vect isa Vector)
	keep_working(md"`random_vect` should be a `Vector`.")
elseif length(random_vect) != 10
	keep_working(md"`random_vect` does not have the correct size.")
else
	correct()
end

# ╔═╡ 38dc80a0-edef-11ea-10e9-615255a4588c
if !@isdefined(mean)
	not_defined(:mean)
else
	let
		result = mean([1,2,3])
		if ismissing(result)
			still_missing()
		elseif isnothing(result)
			keep_working(md"Did you forget to write `return`?")
		elseif result != 2
			keep_working()
		else
			correct()
		end
	end
end

# ╔═╡ 2b1ccaca-edee-11ea-34b0-c51659f844d0
if !@isdefined(m)
	not_defined(:m)
elseif ismissing(m)
	still_missing()
elseif !(m isa Number)
	keep_working(md"`m` should be a number.")
elseif m != mean(random_vect)
	keep_working()
else
	correct()
end

# ╔═╡ e3394c8a-edf0-11ea-1bb8-619f7abb6881
if !@isdefined(create_bar)
	not_defined(:create_bar)
else
	let
		result = create_bar()
		if ismissing(result)
			still_missing()
		elseif isnothing(result)
			keep_working(md"Did you forget to write `return`?")
		elseif !(result isa Vector) || length(result) != 100
			keep_working(md"The result should be a `Vector` with 100 elements.")
		elseif result[[1,50,100]] != [0,1,0]
			keep_working()
		else
			correct()
		end
	end
end

# ╔═╡ adfbe9b2-ed6c-11ea-09ac-675262f420df
if !@isdefined(vecvec_to_matrix)
	not_defined(:vecvec_to_matrix)
else
	let
		input = [[6,7],[8,9]]

		result = vecvec_to_matrix(input)
		shouldbe = [6 7; 8 9]

		if ismissing(result)
			still_missing()
		elseif isnothing(result)
			keep_working(md"Did you forget to write `return`?")
		elseif !(result isa Matrix)
			keep_working(md"The result should be a `Matrix`")
		elseif result != shouldbe && result != shouldbe'
			keep_working()
		else
			correct()
		end
	end
end

# ╔═╡ e06b7fbc-edf2-11ea-1708-fb32599dded3
if !@isdefined(matrix_to_vecvec)
	not_defined(:matrix_to_vecvec)
else
	let
		input = [6 7 8; 8 9 10]
		result = matrix_to_vecvec(input)
		shouldbe = [[6,7,8],[8,9,10]]
		shouldbe2 = [[6,8], [7,9], [8,10]]

		if ismissing(result)
			still_missing()
		elseif isnothing(result)
			keep_working(md"Did you forget to write `return`?")
		elseif result != shouldbe && result != shouldbe2
			keep_working()
		else
			correct()
		end
	end
end

# ╔═╡ 4d0158d0-ee0d-11ea-17c3-c169d4284acb
if !@isdefined(mean_colors)
	not_defined(:mean_colors)
else
	let
		input = reshape([RGB(1.0, 1.0, 1.0), RGB(1.0, 1.0, 0.0)], (2,1))
		
		result = mean_colors(input)
		shouldbe = (1.0, 1.0, 0.5)
		shouldbe2 = RGB(shouldbe...)

		if ismissing(result)
			still_missing()
		elseif isnothing(result)
			keep_working(md"Did you forget to write `return`?")
		elseif !(result == shouldbe) && !(result == shouldbe2)
			keep_working()
		else
			correct()
		end
	end
end

# ╔═╡ c905b73e-ee1a-11ea-2e36-23b8e73bfdb6
if !@isdefined(quantize)
	not_defined(:quantize)
else
	let
		result = quantize(.3)

		if ismissing(result)
			still_missing()
		elseif isnothing(result)
			keep_working(md"Did you forget to write `return`?")
		elseif result != .3
			if quantize(0.35) == .3
				almost(md"What should quantize(`0.2`) be?")
			else
				keep_working()
			end
		else
			correct()
		end
	end
end

# ╔═╡ bcf98dfc-ee1b-11ea-21d0-c14439500971
if !@isdefined(extend)
	not_defined(:extend)
else
	let
		result = extend([6,7],-10)

		if ismissing(result)
			still_missing()
		elseif isnothing(result)
			keep_working(md"Did you forget to write `return`?")
		elseif result != 6 || extend([6,7],10) != 7
			keep_working()
		else
			correct()
		end
	end
end

# ╔═╡ 7ffd14f8-ee1d-11ea-0343-b54fb0333aea
if !@isdefined(convolve_vector)
	not_defined(:convolve_vector)
else
	let
		x = [1, 10, 100]
		result = convolve_vector(x, [0, 1, 1])
		shouldbe = [11, 110, 200]
		shouldbe2 = [2, 11, 110]

		if ismissing(result)
			still_missing()
		elseif isnothing(result)
			keep_working(md"Did you forget to write `return`?")
		elseif !(result isa AbstractVector)
			keep_working(md"The returned object is not a `Vector`.")
		elseif size(result) != size(x)
			keep_working(md"The returned vector has the wrong dimensions.")
		elseif result != shouldbe && result != shouldbe2
			keep_working()
		else
			correct()
		end
	end
end

# ╔═╡ efd1ceb4-ee1c-11ea-350e-f7e3ea059024
if !@isdefined(extend_mat)
	not_defined(:extend_mat)
else
	let
		input = [42 37; 1 0]
		result = extend_mat(input, -2, -2)

		if ismissing(result)
			still_missing()
		elseif isnothing(result)
			keep_working(md"Did you forget to write `return`?")
		elseif result != 42 || extend_mat(input, -1, 3) != 37
			keep_working()
		else
			correct()
		end
	end
end

# ╔═╡ 115ded8c-ee0a-11ea-3493-89487315feb7
bigbreak = html"<br><br><br><br><br>";

# ╔═╡ 54056a02-ee0a-11ea-101f-47feb6623bec
bigbreak

# ╔═╡ 45815734-ee0a-11ea-2982-595e1fc0e7b1
bigbreak

# ╔═╡ 4139ee66-ee0a-11ea-2282-15d63bcca8b8
bigbreak

# ╔═╡ 27847dc4-ee0a-11ea-0651-ebbbb3cfd58c
bigbreak

# ╔═╡ 0001f782-ee0e-11ea-1fb4-2b5ef3d241e2
bigbreak

# ╔═╡ 91f4778e-ee20-11ea-1b7e-2b0892bd3c0f
bigbreak

# ╔═╡ 5842895a-ee10-11ea-119d-81e4c4c8c53b
bigbreak

# ╔═╡ dfb7c6be-ee0d-11ea-194e-9758857f7b20
function camera_input(;max_size=200, default_url="https://i.imgur.com/SUmi94P.png")
"""
<span class="pl-image waiting-for-permission">
<style>
	
	.pl-image.popped-out {
		position: fixed;
		top: 0;
		right: 0;
		z-index: 5;
	}

	.pl-image #video-container {
		width: 250px;
	}

	.pl-image video {
		border-radius: 1rem 1rem 0 0;
	}
	.pl-image.waiting-for-permission #video-container {
		display: none;
	}
	.pl-image #prompt {
		display: none;
	}
	.pl-image.waiting-for-permission #prompt {
		width: 250px;
		height: 200px;
		display: grid;
		place-items: center;
		font-family: monospace;
		font-weight: bold;
		text-decoration: underline;
		cursor: pointer;
		border: 5px dashed rgba(0,0,0,.5);
	}

	.pl-image video {
		display: block;
	}
	.pl-image .bar {
		width: inherit;
		display: flex;
		z-index: 6;
	}
	.pl-image .bar#top {
		position: absolute;
		flex-direction: column;
	}
	
	.pl-image .bar#bottom {
		background: black;
		border-radius: 0 0 1rem 1rem;
	}
	.pl-image .bar button {
		flex: 0 0 auto;
		background: rgba(255,255,255,.8);
		border: none;
		width: 2rem;
		height: 2rem;
		border-radius: 100%;
		cursor: pointer;
		z-index: 7;
	}
	.pl-image .bar button#shutter {
		width: 3rem;
		height: 3rem;
		margin: -1.5rem auto .2rem auto;
	}

	.pl-image video.takepicture {
		animation: pictureflash 200ms linear;
	}

	@keyframes pictureflash {
		0% {
			filter: grayscale(1.0) contrast(2.0);
		}

		100% {
			filter: grayscale(0.0) contrast(1.0);
		}
	}
</style>

	<div id="video-container">
		<div id="top" class="bar">
			<button id="stop" title="Stop video">✖</button>
			<button id="pop-out" title="Pop out/pop in">⏏</button>
		</div>
		<video playsinline autoplay></video>
		<div id="bottom" class="bar">
		<button id="shutter" title="Click to take a picture">📷</button>
		</div>
	</div>
		
	<div id="prompt">
		<span>
		Enable webcam
		</span>
	</div>

<script>
	// based on https://github.com/fonsp/printi-static (by the same author)

	const span = this.currentScript.parentElement
	const video = span.querySelector("video")
	const popout = span.querySelector("button#pop-out")
	const stop = span.querySelector("button#stop")
	const shutter = span.querySelector("button#shutter")
	const prompt = span.querySelector(".pl-image #prompt")

	const maxsize = $(max_size)

	const send_source = (source, src_width, src_height) => {
		const scale = Math.min(1.0, maxsize / src_width, maxsize / src_height)

		const width = Math.floor(src_width * scale)
		const height = Math.floor(src_height * scale)

		const canvas = html`<canvas width=\${width} height=\${height}>`
		const ctx = canvas.getContext("2d")
		ctx.drawImage(source, 0, 0, width, height)

		span.value = {
			width: width,
			height: height,
			data: ctx.getImageData(0, 0, width, height).data,
		}
		span.dispatchEvent(new CustomEvent("input"))
	}
	
	const clear_camera = () => {
		window.stream.getTracks().forEach(s => s.stop());
		video.srcObject = null;

		span.classList.add("waiting-for-permission");
	}

	prompt.onclick = () => {
		navigator.mediaDevices.getUserMedia({
			audio: false,
			video: {
				facingMode: "environment",
			},
		}).then(function(stream) {

			stream.onend = console.log

			window.stream = stream
			video.srcObject = stream
			window.cameraConnected = true
			video.controls = false
			video.play()
			video.controls = false

			span.classList.remove("waiting-for-permission");

		}).catch(function(error) {
			console.log(error)
		});
	}
	stop.onclick = () => {
		clear_camera()
	}
	popout.onclick = () => {
		span.classList.toggle("popped-out")
	}

	shutter.onclick = () => {
		const cl = video.classList
		cl.remove("takepicture")
		void video.offsetHeight
		cl.add("takepicture")
		video.play()
		video.controls = false
		console.log(video)
		send_source(video, video.videoWidth, video.videoHeight)
	}
	
	
	document.addEventListener("visibilitychange", () => {
		if (document.visibilityState != "visible") {
			clear_camera()
		}
	})


	// Set a default image

	const img = html`<img crossOrigin="anonymous">`

	img.onload = () => {
	console.log("helloo")
		send_source(img, img.width, img.height)
	}
	img.src = "$(default_url)"
	console.log(img)
</script>
</span>
""" |> HTML
end

# ╔═╡ 94c0798e-ee18-11ea-3212-1533753eabb6
@bind gauss_raw_camera_data camera_input(;max_size=100)

# ╔═╡ 1a0324de-ee19-11ea-1d4d-db37f4136ad3
@bind sobel_raw_camera_data camera_input(;max_size=100)

# ╔═╡ e15ad330-ee0d-11ea-25b6-1b1b3f3d7888

function process_raw_camera_data(raw_camera_data)
	# the raw image data is a long byte array, we need to transform it into something
	# more "Julian" - something with more _structure_.
	
	# The encoding of the raw byte stream is:
	# every 4 bytes is a single pixel
	# every pixel has 4 values: Red, Green, Blue, Alpha
	# (we ignore alpha for this notebook)
	
	# So to get the red values for each pixel, we take every 4th value, starting at 
	# the 1st:
	reds_flat = UInt8.(raw_camera_data["data"][1:4:end])
	greens_flat = UInt8.(raw_camera_data["data"][2:4:end])
	blues_flat = UInt8.(raw_camera_data["data"][3:4:end])
	
	# but these are still 1-dimensional arrays, nicknamed 'flat' arrays
	# We will 'reshape' this into 2D arrays:
	
	width = raw_camera_data["width"]
	height = raw_camera_data["height"]
	
	# shuffle and flip to get it in the right shape
	reds = reshape(reds_flat, (width, height))' / 255.0
	greens = reshape(greens_flat, (width, height))' / 255.0
	blues = reshape(blues_flat, (width, height))' / 255.0
	
	# we have our 2D array for each color
	# Let's create a single 2D array, where each value contains the R, G and B value of 
	# that pixel
	
	RGB.(reds, greens, blues)
end

# ╔═╡ f461f5f2-ee18-11ea-3d03-95f57f9bf09e
gauss_camera_image = process_raw_camera_data(gauss_raw_camera_data);

# ╔═╡ 169c8656-0e95-11eb-0d98-f38cabc852eb
gauss_camera_image

# ╔═╡ a75701c4-ee18-11ea-2863-d3042e71a68b
with_gaussian_blur(gauss_camera_image)

# ╔═╡ 1ff6b5cc-ee19-11ea-2ca8-7f00c204f587
sobel_camera_image = Gray.(process_raw_camera_data(sobel_raw_camera_data));

# ╔═╡ 8ddf2ef2-0e99-11eb-02ea-c743a7cde567
sobel_camera_image

# ╔═╡ 98f15e46-0e99-11eb-0ba0-45382fb0e7f0
eltype(sobel_camera_image)

# ╔═╡ a899a9f2-0e99-11eb-036d-db2f9d4ace79
typeof(sobel_camera_image)

# ╔═╡ 1bf94c00-ee19-11ea-0e3c-e12bc68d8e28
with_sobel_edge_detect(sobel_camera_image)

# ╔═╡ 441696b0-0e9a-11eb-102c-3f7e4b78c9a6
Gray.(with_sobel_edge_detect(sobel_camera_image))

# ╔═╡ Cell order:
# ╠═83eb9ca0-ed68-11ea-0bc5-99a09c68f867
# ╟─8ef13896-ed68-11ea-160b-3550eeabbd7d
# ╟─ac8ff080-ed61-11ea-3650-d9df06123e1f
# ╠═911ccbce-ed68-11ea-3606-0384e7580d7c
# ╟─5f95e01a-ee0a-11ea-030c-9dba276aba92
# ╠═65780f00-ed6b-11ea-1ecf-8b35523a7ac0
# ╟─67461396-ee0a-11ea-3679-f31d46baa9b4
# ╠═74b008f6-ed6b-11ea-291f-b3791d6d1b35
# ╟─54056a02-ee0a-11ea-101f-47feb6623bec
# ╟─540ccfcc-ee0a-11ea-15dc-4f8120063397
# ╠═467856dc-eded-11ea-0f83-13d939021ef3
# ╠═56ced344-eded-11ea-3e81-3936e9ad5777
# ╠═680fe220-086b-11eb-39b3-ff3e5123a8da
# ╠═74aded2e-086b-11eb-2732-5dae3a8fca89
# ╠═7f00d2b6-086b-11eb-3f7c-0d23b3e577f0
# ╠═859699f8-086b-11eb-32c4-378c0c0cc4b5
# ╠═98cbaf2c-086b-11eb-10ee-d3e4d30e7bea
# ╠═a3f5e6c2-086b-11eb-38d3-3d12729a8915
# ╟─ad6a33b0-eded-11ea-324c-cfabfd658b56
# ╠═b6a9e1ee-086b-11eb-1782-cb51775e9890
# ╠═f51333a6-eded-11ea-34e6-bfbb3a69bcb0
# ╠═cd4a90ec-086b-11eb-293e-a19aa25d2635
# ╠═b18e2c54-edf1-11ea-0cbf-85946d64b6a2
# ╟─397941fc-edee-11ea-33f2-5d46c759fbf7
# ╠═b1d5ca28-edf6-11ea-269e-75a9fb549f1d
# ╠═4a151564-086c-11eb-380a-a5e96d11e49b
# ╠═74166fd4-086c-11eb-3c4b-356dfdb62c67
# ╠═6d149262-086c-11eb-3e75-a73466c9815c
# ╠═53e22386-086c-11eb-2465-7d513d28f3a2
# ╠═66cc93a0-086c-11eb-308a-37256d25b79f
# ╟─cf738088-eded-11ea-2915-61735c2aa990
# ╠═b551707c-086c-11eb-15b2-01c6288c6832
# ╠═0ffa8354-edee-11ea-2883-9d5bfea4a236
# ╠═1f104ce4-ee0e-11ea-2029-1d9c817175af
# ╟─38dc80a0-edef-11ea-10e9-615255a4588c
# ╠═11cd8e30-086d-11eb-3d56-d9e428ac9506
# ╠═116aa5ca-086d-11eb-39ca-3bf8a5cf18d4
# ╠═20a41974-086d-11eb-3793-d71d91df3c05
# ╠═2758613a-086d-11eb-382e-95870f209e6c
# ╟─1f229ca4-edee-11ea-2c56-bb00cc6ea53c
# ╠═2a391708-edee-11ea-124e-d14698171b68
# ╟─2b1ccaca-edee-11ea-34b0-c51659f844d0
# ╟─e2863d4c-edef-11ea-1d67-332ddca03cc4
# ╠═83988c86-086d-11eb-0857-bbba6d29df78
# ╠═896a6382-086d-11eb-2298-77e373745071
# ╠═ec5efe8c-edef-11ea-2c6f-afaaeb5bc50c
# ╟─29e10640-edf0-11ea-0398-17dbf4242de3
# ╟─6f67657e-ee1a-11ea-0c2f-3d567bcfa6ea
# ╠═38155b5a-edf0-11ea-3e3f-7163da7433fb
# ╠═73ef1d50-edf0-11ea-343c-d71706874c82
# ╟─a5f8bafe-edf0-11ea-0da3-3330861ae43a
# ╠═1b8b2e0c-086e-11eb-08cd-1b0b39167cc9
# ╠═e8e678c2-086e-11eb-3b2d-491c155288ce
# ╠═f791ade4-086e-11eb-27ee-b9f2fd4df58d
# ╠═fb421d6e-086e-11eb-1780-8b06cb6cbecc
# ╠═b6b65b94-edf0-11ea-3686-fbff0ff53d08
# ╠═32814b60-086f-11eb-1fab-d9a511a10d23
# ╟─d862fb16-edf1-11ea-36ec-615d521e6bc0
# ╟─e3394c8a-edf0-11ea-1bb8-619f7abb6881
# ╟─22f28dae-edf2-11ea-25b5-11c369ae1253
# ╠═ac167180-086f-11eb-158c-bdd827e3ea65
# ╠═c6bfe0e8-086f-11eb-34f2-218889ba308d
# ╠═252fd35e-0870-11eb-33eb-0d885bd8368e
# ╟─46e9df46-0870-11eb-3c84-1fbab587fa76
# ╠═e2b62012-0871-11eb-1f95-d33b1542fd82
# ╠═8c19fb72-ed6c-11ea-2728-3fa9219eddc4
# ╠═c4761a7e-edf2-11ea-1e75-118e73dadbed
# ╟─adfbe9b2-ed6c-11ea-09ac-675262f420df
# ╟─393667ca-edf2-11ea-09c5-c5d292d5e896
# ╠═6642d9ca-0872-11eb-37a7-a5692ac5af45
# ╠═1cdcc732-0872-11eb-361b-69f7289c05ea
# ╠═5ab31a84-0872-11eb-2280-b5efb09bd6d6
# ╠═605df7b0-0872-11eb-0bb5-5b856f9e70cc
# ╠═85f0afe0-0872-11eb-3f17-d530a17f0074
# ╠═9f1c6d04-ed6c-11ea-007b-75e7e780703d
# ╠═dbaf94fa-0872-11eb-1d61-aff3b58d8f77
# ╠═dd65abfe-0872-11eb-0ac6-2fab9c82bb0d
# ╠═70955aca-ed6e-11ea-2330-89b4d20b1795
# ╠═e06b7fbc-edf2-11ea-1708-fb32599dded3
# ╠═5da8cbe8-eded-11ea-2e43-c5b7cc71e133
# ╟─45815734-ee0a-11ea-2982-595e1fc0e7b1
# ╟─62559026-0b12-11eb-3ff3-4b942eed65b2
# ╟─e083b3e8-ed61-11ea-2ec9-217820b0a1b4
# ╠═c5484572-ee05-11ea-0424-f37295c3072d
# ╠═3deb6ae0-0b0c-11eb-38c4-51c7347c7989
# ╠═c8ecfe5c-ee05-11ea-322b-4b2714898831
# ╟─e86ed944-ee05-11ea-3e0f-d70fc73b789c
# ╟─c54ccdea-ee05-11ea-0365-23aaf053b7d7
# ╠═4f87f44c-0951-11eb-1480-01d3229a6c15
# ╠═c60d7cd4-0b10-11eb-2963-b9423a51cb57
# ╠═cd9137a2-0b10-11eb-3b40-8b27a3749da7
# ╠═0571a6fa-0b11-11eb-3f7b-d78d36dec3b5
# ╠═4528db26-0b11-11eb-0e51-0f030f77abd2
# ╠═2587593c-0b11-11eb-23ab-cfad6e206e4f
# ╠═ea6d6a66-0b0c-11eb-3c5b-4d7745cb7967
# ╠═48767108-0b11-11eb-0d67-0d8270720f74
# ╠═483d3ab4-0b11-11eb-183c-d192271ee63f
# ╠═f6898df6-ee07-11ea-2838-fde9bc739c11
# ╠═5be9b144-ee0d-11ea-2a8d-8775de265a1d
# ╟─4d0158d0-ee0d-11ea-17c3-c169d4284acb
# ╟─d75ec078-ee0d-11ea-3723-71fb8eecb040
# ╟─51cf16c8-0b12-11eb-0cef-61eb404e851a
# ╟─f68d4a36-ee07-11ea-0832-0360530f102e
# ╠═f1b0e7d8-0b13-11eb-2d59-7585f58d4314
# ╠═3d757614-0b14-11eb-0531-414e0a643824
# ╠═77494994-0b14-11eb-0c4e-f14fcd2e2b44
# ╠═7b39552e-0b14-11eb-081c-713738b71a16
# ╠═7dbb6dda-0b15-11eb-213d-b1e201ce502b
# ╠═f6991a50-ee07-11ea-0bc4-1d68eb028e6a
# ╠═51ac16be-0bc1-11eb-2ac6-5bce4590297c
# ╠═fac6fdb6-0b14-11eb-1dc0-c37de0a38832
# ╠═bfea524a-0b8e-11eb-3b24-2b386cc2396b
# ╠═1293e99c-0bb8-11eb-061f-11f5b0dca1fb
# ╠═2d272712-0bb8-11eb-3a63-f97ce1bd5903
# ╟─c539037a-0bb8-11eb-1dbb-85ba87f6e683
# ╠═a9447ea0-0b8e-11eb-3907-f3461a5ba36e
# ╠═f6a655f8-ee07-11ea-13b6-43ca404ddfc7
# ╟─c905b73e-ee1a-11ea-2e36-23b8e73bfdb6
# ╟─f6b218c0-ee07-11ea-2adb-1968c4fd473a
# ╟─f6bf64da-ee07-11ea-3efb-05af01b14f67
# ╟─25dad7ce-ee0b-11ea-3e20-5f3019dd7fa3
# ╠═9751586e-ee0c-11ea-0cbb-b7eda92977c9
# ╠═e0d427be-0bc1-11eb-3ef6-6d5e148ce9b6
# ╠═e5ae6d1c-0bc1-11eb-2f95-617389620926
# ╠═19e7f80e-0bc3-11eb-10f6-377a304761a5
# ╠═27267f7c-0bc3-11eb-2f52-db15681030f1
# ╠═3c56e792-0bc3-11eb-2142-292d8ee33d45
# ╠═521fb932-0bc3-11eb-0be0-23ecf85ece1b
# ╠═586cbf14-0bc4-11eb-2551-5f7f95318bf3
# ╟─f6cc03a0-ee07-11ea-17d8-013991514d42
# ╠═63e8d636-ee0b-11ea-173d-bd3327347d55
# ╟─2cc2f84e-ee0d-11ea-373b-e7ad3204bb00
# ╠═b8f26960-ee0a-11ea-05b9-3f4bc1099050
# ╠═5de3a22e-ee0b-11ea-230f-35df4ca3c96d
# ╠═4e21e0c4-ee0b-11ea-3d65-b311ae3f98e9
# ╠═6dbf67ce-ee0b-11ea-3b71-abc05a64dc43
# ╟─846b1330-ee0b-11ea-3579-7d90fafd7290
# ╠═943103e2-ee0b-11ea-33aa-75a8a1529931
# ╠═f6d6c71a-ee07-11ea-2b63-d759af80707b
# ╠═350ecad2-0bc7-11eb-377b-1ba0d5c48b98
# ╠═39be88ec-0bc7-11eb-17b9-ab21f4564997
# ╠═71678e16-0bcb-11eb-1106-5318376347f7
# ╠═961068b4-0bcb-11eb-1346-2f19eeee0252
# ╠═43e87166-0bcc-11eb-08d6-6157d411ec74
# ╠═7fa37a22-0bcc-11eb-0719-cf4796f11354
# ╠═f6e2cb2a-ee07-11ea-06ee-1b77e34c1e91
# ╟─f6ef2c2e-ee07-11ea-13a8-2512e7d94426
# ╟─f6fc1312-ee07-11ea-39a0-299b67aee3d8
# ╠═774b4ce6-ee1b-11ea-2b48-e38ee25fc89b
# ╠═7e4aeb70-ee1b-11ea-100f-1952ba66f80f
# ╟─6a05f568-ee1b-11ea-3b6c-83b6ada3680f
# ╟─f70823d2-ee07-11ea-2bb3-01425212aaf9
# ╠═e70a84d4-ee0c-11ea-0640-bf78653ba102
# ╠═ac15e0d0-ee0c-11ea-1eaf-d7f88b5df1d7
# ╟─f4475558-0bcd-11eb-1e50-21cfdc41c8b3
# ╟─fc7674b6-0bcd-11eb-18b6-9501c2b84731
# ╠═5ff81cce-0bce-11eb-3a9d-cb26b239a921
# ╠═9604bc44-ee1b-11ea-28f8-7f7af8d0cbb2
# ╠═6456d684-0bce-11eb-1976-f908096fefcf
# ╠═8c798bfc-0bce-11eb-0e5e-7b38ee407384
# ╠═980a6252-0bce-11eb-2e2b-65cfe0d80adb
# ╟─f714699e-ee07-11ea-08b6-5f5169861b57
# ╟─bdc2df7c-ee0c-11ea-2e9f-7d2c085617c1
# ╟─81510a30-ee0e-11ea-0062-8b3327428f9d
# ╠═6b30dc38-ed6b-11ea-10f3-ab3f121bf4b8
# ╟─e3b03628-ee05-11ea-23b6-27c7b0210532
# ╟─4139ee66-ee0a-11ea-2282-15d63bcca8b8
# ╟─29ec796a-0be0-11eb-2186-7f5f336e014e
# ╟─e08781fa-ed61-11ea-13ae-91a49b5eb74a
# ╟─7fc8ee1c-ee09-11ea-1382-ad21d5373308
# ╠═7fcd6230-ee09-11ea-314f-a542d00d582e
# ╠═7fdb34dc-ee09-11ea-366b-ffe10d1aa845
# ╟─7fe9153e-ee09-11ea-15b3-6f24fcc20734
# ╟─80108d80-ee09-11ea-0368-31546eb0d3cc
# ╠═01070e28-ee0f-11ea-1928-a7919d452bdd
# ╟─7522f81e-ee1c-11ea-35af-a17eb257ff1a
# ╟─801d90c0-ee09-11ea-28d6-61b806de26dc
# ╠═537820ae-0cad-11eb-2d18-f36ea34f1706
# ╠═97854cf4-0cad-11eb-3f86-35a33b6d6e7f
# ╠═a95fc44a-0cad-11eb-0ab3-090e2754372f
# ╠═bb5e7830-0cad-11eb-2d92-e1412828b4be
# ╠═802bec56-ee09-11ea-043e-51cf1db02a34
# ╟─956e29bc-0cae-11eb-2c82-193b60071039
# ╟─b7f3994c-ee1b-11ea-211a-d144db8eafc2
# ╠═04cbbab2-0d34-11eb-0e65-0f027e0d4c42
# ╠═17e5beac-0d34-11eb-3ac8-4d898843643e
# ╠═1c6a3728-0d34-11eb-032b-39efe36a1efd
# ╠═803905b2-ee09-11ea-2d52-e77ff79693b0
# ╠═80479d98-ee09-11ea-169e-d166eef65874
# ╠═805691ce-ee09-11ea-053d-6d2e299ee123
# ╟─806e5766-ee0f-11ea-1efc-d753cd83d086
# ╠═38da843a-ee0f-11ea-01df-bfa8b1317d36
# ╟─9bde9f92-ee0f-11ea-27f8-ffef5fce2b3c
# ╠═45c4da9a-ee0f-11ea-2c5b-1f6704559137
# ╠═6781cf0a-0d34-11eb-14f1-a7295b76ba99
# ╠═7b1249aa-0d34-11eb-21ca-ab7b46d4405c
# ╟─bcf98dfc-ee1b-11ea-21d0-c14439500971
# ╠═80664e8c-ee09-11ea-0702-711bce271315
# ╠═c4f2702e-0d34-11eb-0bea-5ffe451c46ec
# ╠═ac54dc16-0d35-11eb-3cf4-f1cf7b90e032
# ╠═b6ff3c74-0d35-11eb-15ff-55c704192250
# ╠═f05f8b4a-0d35-11eb-1e56-e39a50ab53b7
# ╠═24b2a8fa-0d36-11eb-173e-c7f182d0ebf5
# ╠═807e5662-ee09-11ea-3005-21fdcc36b023
# ╟─808deca8-ee09-11ea-0ee3-1586fa1ce282
# ╟─809f5330-ee09-11ea-0e5b-415044b6ac1f
# ╠═ca1ac5f4-ee1c-11ea-3d00-ff5268866f87
# ╠═c8648608-0d36-11eb-15d6-452d813b345a
# ╠═d043c956-0d36-11eb-2d8e-9d0aa9e5d79a
# ╠═d00aa748-0d36-11eb-2dbc-e99d5068c249
# ╟─ea435e58-ee11-11ea-3785-01af8dd72360
# ╟─80ab64f4-ee09-11ea-29b4-498112ed0799
# ╠═e0f50170-0d38-11eb-245b-39600406e6be
# ╠═f9e32a52-0d38-11eb-2b67-6f243577a8d8
# ╠═14bf4fb8-0d39-11eb-3847-8157b9af761f
# ╠═b6e11514-0d3a-11eb-0275-97c49ed16cbe
# ╠═28e20950-ee0c-11ea-0e0a-b5f2e570b56e
# ╠═74d44d30-0d3a-11eb-3fa9-01387aee71b7
# ╠═c68e7b98-0d3a-11eb-043c-6d2bceb36ebf
# ╟─e9aadeee-ee1d-11ea-3525-95f6ba5fda31
# ╟─5eea882c-ee13-11ea-0d56-af81ecd30a4a
# ╠═93284f92-ee12-11ea-0342-833b1a30625c
# ╟─cf73f9f8-ee12-11ea-39ae-0107e9107ef5
# ╟─7ffd14f8-ee1d-11ea-0343-b54fb0333aea
# ╟─2a24d1fa-0d3b-11eb-158c-0d8cc274c09d
# ╟─80b7566a-ee09-11ea-3939-6fab470f9ec8
# ╠═12c4d59c-0dda-11eb-0543-7ba2f33f5360
# ╠═585926a8-0dda-11eb-12cf-d309bb4c8386
# ╠═613815ae-0dda-11eb-1beb-f96e9aad022e
# ╠═6b811306-0dda-11eb-2f97-bfeb63a2e18d
# ╠═866c589e-0dda-11eb-2695-b5b6a1766694
# ╠═8aca0e40-0dda-11eb-2be7-6f20eabf4457
# ╠═e5b23738-0dda-11eb-0aa3-2df8f3999fdc
# ╠═ebe4f570-0dda-11eb-0336-715fbd1a1919
# ╠═1c8b4658-ee0c-11ea-2ede-9b9ed7d3125e
# ╟─f8bd22b8-ee14-11ea-04aa-ab16fd01826e
# ╠═2a9dd06a-ee13-11ea-3f84-67bb309c77a8
# ╠═3cad462a-0de7-11eb-2a39-f79ad1828073
# ╠═b424e2aa-ee14-11ea-33fa-35491e0b9c9d
# ╠═38eb92f6-ee13-11ea-14d7-a503ac04302e
# ╟─bc1c20a4-ee14-11ea-3525-63c9fa78f089
# ╠═24c21c7c-ee14-11ea-1512-677980db1288
# ╠═4ed7a246-0de7-11eb-10b0-b1ec396343c2
# ╠═cc1ea2ac-0de6-11eb-0d9c-0bf9f6831b57
# ╠═096fb31a-0de7-11eb-0faf-ddf11f1a7982
# ╠═aee2ebce-0de6-11eb-26f7-711c2bd7acef
# ╟─27847dc4-ee0a-11ea-0651-ebbbb3cfd58c
# ╟─b01858b6-edf3-11ea-0826-938d33c19a43
# ╟─7c1bc062-ee15-11ea-30b1-1b1e76520f13
# ╠═cba57002-0de8-11eb-190c-37a1f8678426
# ╠═7c2ec6c6-ee15-11ea-2d7d-0d9401a5e5d1
# ╟─649df270-ee24-11ea-397e-79c4355e38db
# ╟─9afc4dca-ee16-11ea-354f-1d827aaa61d2
# ╠═cf6b05e2-ee16-11ea-3317-8919565cb56e
# ╠═e3616062-ee27-11ea-04a9-b9ec60842a64
# ╠═e5b6cd34-ee27-11ea-0d60-bd4796540b18
# ╟─d06ea762-ee27-11ea-2e9c-1bcff86a3fe0
# ╠═e1dc0622-ee16-11ea-274a-3b6ec9e15ab5
# ╟─efd1ceb4-ee1c-11ea-350e-f7e3ea059024
# ╠═8500cc02-0df2-11eb-38d7-fbdaef2d75bf
# ╠═345644a2-0df3-11eb-28e9-2f18f49de908
# ╠═b52bac08-0df2-11eb-21a1-1b5db8b1592b
# ╟─af53cb96-0df3-11eb-3d02-77cf0adb6386
# ╠═584304be-0df2-11eb-2eeb-2bae9d770a30
# ╠═dcdabd1e-0df2-11eb-18be-f1ae118c10ab
# ╠═02acf2d4-0df3-11eb-0e5c-d320ca3f12ea
# ╠═8a9993da-0df5-11eb-0e76-ad243bb3d0f1
# ╟─7c41f0ca-ee15-11ea-05fb-d97a836659af
# ╠═8caaf4e6-0df5-11eb-2ae3-ff75e57068ec
# ╠═d6b44f92-0df7-11eb-0498-43e0b1a66999
# ╠═8b96e0bc-ee15-11ea-11cd-cfecea7075a0
# ╟─0cabed84-ee1e-11ea-11c1-7d8a4b4ad1af
# ╟─5a5135c6-ee1e-11ea-05dc-eb0c683c2ce5
# ╠═577c6daa-ee1e-11ea-1275-b7abc7a27d73
# ╠═275a99c8-ee1e-11ea-0a76-93e3618c9588
# ╠═42dfa206-ee1e-11ea-1fcd-21671042064c
# ╟─6e53c2e6-ee1e-11ea-21bd-c9c05381be07
# ╠═e7f8b41a-ee25-11ea-287a-e75d33fbd98b
# ╟─7a7f08fa-0e94-11eb-01f9-49a431944580
# ╟─7c50ea80-ee15-11ea-328f-6b4e4ff20b7e
# ╠═b3ec7ac2-0e95-11eb-2823-35632ede6889
# ╠═aad67fd0-ee15-11ea-00d4-274ec3cda3a3
# ╟─8ae59674-ee18-11ea-3815-f50713d0fa08
# ╠═94c0798e-ee18-11ea-3212-1533753eabb6
# ╠═169c8656-0e95-11eb-0d98-f38cabc852eb
# ╠═a75701c4-ee18-11ea-2863-d3042e71a68b
# ╟─f461f5f2-ee18-11ea-3d03-95f57f9bf09e
# ╟─7c6642a6-ee15-11ea-0526-a1aac4286cdd
# ╠═bce31dbe-0e97-11eb-0df5-9d5380e77fd0
# ╠═67643534-0e98-11eb-0569-fd0d8614ad39
# ╠═dc6f63ce-0e98-11eb-1d0d-e352ac0593bd
# ╠═e6dc98ba-0e98-11eb-10a2-339e154ae101
# ╠═6ac0de12-0e98-11eb-2ee8-4f463edf9111
# ╠═9eeb876c-ee15-11ea-1794-d3ea79f47b75
# ╠═1a0324de-ee19-11ea-1d4d-db37f4136ad3
# ╠═8ddf2ef2-0e99-11eb-02ea-c743a7cde567
# ╠═98f15e46-0e99-11eb-0ba0-45382fb0e7f0
# ╠═a899a9f2-0e99-11eb-036d-db2f9d4ace79
# ╠═1bf94c00-ee19-11ea-0e3c-e12bc68d8e28
# ╠═441696b0-0e9a-11eb-102c-3f7e4b78c9a6
# ╟─1ff6b5cc-ee19-11ea-2ca8-7f00c204f587
# ╟─0001f782-ee0e-11ea-1fb4-2b5ef3d241e2
# ╟─1b85ee76-ee10-11ea-36d7-978340ef61e6
# ╠═477d0a3c-ee10-11ea-11cf-07b0e0ce6818
# ╟─91f4778e-ee20-11ea-1b7e-2b0892bd3c0f
# ╟─8ffe16ce-ee20-11ea-18bd-15640f94b839
# ╟─5842895a-ee10-11ea-119d-81e4c4c8c53b
# ╠═5516c800-edee-11ea-12cf-3f8c082ef0ef
# ╟─57360a7a-edee-11ea-0c28-91463ece500d
# ╟─dcb8324c-edee-11ea-17ff-375ff5078f43
# ╟─58af703c-edee-11ea-2963-f52e78fc2412
# ╟─f3d00a9a-edf3-11ea-07b3-1db5c6d0b3cf
# ╠═5aa9dfb2-edee-11ea-3754-c368fb40637c
# ╟─74d44e22-edee-11ea-09a0-69aa0aba3281
# ╟─115ded8c-ee0a-11ea-3493-89487315feb7
# ╟─dfb7c6be-ee0d-11ea-194e-9758857f7b20
# ╟─e15ad330-ee0d-11ea-25b6-1b1b3f3d7888
