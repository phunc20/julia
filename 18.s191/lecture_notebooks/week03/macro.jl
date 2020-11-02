### A Pluto.jl notebook ###
# v0.12.6

using Markdown
using InteractiveUtils

# ╔═╡ 63a377a2-1cb7-11eb-1473-bbbbdc14de6e
using Pkg

# ╔═╡ b035ce16-1cb8-11eb-114f-5f0da9077b41
begin
	pkg"add Colors ColorSchemes" #Images ImageMagick PlutoUI Suppressor InteractiveUtils"
	using Colors, ColorSchemes#, Images, ImageMagick
	using Suppressor#, InteractiveUtils, PlutoUI
	#using InteractiveUtils
end

# ╔═╡ 452aff30-1cb6-11eb-343c-7f2f415f3f80
md"## Macro
e.g. `@elapsed`"

# ╔═╡ ff59d45a-1cb4-11eb-050c-a7bbb2c77eb7
peakflops()

# ╔═╡ 17152b9e-1cb5-11eb-140c-e9c449daf989
@elapsed peakflops()

# ╔═╡ 9b720664-1cb5-11eb-3e07-37ab46210c78
@macroexpand @elapsed peakflops()

# ╔═╡ ba491be0-1cb5-11eb-28b1-e35e898aa020
md"
**(?1)**
`Base.remove_linenums!()` there is an exclamation mark; is it necessary? Let's try and find that out.
"

# ╔═╡ a3545440-1cb5-11eb-389e-4138e893cefb
Base.remove_linenums(@macroexpand @elapsed peakflops())

# ╔═╡ df4cd302-1cb5-11eb-3ce6-fda1cade6412
md"**(R1)** Yes, it's necessary."

# ╔═╡ a31d7f60-1cb5-11eb-26fa-a9dd157b96cc
Base.remove_linenums!(@macroexpand @elapsed peakflops())

# ╔═╡ a2ca28e0-1cb5-11eb-3306-577aa4029dc8
md"
**(?2)**
What's the `while` loop there for?
"

# ╔═╡ 35be7ae0-1cb6-11eb-1377-934378940e1f
md"#### `Expr` -- Julia Expression"

# ╔═╡ 2fdd51d2-1cb6-11eb-2744-e99abbf7f831
typeof(@macroexpand @elapsed peakflops())

# ╔═╡ 88d99cdc-1cb6-11eb-12f1-5bb2908bb4eb
x = 1+2

# ╔═╡ bfffc376-1cb6-11eb-286e-ffcc547e42fd
md"There exist at least two syntaxes to create an `Expr`"

# ╔═╡ 8e5b06ee-1cb6-11eb-2d00-71b1b002e312
expr = :(1+2)

# ╔═╡ 968b7440-1cb6-11eb-3b36-1b1500da02e6
typeof(expr)

# ╔═╡ 9b317bf2-1cb6-11eb-047a-0197b247d602
expr2 = quote
			1+2
		end

# ╔═╡ b6a9e3f6-1cb6-11eb-0c8e-3953491fd25a
typeof(expr2)

# ╔═╡ b689ca30-1cb6-11eb-0314-e510a32f7bfc
expr3 = :(y+1)

# ╔═╡ 16be9200-1cb7-11eb-3740-05fb57ab5a66
md"
```julia
UndefVarError: with_terminal not defined
---
with_terminal() do
	dump(expr3)
end
```
"

# ╔═╡ 2d27d67e-1cb9-11eb-14dc-cb25e02060ea
md"
##### Set out to find the minimum needed to run `with_terminal()`
"

# ╔═╡ 3b82bf88-1cb9-11eb-3c81-611711406d8d
md"
With the next cell, one can run `with_terminal()` but I think we don't need that much/bloated.

"

# ╔═╡ 8574c228-1cb7-11eb-072c-bd7e450e4481
# begin
# 	pkg"add Colors ColorSchemes Images ImageMagick PlutoUI Suppressor InteractiveUtils"
# 	using Colors, ColorSchemes, Images, ImageMagick
# 	using Suppressor, InteractiveUtils, PlutoUI
# end

# ╔═╡ 4d79575a-1cb7-11eb-3f67-175c1d7d1cdd
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

# ╔═╡ b63e0622-1cb6-11eb-0f60-0532682a84ce
with_terminal() do
	dump(expr3)
end

# ╔═╡ 61259648-1cb9-11eb-2a3a-fd4d03a6eabd
expr3.head

# ╔═╡ 6100ac3e-1cb9-11eb-3f89-cd3e17965532
expr3.args

# ╔═╡ 60e3dde8-1cb9-11eb-2aaa-1152104cefd7
md"
Can we somehow run the expression?
```julia
Base.run(command, args...; wait::Bool = true)
```
"

