### A Pluto.jl notebook ###
# v0.12.7

using Markdown
using InteractiveUtils

# ╔═╡ bf2c2eda-2cb5-11eb-316a-87856a15dbe9
using Pkg

# ╔═╡ fc2620e0-2cb5-11eb-105b-41a06695bdb7
begin
	#pkg"add Colors ColorSchemes Images ImageMagick PlutoUI Suppressor InteractiveUtils"
	pkg"add Colors ColorSchemes PlutoUI Suppressor InteractiveUtils"
	#using Colors, ColorSchemes, Images, ImageMagick
	using Colors, ColorSchemes
	using Suppressor, InteractiveUtils, PlutoUI
end

# ╔═╡ 2aa55d4a-2ca9-11eb-05ea-238f4606e36e
struct Rectangle
	width::Float64
	height::Float64
end

# ╔═╡ 9c1594e2-2ca9-11eb-1516-3dc39386fe4d
r = Rectangle(1, 2.5)

# ╔═╡ 9c002ee0-2ca9-11eb-035b-15f003ce9430
r.width

# ╔═╡ 9be4524c-2ca9-11eb-3aa4-c53dbdbdbeee
r.height

# ╔═╡ 9bc22032-2ca9-11eb-1bed-897ea27cc35a
typeof(r)

# ╔═╡ bac3f3e8-2ca9-11eb-1bcd-6904b60c3511
r2 = Rectangle(3, 4)

# ╔═╡ baafb45a-2ca9-11eb-375c-b966f74fc8dd
r.height, r2.width

# ╔═╡ ba990854-2ca9-11eb-0817-31f931ea0ee1
md"
### Mutable or Immutable
"

# ╔═╡ ba830f5e-2ca9-11eb-1f94-378e416fd130
r.width = -1

# ╔═╡ ba6dbf00-2ca9-11eb-2937-f3948ec46cfc
md"""
By default, `struct`'s are **immutable**. However, to make a mutable `struct`, it is as simple as **`mutable struct`** (cf. below)

"""

# ╔═╡ ba5c3f46-2ca9-11eb-1f7a-535118c596d1
mutable struct Character
	name::String
	email::String
end

# ╔═╡ ba31e7ca-2ca9-11eb-1624-4724950ca345
mario = Character("Mario", "mario@nitendo.com")

# ╔═╡ 8a139d2e-2caa-11eb-1ad0-4fd15879a5f6
mario.name = "Luigi"

# ╔═╡ 8fccc380-2caa-11eb-23f7-259639d71886
mario

# ╔═╡ 6923043c-2cab-11eb-1a2e-0fc90dbb047c
md"
### Functions whose `arg`'s type are specified

"

# ╔═╡ 6909292a-2cab-11eb-0d1b-0d9504306eca
width(r::Rectangle) = r.width

# ╔═╡ 68ef573e-2cab-11eb-2cc2-2b083cf29b4b
width(r)

# ╔═╡ a6528ee0-2cab-11eb-2cf2-39f63816b595
width(r2)

# ╔═╡ abb15f24-2cab-11eb-1582-913539f7d6f2
width(mario)

# ╔═╡ 68d2b9e6-2cab-11eb-2b3d-d390a3739509
width(30)

# ╔═╡ bd264c6c-2cab-11eb-3502-2f27560bd928
begin
	area(r::Rectangle) = r.width * r.height
	area(x) = x
end

# ╔═╡ cd373f2e-2cab-11eb-206d-f3c2168fa6e4
md"""
In Pluto, one is said to have to define all the methods of a function in a single cell
```julia
begin
  ...
end
```
Let's try and see if this is true.
"""

# ╔═╡ 4ff2eb8c-2cac-11eb-3655-b997c59c3fd0
area(s::String) = s[1]

# ╔═╡ cd988112-2cab-11eb-3b49-dd1ac00f5d0b
area(r)

# ╔═╡ d08d376e-2cab-11eb-2468-edf4a4db7b55
area(r2)

# ╔═╡ cd80d562-2cab-11eb-3917-5d95587c78d4
area(30)

# ╔═╡ d68bc590-2cab-11eb-1a5a-df8febdc69b8
area(mario)

# ╔═╡ cd64f7fa-2cab-11eb-3f8c-3522d5b698a4
area

# ╔═╡ 4fd98c7a-2cac-11eb-2089-8713bf1457b0
area("abcd")

# ╔═╡ 4f97b7aa-2cac-11eb-1e02-c3fd66899ac1
md"Ok... it is NOT true, as least since `Pluto.PLUTO_VERSION==v\"0.12.7\"`. Define **as many methods as you like, anytime, anywhere**."

# ╔═╡ f49ffe94-2cac-11eb-1b17-074378b1eba6
md"""
### Multiple Dispatch
----
The act of choosing which function/method to call based on the types of arguments passed into it is called **dispatch**. A central feature of Julia is **multiple dispatch**: this choice is made based on the types of _all_ the arguments to a function.
"""

# ╔═╡ f47d73fe-2cac-11eb-111f-430bfcd5f063
cc = 3 + 4im

