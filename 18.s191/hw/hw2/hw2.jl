### A Pluto.jl notebook ###
# v0.12.6

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

# ╔═╡ 86e1ee96-f314-11ea-03f6-0f549b79e7c9
begin
	using Pkg
	Pkg.activate(mktempdir())
end

# ╔═╡ a4937996-f314-11ea-2ff9-615c888afaa8
begin
	Pkg.add([
			"Images",
			"ImageMagick",
			"Compose",
			"ImageFiltering",
			"TestImages",
			"Statistics",
			"PlutoUI",
			"BenchmarkTools"
			])

	using Images
	using TestImages
	using ImageFiltering
	using Statistics
	using PlutoUI
	using BenchmarkTools
end

# ╔═╡ e6b6760a-f37f-11ea-3ae1-65443ef5a81a
md"_homework 2, version 2.1_"

# ╔═╡ 85cfbd10-f384-11ea-31dc-b5693630a4c5
md"""

# **Homework 2**: _Dynamic programming_
`18.S191`, fall 2020

This notebook contains _built-in, live answer checks_! In some exercises you will see a coloured box, which runs a test case on your code, and provides feedback based on the result. Simply edit the code, run it, and the check runs again.

_For MIT students:_ there will also be some additional (secret) test cases that will be run as part of the grading process, and we will look at your notebook and write comments.

Feel free to ask questions!
"""

# ╔═╡ 33e43c7c-f381-11ea-3abc-c942327456b1
# edit the code below to set your name and kerberos ID (i.e. email without @mit.edu)

student = (name = "phunc20", kerberos_id = "jazz")

# you might need to wait until all other cells in this notebook have completed running. 
# scroll around the page to see what's up

# ╔═╡ ec66314e-f37f-11ea-0af4-31da0584e881
md"""

Submission by: **_$(student.name)_** ($(student.kerberos_id)@mit.edu)
"""

# ╔═╡ 938185ec-f384-11ea-21dc-b56b7469f798
md"_Let's create a package environment:_"

# ╔═╡ 0d144802-f319-11ea-0028-cd97a776a3d0
#img = load(download("https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/Piet_Mondriaan%2C_1930_-_Mondrian_Composition_II_in_Red%2C_Blue%2C_and_Yellow.jpg/300px-Piet_Mondriaan%2C_1930_-_Mondrian_Composition_II_in_Red%2C_Blue%2C_and_Yellow.jpg"))
#img = load(download("https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Hilma_af_Klint_-_Group_IX_SUW%2C_The_Swan_No._1_%2813947%29.jpg/477px-Hilma_af_Klint_-_Group_IX_SUW%2C_The_Swan_No._1_%2813947%29.jpg"))
#img = load(download("https://i.imgur.com/4SRnmkj.png"))
img = load("fruits-creatures.png")

# ╔═╡ 78f3d1ba-11ef-11eb-1385-032119a54ee9


# ╔═╡ cc9fcdae-f314-11ea-1b9a-1f68b792f005
md"""
# Arrays: Slices and views

In the lecture (included below) we learned about what array views are. In this exercise we will add to that understanding and look at an important use of `view`s: to reduce the amount of memory allocations when reading sub-sequences within an array.

We will use the `BenchmarkTools` package to emperically understand the effects of using views.
"""

# ╔═╡ b49a21a6-f381-11ea-1a98-7f144c55c9b7
html"""
<iframe width="100%" height="450px" src="https://www.youtube.com/embed/gTGJ80HayK0?rel=0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
"""

# ╔═╡ b49e8cc8-f381-11ea-1056-91668ac6ae4e
md"""
## Shrinking an array

Below is a function called `remove_in_each_row(img, pixels)`. It takes a matrix `img` and a vector of integers, `pixels`, and shrinks the image by 1 pixel in width by removing the element `img[i, pixels[i]]` in every row. This function is one of the building blocks of the Image Seam algorithm we saw in the lecture.

Read it and convince yourself that it is correct.
"""

# ╔═╡ 5d9c9270-11f0-11eb-14e8-6f5ffe7a6c41
vcat

# ╔═╡ 6882bbd8-11f0-11eb-1c83-7f4c929d60fb
hcat

# ╔═╡ 45bccee0-11f0-11eb-0689-7b83f464a92b
vcat(img[1, 3:5], img[2, 7:9])

# ╔═╡ fe46cf3a-11f0-11eb-120a-6d9d66f001da
size(img[1, 3:5])

# ╔═╡ a12da3b2-11f0-11eb-3d19-c994afe71784
size(vcat(img[1, 3:5], img[2, 7:9]))

# ╔═╡ e208b2dc-11f0-11eb-3b7a-af3a6a318ccf
size(hcat(img[1, 3:5], img[2, 7:9]))

# ╔═╡ e799be82-f317-11ea-3ae4-6d13ece3fe10
function remove_in_each_row(img, column_numbers)
	@assert size(img, 1) == length(column_numbers) # same as the number of rows
	m, n = size(img)
	local img′ = similar(img, m, n-1) # create a similar image with one less column

	# The prime (′) in the variable name is written as \prime<TAB>
    # You cannot use apostrophe for this! (Apostrophe means the transpose of a matrix)

	for (i, j) in enumerate(column_numbers)
		img′[i, :] = vcat(img[i, 1:j-1], img[i, j+1:end])
		## Here it probably doesn't matter whether we use hcat or vcat, right?
		#img′[i, :] = hcat(img[i, 1:j-1], img[i, j+1:end])
		## No, it matters!!!
	end
	img′
end

# ╔═╡ c075a8e6-f382-11ea-2263-cd9507324f4f
md"Let's use it to remove the pixels on the diagonal. These are the image dimensions before and after doing so:"

# ╔═╡ f7a945d4-1358-11eb-0c6f-87875e89bbb7
remove_in_each_row(img, 1:size(img, 1))

# ╔═╡ 9cced1a8-f326-11ea-0759-0b2f22e5a1db
(before=size(img), after=size(remove_in_each_row(img, 1:size(img, 1))))

# ╔═╡ bc6b0926-1b7d-11eb-01ed-1d7298112711
(before=img, after=remove_in_each_row(img, 1:size(img, 1)))

# ╔═╡ 1d893998-f366-11ea-0828-512de0c44915
md"""
## **Exercise 1** - _Making it efficient_

We can use the `@benchmark` macro from the [BenchmarkTools.jl](https://github.com/JuliaCI/BenchmarkTools.jl) package to benchmark fragments of Julia code. 

`@benchmark` takes an expression and runs it a number of times to obtain statistics about the run time (somewhat like `%%timeit` in Jupyter notebook) and memory allocation. We generally take the __`minimum time`__ as the most stable measurement of performance ([for reasons discussed in the paper on BenchmarkTools](http://www-math.mit.edu/~edelman/publications/robust_benchmarking.pdf))
"""

# ╔═╡ 59991872-f366-11ea-1036-afe313fb4ec1
md"""
First, as an example, let's benchmark the `remove_in_each_row` function we defined above by passing in our image and a some indices to remove.
"""

# ╔═╡ e501ea28-f326-11ea-252a-53949fd9ef57
performance_experiment_default = @benchmark remove_in_each_row(img, 1:size(img, 1))

# ╔═╡ f7915918-f366-11ea-2c46-2f4671ae8a22
md"""
#### Exercise 1.1

`vcat(x, y)` is used in julia to concatenate two arrays vertically. This actually creates a new array of size `length(x) + length(y)` and copies `x` and `y` into it.  We use it in `remove_in_each_row` to create rows which have one pixel less.

While using `vcat` might make it easy to write the first version of our function, it's strictly not necessary.

👉 In `remove_in_each_row_no_vcat` below, figure out a way to avoid using `vcat`.
"""

# ╔═╡ 10eae3b2-11f2-11eb-281d-cf3d2ae95068
1:10 + 12:20

# ╔═╡ 99997184-1b7e-11eb-3961-81f1e8a55cb2
(1:10 + 12:20)[10]

# ╔═╡ f09dbd4c-1b7f-11eb-3876-5b7b2195c2e1
(10:20)[[1,3,4]]

# ╔═╡ 2046b314-1b80-11eb-1cd3-1deaa3574550
1:3, 4:10

# ╔═╡ 77d345f0-1b80-11eb-1851-6b5463376851
typeof(1:10)

# ╔═╡ 808508dc-1b80-11eb-257b-31af70c7f175
Set(1:10)

# ╔═╡ 983b9a8e-1b80-11eb-00e3-c39b0ac10d18
Set(1:10)

# ╔═╡ 37d4ea5c-f327-11ea-2cc5-e3774c232c2b
function remove_in_each_row_no_vcat(img, column_numbers)
	@assert size(img, 1) == length(column_numbers) # same as the number of rows
	m, n = size(img)
	local img′ = similar(img, m, n-1) # create a similar image with one less column

	for (i, j) in enumerate(column_numbers)
		# EDIT THE FOLLOWING LINE and split it into two lines
		# to avoid using `vcat`.
		#img′[i, :] .= vcat(img[i, 1:j-1], img[i, j+1:end])
		
		## Almost there: Still using a copy, not view.
		#img′[i, :] .= [img[i, 1:j-1]
		#	           img[i, j+1:end]]
		## One correct answer
		img′[i, :] = [@view img[i, 1:j-1]
			          @view img[i, j+1:end]]
		## Another possibly correct answer:
		## sth link img[i, 1:j-1 `+` j+1:end]
	end
	img′
