### A Pluto.jl notebook ###
# v0.12.7

using Markdown
using InteractiveUtils

# ╔═╡ 63394910-2ca5-11eb-25b7-1ffbc0904ab1
using Pkg

# ╔═╡ 97a331de-2ca5-11eb-111b-19959dee7344
begin
	pkg"add Colors ColorSchemes PlutoUI Suppressor InteractiveUtils"
	using Colors, ColorSchemes
	using Suppressor, InteractiveUtils, PlutoUI
end

# ╔═╡ 6963423c-2ca5-11eb-3131-5d6b0ebd277d
Pkg.activate(mktempdir())

# ╔═╡ d66fa7ea-2ca4-11eb-1a35-eb7558f2de17
RGB(0.5, 0.1, 0)

# ╔═╡ 1493fd40-2ca6-11eb-0d68-77894d2f62bc
@enter RGB.(rand(Float64, (5,5)), 0, 0)

# ╔═╡ edbde292-2cb6-11eb-23a3-030e7199f54e
with_terminal() do
	dump(RGB.(rand(Float64, (5,5)), 0, 0))
end

# ╔═╡ f905f5d4-2cb6-11eb-2494-2f37811e9571
md"Well, that didn't help."

# ╔═╡ f8d9dadc-2cb6-11eb-1178-b1c24bd78680


# ╔═╡ f8c01674-2cb6-11eb-3802-8521cb493b0f


# ╔═╡ Cell order:
# ╠═63394910-2ca5-11eb-25b7-1ffbc0904ab1
# ╠═6963423c-2ca5-11eb-3131-5d6b0ebd277d
# ╠═97a331de-2ca5-11eb-111b-19959dee7344
# ╠═d66fa7ea-2ca4-11eb-1a35-eb7558f2de17
# ╠═1493fd40-2ca6-11eb-0d68-77894d2f62bc
# ╠═edbde292-2cb6-11eb-23a3-030e7199f54e
# ╟─f905f5d4-2cb6-11eb-2494-2f37811e9571
# ╠═f8d9dadc-2cb6-11eb-1178-b1c24bd78680
# ╠═f8c01674-2cb6-11eb-3802-8521cb493b0f