# ╔═╡ f4528ac2-2cac-11eb-0dea-15495cd56e16
cc + cc

# ╔═╡ 9428e906-2cad-11eb-31d8-7552efb95fdd
@which cc + cc

# ╔═╡ 9871db8a-2cad-11eb-3d14-c1bee026f5d2
@which cc + 3

# ╔═╡ 940daace-2cad-11eb-22df-bd4087b97195
@which 3 + cc

# ╔═╡ 93f97edc-2cad-11eb-1153-9186644a9fc3
md"### Metaprogramming/Macros"

# ╔═╡ 93dc0bc2-2cad-11eb-210f-17bfa8269420
peakflops()  # run this on diff machines of yours to compare

# ╔═╡ 29d37684-2cb2-11eb-25f7-751523b72212
@elapsed peakflops()

# ╔═╡ 86cba10e-2cb2-11eb-30d4-79bf40504cc3
@macroexpand @elapsed peakflops()

# ╔═╡ 919b5386-2cb2-11eb-2921-0b664b58252b
@macroexpand peakflops()  # You can see that @macroexpand only expands macro

# ╔═╡ 5c9dfcc8-2cb3-11eb-020f-0fc77630eed4
Base.remove_linenums!(@macroexpand @elapsed peakflops())

# ╔═╡ 811ff812-2cb3-11eb-2cf0-4b26d7fc55b4
md"""
**(?)** What's the `while` loop doing there?

"""

# ╔═╡ 6af52184-2cb3-11eb-1a42-7545cbd020eb
Base.remove_linenums(@macroexpand @elapsed peakflops())  # w/o !(exclamation mark)

# ╔═╡ 0d6cf63a-2cb4-11eb-0e91-dfbc0051b658
md"""
You can look inside the file `timinig.jl` (To find it, go to the julia folder that you downloaded and extracted, and do a search `find . -type f -iname "timing.jl"`)

```julia
macro elapsed(ex)
    quote
        while false; end # compiler heuristic: compile this block (alter this if the heuristic changes)
        local t0 = time_ns()
        $(esc(ex))
        (time_ns() - t0) / 1e9
    end
end
```

"""

# ╔═╡ 3c0a9600-2cb4-11eb-39bd-5758d0dbcbb2
md"""
### `Expr`, i.e. Expressions
Two ways
01. `:()`
02. by using 
	```
	quote
	  ...
	end
	```



"""

# ╔═╡ c7899640-2cb4-11eb-1d39-d3805eeb1c06
x = 1 + 2

# ╔═╡ c76e6974-2cb4-11eb-0f84-7730b2237b0e
expr = :(1 + 2)

# ╔═╡ c755df62-2cb4-11eb-316b-e77d91b2bbaf
expr2 = quote
	1+2
end

# ╔═╡ c738c45e-2cb4-11eb-2caa-7fc5e12d9459
typeof(expr), typeof(expr2)

# ╔═╡ 71e98712-2cb5-11eb-375b-41387167922f
expr3 = :(yy + 1)

# ╔═╡ 71cbb98a-2cb5-11eb-0dcc-bdc46f84b00a
yy + 1

# ╔═╡ bf70f114-2cb5-11eb-1e23-2b129c860814
expr3.head

# ╔═╡ a23dcab6-2cb7-11eb-09ee-81e2c01f2867
expr3.args

# ╔═╡ a22b7028-2cb7-11eb-3255-e17f0008eccb
expr3.args[3]

# ╔═╡ a20972f2-2cb7-11eb-2b83-81a822c26e5f
expr3.args[3] = :xx

# ╔═╡ a1ee1796-2cb7-11eb-185a-93f8371dc9ec
expr3.args

# ╔═╡ a1ba78b4-2cb7-11eb-28ad-33d5fdb135de
expr3.args[3] = 100

# ╔═╡ 8798c426-2cb8-11eb-3ff0-ef93b23849e8
expr3.args

# ╔═╡ f6ab34c0-2cb8-11eb-1371-357035759f8c
md"""
For more on metaprogramming, cf. [https://docs.julialang.org/en/v1/manual/metaprogramming/](https://docs.julialang.org/en/v1/manual/metaprogramming/)
"""

# ╔═╡ bf55012a-2cb5-11eb-30ca-b3c5c19c1351
md"""
### Bookkeeping

"""

# ╔═╡ d84f67e2-2cb5-11eb-2c1f-6bdc66a1103a
Pkg.activate(mktempdir())

# ╔═╡ bf11bf46-2cb5-11eb-399d-cd5b8402d6eb
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

# ╔═╡ 71b56a86-2cb5-11eb-3e70-2b3002e14e04
with_terminal() do
	dump(expr3)
end