end

# ╔═╡ 67717d02-f327-11ea-0988-bfe661f57f77
performance_experiment_without_vcat = @benchmark remove_in_each_row_no_vcat(img, 1:size(img, 1))

# ╔═╡ 9e149cd2-f367-11ea-28ef-b9533e8a77bb
md"""
If you did it correctly, you should see that this benchmark shows the function running faster! And "memory estimate" should also show a smaller number, and so should "allocs estimate" which is the number of allocations done per call.
"""

# ╔═╡ ba1619d4-f389-11ea-2b3f-fd9ba71cf7e3
md"""
#### Exercise 1.2

👉 How many estimated allocations did this optimization reduce, and how can you explain most of them?
"""

# ╔═╡ 4fa5f906-11f3-11eb-3479-5f0b7393940d
size(img)

# ╔═╡ e49235a4-f367-11ea-3913-f54a4a6b2d6b
no_vcat_observation = md"""
I have not much knowledge in computer science, but, as one can observe, **the number of `allocs estimate`**
drops from $1029$ to $345.\;$ `img` has $342$ rows and $1029 - 345 = 684 = 342 \times 2\,.$
"""

# ╔═╡ 837c43a4-f368-11ea-00a3-990a45cb0cbd
md"""

#### Exercise 1.3 - `view`-based optimization

👉 In the below `remove_in_each_row_views` function, implement the same optimization to remove `vcat` and use `@view` or `@views` to avoid creating copies or slices of the `img` array.

Pluto will automatically time your change with `@benchmark` below.
"""

# ╔═╡ 90a22cc6-f327-11ea-1484-7fda90283797
function remove_in_each_row_views(img, column_numbers)
	@assert size(img, 1) == length(column_numbers) # same as the number of rows
	m, n = size(img)
	local img′ = similar(img, m, n-1) # create a similar image with one less column

	for (i, j) in enumerate(column_numbers)
		# EDIT THE FOLLOWING LINE and split it into two lines
		# to avoid using `vcat`.
		img′[i, 1:j-1] = @view img[i, 1:j-1]
		img′[i, j:end] = @view img[i, j+1:end]
	end
	img′
end

# ╔═╡ 3335e07c-f328-11ea-0e6c-8d38c8c0ad5b
performance_experiment_views = @benchmark begin
	remove_in_each_row_views(img, 1:size(img, 1))
end

# ╔═╡ 40d6f562-f329-11ea-2ee4-d7806a16ede3
md"Final tally:"

# ╔═╡ 4f0975d8-f329-11ea-3d10-59a503f8d6b2
(
	default = performance_experiment_default, 
	without_vcat = performance_experiment_without_vcat,
	views = performance_experiment_views,
)

# ╔═╡ dc63d32a-f387-11ea-37e2-6f3666a72e03
⧀(a, b) = minimum(a).allocs + size(img, 1) ÷ 2  < minimum(b).allocs;

# ╔═╡ 7eaa57d2-f368-11ea-1a70-c7c7e54bd0b1
md"""

#### Exercise 1.4

Nice! If you did your optimizations right, you should be able to get down the estimated allocations to a single digit number!

👉 How many allocations were avoided by adding the `@view` optimization over the `vcat` optimization? Why is this?
"""

# ╔═╡ fd819dac-f368-11ea-33bb-17148387546a
views_observation = md"""
I do not know how to explain why exactly `3 allocs estimate` is left, but from our 2nd result of `345 allocs` down to `3 allocs` it can seem to be explained by the fact that
> By using entirely **`@view`** we avoided another `342` allocations (i.e. $345 - 342 = 3$), which is the number of rows in the matrix (i.e. `size(img, 1)` equals `342`). The reduction of `342` allocations might be due to the fact that, in the 2nd implementation, we've allocated one new array for each row, resulting to exactly `342` allocations.

**Rmk.** Besides, I think one can view `1 alloc estimate = 1 copy`, i.e. `@view` will not result in `alloc estimate`.
"""

# ╔═╡ fc1fbeec-12a9-11eb-34ae-a14eb0b5b03e
md"
**(?1)** If your answer to Exercise 1.3 were correct, how can you explain `allocs estimate = 3` here?
"

# ╔═╡ a1dc747e-142e-11eb-252e-6722818c93e2
md"
**(R1)** I am not sure about this, but one possible answer could be
_The number $3$ in the remaining number of allocations comes from_
- `m, n = size(img)`, which contributes to $2$ allocations
- `img\prime = similar(img, m, n-1)`, which gives rise to $1$ allocation 
"

# ╔═╡ 2a4ab6b2-12aa-11eb-226d-01d3f5ee6c9d
md"
##### Stopped here (2020/10/20 15h00)

"

# ╔═╡ 318a2256-f369-11ea-23a9-2f74c566549b
md"""
## _Brightness and Energy_
"""

# ╔═╡ 7a44ba52-f318-11ea-0406-4731c80c1007
md"""
First, we will define a `brightness` function for a pixel (a color) as the mean of the red, green and blue values.

You should use this function whenever the problem set asks you to deal with _brightness_ of a pixel.
"""

# ╔═╡ 6c7e4b54-f318-11ea-2055-d9f9c0199341
begin
	brightness(c::RGB) = mean((c.r, c.g, c.b))
	brightness(c::RGBA) = mean((c.r, c.g, c.b))
end

# ╔═╡ 74059d04-f319-11ea-29b4-85f5f8f5c610
Gray.(brightness.(img))

# ╔═╡ cf99813e-1430-11eb-1c86-055f4f4dcbf2
typeof(img)

# ╔═╡ c860e7c4-1430-11eb-31c8-537a4d285e56
brightness.(img)

# ╔═╡ 1b3f2616-1431-11eb-3395-9f439bc589e4
size(brightness.(img))

# ╔═╡ 24748b2a-1431-11eb-0589-4bb7057d91e9
typeof(brightness.(img))

# ╔═╡ 0b9ead92-f318-11ea-3744-37150d649d43
md"""We provide you with a convolve function below.
"""

# ╔═╡ d184e9cc-f318-11ea-1a1e-994ab1330c1a
convolve(img, k) = imfilter(img, reflect(k)) # uses ImageFiltering.jl package
# behaves the same way as the `convolve` function used in Lecture 2
# You were asked to implement this in homework 1.

# ╔═╡ 55c346d4-1434-11eb-0a45-a7e5d1fb8a0e
md"
**(?2)** Was this the reason why my python implementation got slower? I mean, I know Python is said to be slower than Julia, but did I write an even slower implementation just because I had not used a library function to do the convolution?

"

# ╔═╡ cdfb3508-f319-11ea-1486-c5c58a0b9177
float_to_color(x) = RGB(max(0, -x), max(0, x), 0)

# ╔═╡ 68eb9e1c-1431-11eb-03ba-27dbaeec708b
md"
A little explanation might come in handy: `float_to_color()`, when applied to a matrix of real numbers, will output to the pixel in question
- **red** if $x < 0$
- **green** if $x > 0$
- **black** if $x = 0$

"

# ╔═╡ 5fccc7cc-f369-11ea-3b9e-2f0eca7f0f0e
md"""
finally we define the `energy` function which takes the Sobel gradients along x and y directions and computes the norm of the gradient for each pixel.
"""

# ╔═╡ 6f37b34c-f31a-11ea-2909-4f2079bf66ec
begin
	energy(∇x, ∇y) = sqrt.(∇x.^2 .+ ∇y.^2)
	function energy(img)
		∇y = convolve(brightness.(img), Kernel.sobel()[1])
		∇x = convolve(brightness.(img), Kernel.sobel()[2])
		energy(∇x, ∇y)
	end
end

# ╔═╡ 9fa0cd3a-f3e1-11ea-2f7e-bd73b8e3f302
float_to_color.(energy(img))

# ╔═╡ 4442740c-1434-11eb-2212-69f4f647fdad
md"
##### Stopped here (2020/10/22 14h00)
"

# ╔═╡ 87afabf8-f317-11ea-3cb3-29dced8e265a
md"""
## **Exercise 2** - _Building up to dynamic programming_

In this exercise and the following ones, we will use the computational problem of Seam carving. We will think through all the "gut reaction" solutions, and then finally end up with the dynamic programming solution that we saw in the lecture.

In the process we will understand the performance and accuracy of each iteration of our solution.

### How to implement the solutions:

For every variation of the algorithm, your job is to write a function which takes a matrix of energies, and an index for a pixel on the first row, and computes a "seam" starting at that pixel.

The function should return a vector of as many integers as there are rows in the input matrix where each number points out a pixel to delete from the corresponding row. (it acts as the input to `remove_in_each_row`).
"""

