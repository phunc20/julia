### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 5df8a742-00b4-11eb-2550-ffdb5889c510
begin
	using Pkg
	Pkg.add(["Images", "ImageIO", "ImageMagick"])
	using Images
end

# ╔═╡ 44194c48-00b2-11eb-2a40-8f7b72d8c826
fill (element, 3, 5)

# ╔═╡ 87575284-00b2-11eb-044b-c70aeb362b03
test = [1,2]

# ╔═╡ 873c10f8-00b2-11eb-0044-63ab2557d356
test2 = [1 2]

# ╔═╡ 3fc0b260-00b4-11eb-34e5-97cd28ed1cfa
#cute_one = load(download("https://www.pngfuel.com/free-png/aazsv"))
cute_one = load(download("https://f0.pngfuel.com/png/880/544/number-cute-number-one-orange-and-red-star-print-number-1-illustration-png-clip-art.png"))

# ╔═╡ 39afb424-00b2-11eb-0a52-193b6a4d1ff7
element = cute_one

# ╔═╡ 43f9b374-00b2-11eb-1c41-d505d59dbfde
fill(element, 3, 5)

# ╔═╡ 43d41466-00b2-11eb-3b3c-1faf5b03c502
kt = [typeof(1) typeof(2.7182) typeof("one") typeof(1//1) typeof(cute_one)]

# ╔═╡ 86f76c34-00b2-11eb-2779-d7354a5a5321
typeof(kt)

# ╔═╡ 8773db70-00b2-11eb-3d87-f9af1d5dd8aa
keeptrack = [typeof(1), typeof(2.7182), typeof("one"), typeof(1//1), typeof(cute_one)]

# ╔═╡ 87205048-00b2-11eb-17e5-d96d0b3061de
typeof(keeptrack)

# ╔═╡ be1ee572-00b5-11eb-09ab-6368a13bf722
download("https://i.ytimg.com/vi/nSj7mMjgRug/maxresdefault.jpg", "/tmp/one.png")

# ╔═╡ bfbb178a-00b7-11eb-05f3-af87657c2e2c
load("/tmp/one.png")

# ╔═╡ Cell order:
# ╠═39afb424-00b2-11eb-0a52-193b6a4d1ff7
# ╠═44194c48-00b2-11eb-2a40-8f7b72d8c826
# ╠═43f9b374-00b2-11eb-1c41-d505d59dbfde
# ╠═43d41466-00b2-11eb-3b3c-1faf5b03c502
# ╠═8773db70-00b2-11eb-3d87-f9af1d5dd8aa
# ╠═87575284-00b2-11eb-044b-c70aeb362b03
# ╠═873c10f8-00b2-11eb-0044-63ab2557d356
# ╠═87205048-00b2-11eb-17e5-d96d0b3061de
# ╠═86f76c34-00b2-11eb-2779-d7354a5a5321
# ╠═5df8a742-00b4-11eb-2550-ffdb5889c510
# ╠═3fc0b260-00b4-11eb-34e5-97cd28ed1cfa
# ╠═be1ee572-00b5-11eb-09ab-6368a13bf722
# ╠═bfbb178a-00b7-11eb-05f3-af87657c2e2c
