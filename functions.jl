### A Pluto.jl notebook ###
# v0.12.4

using Markdown
using InteractiveUtils

# ╔═╡ 93a73a2c-1848-11eb-136d-071fe5df0b74
md"## `Tuple`"

# ╔═╡ 7148d638-1846-11eb-035c-818d51cf9b50
1, 2

# ╔═╡ 9548f644-1846-11eb-049a-7da476c0b713
typeof(1,2)

# ╔═╡ 9500b488-1846-11eb-12de-9d0a73851331
typeof((1,2))

# ╔═╡ 9fe763e2-1846-11eb-3fb7-5d3357eac680
function return_cs()
	return 1,2
end

# ╔═╡ b6c2d808-1846-11eb-03f4-2bab95ad2fd5
return_cs()

# ╔═╡ bd53720e-1846-11eb-077c-c5cb69542e58
typeof(return_cs())

# ╔═╡ a1cc8c26-1848-11eb-33c4-c1544ddcd5c1
(1)

# ╔═╡ a9af4af0-1848-11eb-329a-87beeda458e9
typeof((1))

# ╔═╡ a524d298-1848-11eb-2e00-891c9b29afb5
(1,)

# ╔═╡ af254728-1848-11eb-3a61-cb1a6aaceff8
typeof((1,))

# ╔═╡ 56eb4a58-184d-11eb-02fd-374fef184c12
md"## `Function`"

# ╔═╡ 56d31aa0-184d-11eb-3239-afeacb30348f
md"
Can a function return **diff return values** according to some condition?
"

# ╔═╡ 56b63b4e-184d-11eb-3685-c1c2654b2345
function test_func(i)
	if i == 0
		return 100
	end
	
	return (100-i, i)
end

# ╔═╡ c27976e6-184d-11eb-3301-7338792968e8
test_func(100)

# ╔═╡ c7134f10-184d-11eb-1ecb-ad0c2892e42b
test_func(1)

# ╔═╡ cc081dfc-184d-11eb-1b97-2570bcf2cdb3
test_func(0)

# ╔═╡ 568dcc5c-184d-11eb-1ff2-0106b7ef7f9d
(100)[1]

# ╔═╡ 55fd6f0e-184d-11eb-3c97-51c4a164e981
(100,)[1]

# ╔═╡ 402cb642-184f-11eb-3fe0-c11f79a97568
push!((1,2,3), 4)

# ╔═╡ 71517e7e-184f-11eb-0230-6b7905123364
append!((1,2,3), 4)

# ╔═╡ 64dd78d2-184f-11eb-33a0-35aff834145d
append!([1,2,3], 4)

# ╔═╡ Cell order:
# ╟─93a73a2c-1848-11eb-136d-071fe5df0b74
# ╠═7148d638-1846-11eb-035c-818d51cf9b50
# ╠═9548f644-1846-11eb-049a-7da476c0b713
# ╠═9500b488-1846-11eb-12de-9d0a73851331
# ╠═9fe763e2-1846-11eb-3fb7-5d3357eac680
# ╠═b6c2d808-1846-11eb-03f4-2bab95ad2fd5
# ╠═bd53720e-1846-11eb-077c-c5cb69542e58
# ╠═a1cc8c26-1848-11eb-33c4-c1544ddcd5c1
# ╠═a9af4af0-1848-11eb-329a-87beeda458e9
# ╠═a524d298-1848-11eb-2e00-891c9b29afb5
# ╠═af254728-1848-11eb-3a61-cb1a6aaceff8
# ╟─56eb4a58-184d-11eb-02fd-374fef184c12
# ╟─56d31aa0-184d-11eb-3239-afeacb30348f
# ╠═56b63b4e-184d-11eb-3685-c1c2654b2345
# ╠═c27976e6-184d-11eb-3301-7338792968e8
# ╠═c7134f10-184d-11eb-1ecb-ad0c2892e42b
# ╠═cc081dfc-184d-11eb-1b97-2570bcf2cdb3
# ╠═568dcc5c-184d-11eb-1ff2-0106b7ef7f9d
# ╠═55fd6f0e-184d-11eb-3c97-51c4a164e981
# ╠═402cb642-184f-11eb-3fe0-c11f79a97568
# ╠═71517e7e-184f-11eb-0230-6b7905123364
# ╠═64dd78d2-184f-11eb-33a0-35aff834145d
