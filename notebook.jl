### A Pluto.jl notebook ###
# v0.12.4

using Markdown
using InteractiveUtils

# ╔═╡ bf195534-1831-11eb-0f70-59f03f03a612
md" ## `Vector`
- [https://stackoverflow.com/questions/28524105/julia-append-to-an-empty-vector](https://stackoverflow.com/questions/28524105/julia-append-to-an-empty-vector)


"

# ╔═╡ a2d69074-182c-11eb-360b-e765526d77bf
begin
  x = Vector{Float64}
  typeof(x)
end

# ╔═╡ 6042218c-182d-11eb-2e6a-4d2e474c51d5
x

# ╔═╡ 65f761f4-1830-11eb-01b8-1f7a7c3d1f22
typeof(x)

# ╔═╡ 6ee6a57a-1830-11eb-333a-9f58a038f01f
size(x)

# ╔═╡ 69c53620-182d-11eb-063c-f1ae913aba69
x[0]

# ╔═╡ 281ce226-1830-11eb-1b93-bfb67290013d
md"
`Vector{T}` is an **alias for `Array{T,1}`**.
"

# ╔═╡ 78632766-182d-11eb-3463-33546f3118ce
y = Vector{Float64}(undef, 10)

# ╔═╡ 41740838-1830-11eb-01d8-f7236fff13ec
size(y)

# ╔═╡ 55ab588a-1830-11eb-2138-a5465f09307d
typeof(y)

# ╔═╡ 78389a28-182d-11eb-254d-3574229fe603
z = Vector{Float64}(nothing, 10)

# ╔═╡ 77effe58-182d-11eb-21b2-b9fe89e3b13e
zz = Vector{Union{Nothing, Float64}}(nothing, 10)

# ╔═╡ 77aa3c42-182d-11eb-3de6-6592d38aa43d
L = [1,2,3]

# ╔═╡ 8633e54e-1830-11eb-3a56-13db49f2a7a3
typeof(L)

# ╔═╡ 899d1926-1830-11eb-1296-71d7f766abb7
Array(Float64, 4)

# ╔═╡ d55300b0-1830-11eb-2965-9d3575656c30
Array{Float64, 4}

# ╔═╡ c81ac85e-1830-11eb-2914-df89cddc4fc7
zeros(Float32, 3)

# ╔═╡ f33231e6-1830-11eb-0b66-cf9a87588f5a
zeros(0)

# ╔═╡ fbc397bc-1830-11eb-0b67-21dc50862773
[32.3] isa Array{Float32, 1}

# ╔═╡ 19fe7424-1831-11eb-197b-ad0cf4557a6d
typeof([32.3])

# ╔═╡ 2caf40b4-1831-11eb-0277-db67f216de27
[32.3] isa Array{Float64, 1}

# ╔═╡ 2f7ff7f0-1831-11eb-1f9d-532c8e898d9e


# ╔═╡ 391fdf32-1831-11eb-2228-bb31b33afaf7
md"### How to append to an array like one does in Python (appending to a `list`)?
**`append!()`**

"

# ╔═╡ 2c991062-1831-11eb-00c8-256c953580a3
x

# ╔═╡ 2c81446e-1831-11eb-2348-579c9c6942d9
zeros(0)

# ╔═╡ 2c6b3e92-1831-11eb-2344-99a6b6df48b5
append!(zeros(0), rand(5))

# ╔═╡ 2c52b830-1831-11eb-2b0a-9b5acef534fc
append!(zeros(0), 5)

# ╔═╡ 87ebb528-1831-11eb-1fa4-b1176c7f2d4f
append!(zeros(0), 5, 6, 7)

# ╔═╡ a3dce778-1833-11eb-2513-3f7f8d5c9c10
md"#### Copy or view?"

# ╔═╡ a3b811dc-1833-11eb-0736-b9a946533aed
aaa = zeros(3)

# ╔═╡ a395b402-1833-11eb-382e-c5b7d4acfe86
bbb = append!(aaa, ones(5))

# ╔═╡ a370e91a-1833-11eb-3ae8-5f3db2c5f5e0
aaa

# ╔═╡ a326706a-1833-11eb-2d6d-ab3fb5a7076e
bbb == aaa, bbb === aaa, isequal(bbb, aaa)

# ╔═╡ e730b63c-1831-11eb-1a6b-6596a1390e72
begin
  xx = Vector{Float64}()
  typeof(xx)
end

# ╔═╡ f100186a-1831-11eb-16a0-81e3f4908e8d
xx

# ╔═╡ f881c232-1831-11eb-1655-5758c21e4d97
Vector{Float64}([3;1;4])

# ╔═╡ 30a29aa0-1833-11eb-3e7e-076e43a6cbc7
Vector{Float64}([3,1,4])

# ╔═╡ 35993f78-1833-11eb-084e-dd1c1a7759da
Vector{Float64}([3 1 4])

# ╔═╡ 45f778d0-1833-11eb-138a-c1f6cb958a44
[3;1;4]

# ╔═╡ 45da8810-1833-11eb-3509-0d57ba105983
[3,1,4]

# ╔═╡ 3582cc2a-1833-11eb-344f-89ae3ab3dd4f
[3, 1;4, 5]

# ╔═╡ 3568aaac-1833-11eb-0d7d-db05fb3339b3
[3 1
4 5]

# ╔═╡ 5f3e1894-1833-11eb-29af-4d3eb8185cda
[3, 1
4, 5]

# ╔═╡ 30844a6e-1833-11eb-106f-a30d5101a4a0
[3, 1,
4, 5]

# ╔═╡ 71e4dd70-1833-11eb-2bcc-87430bf3e087
[3, 1;
4, 5]

# ╔═╡ Cell order:
# ╠═bf195534-1831-11eb-0f70-59f03f03a612
# ╠═a2d69074-182c-11eb-360b-e765526d77bf
# ╠═6042218c-182d-11eb-2e6a-4d2e474c51d5
# ╠═65f761f4-1830-11eb-01b8-1f7a7c3d1f22
# ╠═6ee6a57a-1830-11eb-333a-9f58a038f01f
# ╠═69c53620-182d-11eb-063c-f1ae913aba69
# ╟─281ce226-1830-11eb-1b93-bfb67290013d
# ╠═78632766-182d-11eb-3463-33546f3118ce
# ╠═41740838-1830-11eb-01d8-f7236fff13ec
# ╠═55ab588a-1830-11eb-2138-a5465f09307d
# ╠═78389a28-182d-11eb-254d-3574229fe603
# ╠═77effe58-182d-11eb-21b2-b9fe89e3b13e
# ╠═77aa3c42-182d-11eb-3de6-6592d38aa43d
# ╠═8633e54e-1830-11eb-3a56-13db49f2a7a3
# ╠═899d1926-1830-11eb-1296-71d7f766abb7
# ╠═d55300b0-1830-11eb-2965-9d3575656c30
# ╠═c81ac85e-1830-11eb-2914-df89cddc4fc7
# ╠═f33231e6-1830-11eb-0b66-cf9a87588f5a
# ╠═fbc397bc-1830-11eb-0b67-21dc50862773
# ╠═19fe7424-1831-11eb-197b-ad0cf4557a6d
# ╠═2caf40b4-1831-11eb-0277-db67f216de27
# ╠═2f7ff7f0-1831-11eb-1f9d-532c8e898d9e
# ╟─391fdf32-1831-11eb-2228-bb31b33afaf7
# ╠═2c991062-1831-11eb-00c8-256c953580a3
# ╠═2c81446e-1831-11eb-2348-579c9c6942d9
# ╠═2c6b3e92-1831-11eb-2344-99a6b6df48b5
# ╠═2c52b830-1831-11eb-2b0a-9b5acef534fc
# ╠═87ebb528-1831-11eb-1fa4-b1176c7f2d4f
# ╠═a3dce778-1833-11eb-2513-3f7f8d5c9c10
# ╠═a3b811dc-1833-11eb-0736-b9a946533aed
# ╠═a395b402-1833-11eb-382e-c5b7d4acfe86
# ╠═a370e91a-1833-11eb-3ae8-5f3db2c5f5e0
# ╠═a326706a-1833-11eb-2d6d-ab3fb5a7076e
# ╠═e730b63c-1831-11eb-1a6b-6596a1390e72
# ╠═f100186a-1831-11eb-16a0-81e3f4908e8d
# ╠═f881c232-1831-11eb-1655-5758c21e4d97
# ╠═30a29aa0-1833-11eb-3e7e-076e43a6cbc7
# ╠═35993f78-1833-11eb-084e-dd1c1a7759da
# ╠═45f778d0-1833-11eb-138a-c1f6cb958a44
# ╠═45da8810-1833-11eb-3509-0d57ba105983
# ╠═3582cc2a-1833-11eb-344f-89ae3ab3dd4f
# ╠═3568aaac-1833-11eb-0d7d-db05fb3339b3
# ╠═5f3e1894-1833-11eb-29af-4d3eb8185cda
# ╠═30844a6e-1833-11eb-106f-a30d5101a4a0
# ╠═71e4dd70-1833-11eb-2bcc-87430bf3e087