# ╔═╡ 8ba9f5fc-f31b-11ea-00fe-79ecece09c25
md"""
#### Exercise 2.1 - _The greedy approach_

The first approach discussed in the lecture (included below) is the _greedy approach_: you start from your top pixel, and at each step you just look at the three neighbors below. The next pixel in the seam is the neighbor with the lowest energy.

"""

# ╔═╡ f5a74dfc-f388-11ea-2577-b543d31576c6
html"""
<iframe width="100%" height="450px" src="https://www.youtube.com/embed/rpB6zQNsbQU?start=777&end=833" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
"""

# ╔═╡ c3543ea4-f393-11ea-39c8-37747f113b96
md"""
👉 Implement the greedy approach.
"""

# ╔═╡ 2f9cbea8-f3a1-11ea-20c6-01fd1464a592
random_seam(m, n, i) = reduce((a, b) -> [a..., clamp(last(a) + rand(-1:1), 1, n)], 1:m-1; init=[i])

# ╔═╡ bee2cd68-1819-11eb-25b7-17ba8d35c618
md"
Example usage of `reduce()`
```julia
julia> reduce(*, [2,3,4])
24

julia> reduce(*, [2,3,4], init=-1)
-24

julia> reduce(*, [2,3,4], init=0)
0

julia> reduce(*, [2,3,4], init=10)
240
```
"

# ╔═╡ 83485c0e-181a-11eb-03f2-092b709aee11
md"
```
  clamp(x, lo, hi)

  Return x if lo <= x <= hi. If x > hi, return hi. If x < lo, return lo. Arguments are promoted to a common type.

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> clamp.([pi, 1.0, big(10.)], 2., 9.)
  3-element Array{BigFloat,1}:
   3.141592653589793238462643383279502884197169399375105820974944592307816406286198
   2.0
   9.0

  julia> clamp.([11,8,5],10,6) # an example where lo > hi
  3-element Array{Int64,1}:
    6
    6
   10

  ────────────────────────────────────────────────────────────────────────────────

  clamp(x, T)::T

  Clamp x between typemin(T) and typemax(T) and convert the result to type T.

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> clamp(200, Int8)
  127
  julia> clamp(-200, Int8)
  -128
```
"

# ╔═╡ dcef1ac8-1819-11eb-0c1e-db26b5a8e1e4
md"
Although not sure, I guess the `a...` is somewhat like the expansion of an arg in Python, i.e. `func(*a)` or `func(**a)`.
"

# ╔═╡ 906c19ce-181b-11eb-0ceb-f9e865370ff6
# Try execute this cell several times
random_seam(3,5,1)

# ╔═╡ b7d6e060-181c-11eb-35fe-fbb0403eea33
md"##### Why it seems so hard to understand the function `random_seam(m,n,i)`?"

# ╔═╡ 4203de1a-181c-11eb-01af-9346d45b84c8
md"
```
  The \"splat\" operator, ..., represents a sequence of arguments. ... can be used in function definitions, to indicate that
  the function accepts an arbitrary number of arguments. ... can also be used to apply a function to a sequence of
  arguments.

  Examples
  ≡≡≡≡≡≡≡≡≡≡

  julia> add(xs...) = reduce(+, xs)
  add (generic function with 1 method)

  julia> add(1, 2, 3, 4, 5)
  15

  julia> add([1, 2, 3]...)
  6

  julia> add(7, 1:100..., 1000:1100...)
  111107
```
"

# ╔═╡ 8a86c3c2-185e-11eb-0897-75b86e077626
md"
![note](random_seam.png)
"

# ╔═╡ e9901e6e-185f-11eb-186a-1b7d2631ce1e
md"
![note](/home/phunc20/git-repos/phunc20/julia/18.s191/hw/hw2/random_seam.png)
"

# ╔═╡ ffd1a970-185f-11eb-366e-032136beee0d
md"
![note](~/git-repos/phunc20/julia/18.s191/hw/hw2/random_seam.png)
"

# ╔═╡ 96b925bc-1869-11eb-385a-d36fbad5aa76
md"
![note](./git-repos/phunc20/julia/18.s191/hw/hw2/random_seam.png)
"

# ╔═╡ 7c419cc8-185f-11eb-089d-85bb746fdcbf
html"
<img src=\"random_seam.png\" />
"

# ╔═╡ 5af26608-183a-11eb-258d-57a6ce49deda
function gggreedy_seam(energies, starting_pixel::Int)
	# you can delete the body of this function - it's just a placeholder.
	random_seam(size(energies)..., starting_pixel)
end

# ╔═╡ d73647c8-1837-11eb-21ca-cd01dd92b809
function greedy_seamMMM(energies, starting_pixel::Int)
	## It's hard to use exclusively reduce() to do this function, isn't it?
	#reduce(, 2:m-1 ; init=[starting_pixel])
	## normal way of doing it
	#local m, n  = size(energies)
	m, n  = size(energies)
	#cols = zeros(Int, m)
	#cols = zeros(Int, 1)
	cols = [starting_pixel]
	#indices = 
	#values_
	for row in 2:m
		center = last(cols)
		left = max(1, center - 1)
		println(left)
		if !(left == center)
			indices = [left, center]
		else
			indices = [center]
		end
		right = min(n, center + 1)
		if !(right == center)
			#append!(indices, right)
			push!(indices, right)
		end
		println(indices)
		values_ = energies[row, indices]
		smallest_index = indices[argmin(values_)]
		#smallest_index = 1
		#append!(cols, smallest_index)
		push!(cols, smallest_index)
	end
	cols
end

# ╔═╡ 09de70ec-1b85-11eb-17bf-cbc0a9c6dbe9
@view [1][end]

# ╔═╡ 198b6266-1b85-11eb-02c4-b736941c7d64
@view [1, 7][end]

# ╔═╡ b2614ec0-1b84-11eb-3f0e-a58198ccc02a
function greedy_seam(energies, starting_pixel::Int)
	## It's hard to use exclusively reduce() to do this function, isn't it?
	#reduce(, 2:m-1 ; init=[starting_pixel])
	## normal way of doing it
	#local m, n  = size(energies)
	m, n  = size(energies)
	#seam = zeros(Int, m)
	#seam = zeros(Int, 1)
	seam = [starting_pixel]
	for row in 2:m
		center = last(seam)
		#center = @view seam[end]  ## This will not work.
		cols = [center]
		if center > 1
			left = center - 1
			push!(cols, left)
		end
		if center < n
			right = center + 1
			push!(cols, right)
		end
		adj_energies = energies[row, cols]
		best_col = cols[argmin(adj_energies)]
		#append!(seam, best_col)
		## append!() is for concatenating two arrays despite the misleading similar naming from Python.
		push!(seam, best_col)
	end
	seam
end

# ╔═╡ 5430d772-f397-11ea-2ed8-03ee06d02a22
md"Before we apply your function to our test image, let's try it out on a small matrix of energies (displayed here in grayscale), just like in the lecture snippet above (clicking on the video will take you to the right part of the video). Light pixels have high energy, dark pixels signify low energy."

# ╔═╡ f580527e-f397-11ea-055f-bb9ea8f12015
# try
# 	if length(Set(greedy_seam(greedy_test, 5))) == 1
# 		md"Right now you are seeing the placeholder function. (You haven't done the exercise yet!) This is a straight line from the starting pixel."
# 	end
# catch end

# ╔═╡ 7ddee6fc-f394-11ea-31fc-5bd665a65bef
greedy_test = Gray.(rand(Float64, (8,10)));

# ╔═╡ 6f52c1a2-f395-11ea-0c8a-138a77f03803
md"Starting pixel: $(@bind greedy_starting_pixel Slider(1:size(greedy_test, 2); show_value=true))"

# ╔═╡ d2291c76-183a-11eb-1c42-43c569750f5d
greedy_test

# ╔═╡ 9945ae78-f395-11ea-1d78-cf6ad19606c8
md"_Let's try it on a bigger image!_"

# ╔═╡ 87efe4c2-f38d-11ea-39cc-bdfa11298317
md"Compute shrunk image: $(@bind shrink_greedy CheckBox())"

# ╔═╡ 10ee1470-183b-11eb-13b3-53210ce7ec13
md"
##### Stopped here (2020/10/27 17h00)
- The function `greedy_seam` was not very well written
- Part of the reason why it is not well written is that I realized I am very bad at the grammar of Julia, or put in another way, the more I code in Julia the more I find I am ignorant of it. I don't know which way is well optimized.
"


# ╔═╡ 52452d26-f36c-11ea-01a6-313114b4445d
md"""
#### Exercise 2.2 - _Recursion_

A common pattern in algorithm design is the idea of solving a problem as the combination of solutions to subproblems.

The classic example, is a [Fibonacci number](https://en.wikipedia.org/wiki/Fibonacci_number) generator.

The recursive implementation of Fibonacci looks something like this
"""

# ╔═╡ 2a98f268-f3b6-11ea-1eea-81c28256a19e
function fib(n)
    # base case (basis)
	if n == 0 || n == 1      # `||` means "or"
		return 1
	end

    # recursion (induction)
	return fib(n-1) + fib(n-2)
