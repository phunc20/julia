### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 3dcbe11e-00b6-11eb-0219-034615a667c6
v = [1,2,3,4] # vector

# ╔═╡ 537aee7c-00b6-11eb-1c4f-bd040cd0f6af
md"### Consistency

I've noticed that this kind of expression (i.e. **`vector`**) seems to require its elements being of the same type. What if we `[1,2,3,4.0]`?
"

# ╔═╡ 45295f34-00b6-11eb-1ae7-138a021cc838
v1 = [1,2,3,4.0]

# ╔═╡ 7b5e9614-00b6-11eb-36e1-81d222de59cf
size(v)

# ╔═╡ 8324163a-00b6-11eb-3227-513563f3acae
w = [1 2 3
	 4 5 6]

# ╔═╡ 830c016a-00b6-11eb-3ef0-db8cfefe6458
size(w)

# ╔═╡ 82f83aba-00b6-11eb-0fda-61c8360cd568
w[1, :]

# ╔═╡ 82de2c56-00b6-11eb-1a0a-e732a709cfeb
w[:, 1]

# ╔═╡ 82c1f392-00b6-11eb-377f-f1c5960bc051
A1 = rand(1:9, 3, 4)  # random int from 1 to 9 (inclusive) of size (3,4)

# ╔═╡ 23a57324-00b7-11eb-2fbd-ad42b56a086d
size(A1)

# ╔═╡ 238b281e-00b7-11eb-1a59-431d0a592ac9


# ╔═╡ 2375f108-00b7-11eb-1997-0f1c407fcb55


# ╔═╡ 235843f6-00b7-11eb-2346-175ecd3eb0f0


# ╔═╡ Cell order:
# ╠═3dcbe11e-00b6-11eb-0219-034615a667c6
# ╟─537aee7c-00b6-11eb-1c4f-bd040cd0f6af
# ╠═45295f34-00b6-11eb-1ae7-138a021cc838
# ╠═7b5e9614-00b6-11eb-36e1-81d222de59cf
# ╠═8324163a-00b6-11eb-3227-513563f3acae
# ╠═830c016a-00b6-11eb-3ef0-db8cfefe6458
# ╠═82f83aba-00b6-11eb-0fda-61c8360cd568
# ╠═82de2c56-00b6-11eb-1a0a-e732a709cfeb
# ╠═82c1f392-00b6-11eb-377f-f1c5960bc051
# ╠═23a57324-00b7-11eb-2fbd-ad42b56a086d
# ╠═238b281e-00b7-11eb-1a59-431d0a592ac9
# ╠═2375f108-00b7-11eb-1997-0f1c407fcb55
# ╠═235843f6-00b7-11eb-2346-175ecd3eb0f0