# ╔═╡ 608e984c-1cb9-11eb-00ea-cdb2461dec18
Base.run(expr3, y=3)

# ╔═╡ 4858a118-1cba-11eb-21d4-97ffc4624fa8
md"""
##### Evaluating Expressions
Well, in order to "_run_" an expression, which in Julia is called **evaluate** an expression, one uses **`eval()`**

More on evaluations and macros,
**cf.** [https://docs.julialang.org/en/v1/manual/metaprogramming/#Evaluating-expressions](https://docs.julialang.org/en/v1/manual/metaprogramming/#Evaluating-expressions)
"""

# ╔═╡ d09c195c-1cb9-11eb-160e-1f9b23545d3e
expr3

# ╔═╡ aaf100d6-1cba-11eb-05e5-13b135c06eb4
y = 10

# ╔═╡ b65cb37e-1cb6-11eb-3f8a-61cc1d4c96fc
y+1

# ╔═╡ aeedcf2a-1cba-11eb-2e8d-fd33b76c8b84
eval(expr3)

# ╔═╡ bc4ce110-1cba-11eb-35dc-19d9b0775521
expr3.args

# ╔═╡ c807bcd4-1cba-11eb-0837-a37840670356
expr3.args[1] = :-

# ╔═╡ c7d843e4-1cba-11eb-04b9-0d7e31f5432b
expr3

# ╔═╡ d2c4ad7e-1cba-11eb-2907-ed1ad403669b
eval(expr3)

# ╔═╡ Cell order:
# ╟─452aff30-1cb6-11eb-343c-7f2f415f3f80
# ╠═ff59d45a-1cb4-11eb-050c-a7bbb2c77eb7
# ╠═17152b9e-1cb5-11eb-140c-e9c449daf989
# ╠═9b720664-1cb5-11eb-3e07-37ab46210c78
# ╟─ba491be0-1cb5-11eb-28b1-e35e898aa020
# ╠═a3545440-1cb5-11eb-389e-4138e893cefb
# ╟─df4cd302-1cb5-11eb-3ce6-fda1cade6412
# ╠═a31d7f60-1cb5-11eb-26fa-a9dd157b96cc
# ╟─a2ca28e0-1cb5-11eb-3306-577aa4029dc8
# ╟─35be7ae0-1cb6-11eb-1377-934378940e1f
# ╠═2fdd51d2-1cb6-11eb-2744-e99abbf7f831
# ╠═88d99cdc-1cb6-11eb-12f1-5bb2908bb4eb
# ╟─bfffc376-1cb6-11eb-286e-ffcc547e42fd
# ╠═8e5b06ee-1cb6-11eb-2d00-71b1b002e312
# ╠═968b7440-1cb6-11eb-3b36-1b1500da02e6
# ╠═9b317bf2-1cb6-11eb-047a-0197b247d602
# ╠═b6a9e3f6-1cb6-11eb-0c8e-3953491fd25a
# ╠═b689ca30-1cb6-11eb-0314-e510a32f7bfc
# ╠═b65cb37e-1cb6-11eb-3f8a-61cc1d4c96fc
# ╟─16be9200-1cb7-11eb-3740-05fb57ab5a66
# ╟─2d27d67e-1cb9-11eb-14dc-cb25e02060ea
# ╠═63a377a2-1cb7-11eb-1473-bbbbdc14de6e
# ╟─3b82bf88-1cb9-11eb-3c81-611711406d8d
# ╠═8574c228-1cb7-11eb-072c-bd7e450e4481
# ╠═b035ce16-1cb8-11eb-114f-5f0da9077b41
# ╠═4d79575a-1cb7-11eb-3f67-175c1d7d1cdd
# ╠═b63e0622-1cb6-11eb-0f60-0532682a84ce
# ╠═61259648-1cb9-11eb-2a3a-fd4d03a6eabd
# ╠═6100ac3e-1cb9-11eb-3f89-cd3e17965532
# ╟─60e3dde8-1cb9-11eb-2aaa-1152104cefd7
# ╠═608e984c-1cb9-11eb-00ea-cdb2461dec18
# ╠═4858a118-1cba-11eb-21d4-97ffc4624fa8
# ╠═d09c195c-1cb9-11eb-160e-1f9b23545d3e
# ╠═aaf100d6-1cba-11eb-05e5-13b135c06eb4
# ╠═aeedcf2a-1cba-11eb-2e8d-fd33b76c8b84
# ╠═bc4ce110-1cba-11eb-35dc-19d9b0775521
# ╠═c807bcd4-1cba-11eb-0837-a37840670356
# ╠═c7d843e4-1cba-11eb-04b9-0d7e31f5432b
# ╠═d2c4ad7e-1cba-11eb-2907-ed1ad403669b