end

# ╔═╡ 32e9a944-f3b6-11ea-0e82-1dff6c2eef8d
md"""
Notice that you can call a function from within itself which may call itself and so on until a base case is reached. Then the program will combine the result from the base case up to the final result.

In the case of the Fibonacci function, we added the solutions to the subproblems `fib(n-1)`, `fib(n-2)` to produce `fib(n)`.

An analogy can be drawn to the process of mathematical induction in mathematics. And as with mathematical induction there are parts to constructing such a recursive algorithm:

- Defining a base case
- Defining an recursion i.e. finding a solution to the problem as a combination of solutions to smaller problems.

"""

# ╔═╡ 9101d5a0-f371-11ea-1c04-f3f43b96ca4a
md"""
👉 Define a `least_energy` function which returns:
1. the lowest possible total energy for a seam starting at the pixel at $(i, j)$;
2. the column to jump to on the next move (in row $i + 1$),
which is one of $j-1$, $j$ or $j+1$, up to boundary conditions.

Return these two values in a tuple.
"""

# ╔═╡ 8ec27ef8-f320-11ea-2573-c97b7b908cb7
## returns lowest possible sum energy at pixel (i, j), and the column to jump to in row i+1.
function leasttt_energy(energies, i, j)
	# base case
	# if i == something
	#    return energies[...] # no need for recursive computation in the base case!
	# end
	#
	# induction
	# combine results from recursive calls to `least_energy`.
end

# ╔═╡ 28e4bb1a-1b88-11eb-20c8-f32de76f1eda
## returns lowest possible sum energy at pixel (i, j), and the column to jump to in row i+1.
function least_energy(energies, i, j)
	## base case
	m, n = size(energies)
	if i == m
	   #return (energies[i, j], 1) # no need for recursive computation in the base case!
	   return energies[i, j]
	end

	# induction
	# combine results from recursive calls to `least_energy`.
	center = j
	cols = [center]
	adj_cum_energies = [least_energy(energies, i+1, center)[1]]
	if center > 1
		left = center - 1
		push!(cols, left)
		push!(adj_cum_energies, least_energy(energies, i+1, left)[1])
	end
	if center < n
		right = center + 1
		push!(cols, right)
		push!(adj_cum_energies, least_energy(energies, i+1, right)[1])
	end
	index = argmin(adj_cum_energies)
	return energies[i, j] + adj_cum_energies[index], cols[index]
end

# ╔═╡ eba7143c-1849-11eb-39d9-8f0f6b8f96fe
## returns lowest possible sum energy at pixel (i, j), and the column to jump to in row i+1.
function least_energyYY(energies, i, j)
	## base case
	m, n = size(energies)
	if i == m
	   #return (energies[i, j], 1) # no need for recursive computation in the base case!
	   return energies[i, j]
	end

	# induction
	# combine results from recursive calls to `least_energy`.
	center = j
	cols = [center]
	values_ = [least_energy(energies, i+1, center)[1]]
	if center > 1
		left = center - 1
		push!(cols, left)
		push!(values_, least_energy(energies, i+1, left)[1])
	end
	if center < size(energies, 2)
		right = center + 1
		push!(cols, right)
		push!(values_, least_energy(energies, i+1, right)[1])
	end
	index = argmin(values_)
	return energies[i, j] + values_[index], cols[index]
end

# ╔═╡ d6db4b4e-1b88-11eb-165d-f37138789d25
greedy_test

# ╔═╡ d6b0b5a8-1b88-11eb-375f-4ba3591e947f
least_energy(greedy_test, 3, 4)

# ╔═╡ d651c9d2-1b88-11eb-3bc5-27868a0583bc
AA = rand(Float64, (5,7))

# ╔═╡ 54b63254-1b89-11eb-292d-133043573fca
Gray.(AA)

# ╔═╡ 3e445366-1b89-11eb-3fd2-4781d14d7e48
size(AA)

# ╔═╡ 34391bea-1b89-11eb-27a0-43e542d5f6a9
least_energy(AA, 2, 3)

# ╔═╡ a7f3d9f8-f3bb-11ea-0c1a-55bbb8408f09
md"""
This is so elegant, correct, but inefficient! If you **check this checkbox** $(@bind compute_access CheckBox()), you will see the number of accesses made to the energies array it took to compute the least energy from the pixel (1,7):
"""

# ╔═╡ 18e0fd8a-f3bc-11ea-0713-fbf74d5fa41a
md"Whoa!"

# ╔═╡ cbf29020-f3ba-11ea-2cb0-b92836f3d04b
begin
	struct AccessTrackerArray{T,N} <: AbstractArray{T, N}
		data::Array{T,N}
		accesses::Ref{Int}
	end
	track_access(x) = AccessTrackerArray(x, Ref(0))
	
	Base.IndexStyle(::Type{AccessTrackerArray}) = IndexLinear()
	
	Base.size(x::AccessTrackerArray) = size(x.data)
	Base.getindex(x::AccessTrackerArray, i::Int...) = (x.accesses[] += 1; x.data[i...])
	Base.setindex!(x::AccessTrackerArray, v, i...) = (x.accesses[] += 1; x.data[i...] = v;)
end

# ╔═╡ 99662410-1aa6-11eb-214a-57a0c0c1eb09
md"
**(?3)**
Can a `number` be viewed as an array and thus be indexed?
"

# ╔═╡ 8c16ad0c-1aa6-11eb-1f31-07741437eabf
3.14[1]

# ╔═╡ f944397a-184f-11eb-2c40-d72845a3b2b5
md"
##### Stopped here (2020/10/27 19h30)
"

# ╔═╡ 8bc930f0-f372-11ea-06cb-79ced2834720
md"""
#### Exercise 2.3 - _Exhaustive search with recursion_

Now use the `least_energy` function you defined above to define the `recursive_seam` function which takes the energies matrix and a starting pixel, and computes the seam with the lowest energy from that starting pixel.

This will give you the method used in the lecture to perform [exhaustive search of all possible paths](https://youtu.be/rpB6zQNsbQU?t=839).
"""

# ╔═╡ 85033040-f372-11ea-2c31-bb3147de3c0d
function recursive_seammm(energies, starting_pixel)
	m, n = size(energies)
	# Replace the following line with your code.
	[rand(1:starting_pixel) for i=1:m]
end

# ╔═╡ fa201006-1928-11eb-2128-dbba6f24375c
function recursive_seam(energies, starting_pixel)
	m, n = size(energies)
	prev_col = starting_pixel
	seam = [starting_pixel]
	for current_row = 2:m
		prev_row = current_row - 1
		current_col = least_energy(energies, prev_row, prev_col)[2]
		push!(seam, current_col)
		#push!(seam, copy(current_col))
		prev_col = current_col
	end
	return seam
end

# ╔═╡ 1d55333c-f393-11ea-229a-5b1e9cabea6a
md"Compute shrunk image: $(@bind shrink_recursive CheckBox())"

# ╔═╡ 0d72a340-19aa-11eb-297d-f1472e1c991a
shrink_recursive

# ╔═╡ c572f6ce-f372-11ea-3c9a-e3a21384edca
md"""
#### Exercise 2.4

- State clearly why this algorithm does an exhaustive search of all possible paths.
- How does the number of possible seam grow as n increases for a `m×n` image? (Big O notation is fine, or an approximation is fine).
"""

# ╔═╡ 8af5ffb6-1b8e-11eb-10ca-d9d8b041e858
# TODO

# ╔═╡ 6d993a5c-f373-11ea-0dde-c94e3bbd1552
exhaustive_observation = md"""
<your answer here>
"""

# ╔═╡ ea417c2a-f373-11ea-3bb0-b1b5754f2fac
md"""
## **Exercise 3** - _Memoization_

**Memoization** is the name given to the technique of storing results to expensive function calls that will be accessed more than once.

As stated in the video, the function `least_energy` is called repeatedly with the same arguments. In fact, we call it on the order of $3^n$ times, when there are only really $m \times n$ unique ways to call it!

Lets implement memoization on this function with first a [dictionary](https://docs.julialang.org/en/v1/base/collections/#Dictionaries) for storage.
"""

# ╔═╡ 56a7f954-f374-11ea-0391-f79b75195f4d
md"""
#### Exercise 3.1 - _Dictionary as storage_

Let's make a memoized version of least_energy function which takes a dictionary and
first checks to see if the dictionary contains the key (i,j) if it does, returns the value stored in that place, if not, will compute it, and store it in the dictionary at key (i, j) and return the value it computed.


`memoized_least_energy(energies, starting_pixel, memory)`

This function must recursively call itself, and pass the same `memory` object it received as an argument.

You are expected to read and understand the [documentation on dictionaries](https://docs.julialang.org/en/v1/base/collections/#Dictionaries) to find out how to:

1. Create a dictionary
2. Check if a key is stored in the dictionary
3. Access contents of the dictionary by a key.
"""

# ╔═╡ b1d09bc8-f320-11ea-26bb-0101c9a204e2
function memoized_least_energyyyy(energies, i, j, memory)
	m, n = size(energies)
	
	# Replace the following line with your code.
	[starting_pixel for i=1:m]
