
```jl
hint(text) = Markdown.MD(Markdown.Admonition("hint", "Hint", [text]))
# usage
hint(md"##### Structure")
```



```jl
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
# usage like
struct OneHot <: AbstractVector{Int}
	n::Int
	k::Int
end

myonehot = OneHot(6,2)

with_terminal() do
    dump(myonehot)
end
```




