### A Pluto.jl notebook ###
# v0.12.7

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

# ╔═╡ ae24c8b2-f60b-11ea-2c7a-03857d1217b2
using Pkg

# ╔═╡ bc14fc1a-f60b-11ea-207a-91b967f28076
begin
	pkg"add Colors ColorSchemes Images ImageMagick PlutoUI Suppressor InteractiveUtils"
	using Colors, ColorSchemes, Images, ImageMagick
	using Suppressor, InteractiveUtils, PlutoUI
end

# ╔═╡ 0feb5674-f5d5-11ea-0714-7379a7d381a3
using LinearAlgebra

# ╔═╡ 20125236-f5d6-11ea-3877-6b332497be62
using SparseArrays

# ╔═╡ 0f6ecba6-f5da-11ea-22c2-2929e562f413
using Statistics

# ╔═╡ b0ba5b8c-f5d1-11ea-1304-3f0e47f935fe
md"# What do data structures, machine learning and the singular-value decomposition have in common?"

# ╔═╡ ffa95430-f5d1-11ea-3cb7-5bb8d8f13701
md"""Blurry Fons magic: Exploiting Structure!

ADD A HINT BOX HERE WITH THE ANSWER "STRUCTURE" """

# ╔═╡ 671c9ad2-1cbf-11eb-1c57-dbb7f3d8e728
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Hint", [text]))

# ╔═╡ 43e5b364-1cbf-11eb-2d5f-61e48bb73d66
hint(md"##### Structure")

# ╔═╡ 261c4df2-f5d2-11ea-2c72-7d4b09c46098
md"One-hot vectors:  Numbers and images

0s and 1s and colors"

# ╔═╡ b5177f70-f60b-11ea-14a9-f5a574cc5185
Pkg.activate(mktempdir())

# ╔═╡ d61dc726-1cbd-11eb-2190-4f39b2237ffc
md"
**(?1)**
What's `Pkg.activate(mktempdir())` all about?
"

# ╔═╡ 77494690-1cbe-11eb-1368-f1a05b955df0
md"**(R1)** Attempts to answer:"

# ╔═╡ 14cddfc6-1cbe-11eb-376e-5b62a7d6ef5a
tempdir()

# ╔═╡ 14069fea-1cbe-11eb-2f31-f149c32f8491
mktempdir()  # Try executing this cell several times to see the efect

# ╔═╡ 477159dc-2bcb-11eb-3dc2-27da6d69b559


# ╔═╡ ef8f44b2-f5fc-11ea-1e4d-bd873cd39d6c
@bind nn Slider(1:20, show_value=true)

# ╔═╡ fd9211c0-f5fc-11ea-1745-7f2dae88af9e
@bind kk Slider(1:nn, default=nn, show_value=true)

# ╔═╡ 3a1ed5b8-f5fd-11ea-2ecd-b9d08349651f
colors = [colorant"black", colorant"red"]

# ╔═╡ 97c98efc-1cbe-11eb-1e22-b74415521c72
md"`colorant`? Where is it defined?"

# ╔═╡ 77ae1146-f5d2-11ea-1226-27d15c90a8df
begin
	v = fill(1, nn)
	v[kk] = 2
	
	colors[v]'
end

# ╔═╡ d41aaa20-1cbf-11eb-2882-d5835fb6b01b
md"**(?2)**
`'` means __transpose__ of a matrix?
"

# ╔═╡ 3592648a-f5fd-11ea-2ed0-a1d4a4c14d07
colors[v]

# ╔═╡ 99e9d602-2bcc-11eb-22d4-7394bb5a8173
[1 2 3]

# ╔═╡ 9dc9ede8-2bcc-11eb-1f73-25fcd0638137
[1 2 3]'

# ╔═╡ c6bbee3c-1cbf-11eb-1870-1d16fdaefb32
typeof(colors[v])

# ╔═╡ 81d88bea-11e0-11eb-02c9-3d6a58988296
colors[v]'