end

# ╔═╡ 86702b90-1b92-11eb-270b-d3d3ab8870e8
function memoized_least_energy(energies, i, j, memory)
	m, n = size(energies)

	# Replace the following line with your code.
	get!(memory, (i, j),
		if i == m
			# get memory[(i, j)] if exists; otherwise, return energies[i, j] and, in the mean time,
			# store that value to memory[(i, j)]
			#get!(memory, (i, j), energies[i, j])
			energies[i, j]
		else
			center = j
			cols = [center]
			values_ =  [get!(memory, (i+1, center), memoized_least_energy(energies, i+1, center, memory))]
			if center > 1
				left = center - 1
				push!(cols, left)
				push!(values_, get!(memory, (i+1, left), memoized_least_energy(energies, i+1, left, memory)[1]))
			end
			if center < n
				right = center + 1
				push!(cols, right)
				push!(values_, get!(memory, (i+1, right), memoized_least_energy(energies, i+1, right, memory)))
			end
			v_min, i_min = findmin(values_)
			#energies[i, j] + values_[i_min], cols[i_min]
			energies[i, j] + values_[i_min]
		end
	)
end


# ╔═╡ f8ce73e8-1ac5-11eb-0c1b-83943816ebc5
function memoized_least_energyY(energies, i, j, memory)
	m, n = size(energies)

	# Replace the following line with your code.
	get!(memory, (i, j),
		if i == m
			# get memory[(i, j)] if exists; otherwise, return energies[i, j] and, in the mean time,
			# store that value to memory[(i, j)]
			#get!(memory, (i, j), energies[i, j])
			energies[i, j]
		else
			center = j
			cols = [center]
			values_ =  [get!(memory, (i+1, center), memoized_least_energy(energies, i+1, center, memory)[1])]
			if center > 1
				left = center - 1
				push!(cols, left)
				push!(values_, get!(memory, (i+1, left), memoized_least_energy(energies, i+1, left, memory)[1]))
			end
			if center < n
				right = center + 1
				push!(cols, right)
				push!(values_, get!(memory, (i+1, right), memoized_least_energy(energies, i+1, right, memory)[1]))
			end
			v_min, i_min = findmin(values_)
			#energies[i, j] + values_[i_min], cols[i_min]
			energies[i, j] + values_[i_min]
		end
	)
end


# ╔═╡ 3e8b0868-f3bd-11ea-0c15-011bbd6ac051
function recursive_memoized_seammm(energies, starting_pixel)
	memory = Dict{Tuple{Int,Int}, Float64}() # location => least energy.
	                                         # pass this every time you call memoized_least_energy.
	m, n = size(energies)
	
	# Replace the following line with your code.
	[rand(1:starting_pixel) for i=1:m]
end

# ╔═╡ 0aca395e-1acd-11eb-36ba-f72bd2bab4a6
function recursive_memoized_seamMM(energies, starting_pixel)
	memory = Dict{Tuple{Int,Int}, Float64}() # location => least energy.
	                                         # pass this every time you call memoized_least_energy.
	m, n = size(energies)

	# Replace the following line with your code.
	prev_col = starting_pixel
	seam = [starting_pixel]
	for current_row = 2:m
		prev_row = current_row - 1
		current_col = memoized_least_energy(energies, prev_row, prev_col, memory)[2]
		push!(seam, current_col)
		prev_col = current_col
	end
	seam
end

# ╔═╡ a45f6322-1b91-11eb-27ef-3dbcdce26395
function recursive_memoized_seam(energies, starting_pixel)
	memory = Dict{Tuple{Int,Int}, Float64}() # location => least energy.
	                                         # pass this every time you call memoized_least_energy.
	m, n = size(energies)

	# Replace the following line with your code.
	prev_col = starting_pixel
	seam = [starting_pixel]
	for current_row = 2:m
		#prev_row = current_row - 1
		center = last(seam)
		cols = [center]
		adj_cum_energies = [memoized_least_energy(energies, current_row, center, memory)]
		if center > 1
			left = center - 1
			push!(cols, left)
			push!(adj_cum_energies, memoized_least_energy(energies, current_row, left, memory))
		end
		if center < n
			right = center + 1
			push!(cols, right)
			push!(adj_cum_energies, memoized_least_energy(energies, current_row, right, memory))
		end
		#current_col = memoized_least_energy(energies, prev_row, prev_col, memory)[2]
		current_col = cols[argmin(adj_cum_energies)]
		push!(seam, current_col)
		#prev_col = current_col
	end
	seam
end

# ╔═╡ 4fa4d25a-1b92-11eb-3f86-6d8a10ce0a01
md"###### Debug `recursive_memoized_seam()`"

# ╔═╡ 684ddc9a-1b9d-11eb-2dce-bb6581aa7dad
s_px = 7

# ╔═╡ 4e3bcf88-f3c5-11ea-3ada-2ff9213647b7
md"Compute shrunk image: $(@bind shrink_dict CheckBox())"

# ╔═╡ cf39fa2a-f374-11ea-0680-55817de1b837
md"""
### Exercise 3.2 - _Matrix as storage_

The dictionary-based memoization we tried above works well in general as there is no restriction on what type of keys can be used.

But in our particular case, we can use a matrix as a storage, since a matrix is naturally keyed by two integers.

Write a variation of `matrix_memoized_least_energy` and `matrix_memoized_seam` which use a matrix as storage.
"""

# ╔═╡ c8724b5e-f3bd-11ea-0034-b92af21ca12d
function matrix_memoized_least_energy(energies, i, j, memory)
	m, n = size(energies)
	
	# Replace the following line with your code.
	[starting_pixel for i=1:m]
end

# ╔═╡ be7d40e2-f320-11ea-1b56-dff2a0a16e8d
function matrix_memoized_seam(energies, starting_pixel)
	memory = zeros(size(energies)) # use this as storage -- intially it's all zeros
	m, n = size(energies)
	
	# Replace the following line with your code.
	[starting_pixel for i=1:m]
end

# ╔═╡ 507f3870-f3c5-11ea-11f6-ada3bb087634
md"Compute shrunk image: $(@bind shrink_matrix CheckBox())"

# ╔═╡ 24792456-f37b-11ea-07b2-4f4c8caea633
md"""
## **Exercise 4** - _Dynamic programming without recursion_ 

Now it's easy to see that the above algorithm is equivalent to one that populates the memory matrix in a for loop.

#### Exercise 4.1

👉 Write a function which takes the energies and returns the least energy matrix which has the least possible seam energy for each pixel. This was shown in the lecture, but attempt to write it on your own.
"""

# ╔═╡ ff055726-f320-11ea-32f6-2bf38d7dd310
function least_energy_matrix(energies)
	copy(energies)
end

# ╔═╡ 92e19f22-f37b-11ea-25f7-e321337e375e
md"""
#### Exercise 4.2

👉 Write a function which, when given the matrix returned by `least_energy_matrix` and a starting pixel (on the first row), computes the least energy seam from that pixel.
"""

# ╔═╡ 795eb2c4-f37b-11ea-01e1-1dbac3c80c13
function seam_from_precomputed_least_energy(energies, starting_pixel::Int)
	least_energies = least_energy_matrix(energies)
	m, n = size(least_energies)
	
	# Replace the following line with your code.
	[starting_pixel for i=1:m]
end

# ╔═╡ 51df0c98-f3c5-11ea-25b8-af41dc182bac
md"Compute shrunk image: $(@bind shrink_bottomup CheckBox())"

# ╔═╡ 0fbe2af6-f381-11ea-2f41-23cd1cf930d9
if student.kerberos_id === "jazz"
	md"""
!!! danger "Oops!"
    **Before you submit**, remember to fill in your name and kerberos ID at the top of this notebook!
	"""
end

# ╔═╡ 6b4d6584-f3be-11ea-131d-e5bdefcc791b
md"## Function library

Just some helper functions used in the notebook."

# ╔═╡ ef88c388-f388-11ea-3828-ff4db4d1874e
function mark_path(img, path)
	img′ = copy(img)
	m = size(img, 2)
	for (i, j) in enumerate(path)
		# To make it easier to see, we'll color not just
		# the pixels of the seam, but also those adjacent to it
		for j′ in j-1:j+1
			img′[i, clamp(j′, 1, m)] = RGB(1,0,1)
		end
	end
	img′
end

# ╔═╡ 437ba6ce-f37d-11ea-1010-5f6a6e282f9b
function shrink_n(img, n, min_seam, imgs=[]; show_lightning=true)
	n==0 && return push!(imgs, img)

	e = energy(img)
	# Define a new function `seam_energy()`
	seam_energy(seam) = sum(e[i, seam[i]]  for i in 1:size(img, 1))
	_, min_j = findmin(map(j->seam_energy(min_seam(e, j)), 1:size(e, 2)))
	min_seam_vec = min_seam(e, min_j)
	img′ = remove_in_each_row(img, min_seam_vec)
	if show_lightning
		push!(imgs, mark_path(img, min_seam_vec))
	else
		push!(imgs, img′)
	end
	shrink_n(img′, n-1, min_seam, imgs)