# ╔═╡ Cell order:
# ╠═2aa55d4a-2ca9-11eb-05ea-238f4606e36e
# ╠═9c1594e2-2ca9-11eb-1516-3dc39386fe4d
# ╠═9c002ee0-2ca9-11eb-035b-15f003ce9430
# ╠═9be4524c-2ca9-11eb-3aa4-c53dbdbdbeee
# ╠═9bc22032-2ca9-11eb-1bed-897ea27cc35a
# ╠═bac3f3e8-2ca9-11eb-1bcd-6904b60c3511
# ╠═baafb45a-2ca9-11eb-375c-b966f74fc8dd
# ╟─ba990854-2ca9-11eb-0817-31f931ea0ee1
# ╠═ba830f5e-2ca9-11eb-1f94-378e416fd130
# ╟─ba6dbf00-2ca9-11eb-2937-f3948ec46cfc
# ╠═ba5c3f46-2ca9-11eb-1f7a-535118c596d1
# ╠═ba31e7ca-2ca9-11eb-1624-4724950ca345
# ╠═8a139d2e-2caa-11eb-1ad0-4fd15879a5f6
# ╠═8fccc380-2caa-11eb-23f7-259639d71886
# ╟─6923043c-2cab-11eb-1a2e-0fc90dbb047c
# ╠═6909292a-2cab-11eb-0d1b-0d9504306eca
# ╠═68ef573e-2cab-11eb-2cc2-2b083cf29b4b
# ╠═a6528ee0-2cab-11eb-2cf2-39f63816b595
# ╠═abb15f24-2cab-11eb-1582-913539f7d6f2
# ╠═68d2b9e6-2cab-11eb-2b3d-d390a3739509
# ╠═bd264c6c-2cab-11eb-3502-2f27560bd928
# ╠═cd988112-2cab-11eb-3b49-dd1ac00f5d0b
# ╠═d08d376e-2cab-11eb-2468-edf4a4db7b55
# ╠═cd80d562-2cab-11eb-3917-5d95587c78d4
# ╠═d68bc590-2cab-11eb-1a5a-df8febdc69b8
# ╠═cd64f7fa-2cab-11eb-3f8c-3522d5b698a4
# ╟─cd373f2e-2cab-11eb-206d-f3c2168fa6e4
# ╠═4ff2eb8c-2cac-11eb-3655-b997c59c3fd0
# ╠═4fd98c7a-2cac-11eb-2089-8713bf1457b0
# ╟─4f97b7aa-2cac-11eb-1e02-c3fd66899ac1
# ╟─f49ffe94-2cac-11eb-1b17-074378b1eba6
# ╠═f47d73fe-2cac-11eb-111f-430bfcd5f063
# ╠═f4528ac2-2cac-11eb-0dea-15495cd56e16
# ╠═9428e906-2cad-11eb-31d8-7552efb95fdd
# ╠═9871db8a-2cad-11eb-3d14-c1bee026f5d2
# ╠═940daace-2cad-11eb-22df-bd4087b97195
# ╠═93f97edc-2cad-11eb-1153-9186644a9fc3
# ╠═93dc0bc2-2cad-11eb-210f-17bfa8269420
# ╠═29d37684-2cb2-11eb-25f7-751523b72212
# ╠═86cba10e-2cb2-11eb-30d4-79bf40504cc3
# ╠═919b5386-2cb2-11eb-2921-0b664b58252b
# ╠═5c9dfcc8-2cb3-11eb-020f-0fc77630eed4
# ╟─811ff812-2cb3-11eb-2cf0-4b26d7fc55b4
# ╠═6af52184-2cb3-11eb-1a42-7545cbd020eb
# ╟─0d6cf63a-2cb4-11eb-0e91-dfbc0051b658
# ╠═3c0a9600-2cb4-11eb-39bd-5758d0dbcbb2
# ╠═c7899640-2cb4-11eb-1d39-d3805eeb1c06
# ╠═c76e6974-2cb4-11eb-0f84-7730b2237b0e
# ╠═c755df62-2cb4-11eb-316b-e77d91b2bbaf
# ╠═c738c45e-2cb4-11eb-2caa-7fc5e12d9459
# ╠═71e98712-2cb5-11eb-375b-41387167922f
# ╠═71cbb98a-2cb5-11eb-0dcc-bdc46f84b00a
# ╠═71b56a86-2cb5-11eb-3e70-2b3002e14e04
# ╠═bf70f114-2cb5-11eb-1e23-2b129c860814
# ╠═a23dcab6-2cb7-11eb-09ee-81e2c01f2867
# ╠═a22b7028-2cb7-11eb-3255-e17f0008eccb
# ╠═a20972f2-2cb7-11eb-2b83-81a822c26e5f
# ╠═a1ee1796-2cb7-11eb-185a-93f8371dc9ec
# ╠═a1ba78b4-2cb7-11eb-28ad-33d5fdb135de
# ╠═8798c426-2cb8-11eb-3ff0-ef93b23849e8
# ╟─f6ab34c0-2cb8-11eb-1371-357035759f8c
# ╟─bf55012a-2cb5-11eb-30ca-b3c5c19c1351
# ╠═bf2c2eda-2cb5-11eb-316a-87856a15dbe9
# ╠═d84f67e2-2cb5-11eb-2c1f-6bdc66a1103a
# ╠═fc2620e0-2cb5-11eb-105b-41a06695bdb7
# ╟─bf11bf46-2cb5-11eb-399d-cd5b8402d6eb