# ╔═╡ f0520d6e-1cbf-11eb-156a-058f99206dd0
typeof(colors[v]')

# ╔═╡ 04af1a66-1cbf-11eb-1b75-4fdbc38a1eec
v

# ╔═╡ 7ffa02f6-f5d2-11ea-1b41-15c21f92e9ee
Int.((1:10) .== 3)

# ╔═╡ 0690e74c-11e1-11eb-236a-736f63a47db0
(1:10) .== 3

# ╔═╡ 21a15906-f5d3-11ea-3a71-f53eabc31acc
md"Colors and sliders"

# ╔═╡ 3c5f0ba8-f5d3-11ea-22d3-4f7c513144bc
md"Data structure for a one-hot vector"

# ╔═╡ 4624cd26-f5d3-11ea-1cf8-7d6555eae5fa
struct OneHot <: AbstractVector{Int}
	n::Int
	k::Int
end

# ╔═╡ 397ac764-f5fe-11ea-20cc-8d7cab19d410
Base.size(x::OneHot) = (x.n, )

# ╔═╡ 82c7046c-f5d3-11ea-04e2-ef7c0f4db5da
Base.getindex(x::OneHot, i::Int) = Int(x.k == i)

# ╔═╡ 7a98f708-f5d3-11ea-2301-cde71ca469ff
x = OneHot(5, 3)

# ╔═╡ a8386252-1cc0-11eb-20f3-418d6a4ed672
x[1:4]

# ╔═╡ cf77d83c-f5fd-11ea-136e-8951de64e05e
show_vector(x::OneHot) = colors[x .+ 1]'

# ╔═╡ 3b6ded74-2bcd-11eb-0c5e-df3ef692d650
md"""
We `colors[x .+ 1]` because `length(colors) = 2`

"""

# ╔═╡ 58d63ebc-11e1-11eb-028f-316ba21898a8
show_vector(x)

# ╔═╡ b1aad82e-1cc0-11eb-3703-4fc209772fb1
md"
##### Stopped here (2020/11/02 (月) 11h00)
"

# ╔═╡ 5813e1b2-f5ff-11ea-2849-a1def74fc065
begin
	imshow(M) = get.(Ref(ColorSchemes.rainbow), M ./ maximum(M))
	imshow(x::AbstractVector) = imshow(x')
end

# ╔═╡ e51d4ef6-f5fd-11ea-28f1-a1616e17f715
imshow(rand(5, 5))

# ╔═╡ fdb630f2-2bce-11eb-1e4f-35e01243fa1a
typeof(rand(5, 5))

# ╔═╡ 982590d4-f5ff-11ea-3802-73292c75ad6c
imshow(x)

# ╔═╡ c3f70e18-f5ff-11ea-35aa-31b22ca506b8
get.([ColorSchemes.rainbow], x)'

# ╔═╡ c200deb0-f5fd-11ea-32e1-d96596b16ebc
x[3]

# ╔═╡ a5989a76-f5d3-11ea-3fe5-5f9959199fe8
typeof(x)

# ╔═╡ b0bd6c6a-f5d3-11ea-00ee-b7c155f23481
x[3:5]

# ╔═╡ bd94f82c-f5d3-11ea-2a1e-77ddaadbfeb9
collect(x)

# ╔═╡ 9c46e1f6-11e1-11eb-085e-9791e2e8cff1
x

# ╔═╡ a23679aa-11e1-11eb-36bc-dfc1ca06999d
collect

# ╔═╡ 8d2c6910-f5d4-11ea-1928-1baf09815687
md"""How much "information" (numbers) do you need to represent a one-hot vector? Is it $n$ or is it two?
"""

# ╔═╡ 94662606-2bcf-11eb-1f60-57a602d279c3
myonehot = OneHot(6,2)

# ╔═╡ 81c35324-f5d4-11ea-2338-9f982d38732c
md"# Diagonal matrices"

# ╔═╡ 2cfda0dc-f5d5-11ea-16c4-b5a33b90e37f
md"As you might see in high school:"

# ╔═╡ 150432d4-f5d5-11ea-32b2-19a2a91d9637
M = [5 0 0 
	 0 6 0
	 0 0 -10]	

# ╔═╡ 21328d1c-f5d5-11ea-288e-4171ad35326d
Diagonal(M)

# ╔═╡ 91fedca6-2bd0-11eb-0886-e7e62f8c4026
Diagonal([5,6,-10])

# ╔═╡ 9c4a6d54-2bd0-11eb-0546-77dbed6e32a5
Diagonal((5,6,-10))

# ╔═╡ ab820746-2bd0-11eb-2c58-b98794a0681d
[5,6,-10], typeof([5,6,-10])

# ╔═╡ d8f36278-f5d5-11ea-3338-8573ce40e65e
md"How much information do you need for a diagonal matrix?"

# ╔═╡ e90c55fc-f5d5-11ea-10f1-470ff772985d
md"""We should always look for *structure* where it exists"""

# ╔═╡ 19775c3c-f5d6-11ea-15c2-89618e654a1e
md"## Sparse matrices"

# ╔═╡ 232d1dcc-f5d6-11ea-2710-658c75b9c7a4
sparse(M)

# ╔═╡ 2b2feb9c-f5d6-11ea-191c-df20360b12a9
M2 = spzeros(10^6, 10^6)

# ╔═╡ 50c74f6c-f5d6-11ea-29f1-5de9997d5d9f
M2[1, 2] = 1

# ╔═╡ 5de72b7c-f5d6-11ea-1b6f-35b830b5fb34
M3 = sparse([1, 2, 10^6], [4, 10, 10^6], [7, 8, 9])

# ╔═╡ 2fd7e52e-f5d7-11ea-3b5a-1f338e2451e0
M4 = [1 0 2 0 10; 0 3 4 0 9; 0 0 0 5 8; 0 0 0 0 7] .* 0

# ╔═╡ aa09c008-f5d8-11ea-1bdc-b51ee6eb2478
sparse(M4)

# ╔═╡ d941cd66-f5d8-11ea-26ff-47ba7779ab20
md"Sparse matrix dictionaries? Before CSC"

# ╔═╡ 7c56506a-11e2-11eb-373f-97b7497a89b7
md"
##### Stopped here (2020/10/19 15h10)
"

# ╔═╡ 62a6ec62-f5d9-11ea-071e-ed33c5dea0cd
md"## Rand: Where is the structure?"

# ╔═╡ 67274c3c-f5d9-11ea-3475-c9d228e3bd5a
# join(rand("ACGT", 100))

vv = rand(1:9, 1000000)

# ╔═╡ febc5df6-2bd2-11eb-1d9d-8b166645c3fa
join(rand("ACGT", 100))

# ╔═╡ 08f8087e-2bd3-11eb-0f83-a183ada624f7
rand("ACGT", 100)

# ╔═╡ 1b81c0d4-2bd3-11eb-1cf5-11e591a3f7f5
typeof(rand("ACGT", 100))

# ╔═╡ 1f6c1168-2bd3-11eb-1a9f-1b77748ef7fa
join(rand(1:9, 100))

# ╔═╡ b6c7a918-f600-11ea-18ff-6521507358c6
md"Mention lossless compression e.g. run-length encoding"

# ╔═╡ 765c6552-f5d9-11ea-29d3-bfe7b4b04612
md"""Some might guess that there is "no structure"

Take mean and standard deviation -- some would say that's the structure 

"""

# ╔═╡ 126fb3ea-f5da-11ea-2f7d-0b3259a296ce
mean(vv), std(vv), 5, sqrt(10 * 2/3)

# ╔═╡ 7ccdcc0c-2bd3-11eb-27c7-25a881331018
md"""
**(?)** How does the author see that `10 * 2/3` equals the **variance**?

"""

# ╔═╡ 5f79e8f4-f5da-11ea-2b55-ef344b8a3ba2
var(vv)

# ╔═╡ 9b9e2c2a-f5da-11ea-369b-b513b196515b
md"Statisticians (and professors who've just graded exams) might say that under certain circumstances the mean and the variance give you the necessary structure, and the rest can be thrown away"

# ╔═╡ e68b98ea-f5da-11ea-1a9d-db45e4f80241
m = sum(vv) / length(vv)  # mean

# ╔═╡ f20ccac4-f5da-11ea-0e69-413b5e49f423
σ² = sum( (vv .- m) .^ 2 ) / (length(vv) - 1)

# ╔═╡ 0bc792e8-f5db-11ea-0b7a-1502ddc8008e
var(vv)

# ╔═╡ 12a2e96c-f5db-11ea-1c3e-494ae7446886
σ = sqrt(σ²)

# ╔═╡ 22487ce2-f5db-11ea-32e9-6f70ab2c0353
std(vv)

# ╔═╡ 389ae62e-f5db-11ea-1557-c3adbbee0e5c
md"Sometimes the summary statistics are all you want. (But sometimes not)"

# ╔═╡ 0c2b6408-f5d9-11ea-2b7f-7fece2eecc1f
md"## Multiplication tables"

# ╔═╡ 542a9556-f5db-11ea-0375-99f52416f6e4
md"How do you make a multiplication table?"

# ╔═╡ 165788b2-f601-11ea-3e69-cdbbb6558e54
md"Do you recognise this?"

# ╔═╡ 22941bb8-f601-11ea-1d6e-0d955297bc2e
rand(3) .* rand(4)'

# ╔═╡ 2f75df7e-f601-11ea-2fc2-aff4f335af33
imshow(rand(3) .* rand(4)')

# ╔═╡ 4e1335cc-2bd4-11eb-3b62-e7362de91ed6
size(rand(3))

# ╔═╡ 77655326-2bd4-11eb-3fe1-d787ce74dad8
typeof(rand(3))

# ╔═╡ 5a8bf79e-2bd4-11eb-295c-8bd540ed8891
size(rand(3)')

# ╔═╡ 7c5ce25a-2bd4-11eb-1c62-b5b509414cc9
rand(3) * 3

# ╔═╡ 53e6b612-f601-11ea-05a9-5395e69b3c41
svd(rand(3) .* rand(4)')

# ╔═╡ 3e919766-f601-11ea-0485-05f45484bf8d
md"It's not easy to see the structure!"

# ╔═╡ 1052993e-f601-11ea-2c55-0d67e31b670e
M5 = 
[1  2  3   4
 2  4  6   8
 3  6  9  12
]

# ╔═╡ 68190822-f5db-11ea-117f-d10a161208c3
md"Comprehension:"

# ╔═╡ 71b44874-f5db-11ea-1f67-47bad9295e03
md"Slider"

# ╔═╡ 6c51eddc-f5db-11ea-1235-332cdbb072fa
[i * j for i ∈ 1:3, j ∈ 1:4]

# ╔═╡ 86fb49ee-f5db-11ea-3bfa-c95c3b8775a3
md"Explain '"

# ╔═╡ 173cfab4-f5d9-11ea-0c7c-bf8b0888f6e7
(1:3) .* (1:4)'

# ╔═╡ 8bab3e36-f5db-11ea-187a-f31fa8cf357d
reshape([1, 2, 3], 3, 1)

# ╔═╡ e64291e8-f5db-11ea-0cab-8567b781408f
[1
 2
 3]

# ╔═╡ 0111a124-f5dc-11ea-0904-fdd88d7acac4
MM = rand(3, 3)

# ╔═╡ 06406158-f5dc-11ea-02b1-2519a0176993
MM[:, 1]

# ╔═╡ 12051f06-f5dc-11ea-2f6c-0fdc50eeff01
vvv = [1, 2, 3]

# ╔═╡ 195854e6-f5dc-11ea-114b-2333f87173f7
a = reshape([1, 2, 3], 3, 1)

# ╔═╡ 768116f6-f5dc-11ea-1cfe-b3016c574725
b = reshape([4, 5, 6], 3, 1)

# ╔═╡ 9050426e-f5dc-11ea-373c-65456732bd34
a * b'

# ╔═╡ 965bd07e-f5dc-11ea-2e85-d34996cf2fae
v4 = [1, 2, 3]

# ╔═╡ a9daf4cc-f5dc-11ea-270b-2566f89f168c
v4 * v4'

# ╔═╡ dc0c8b72-f5dc-11ea-3e6f-0f43cbf58f56
v4 .* v4'

# ╔═╡ 54b34efc-2bd5-11eb-0aeb-0b55b6dcdff9
md"""
**(?)** Checkout the source code of `*` when occurred in `v4 * v4'` and `v4 .* v4'`.

"""

# ╔═╡ ad791c68-2c04-11eb-3a92-ad36738f5e78
@which v4 .* v4'

# ╔═╡ db0a0372-2c04-11eb-3c72-f9d81da2a28c
@which v4 * v4'

# ╔═╡ c9b5e918-2c04-11eb-33e8-b703e68f9665
@which .*(v4, v4')

# ╔═╡ 8ffa6880-2c05-11eb-07d8-a98305f1ff73
@which [1,2,3] * 3

# ╔═╡ a3bd08c8-2c05-11eb-284c-cb199f8dbcbd
[1,2,3] * 3

# ╔═╡ f366e2f4-2c05-11eb-39fc-b726defe9776
typeof([1,2,3] * 3)

# ╔═╡ f78a3c84-2c05-11eb-326a-4f20b69ec3ff
typeof([1,2,3] * [4,5,6])

# ╔═╡ 0b0f105c-2c06-11eb-2e14-594db4c80510
[1,2,3] .* [4,5,6]

# ╔═╡ 2ab8f6ca-2c06-11eb-2f06-1993332149a2
[[1,2,3] * x for x in [4,5,6]]

# ╔═╡ 4470b678-2c06-11eb-34fe-afcb2893e9cc
[1,2,3] .* [4,5,6]'

# ╔═╡ 59af5186-2c06-11eb-0565-e71d522a21cc
typeof([4,5,6]')

# ╔═╡ 05628762-2c06-11eb-3896-9f92e1a709dd
typeof([1,2,3] .* [4,5,6])

# ╔═╡ 0ed78e76-f5dd-11ea-2ad8-a35a69c0ef9a
v4

# ╔═╡ 1648a0fa-f5dd-11ea-0292-495207e83de9
[v4 v4]

# ╔═╡ 1e9cefea-f5dd-11ea-3e5f-a189fd41c42e
[1*v4 5*v4 6*v4]

# ╔═╡ 24664f20-f5dd-11ea-2a69-cd3e0ebd5c39
v4 * [1, 5, 6]'

# ╔═╡ 43a4920c-f5dd-11ea-1ab1-0b3d673c0f1e
v4 .* [1, 5, 6]'

# ╔═╡ 5d767290-f5dd-11ea-2189-81198fd216ce
outer(v, w) = [x * y for x in v, y in w]  # just a multiplication table

# ╔═╡ 5a493052-f601-11ea-2f5f-f940412905f2
begin
	v6 = rand(3)
	w6 = rand(4)
	
	U6, Σ6, V6 = svd( outer(v6, w6) )
end

# ╔═╡ 8633afb2-f601-11ea-206b-e9c4b9621c2a
outer(U6[:,1], V6[:, 1]) .* Σ6[1]

# ╔═╡ 9918c4fa-f601-11ea-3bf1-3506dcb437f7
outer(v6, w6)

# ╔═╡ 6aae805e-f5dd-11ea-108c-733daae313dc
outer(v4, [1, 5, 6])

# ╔═╡ 9a023cf8-f5dd-11ea-3016-f95d433e6df0
outer(1:10, 1:10)  # works with things other than Vectors

# ╔═╡ b4c82246-f5dd-11ea-068f-2f63a5a382e2
md"Did you memorize this in third grade?"

# ╔═╡ d1f87b22-f5dd-11ea-3bc3-471d5b3a5202
md"Slider: 12 is the standard in the UK"

# ╔═╡ d790281e-f5dd-11ea-0d1c-f57da5018a6b
md"How much information do I need to store a multiplication table?"

# ╔═╡ d1578d4c-f601-11ea-2983-27dc131d39b8
md"### Scaled multiplication table"

# ╔═╡ d9556f32-f601-11ea-3dd8-1bc876b7b719
10 .* outer(1:10, 1:10)

# ╔═╡ e36e4ec2-f5dd-11ea-34ea-1bcf5fd7c16d
md"In the context of 1:n times 1:n, just one number n is needed.

But given arbitrary vectors v and w,  we need to store the whole of v and w"

# ╔═╡ 52e857ca-f5de-11ea-14bb-bdc0ac24ab90
md"Toeplitz in hw"

# ╔═╡ 98f08990-f5de-11ea-1f56-1f2d73649773
"Add mult tables to make flag"

# ╔═╡ 21bbb60a-f5df-11ea-2c1b-dd716a657df8
cs = distinguishable_colors(100)

# ╔═╡ 19fa5366-2bd6-11eb-06cf-0979ba2cc02c
@which distinguishable_colors  # Find out which package gives this function

# ╔═╡ a5d637ea-f5de-11ea-3b70-877e876bc9c9
flag = outer([1, 1, 1, 2, 2, 2, 1, 1, 1], ones(Int, 9))

# ╔═╡ 2668e100-f5df-11ea-12b0-073a578a5edb
cs[flag]

# ╔═╡ 6dd4b226-2bd6-11eb-3e97-f589d9fcf95e
typeof(cs)

# ╔═╡ e8d727f2-f5de-11ea-1456-f72602e81e0d
cs[flag + flag']  # flag + flag' should be a symmetric matrix

# ╔═╡ 1acc670a-2bda-11eb-1f26-1d287a201bfe
cs[outer([1, 1, 1, 2, 2, 2, 1, 1, 1], ones(Int, 9)) + outer(ones(Int, 9), [1, 1, 1, 2, 2, 2, 1, 1, 1])]

# ╔═╡ 4c80c786-f5df-11ea-31ec-318439349648
cs[outer(rand(1:10, 3), rand(1:10, 5))]

# ╔═╡ 8d2bae22-f5df-11ea-10d3-859f4c3aa6c7
Gray.((100 .- outer(1:10, 1:10)) ./ 100)

# ╔═╡ 0a2c6d12-2bd7-11eb-158d-97a78aa00321
N0f8

# ╔═╡ bb8d92a8-2bd6-11eb-3424-63f9822a87d7
Gray.((100 .- outer(1:10, 1:10)))  # see what happens if no ./ 100

# ╔═╡ e23debc8-f5df-11ea-2c1e-b58a64f9acd3
ColorSchemes.rainbow[floor.(Int, (1:10, 1:10) ./ 10)]

# ╔═╡ 70b8918e-f5e0-11ea-3c86-6fa72df5a28e
ColorSchemes.rainbow.colors[floor.(Int, outer(1:10, 1:10) ./ 10)]

# ╔═╡ a0934122-f5e0-11ea-1f3b-ab0021ac6906
ColorSchemes.rainbow.colors[ceil.(Int, outer(1:10, 1:10) ./ 10)]

# ╔═╡ b9381b8a-f5e0-11ea-1f84-e39325203038
length(ColorSchemes.rainbow)

# ╔═╡ 4cf96558-f5e0-11ea-19be-db4c59a41120
ColorSchemes.rainbow

# ╔═╡ 11de523c-f5e0-11ea-2f3d-c981c1b6a1fe
outer(1:10, 1:10) ./ 100

# ╔═╡ fb0c6c7e-f5df-11ea-38d0-2d98c9dc232f
md"
##### Stopped here (2020/11/21 16h10)
"

# ╔═╡ ebd72fb8-f5e0-11ea-0630-573337dff753
md"## SVD"

# ╔═╡ f00d1eaa-f5e0-11ea-21df-d9cf6f7af9b9
md"Grab the rank-1 approx of an image.

First multiplication table"

# ╔═╡ b6478e1a-f5f6-11ea-3b92-6d4f067285f4
url = "https://arbordayblog.org/wp-content/uploads/2018/06/oak-tree-sunset-iStock-477164218.jpg"

# ╔═╡ d4a049a2-f5f8-11ea-2f34-4bc0e3a5954a
download(url, "tree.jpg")

# ╔═╡ f2c11f88-f5f8-11ea-3e02-c1d4fa22031e
begin
	image = load("tree.jpg")
	#println(size(image))
	image = image[1:5:end, 1:5:end]
	#println(size(image))
end

# ╔═╡ eebb9094-2c03-11eb-2115-affb6b5ca59e
size(load("tree.jpg"))

# ╔═╡ f76cd784-2c03-11eb-3bf6-5bcd2d928839
size(load("tree.jpg")[1:5:end, 1:5:end])

# ╔═╡ f7e38aaa-f5f8-11ea-002f-09dd1fa21181
reds = [Float64(c.r) for c in image]

# ╔═╡ 291abb52-2c04-11eb-3b85-53f6149f94f4
[c.r for c in image]

# ╔═╡ 29062f7a-f5f9-11ea-2682-1374e7694e32
picture = Float64.(channelview(image))

# ╔═╡ 6156fd1e-f5f9-11ea-06a9-211c7ab813a4
pr, pg, pb = eachslice(picture, dims=1)

# ╔═╡ 05366132-2c09-11eb-3d7a-031e7045159b
pr

# ╔═╡ a9766e68-f5f9-11ea-0019-6f9d02050521
[RGB.(pr, 0, 0) RGB.(0, pg, 0) RGB.(0, 0, pb)]

# ╔═╡ fee66076-f5f9-11ea-2316-abc57b62a57c
RGB.(image)

# ╔═╡ 0c0ee362-f5f9-11ea-0f75-2d2810c88d65
begin
	Ur, Σr, Vr = svd(pr)
	Ug, Σg, Vg = svd(pg)
	Ub, Σb, Vb = svd(pb)
end

# ╔═╡ 3c28c4c2-f5fa-11ea-1947-9dfe91ea1535
RGB.(sum(outer(Ur[:,i], Vr[:,i]) .* Σr[i] for i in 1:5), 0, 0)

# ╔═╡ 6c66a4f2-2c09-11eb-09ec-517d7a704aec
(pr, 0, 0)

# ╔═╡ a67f9766-2c09-11eb-3fb7-df7b74234074
typeof(RGB.(pr, 0, 0))

# ╔═╡ b181e768-2c09-11eb-13c0-f1405cc311c7
size(RGB.(pr, 0, 0))

# ╔═╡ bc42c514-2c09-11eb-3ce8-b719da4ed6f6
md"""
**(?)** What's the logic behind the fact that we are able to write `RGB.(pr, 0, 0)`?

"""

# ╔═╡ f56f40e4-f5fa-11ea-3a99-156565445c2e
@bind n Slider(1:100, show_value=true)

# ╔═╡ 7ba6e6a6-f5fa-11ea-2bcd-616d5a3c898b
RGB.(sum(outer(Ur[:,i], Vr[:,i]) .* Σr[i] for i in 1:n), 
	sum(outer(Ug[:,i], Vg[:,i]) .* Σg[i] for i in 1:n),
	sum(outer(Ub[:,i], Vb[:,i]) .* Σb[i] for i in 1:n))

# ╔═╡ 8a22387e-f5fb-11ea-249b-435af5c0a6b6


# ╔═╡ f9825a40-2c09-11eb-0d75-4ff8439275b9
md"""
**(?)** Try to do the same thing with `tree.jpg` in **python** and see how its speed is compared to Julia.
"""

# ╔═╡ 8df84fcc-f5d5-11ea-312f-bf2a3b3ce2ce
md"## Appendix"

# ╔═╡ 91980bcc-f5d5-11ea-211f-e9a08ff0fb19
function with_terminal(f)
	local spam_out, spam_err
	@color_output false begin
		spam_out = @capture_out begin
			spam_err = @capture_err begin
				f()
			end
		end
	end
	spam_out, spam_err
	
	HTML("""
		<style>
		div.vintage_terminal {
			
		}
		div.vintage_terminal pre {
			color: #ddd;
			background-color: #333;
			border: 5px solid pink;
			font-size: .75rem;
		}
		
		</style>
	<div class="vintage_terminal">
		<pre>$(Markdown.htmlesc(spam_out))</pre>
	</div>
	""")
end

# ╔═╡ 97e1e066-2bcf-11eb-0e76-239e5b252c15
with_terminal() do
    dump(myonehot)
end

# ╔═╡ 466a01b0-2bd0-11eb-0844-93f9a6031a34
with_terminal() do
    dump([0,1,0,0,0,0])
end

# ╔═╡ 466901ea-f5d5-11ea-1db5-abf82c96eabf
with_terminal() do
	dump(M)
end

# ╔═╡ b38c4aae-f5d5-11ea-39b6-7b0c7d529019
with_terminal() do
	dump(Diagonal(M))
end

# ╔═╡ ddf67b58-2bd0-11eb-06a2-c5fdc4ad845f
with_terminal() do
	dump(Diagonal([5,6,-10]))
end

# ╔═╡ 8b60629e-f5d6-11ea-27c8-d934460d3a57
with_terminal() do
	dump(M3)
end

# ╔═╡ 88ab93b6-2bd2-11eb-16dd-0b26b00bef5b
with_terminal() do
    dump(sparse([0 8 9; 5 0 0; 12 0 4]))
end

# ╔═╡ cde79f38-f5d6-11ea-3297-0b5b240f7b9e
with_terminal() do
	dump(sparse(M4))
end

# ╔═╡ 4f8684ea-f5fb-11ea-07be-11d8046f35df
with_terminal() do
	@time @inbounds RGB.(sum(outer(Ur[:,i], Vr[:,i]) .* Σr[i] for i in 1:20), 
	sum(outer(Ug[:,i], Vg[:,i]) .* Σg[i] for i in 1:20),
	sum(outer(Ub[:,i], Vb[:,i]) .* Σb[i] for i in 1:20));
end

# ╔═╡ 69374b56-2c04-11eb-090b-8362caf5fbb2
[Float64(c.r) for c in image]

# ╔═╡ a58cf152-2c20-11eb-1b79-13ec5f4fab2a
RGB.([0.1, 0.9], 0, 0)

# ╔═╡ 393638d2-2c21-11eb-2a34-4da73047b06d
RGB.(rand(Float64,(10,10)), 0, 0)

# ╔═╡ a81a2394-2c21-11eb-3db9-c17ac60d28e7
rand(Float64,(10,10))

# ╔═╡ 7726fca8-2c21-11eb-0f4c-2d1df7865516
RGB(0.9)

# ╔═╡ b78a3800-2c21-11eb-0073-d96ffc667e00
RGB(0.9, 0.1, 0.7)

# ╔═╡ 32b8c00a-2c22-11eb-015f-a7390ac535d2
RGB.([rand(Float64,(10,10)),0,0])

# ╔═╡ 8c2879a0-2c22-11eb-3bfd-77ff960527bb
#begin
#	K = rand(Float64,(10,10))
#	RGB.([K,K,K])
#end

# ╔═╡ a81d41b8-2c22-11eb-28b4-0be55a229a28
begin
	K = rand(Float64,(10,10))
	RGB.((K,K,K))
end

# ╔═╡ dfd12e92-2c8d-11eb-01ff-bd25c7907027
RGB.([K K K])

# ╔═╡ fda82466-2c8d-11eb-2e3e-433b03ddab15
RGB.([K, K, K])

# ╔═╡ Cell order:
# ╟─b0ba5b8c-f5d1-11ea-1304-3f0e47f935fe
# ╟─ffa95430-f5d1-11ea-3cb7-5bb8d8f13701
# ╠═671c9ad2-1cbf-11eb-1c57-dbb7f3d8e728
# ╠═43e5b364-1cbf-11eb-2d5f-61e48bb73d66
# ╟─261c4df2-f5d2-11ea-2c72-7d4b09c46098
# ╠═ae24c8b2-f60b-11ea-2c7a-03857d1217b2
# ╠═b5177f70-f60b-11ea-14a9-f5a574cc5185
# ╟─d61dc726-1cbd-11eb-2190-4f39b2237ffc
# ╟─77494690-1cbe-11eb-1368-f1a05b955df0
# ╠═14cddfc6-1cbe-11eb-376e-5b62a7d6ef5a
# ╠═14069fea-1cbe-11eb-2f31-f149c32f8491
# ╠═477159dc-2bcb-11eb-3dc2-27da6d69b559
# ╠═bc14fc1a-f60b-11ea-207a-91b967f28076
# ╠═ef8f44b2-f5fc-11ea-1e4d-bd873cd39d6c
# ╠═fd9211c0-f5fc-11ea-1745-7f2dae88af9e
# ╠═3a1ed5b8-f5fd-11ea-2ecd-b9d08349651f
# ╟─97c98efc-1cbe-11eb-1e22-b74415521c72
# ╠═77ae1146-f5d2-11ea-1226-27d15c90a8df
# ╟─d41aaa20-1cbf-11eb-2882-d5835fb6b01b
# ╠═3592648a-f5fd-11ea-2ed0-a1d4a4c14d07
# ╠═99e9d602-2bcc-11eb-22d4-7394bb5a8173
# ╠═9dc9ede8-2bcc-11eb-1f73-25fcd0638137
# ╠═c6bbee3c-1cbf-11eb-1870-1d16fdaefb32
# ╠═81d88bea-11e0-11eb-02c9-3d6a58988296
# ╠═f0520d6e-1cbf-11eb-156a-058f99206dd0
# ╠═04af1a66-1cbf-11eb-1b75-4fdbc38a1eec
# ╠═7ffa02f6-f5d2-11ea-1b41-15c21f92e9ee
# ╠═0690e74c-11e1-11eb-236a-736f63a47db0
# ╟─21a15906-f5d3-11ea-3a71-f53eabc31acc
# ╟─3c5f0ba8-f5d3-11ea-22d3-4f7c513144bc
# ╠═4624cd26-f5d3-11ea-1cf8-7d6555eae5fa
# ╠═397ac764-f5fe-11ea-20cc-8d7cab19d410
# ╠═82c7046c-f5d3-11ea-04e2-ef7c0f4db5da
# ╠═7a98f708-f5d3-11ea-2301-cde71ca469ff
# ╠═a8386252-1cc0-11eb-20f3-418d6a4ed672
# ╠═cf77d83c-f5fd-11ea-136e-8951de64e05e
# ╠═3b6ded74-2bcd-11eb-0c5e-df3ef692d650
# ╠═58d63ebc-11e1-11eb-028f-316ba21898a8
# ╟─b1aad82e-1cc0-11eb-3703-4fc209772fb1
# ╠═5813e1b2-f5ff-11ea-2849-a1def74fc065
# ╠═e51d4ef6-f5fd-11ea-28f1-a1616e17f715
# ╠═fdb630f2-2bce-11eb-1e4f-35e01243fa1a
# ╠═982590d4-f5ff-11ea-3802-73292c75ad6c
# ╠═c3f70e18-f5ff-11ea-35aa-31b22ca506b8
# ╠═c200deb0-f5fd-11ea-32e1-d96596b16ebc
# ╠═a5989a76-f5d3-11ea-3fe5-5f9959199fe8
# ╠═b0bd6c6a-f5d3-11ea-00ee-b7c155f23481
# ╠═bd94f82c-f5d3-11ea-2a1e-77ddaadbfeb9
# ╠═9c46e1f6-11e1-11eb-085e-9791e2e8cff1
# ╟─a23679aa-11e1-11eb-36bc-dfc1ca06999d
# ╟─8d2c6910-f5d4-11ea-1928-1baf09815687
# ╠═94662606-2bcf-11eb-1f60-57a602d279c3
# ╠═97e1e066-2bcf-11eb-0e76-239e5b252c15
# ╠═466a01b0-2bd0-11eb-0844-93f9a6031a34
# ╟─81c35324-f5d4-11ea-2338-9f982d38732c
# ╟─2cfda0dc-f5d5-11ea-16c4-b5a33b90e37f
# ╠═0feb5674-f5d5-11ea-0714-7379a7d381a3
# ╠═150432d4-f5d5-11ea-32b2-19a2a91d9637
# ╠═21328d1c-f5d5-11ea-288e-4171ad35326d
# ╠═91fedca6-2bd0-11eb-0886-e7e62f8c4026
# ╠═9c4a6d54-2bd0-11eb-0546-77dbed6e32a5
# ╠═ab820746-2bd0-11eb-2c58-b98794a0681d
# ╠═466901ea-f5d5-11ea-1db5-abf82c96eabf
# ╠═b38c4aae-f5d5-11ea-39b6-7b0c7d529019
# ╠═ddf67b58-2bd0-11eb-06a2-c5fdc4ad845f
# ╟─d8f36278-f5d5-11ea-3338-8573ce40e65e
# ╟─e90c55fc-f5d5-11ea-10f1-470ff772985d
# ╟─19775c3c-f5d6-11ea-15c2-89618e654a1e
# ╠═20125236-f5d6-11ea-3877-6b332497be62
# ╠═232d1dcc-f5d6-11ea-2710-658c75b9c7a4
# ╠═2b2feb9c-f5d6-11ea-191c-df20360b12a9
# ╠═50c74f6c-f5d6-11ea-29f1-5de9997d5d9f
# ╠═5de72b7c-f5d6-11ea-1b6f-35b830b5fb34
# ╠═8b60629e-f5d6-11ea-27c8-d934460d3a57
# ╠═88ab93b6-2bd2-11eb-16dd-0b26b00bef5b
# ╠═2fd7e52e-f5d7-11ea-3b5a-1f338e2451e0
# ╠═cde79f38-f5d6-11ea-3297-0b5b240f7b9e
# ╠═aa09c008-f5d8-11ea-1bdc-b51ee6eb2478
# ╟─d941cd66-f5d8-11ea-26ff-47ba7779ab20
# ╟─7c56506a-11e2-11eb-373f-97b7497a89b7
# ╟─62a6ec62-f5d9-11ea-071e-ed33c5dea0cd
# ╠═67274c3c-f5d9-11ea-3475-c9d228e3bd5a
# ╠═febc5df6-2bd2-11eb-1d9d-8b166645c3fa
# ╠═08f8087e-2bd3-11eb-0f83-a183ada624f7
# ╠═1b81c0d4-2bd3-11eb-1cf5-11e591a3f7f5
# ╠═1f6c1168-2bd3-11eb-1a9f-1b77748ef7fa
# ╟─b6c7a918-f600-11ea-18ff-6521507358c6
# ╟─765c6552-f5d9-11ea-29d3-bfe7b4b04612
# ╠═0f6ecba6-f5da-11ea-22c2-2929e562f413
# ╠═126fb3ea-f5da-11ea-2f7d-0b3259a296ce
# ╟─7ccdcc0c-2bd3-11eb-27c7-25a881331018
# ╠═5f79e8f4-f5da-11ea-2b55-ef344b8a3ba2
# ╟─9b9e2c2a-f5da-11ea-369b-b513b196515b
# ╠═e68b98ea-f5da-11ea-1a9d-db45e4f80241
# ╠═f20ccac4-f5da-11ea-0e69-413b5e49f423
# ╠═0bc792e8-f5db-11ea-0b7a-1502ddc8008e
# ╠═12a2e96c-f5db-11ea-1c3e-494ae7446886
# ╠═22487ce2-f5db-11ea-32e9-6f70ab2c0353
# ╠═389ae62e-f5db-11ea-1557-c3adbbee0e5c
# ╟─0c2b6408-f5d9-11ea-2b7f-7fece2eecc1f
# ╟─542a9556-f5db-11ea-0375-99f52416f6e4
# ╟─165788b2-f601-11ea-3e69-cdbbb6558e54
# ╠═22941bb8-f601-11ea-1d6e-0d955297bc2e
# ╠═2f75df7e-f601-11ea-2fc2-aff4f335af33
# ╠═4e1335cc-2bd4-11eb-3b62-e7362de91ed6
# ╠═77655326-2bd4-11eb-3fe1-d787ce74dad8
# ╠═5a8bf79e-2bd4-11eb-295c-8bd540ed8891
# ╠═7c5ce25a-2bd4-11eb-1c62-b5b509414cc9
# ╠═53e6b612-f601-11ea-05a9-5395e69b3c41
# ╠═5a493052-f601-11ea-2f5f-f940412905f2
# ╠═8633afb2-f601-11ea-206b-e9c4b9621c2a
# ╠═9918c4fa-f601-11ea-3bf1-3506dcb437f7
# ╟─3e919766-f601-11ea-0485-05f45484bf8d
# ╠═1052993e-f601-11ea-2c55-0d67e31b670e
# ╟─68190822-f5db-11ea-117f-d10a161208c3
# ╟─71b44874-f5db-11ea-1f67-47bad9295e03
# ╠═6c51eddc-f5db-11ea-1235-332cdbb072fa
# ╟─86fb49ee-f5db-11ea-3bfa-c95c3b8775a3
# ╠═173cfab4-f5d9-11ea-0c7c-bf8b0888f6e7
# ╠═8bab3e36-f5db-11ea-187a-f31fa8cf357d
# ╠═e64291e8-f5db-11ea-0cab-8567b781408f
# ╠═0111a124-f5dc-11ea-0904-fdd88d7acac4
# ╠═06406158-f5dc-11ea-02b1-2519a0176993
# ╠═12051f06-f5dc-11ea-2f6c-0fdc50eeff01
# ╠═195854e6-f5dc-11ea-114b-2333f87173f7
# ╠═768116f6-f5dc-11ea-1cfe-b3016c574725
# ╠═9050426e-f5dc-11ea-373c-65456732bd34
# ╠═965bd07e-f5dc-11ea-2e85-d34996cf2fae
# ╠═a9daf4cc-f5dc-11ea-270b-2566f89f168c
# ╠═dc0c8b72-f5dc-11ea-3e6f-0f43cbf58f56
# ╟─54b34efc-2bd5-11eb-0aeb-0b55b6dcdff9
# ╠═ad791c68-2c04-11eb-3a92-ad36738f5e78
# ╠═db0a0372-2c04-11eb-3c72-f9d81da2a28c
# ╠═c9b5e918-2c04-11eb-33e8-b703e68f9665
# ╠═8ffa6880-2c05-11eb-07d8-a98305f1ff73
# ╠═a3bd08c8-2c05-11eb-284c-cb199f8dbcbd
# ╠═f366e2f4-2c05-11eb-39fc-b726defe9776
# ╠═f78a3c84-2c05-11eb-326a-4f20b69ec3ff
# ╠═0b0f105c-2c06-11eb-2e14-594db4c80510
# ╠═2ab8f6ca-2c06-11eb-2f06-1993332149a2
# ╠═4470b678-2c06-11eb-34fe-afcb2893e9cc
# ╠═59af5186-2c06-11eb-0565-e71d522a21cc
# ╠═05628762-2c06-11eb-3896-9f92e1a709dd
# ╠═0ed78e76-f5dd-11ea-2ad8-a35a69c0ef9a
# ╠═1648a0fa-f5dd-11ea-0292-495207e83de9
# ╠═1e9cefea-f5dd-11ea-3e5f-a189fd41c42e
# ╠═24664f20-f5dd-11ea-2a69-cd3e0ebd5c39
# ╠═43a4920c-f5dd-11ea-1ab1-0b3d673c0f1e
# ╠═5d767290-f5dd-11ea-2189-81198fd216ce
# ╠═6aae805e-f5dd-11ea-108c-733daae313dc
# ╠═9a023cf8-f5dd-11ea-3016-f95d433e6df0
# ╠═b4c82246-f5dd-11ea-068f-2f63a5a382e2
# ╠═d1f87b22-f5dd-11ea-3bc3-471d5b3a5202
# ╠═d790281e-f5dd-11ea-0d1c-f57da5018a6b
# ╠═d1578d4c-f601-11ea-2983-27dc131d39b8
# ╠═d9556f32-f601-11ea-3dd8-1bc876b7b719
# ╟─e36e4ec2-f5dd-11ea-34ea-1bcf5fd7c16d
# ╟─52e857ca-f5de-11ea-14bb-bdc0ac24ab90
# ╟─98f08990-f5de-11ea-1f56-1f2d73649773
# ╠═21bbb60a-f5df-11ea-2c1b-dd716a657df8
# ╠═19fa5366-2bd6-11eb-06cf-0979ba2cc02c
# ╠═a5d637ea-f5de-11ea-3b70-877e876bc9c9
# ╠═2668e100-f5df-11ea-12b0-073a578a5edb
# ╠═6dd4b226-2bd6-11eb-3e97-f589d9fcf95e
# ╠═e8d727f2-f5de-11ea-1456-f72602e81e0d
# ╠═1acc670a-2bda-11eb-1f26-1d287a201bfe
# ╠═4c80c786-f5df-11ea-31ec-318439349648
# ╠═8d2bae22-f5df-11ea-10d3-859f4c3aa6c7
# ╠═0a2c6d12-2bd7-11eb-158d-97a78aa00321
# ╠═bb8d92a8-2bd6-11eb-3424-63f9822a87d7
# ╠═e23debc8-f5df-11ea-2c1e-b58a64f9acd3
# ╠═70b8918e-f5e0-11ea-3c86-6fa72df5a28e
# ╠═a0934122-f5e0-11ea-1f3b-ab0021ac6906
# ╠═b9381b8a-f5e0-11ea-1f84-e39325203038
# ╠═4cf96558-f5e0-11ea-19be-db4c59a41120
# ╠═11de523c-f5e0-11ea-2f3d-c981c1b6a1fe
# ╟─fb0c6c7e-f5df-11ea-38d0-2d98c9dc232f
# ╟─ebd72fb8-f5e0-11ea-0630-573337dff753
# ╟─f00d1eaa-f5e0-11ea-21df-d9cf6f7af9b9
# ╠═b6478e1a-f5f6-11ea-3b92-6d4f067285f4
# ╠═d4a049a2-f5f8-11ea-2f34-4bc0e3a5954a
# ╠═f2c11f88-f5f8-11ea-3e02-c1d4fa22031e
# ╠═eebb9094-2c03-11eb-2115-affb6b5ca59e
# ╠═f76cd784-2c03-11eb-3bf6-5bcd2d928839
# ╠═f7e38aaa-f5f8-11ea-002f-09dd1fa21181
# ╠═291abb52-2c04-11eb-3b85-53f6149f94f4
# ╠═29062f7a-f5f9-11ea-2682-1374e7694e32
# ╠═6156fd1e-f5f9-11ea-06a9-211c7ab813a4
# ╠═05366132-2c09-11eb-3d7a-031e7045159b
# ╠═a9766e68-f5f9-11ea-0019-6f9d02050521
# ╠═fee66076-f5f9-11ea-2316-abc57b62a57c
# ╠═0c0ee362-f5f9-11ea-0f75-2d2810c88d65
# ╠═3c28c4c2-f5fa-11ea-1947-9dfe91ea1535
# ╠═6c66a4f2-2c09-11eb-09ec-517d7a704aec
# ╠═a67f9766-2c09-11eb-3fb7-df7b74234074
# ╠═b181e768-2c09-11eb-13c0-f1405cc311c7
# ╠═bc42c514-2c09-11eb-3ce8-b719da4ed6f6
# ╠═f56f40e4-f5fa-11ea-3a99-156565445c2e
# ╠═7ba6e6a6-f5fa-11ea-2bcd-616d5a3c898b
# ╠═8a22387e-f5fb-11ea-249b-435af5c0a6b6
# ╠═4f8684ea-f5fb-11ea-07be-11d8046f35df
# ╠═f9825a40-2c09-11eb-0d75-4ff8439275b9
# ╟─8df84fcc-f5d5-11ea-312f-bf2a3b3ce2ce
# ╠═91980bcc-f5d5-11ea-211f-e9a08ff0fb19
# ╠═69374b56-2c04-11eb-090b-8362caf5fbb2
# ╠═a58cf152-2c20-11eb-1b79-13ec5f4fab2a
# ╠═393638d2-2c21-11eb-2a34-4da73047b06d
# ╠═a81a2394-2c21-11eb-3db9-c17ac60d28e7
# ╠═7726fca8-2c21-11eb-0f4c-2d1df7865516
# ╠═b78a3800-2c21-11eb-0073-d96ffc667e00
# ╠═32b8c00a-2c22-11eb-015f-a7390ac535d2
# ╠═8c2879a0-2c22-11eb-3bfd-77ff960527bb
# ╠═a81d41b8-2c22-11eb-28b4-0be55a229a28
# ╠═dfd12e92-2c8d-11eb-01ff-bd25c7907027
# ╠═fda82466-2c8d-11eb-2e3e-433b03ddab15