end

# ╔═╡ f6571d86-f388-11ea-0390-05592acb9195
if shrink_greedy
	greedy_carved = shrink_n(img, 200, greedy_seam)
	md"Shrink by: $(@bind greedy_n Slider(1:200; show_value=true))"
end

# ╔═╡ f626b222-f388-11ea-0d94-1736759b5f52
if shrink_greedy
	greedy_carved[greedy_n]
end

# ╔═╡ 7a0ff0e8-1b85-11eb-0fb5-471c4fdf553d
greedy_carved[1:5]

# ╔═╡ 4e3ef866-f3c5-11ea-3fb0-27d1ca9a9a3f
if shrink_dict
	#dict_carved = shrink_n(img, 5, recursive_memoized_seam)
	dict_carved = shrink_n(img, 200, recursive_memoized_seam)
	md"Shrink by: $(@bind dict_n Slider(1:200, show_value=true))"
end

# ╔═╡ 6e73b1da-f3c5-11ea-145f-6383effe8a89
if shrink_dict
	dict_carved[dict_n]
end

# ╔═╡ 50829af6-f3c5-11ea-04a8-0535edd3b0aa
if shrink_matrix
	matrix_carved = shrink_n(img, 200, matrix_memoized_seam)
	md"Shrink by: $(@bind matrix_n Slider(1:200, show_value=true))"
end

# ╔═╡ 9e56ecfa-f3c5-11ea-2e90-3b1839d12038
if shrink_matrix
	matrix_carved[matrix_n]
end

# ╔═╡ 51e28596-f3c5-11ea-2237-2b72bbfaa001
if shrink_bottomup
	bottomup_carved = shrink_n(img, 200, seam_from_precomputed_least_energy)
	md"Shrink by: $(@bind bottomup_n Slider(1:200, show_value=true))"
end

# ╔═╡ 0a10acd8-f3c6-11ea-3e2f-7530a0af8c7f
if shrink_bottomup
	bottomup_carved[bottomup_n]
end

# ╔═╡ ef26374a-f388-11ea-0b4e-67314a9a9094
function pencil(X)
	f(x) = RGB(1-x,1-x,1-x)
	map(f, X ./ maximum(X))
end

# ╔═╡ 6bdbcf4c-f321-11ea-0288-fb16ff1ec526
function decimate(img, n)
	img[1:n:end, 1:n:end]
end

# ╔═╡ ddba07dc-f3b7-11ea-353e-0f67713727fc
# Do not make this image bigger, it will be infeasible to compute.
#pika = decimate(load(download("https://art.pixilart.com/901d53bcda6b27b.png")),150)
pika = decimate(load("pika.png"), 150)

# ╔═╡ 73b52fd6-f3b9-11ea-14ed-ebfcab1ce6aa
size(pika)

# ╔═╡ fa8e2772-f3b6-11ea-30f7-699717693164
if compute_access
	tracked = track_access(energy(pika))
	least_energy(tracked, 1,7)
	tracked.accesses[]
end

# ╔═╡ d88bc272-f392-11ea-0efd-15e0e2b2cd4e
if shrink_recursive
	recursive_carved = shrink_n(pika, 3, recursive_seam)
	md"Shrink by: $(@bind recursive_n Slider(1:3, show_value=true))"
end

# ╔═╡ e66ef06a-f392-11ea-30ab-7160e7723a17
if shrink_recursive
	recursive_carved[recursive_n]
end

# ╔═╡ 6358aa5c-19aa-11eb-3c9b-c589ef5874b9
recursive_carved

# ╔═╡ 7f91e8e6-19aa-11eb-112b-cf8ff4d60ecc
pika

# ╔═╡ 3058197c-1b8e-11eb-1340-772b2a686ef0
energy(pika)

# ╔═╡ 335ff82e-1b8e-11eb-37b1-3b6de537ccb5
Gray.(energy(pika))

# ╔═╡ f752cc80-1b8d-11eb-36ef-7794e95d2ffc
recursive_seam(energy(pika), 1)

# ╔═╡ 6481432c-1b8e-11eb-2119-7753ea213d45
size(pika)

# ╔═╡ 3cd72254-1b8e-11eb-01bf-73d8e3d5cff5
recursive_seam(energy(pika), 7)

# ╔═╡ 1368ac56-1b92-11eb-19d4-57a0e27e8876
Gray.(energy(pika))

# ╔═╡ 1dc961c2-1b92-11eb-219f-a1c0fb2cb451
recursive_memoized_seam(energy(pika), s_px)

# ╔═╡ 62f52c8a-1b9d-11eb-3792-e5e9335a16d1
recursive_seam(energy(pika), s_px)

# ╔═╡ ffc17f40-f380-11ea-30ee-0fe8563c0eb1
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Hint", [text]))

# ╔═╡ 9f18efe2-f38e-11ea-0871-6d7760d0b2f6
hint(md"You can call the `least_energy` function recursively within itself to obtain the least energy of the adjacent cells and add the energy at the current cell to get the total energy.")

# ╔═╡ ffc40ab2-f380-11ea-2136-63542ff0f386
almost(text) = Markdown.MD(Markdown.Admonition("warning", "Almost there!", [text]))

# ╔═╡ ffceaed6-f380-11ea-3c63-8132d270b83f
still_missing(text=md"Replace `missing` with your answer.") = Markdown.MD(Markdown.Admonition("warning", "Here we go!", [text]))

# ╔═╡ ffde44ae-f380-11ea-29fb-2dfcc9cda8b4
keep_working(text=md"The answer is not quite right.") = Markdown.MD(Markdown.Admonition("danger", "Keep working on it!", [text]))

# ╔═╡ 980b1104-f394-11ea-0948-21002f26ee25
function visualize_seam_algorithm(algorithm, test_img, starting_pixel)
	seam = algorithm(test_img, starting_pixel)
	
	display_img = RGB.(test_img)
	for (i, j) in enumerate(seam)
		try
			display_img[i, j] = RGB(0.9, 0.3, 0.6)
		catch ex
			if ex isa BoundsError
				return keep_working("")
			end
			# the solution might give an illegal index
		end
	end
	display_img
end;

# ╔═╡ 2a7e49b8-f395-11ea-0058-013e51baa554
visualize_seam_algorithm(greedy_seam, greedy_test, greedy_starting_pixel)

# ╔═╡ ffe326e0-f380-11ea-3619-61dd0592d409
yays = [md"Great!", md"Yay ❤", md"Great! 🎉", md"Well done!", md"Keep it up!", md"Good job!", md"Awesome!", md"You got the right answer!", md"Let's move on to the next section."]

# ╔═╡ fff5aedc-f380-11ea-2a08-99c230f8fa32
correct(text=rand(yays)) = Markdown.MD(Markdown.Admonition("correct", "Got it!", [text]))

# ╔═╡ e3519118-f387-11ea-0c61-e1c2de1c24c1
if performance_experiment_without_vcat ⧀ performance_experiment_default
	correct()
else
	keep_working(md"We are still using (roughly) the same number of allocations as the default implementation.")
end

# ╔═╡ d4ea4222-f388-11ea-3c8d-db0d651f5282
if performance_experiment_views ⧀ performance_experiment_default
	if minimum(performance_experiment_views).allocs < 10
		correct()
	else
		keep_working(md"We are still using (roughly) the same number of allocations as the implementation without `vcat`.")
	end
else
	keep_working(md"We are still using (roughly) the same number of allocations as the default implementation.")
end

# ╔═╡ 00026442-f381-11ea-2b41-bde1fff66011
not_defined(variable_name) = Markdown.MD(Markdown.Admonition("danger", "Oopsie!", [md"Make sure that you define a variable called **$(Markdown.Code(string(variable_name)))**"]))

# ╔═╡ 145c0f58-f384-11ea-2b71-09ae83f66da2
if !@isdefined(views_observation)
	not_defined(:views_observation)
end

# ╔═╡ d7a9c000-f383-11ea-1516-cf71102d8e94
if !@isdefined(views_observation)
	not_defined(:views_observation)
end

# ╔═╡ e0622780-f3b4-11ea-1f44-59fb9c5d2ebd
if !@isdefined(least_energy_matrix)
	not_defined(:least_energy_matrix)
end

# ╔═╡ 946b69a0-f3a2-11ea-2670-819a5dafe891
if !@isdefined(seam_from_precomputed_least_energy)
	not_defined(:seam_from_precomputed_least_energy)
end

# ╔═╡ fbf6b0fa-f3e0-11ea-2009-573a218e2460
function hbox(x, y, gap=16; sy=size(y), sx=size(x))
	w,h = (max(sx[1], sy[1]),
		   gap + sx[2] + sy[2])
	
	slate = fill(RGB(1,1,1), w,h)
	slate[1:size(x,1), 1:size(x,2)] .= RGB.(x)
	slate[1:size(y,1), size(x,2) + gap .+ (1:size(y,2))] .= RGB.(y)
	slate
end

