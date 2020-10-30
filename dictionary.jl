### A Pluto.jl notebook ###
# v0.12.4

using Markdown
using InteractiveUtils

# ╔═╡ 5b2c88be-1ac0-11eb-06fe-2b234e144180
D = Dict("name" => "Tom", "height" => 1.75)

# ╔═╡ f94006c0-1ac0-11eb-3f0e-bb65dfac1306
typeof(D)

# ╔═╡ 013581b6-1ac1-11eb-19d0-e90236bf334a
md"
**Note** that although when declared with type, dictionaries have to go like e.g. `Dict{String, Float64}`, it does not mean that the values all have to be of a certain type.

Just like the example above, the type of the value when in that situation simply grows to be **sth more general**, here `Any`.
"

# ╔═╡ a6b89f5c-1ac0-11eb-2c67-776805fd5d24
#D = Dict("a" => 1, "b" => -7.6543)

# ╔═╡ b8ddc9b4-1ac0-11eb-0923-5f09bd14aa1f
DD = Dict("a" => 1., "b" => -7.6543)

# ╔═╡ 69a4128a-1ac1-11eb-23e9-f3d3f83dcf75
md"
Try sth original
"

# ╔═╡ 7129290a-1ac1-11eb-1c6c-29c563e3df40
get!(DD, "c",
	if 10 > 1
		"big"
	else
		"small"
	end
)

# ╔═╡ 9eb2d362-1ac1-11eb-0dba-8d81dc6c713d
get!(D, "c",
	if 10 > 1
		"big"
	else
		"small"
	end
)

# ╔═╡ a3e1f444-1ac1-11eb-28b0-bb83222b1436
D

# ╔═╡ aeeac58c-1ac1-11eb-1d09-859aad4978e2
typeof('c'), typeof("c")

# ╔═╡ d326d8e8-1ac4-11eb-2cab-bd528d93b7c2
DDD = Dict{String, Any}("name" => "Denjiro", "height" => 185)

# ╔═╡ dafe7e22-1ac4-11eb-1332-afbdd199b245
get!(DDD, "weight_comment",
	measured = 100
	if measured < 30
		"skinny"
	elseif measured < 70
		"fit"
	else
		"béo phì"
	end
)

# ╔═╡ d8a96f26-1ac4-11eb-2523-170585b2121a
begin
	measured = 100
	get!(DDD, "weight_comment",
		if measured < 30
			"skinny"
		elseif measured < 70
			"fit"
		else
			"béo phì"
		end
	)
end

# ╔═╡ ed4c0f54-1ac4-11eb-3ecb-e919fa1861b3
DDD

# ╔═╡ Cell order:
# ╠═5b2c88be-1ac0-11eb-06fe-2b234e144180
# ╠═f94006c0-1ac0-11eb-3f0e-bb65dfac1306
# ╠═013581b6-1ac1-11eb-19d0-e90236bf334a
# ╠═a6b89f5c-1ac0-11eb-2c67-776805fd5d24
# ╠═b8ddc9b4-1ac0-11eb-0923-5f09bd14aa1f
# ╟─69a4128a-1ac1-11eb-23e9-f3d3f83dcf75
# ╠═7129290a-1ac1-11eb-1c6c-29c563e3df40
# ╠═9eb2d362-1ac1-11eb-0dba-8d81dc6c713d
# ╠═a3e1f444-1ac1-11eb-28b0-bb83222b1436
# ╠═aeeac58c-1ac1-11eb-1d09-859aad4978e2
# ╠═d326d8e8-1ac4-11eb-2cab-bd528d93b7c2
# ╠═dafe7e22-1ac4-11eb-1332-afbdd199b245
# ╠═d8a96f26-1ac4-11eb-2523-170585b2121a
# ╠═ed4c0f54-1ac4-11eb-3ecb-e919fa1861b3