# ╔═╡ f010933c-f318-11ea-22c5-4d2e64cd9629
begin
	hbox(
		float_to_color.(convolve(brightness.(img), Kernel.sobel()[1])),
		float_to_color.(convolve(brightness.(img), Kernel.sobel()[2])))
end

# ╔═╡ 256edf66-f3e1-11ea-206e-4f9b4f6d3a3d
vbox(x,y, gap=16) = hbox(x', y')'

# ╔═╡ 00115b6e-f381-11ea-0bc6-61ca119cb628
bigbreak = html"<br><br><br><br><br>";

# ╔═╡ c086bd1e-f384-11ea-3b26-2da9e24360ca
bigbreak

# ╔═╡ 8d558c4c-f328-11ea-0055-730ead5d5c34
bigbreak

# ╔═╡ f7eba2b6-f388-11ea-06ad-0b861c764d61
bigbreak

# ╔═╡ 4f48c8b8-f39d-11ea-25d2-1fab031a514f
bigbreak

# ╔═╡ 48089a00-f321-11ea-1479-e74ba71df067
bigbreak

# ╔═╡ 927e6c3e-183a-11eb-3809-c95e2327bd19
##function greedy_seam(energies, starting_pixel::Int)
#	# you can delete the body of this function - it's just a placeholder.
#	#random_seam(size(energies)..., starting_pixel)
#	## It's hard to use reduce(), isn't it?
#	#reduce(, 2:m-1 ; init=[starting_pixel])
#	## normal way of doing it
#	#local m, n  = size(energies)
#	m, n  = size(energies)
#	#cols = zeros(Int, m)
#	#cols = zeros(Int, 1)
#	cols = [starting_pixel]
#	#indices = 
#	#values_
#	for row in 2:m
#		center = last(cols)
#		left = max(1, center - 1)
#		println(left)
#		if !(left == center)
#			indices = [left, center]
#		else
#			indices = [center]
#		end
#		right = min(n, center + 1)
#		if !(right == center)
#			append!(indices, right)
#		end
#		println(indices)
#		values_ = energies[row, indices]
#		smallest_index = indices[argmin(values)]
#		#smallest_index = 1
#		append!(cols, smallest_index)
#	end
#	cols
#end

# ╔═╡ Cell order:
# ╟─e6b6760a-f37f-11ea-3ae1-65443ef5a81a
# ╟─ec66314e-f37f-11ea-0af4-31da0584e881
# ╟─85cfbd10-f384-11ea-31dc-b5693630a4c5
# ╠═33e43c7c-f381-11ea-3abc-c942327456b1
# ╟─938185ec-f384-11ea-21dc-b56b7469f798
# ╠═86e1ee96-f314-11ea-03f6-0f549b79e7c9
# ╠═a4937996-f314-11ea-2ff9-615c888afaa8
# ╠═0d144802-f319-11ea-0028-cd97a776a3d0
# ╠═78f3d1ba-11ef-11eb-1385-032119a54ee9
# ╟─cc9fcdae-f314-11ea-1b9a-1f68b792f005
# ╟─b49a21a6-f381-11ea-1a98-7f144c55c9b7
# ╟─b49e8cc8-f381-11ea-1056-91668ac6ae4e
# ╠═5d9c9270-11f0-11eb-14e8-6f5ffe7a6c41
# ╠═6882bbd8-11f0-11eb-1c83-7f4c929d60fb
# ╠═45bccee0-11f0-11eb-0689-7b83f464a92b
# ╠═fe46cf3a-11f0-11eb-120a-6d9d66f001da
# ╠═a12da3b2-11f0-11eb-3d19-c994afe71784
# ╠═e208b2dc-11f0-11eb-3b7a-af3a6a318ccf
# ╠═e799be82-f317-11ea-3ae4-6d13ece3fe10
# ╟─c075a8e6-f382-11ea-2263-cd9507324f4f
# ╠═f7a945d4-1358-11eb-0c6f-87875e89bbb7
# ╠═9cced1a8-f326-11ea-0759-0b2f22e5a1db
# ╠═bc6b0926-1b7d-11eb-01ed-1d7298112711
# ╟─c086bd1e-f384-11ea-3b26-2da9e24360ca
# ╟─1d893998-f366-11ea-0828-512de0c44915
# ╟─59991872-f366-11ea-1036-afe313fb4ec1
# ╠═e501ea28-f326-11ea-252a-53949fd9ef57
# ╟─f7915918-f366-11ea-2c46-2f4671ae8a22
# ╠═10eae3b2-11f2-11eb-281d-cf3d2ae95068
# ╠═99997184-1b7e-11eb-3961-81f1e8a55cb2
# ╠═f09dbd4c-1b7f-11eb-3876-5b7b2195c2e1
# ╠═2046b314-1b80-11eb-1cd3-1deaa3574550
# ╠═77d345f0-1b80-11eb-1851-6b5463376851
# ╠═808508dc-1b80-11eb-257b-31af70c7f175
# ╠═983b9a8e-1b80-11eb-00e3-c39b0ac10d18
# ╠═37d4ea5c-f327-11ea-2cc5-e3774c232c2b
# ╠═67717d02-f327-11ea-0988-bfe661f57f77
# ╟─9e149cd2-f367-11ea-28ef-b9533e8a77bb
# ╟─e3519118-f387-11ea-0c61-e1c2de1c24c1
# ╟─ba1619d4-f389-11ea-2b3f-fd9ba71cf7e3
# ╠═4fa5f906-11f3-11eb-3479-5f0b7393940d
# ╟─e49235a4-f367-11ea-3913-f54a4a6b2d6b
# ╟─145c0f58-f384-11ea-2b71-09ae83f66da2
# ╟─837c43a4-f368-11ea-00a3-990a45cb0cbd
# ╠═90a22cc6-f327-11ea-1484-7fda90283797
# ╠═3335e07c-f328-11ea-0e6c-8d38c8c0ad5b
# ╟─d4ea4222-f388-11ea-3c8d-db0d651f5282
# ╟─40d6f562-f329-11ea-2ee4-d7806a16ede3
# ╟─4f0975d8-f329-11ea-3d10-59a503f8d6b2
# ╟─dc63d32a-f387-11ea-37e2-6f3666a72e03
# ╟─7eaa57d2-f368-11ea-1a70-c7c7e54bd0b1
# ╟─fd819dac-f368-11ea-33bb-17148387546a
# ╟─fc1fbeec-12a9-11eb-34ae-a14eb0b5b03e
# ╟─a1dc747e-142e-11eb-252e-6722818c93e2
# ╟─d7a9c000-f383-11ea-1516-cf71102d8e94
# ╟─8d558c4c-f328-11ea-0055-730ead5d5c34
# ╟─2a4ab6b2-12aa-11eb-226d-01d3f5ee6c9d
# ╟─318a2256-f369-11ea-23a9-2f74c566549b
# ╟─7a44ba52-f318-11ea-0406-4731c80c1007
# ╠═6c7e4b54-f318-11ea-2055-d9f9c0199341
# ╠═74059d04-f319-11ea-29b4-85f5f8f5c610
# ╠═cf99813e-1430-11eb-1c86-055f4f4dcbf2
# ╠═c860e7c4-1430-11eb-31c8-537a4d285e56
# ╠═1b3f2616-1431-11eb-3395-9f439bc589e4
# ╠═24748b2a-1431-11eb-0589-4bb7057d91e9
# ╟─0b9ead92-f318-11ea-3744-37150d649d43
# ╠═d184e9cc-f318-11ea-1a1e-994ab1330c1a
# ╟─55c346d4-1434-11eb-0a45-a7e5d1fb8a0e
# ╠═cdfb3508-f319-11ea-1486-c5c58a0b9177
# ╟─68eb9e1c-1431-11eb-03ba-27dbaeec708b
# ╠═f010933c-f318-11ea-22c5-4d2e64cd9629
# ╟─5fccc7cc-f369-11ea-3b9e-2f0eca7f0f0e
# ╠═6f37b34c-f31a-11ea-2909-4f2079bf66ec
# ╠═9fa0cd3a-f3e1-11ea-2f7e-bd73b8e3f302
# ╟─f7eba2b6-f388-11ea-06ad-0b861c764d61
# ╟─4442740c-1434-11eb-2212-69f4f647fdad
# ╟─87afabf8-f317-11ea-3cb3-29dced8e265a
# ╟─8ba9f5fc-f31b-11ea-00fe-79ecece09c25
# ╟─f5a74dfc-f388-11ea-2577-b543d31576c6
# ╟─c3543ea4-f393-11ea-39c8-37747f113b96
# ╠═2f9cbea8-f3a1-11ea-20c6-01fd1464a592
# ╟─bee2cd68-1819-11eb-25b7-17ba8d35c618
# ╟─83485c0e-181a-11eb-03f2-092b709aee11
# ╟─dcef1ac8-1819-11eb-0c1e-db26b5a8e1e4
# ╠═906c19ce-181b-11eb-0ceb-f9e865370ff6
# ╟─b7d6e060-181c-11eb-35fe-fbb0403eea33
# ╟─4203de1a-181c-11eb-01af-9346d45b84c8
# ╠═8a86c3c2-185e-11eb-0897-75b86e077626
# ╠═e9901e6e-185f-11eb-186a-1b7d2631ce1e
# ╠═ffd1a970-185f-11eb-366e-032136beee0d
# ╠═96b925bc-1869-11eb-385a-d36fbad5aa76
# ╠═7c419cc8-185f-11eb-089d-85bb746fdcbf
# ╠═5af26608-183a-11eb-258d-57a6ce49deda
# ╠═d73647c8-1837-11eb-21ca-cd01dd92b809
# ╠═09de70ec-1b85-11eb-17bf-cbc0a9c6dbe9
# ╠═198b6266-1b85-11eb-02c4-b736941c7d64
# ╠═b2614ec0-1b84-11eb-3f0e-a58198ccc02a
# ╟─5430d772-f397-11ea-2ed8-03ee06d02a22
# ╠═f580527e-f397-11ea-055f-bb9ea8f12015
# ╠═6f52c1a2-f395-11ea-0c8a-138a77f03803
# ╠═d2291c76-183a-11eb-1c42-43c569750f5d
# ╠═2a7e49b8-f395-11ea-0058-013e51baa554
# ╠═7ddee6fc-f394-11ea-31fc-5bd665a65bef
# ╟─980b1104-f394-11ea-0948-21002f26ee25
# ╟─9945ae78-f395-11ea-1d78-cf6ad19606c8
# ╟─87efe4c2-f38d-11ea-39cc-bdfa11298317
# ╠═f6571d86-f388-11ea-0390-05592acb9195
# ╠═f626b222-f388-11ea-0d94-1736759b5f52
# ╠═7a0ff0e8-1b85-11eb-0fb5-471c4fdf553d
# ╟─10ee1470-183b-11eb-13b3-53210ce7ec13
# ╟─52452d26-f36c-11ea-01a6-313114b4445d
# ╠═2a98f268-f3b6-11ea-1eea-81c28256a19e
# ╟─32e9a944-f3b6-11ea-0e82-1dff6c2eef8d
# ╟─9101d5a0-f371-11ea-1c04-f3f43b96ca4a
# ╠═ddba07dc-f3b7-11ea-353e-0f67713727fc
# ╠═73b52fd6-f3b9-11ea-14ed-ebfcab1ce6aa
# ╠═8ec27ef8-f320-11ea-2573-c97b7b908cb7
# ╠═eba7143c-1849-11eb-39d9-8f0f6b8f96fe
# ╠═28e4bb1a-1b88-11eb-20c8-f32de76f1eda
# ╟─9f18efe2-f38e-11ea-0871-6d7760d0b2f6
# ╠═d6db4b4e-1b88-11eb-165d-f37138789d25
# ╠═d6b0b5a8-1b88-11eb-375f-4ba3591e947f
# ╠═d651c9d2-1b88-11eb-3bc5-27868a0583bc
# ╠═54b63254-1b89-11eb-292d-133043573fca
# ╠═3e445366-1b89-11eb-3fd2-4781d14d7e48
# ╠═34391bea-1b89-11eb-27a0-43e542d5f6a9
# ╟─a7f3d9f8-f3bb-11ea-0c1a-55bbb8408f09
# ╠═fa8e2772-f3b6-11ea-30f7-699717693164
# ╟─18e0fd8a-f3bc-11ea-0713-fbf74d5fa41a
# ╟─cbf29020-f3ba-11ea-2cb0-b92836f3d04b
# ╟─99662410-1aa6-11eb-214a-57a0c0c1eb09
# ╠═8c16ad0c-1aa6-11eb-1f31-07741437eabf
# ╟─f944397a-184f-11eb-2c40-d72845a3b2b5
# ╟─8bc930f0-f372-11ea-06cb-79ced2834720
# ╠═85033040-f372-11ea-2c31-bb3147de3c0d
# ╠═fa201006-1928-11eb-2128-dbba6f24375c
# ╠═1d55333c-f393-11ea-229a-5b1e9cabea6a
# ╠═0d72a340-19aa-11eb-297d-f1472e1c991a
# ╠═d88bc272-f392-11ea-0efd-15e0e2b2cd4e
# ╠═e66ef06a-f392-11ea-30ab-7160e7723a17
# ╠═6358aa5c-19aa-11eb-3c9b-c589ef5874b9
# ╠═7f91e8e6-19aa-11eb-112b-cf8ff4d60ecc
# ╠═3058197c-1b8e-11eb-1340-772b2a686ef0
# ╠═335ff82e-1b8e-11eb-37b1-3b6de537ccb5
# ╠═f752cc80-1b8d-11eb-36ef-7794e95d2ffc
# ╠═6481432c-1b8e-11eb-2119-7753ea213d45
# ╠═3cd72254-1b8e-11eb-01bf-73d8e3d5cff5
# ╟─c572f6ce-f372-11ea-3c9a-e3a21384edca
# ╠═8af5ffb6-1b8e-11eb-10ca-d9d8b041e858
# ╠═6d993a5c-f373-11ea-0dde-c94e3bbd1552
# ╟─ea417c2a-f373-11ea-3bb0-b1b5754f2fac
# ╟─56a7f954-f374-11ea-0391-f79b75195f4d
# ╠═b1d09bc8-f320-11ea-26bb-0101c9a204e2
# ╠═f8ce73e8-1ac5-11eb-0c1b-83943816ebc5
# ╠═86702b90-1b92-11eb-270b-d3d3ab8870e8
# ╠═3e8b0868-f3bd-11ea-0c15-011bbd6ac051
# ╠═0aca395e-1acd-11eb-36ba-f72bd2bab4a6
# ╠═a45f6322-1b91-11eb-27ef-3dbcdce26395
# ╟─4fa4d25a-1b92-11eb-3f86-6d8a10ce0a01
# ╠═1368ac56-1b92-11eb-19d4-57a0e27e8876
# ╠═684ddc9a-1b9d-11eb-2dce-bb6581aa7dad
# ╠═1dc961c2-1b92-11eb-219f-a1c0fb2cb451
# ╠═62f52c8a-1b9d-11eb-3792-e5e9335a16d1
# ╠═4e3bcf88-f3c5-11ea-3ada-2ff9213647b7
# ╠═4e3ef866-f3c5-11ea-3fb0-27d1ca9a9a3f
# ╠═6e73b1da-f3c5-11ea-145f-6383effe8a89
# ╟─cf39fa2a-f374-11ea-0680-55817de1b837
# ╠═c8724b5e-f3bd-11ea-0034-b92af21ca12d
# ╠═be7d40e2-f320-11ea-1b56-dff2a0a16e8d
# ╟─507f3870-f3c5-11ea-11f6-ada3bb087634
# ╠═50829af6-f3c5-11ea-04a8-0535edd3b0aa
# ╠═9e56ecfa-f3c5-11ea-2e90-3b1839d12038
# ╟─4f48c8b8-f39d-11ea-25d2-1fab031a514f
# ╟─24792456-f37b-11ea-07b2-4f4c8caea633
# ╠═ff055726-f320-11ea-32f6-2bf38d7dd310
# ╟─e0622780-f3b4-11ea-1f44-59fb9c5d2ebd
# ╟─92e19f22-f37b-11ea-25f7-e321337e375e
# ╠═795eb2c4-f37b-11ea-01e1-1dbac3c80c13
# ╠═51df0c98-f3c5-11ea-25b8-af41dc182bac
# ╠═51e28596-f3c5-11ea-2237-2b72bbfaa001
# ╠═0a10acd8-f3c6-11ea-3e2f-7530a0af8c7f
# ╟─946b69a0-f3a2-11ea-2670-819a5dafe891
# ╟─0fbe2af6-f381-11ea-2f41-23cd1cf930d9
# ╟─48089a00-f321-11ea-1479-e74ba71df067
# ╟─6b4d6584-f3be-11ea-131d-e5bdefcc791b
# ╠═437ba6ce-f37d-11ea-1010-5f6a6e282f9b
# ╟─ef88c388-f388-11ea-3828-ff4db4d1874e
# ╟─ef26374a-f388-11ea-0b4e-67314a9a9094
# ╟─6bdbcf4c-f321-11ea-0288-fb16ff1ec526
# ╟─ffc17f40-f380-11ea-30ee-0fe8563c0eb1
# ╟─ffc40ab2-f380-11ea-2136-63542ff0f386
# ╟─ffceaed6-f380-11ea-3c63-8132d270b83f
# ╟─ffde44ae-f380-11ea-29fb-2dfcc9cda8b4
# ╟─ffe326e0-f380-11ea-3619-61dd0592d409
# ╟─fff5aedc-f380-11ea-2a08-99c230f8fa32
# ╟─00026442-f381-11ea-2b41-bde1fff66011
# ╟─fbf6b0fa-f3e0-11ea-2009-573a218e2460
# ╟─256edf66-f3e1-11ea-206e-4f9b4f6d3a3d
# ╟─00115b6e-f381-11ea-0bc6-61ca119cb628
# ╠═927e6c3e-183a-11eb-3809-c95e2327bd19
