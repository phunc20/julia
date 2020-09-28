### A Pluto.jl notebook ###
# v0.11.14

using Markdown
using InteractiveUtils

# ╔═╡ 4feac14c-0147-11eb-0b63-fb0abb633e6f
#v = ones(Int, 3, 2)

# ╔═╡ b8a03500-0147-11eb-2e06-b12249facf81
#v = ones(Int, 10)

# ╔═╡ b8056fc0-0147-11eb-1f76-d917c37e9037
v = 1:10

# ╔═╡ dc251748-0147-11eb-1bf4-b50dbd83eda7
v[-1]

# ╔═╡ e485b500-0147-11eb-03b4-c18bfd240492
v[end]

# ╔═╡ e8bec0d0-0147-11eb-37f3-df3441a5b4b3
v[end-2]

# ╔═╡ e898a2e4-0147-11eb-3e98-598ccb31c557
v[end-2:end]

# ╔═╡ e7fbdc50-0147-11eb-33b1-e7bbcaef2457
v[end: end-2]

# ╔═╡ 1825c68e-0152-11eb-396b-3ba91a54eebe
md"### Broadcast"

# ╔═╡ 180cea9c-0152-11eb-0bbe-73a7c02e623d
v[3:5] = 4

# ╔═╡ 17f2f542-0152-11eb-2c6f-b9148a564826
v[3:5] .= 4

# ╔═╡ 17cf2234-0152-11eb-2e34-7517c128105d
v1 = ones(Int, 10)

# ╔═╡ 6b1c8ab2-0152-11eb-0bc7-dddf4c6e5145
typeof(v), typeof(v1)

# ╔═╡ 5ac74b8e-0152-11eb-154b-5170fe82fabe
v1[3:5] .= 4

# ╔═╡ 5aa87632-0152-11eb-3ffd-695ce02f9c88
v1

# ╔═╡ 851092ce-0152-11eb-3046-093147f2f930
v1[3:5] .= [-1,-1,-1]

# ╔═╡ 84f33c10-0152-11eb-1e5c-2b311a38faaa
v1

# ╔═╡ 84d79ad2-0152-11eb-0e3f-9fa996c977a4
md"
### view or copy?

"

# ╔═╡ b78cefb8-0152-11eb-291e-d3e28f3f1c20
w = v1[3:5]

# ╔═╡ b76eedb0-0152-11eb-22f9-dd879ae1a11e
w .= pi

# ╔═╡ b7555594-0152-11eb-1d0e-1fb2feda6e43
pi

# ╔═╡ 0061bab6-0153-11eb-12f2-ebc7a8c76a7a
\pi

# ╔═╡ 00440ebc-0153-11eb-1ec8-e3389df4466a
w .= 8

# ╔═╡ 0002c74c-0153-11eb-3677-c53ea832ee37
v1

# ╔═╡ 3d1a982e-0153-11eb-0688-c10ffa312c60
md"
So, in Julia, things like `w = v[3:5]` return a **copy**.
"

# ╔═╡ fe175492-0147-11eb-28e8-9547a5afeaa7
md"
### What about in Python?
```python
In [1]: import numpy as np

In [2]: v = np.arange(10)

In [3]: w = v[:3]

In [4]: w
Out[4]: array([0, 1, 2])

In [5]: w[0] = np.e

In [6]: w
Out[6]: array([2, 1, 2])

In [7]: np.e
Out[7]: 2.718281828459045

In [8]: v
Out[8]: array([2, 1, 2, 3, 4, 5, 6, 7, 8, 9])

In [9]: v.view
Out[9]: <function ndarray.view>

In [10]: v.view()
Out[10]: array([2, 1, 2, 3, 4, 5, 6, 7, 8, 9])

In [11]: ?v.view
```
In Python, `w = v[3:5]` returns **the ndarray itself**; modifying `w` will modify `v` as well.
"

# ╔═╡ 8aecaede-0153-11eb-1013-051a4497dd57
md"### `view`"

# ╔═╡ fdfb61d8-0147-11eb-02e0-41790feb3655
z = view(v1, 3:5)

# ╔═╡ ede6be92-0153-11eb-2581-1155ab581993
z .= 9

# ╔═╡ f2ded26a-0153-11eb-1514-5743456572b7
v1

# ╔═╡ fde34864-0147-11eb-2283-e18ea46fba4d
z .= ones(Int, 3) * 100

# ╔═╡ fdc9e676-0147-11eb-06be-79354ad4ef1d
v1

# ╔═╡ 04bba3b4-0154-11eb-3593-9561224a3c20
md"```
z = [30 29 28]

z
Multiple definitions for z:

Combine all definitions into a single reactive cell using a `begin ... end` block.
```
"

# ╔═╡ 04a213ae-0154-11eb-058b-1d27e2ccf9fa
typeof(z), typeof(v1)

# ╔═╡ 44a00286-0154-11eb-1845-4373243eda55
md"### Shorthand: **macro** `@view`"

# ╔═╡ 048cd516-0154-11eb-3879-b7770087a8da
z2 = @view v1[3:5]

# ╔═╡ 0474248a-0154-11eb-3163-01e547db0f15
z2 .= 314159

# ╔═╡ 0451531a-0154-11eb-0ed7-3767e7284bf9
z

# ╔═╡ 6f767d8e-0154-11eb-32ed-0d752ddd97c6
v1

# ╔═╡ 724c97a8-0154-11eb-3ea8-93e1875a6ade
typeof(z2)

# ╔═╡ 72321a04-0154-11eb-2946-c399bad6636b
md"### Matrices"

# ╔═╡ 721e8fac-0154-11eb-2767-a570ad474e18
M = [10i+j for i in 0:5, j in 1:4]

# ╔═╡ 720771fa-0154-11eb-26ee-f909c9e6020b
A = M[3:5, 3:4]

# ╔═╡ d45ad12e-0154-11eb-2016-c34bf664ff1f
md"Show that `A` is a **copy**."

# ╔═╡ 71ecfa78-0154-11eb-291c-d710c489c1cf
A[1,1] = -100

# ╔═╡ caf390aa-0154-11eb-3ef2-b760b008fb14
A

# ╔═╡ cd923730-0154-11eb-3e02-33b79ee903be
M

# ╔═╡ e1db7e9a-0154-11eb-0a41-7f2837f418ce
view(M, 3:5, 3:4)

# ╔═╡ e1bf4dec-0154-11eb-051a-b55a685d7170
@view M[3:5, 3:4]

# ╔═╡ ff398f4c-0154-11eb-3ac4-63c6ec0bfb05
begin
	M_duppel = @view M[3:5, 3:4]
	M_duppel[1,1] = -100
end

# ╔═╡ 15769e9c-0155-11eb-1ba0-759435d17c81
M

# ╔═╡ 23fecdee-0156-11eb-255b-01d42a613fb6
md"
```python
In [21]: M
Out[21]:
array([[ 0,  1,  2,  3],
       [ 4,  5,  6,  7],
       [ 8,  9, 10, 11]])

In [22]: M3 = M[1:, 1:]

In [23]: M3
Out[23]:
array([[ 5,  6,  7],
       [ 9, 10, 11]])

In [24]: M3[0,0] = -999

In [25]: M
Out[25]:
array([[   0,    1,    2,    3],
       [   4, -999,    6,    7],
       [   8,    9,   10,   11]])


```
"

# ╔═╡ 374d0bc8-0155-11eb-2aed-eb3cd8375efc
md"### `reshape(M, 3, 8)`"

# ╔═╡ 456e13d2-0155-11eb-3d34-8726e7fe3843
M2 = reshape(M, 3, 8)

# ╔═╡ 45578fe0-0155-11eb-3cd2-f38ed0c93472
M

# ╔═╡ 514a29ac-0155-11eb-198f-9f058848a7bc
md"So `reshape()` returns a **copy**."

# ╔═╡ 45404c5e-0155-11eb-12ae-7db74de07d8f
md"### `vec(M)`"

# ╔═╡ 45253a68-0155-11eb-38e6-2b1192eb9f85
vec(M)

# ╔═╡ 7825a4b4-0155-11eb-0736-75b8dde5d64c
a = vec(M)

# ╔═╡ 7cb46940-0155-11eb-2b2f-0da764f1a40e
M

# ╔═╡ 893f8e8a-0155-11eb-0d24-8d58745004e1
b = @vec M

# ╔═╡ 89265668-0155-11eb-0b12-379e13ea632c
md"
```python
In [14]: M = np.arange(3*4).reshape((3,4))

In [15]: M
Out[15]:
array([[ 0,  1,  2,  3],
       [ 4,  5,  6,  7],
       [ 8,  9, 10, 11]])

In [16]: M2 = M.reshape((2,6))

In [17]: M2
Out[17]:
array([[ 0,  1,  2,  3,  4,  5],
       [ 6,  7,  8,  9, 10, 11]])

In [18]: M
Out[18]:
array([[ 0,  1,  2,  3],
       [ 4,  5,  6,  7],
       [ 8,  9, 10, 11]])


```
"

# ╔═╡ 88ed8a0c-0155-11eb-0980-d3a09251cfa1
M

# ╔═╡ 940932d0-0158-11eb-1daf-4feff31ec9a1
M[:2,:2]

# ╔═╡ a0f1caa2-0158-11eb-033f-1b376595e81b
M[:3,:3]

# ╔═╡ abc8ca2a-0158-11eb-2359-198f30e8000a
M[1:3,1:3] .= -500

# ╔═╡ a90f7234-0158-11eb-193e-d1c1b7f6e522
M

# ╔═╡ be385874-0158-11eb-1510-63c80ff6cf23
M4 = M[1:3, 1:3]

# ╔═╡ c50c4e30-0158-11eb-16da-3feda2e1c425
M4 .= 1

# ╔═╡ c8c2da9e-0158-11eb-30be-fb97e9a3abf5
M

# ╔═╡ d30c3536-0158-11eb-0119-b911b1822c4b
md"
### So the greatest diff btw Julia and Python in slicing
is that when slicing of an array is assigned to another variable
- Python treats the variable as the array itself
- Julia treats the variable as a new **copy**

"

# ╔═╡ Cell order:
# ╠═4feac14c-0147-11eb-0b63-fb0abb633e6f
# ╠═b8a03500-0147-11eb-2e06-b12249facf81
# ╠═b8056fc0-0147-11eb-1f76-d917c37e9037
# ╠═dc251748-0147-11eb-1bf4-b50dbd83eda7
# ╠═e485b500-0147-11eb-03b4-c18bfd240492
# ╠═e8bec0d0-0147-11eb-37f3-df3441a5b4b3
# ╠═e898a2e4-0147-11eb-3e98-598ccb31c557
# ╠═e7fbdc50-0147-11eb-33b1-e7bbcaef2457
# ╟─1825c68e-0152-11eb-396b-3ba91a54eebe
# ╠═180cea9c-0152-11eb-0bbe-73a7c02e623d
# ╠═17f2f542-0152-11eb-2c6f-b9148a564826
# ╠═17cf2234-0152-11eb-2e34-7517c128105d
# ╠═6b1c8ab2-0152-11eb-0bc7-dddf4c6e5145
# ╠═5ac74b8e-0152-11eb-154b-5170fe82fabe
# ╠═5aa87632-0152-11eb-3ffd-695ce02f9c88
# ╠═851092ce-0152-11eb-3046-093147f2f930
# ╠═84f33c10-0152-11eb-1e5c-2b311a38faaa
# ╟─84d79ad2-0152-11eb-0e3f-9fa996c977a4
# ╠═b78cefb8-0152-11eb-291e-d3e28f3f1c20
# ╠═b76eedb0-0152-11eb-22f9-dd879ae1a11e
# ╠═b7555594-0152-11eb-1d0e-1fb2feda6e43
# ╠═0061bab6-0153-11eb-12f2-ebc7a8c76a7a
# ╠═00440ebc-0153-11eb-1ec8-e3389df4466a
# ╠═0002c74c-0153-11eb-3677-c53ea832ee37
# ╟─3d1a982e-0153-11eb-0688-c10ffa312c60
# ╟─fe175492-0147-11eb-28e8-9547a5afeaa7
# ╟─8aecaede-0153-11eb-1013-051a4497dd57
# ╠═fdfb61d8-0147-11eb-02e0-41790feb3655
# ╠═ede6be92-0153-11eb-2581-1155ab581993
# ╠═f2ded26a-0153-11eb-1514-5743456572b7
# ╠═fde34864-0147-11eb-2283-e18ea46fba4d
# ╠═fdc9e676-0147-11eb-06be-79354ad4ef1d
# ╟─04bba3b4-0154-11eb-3593-9561224a3c20
# ╠═04a213ae-0154-11eb-058b-1d27e2ccf9fa
# ╟─44a00286-0154-11eb-1845-4373243eda55
# ╠═048cd516-0154-11eb-3879-b7770087a8da
# ╠═0474248a-0154-11eb-3163-01e547db0f15
# ╠═0451531a-0154-11eb-0ed7-3767e7284bf9
# ╠═6f767d8e-0154-11eb-32ed-0d752ddd97c6
# ╠═724c97a8-0154-11eb-3ea8-93e1875a6ade
# ╟─72321a04-0154-11eb-2946-c399bad6636b
# ╠═721e8fac-0154-11eb-2767-a570ad474e18
# ╠═720771fa-0154-11eb-26ee-f909c9e6020b
# ╟─d45ad12e-0154-11eb-2016-c34bf664ff1f
# ╠═71ecfa78-0154-11eb-291c-d710c489c1cf
# ╠═caf390aa-0154-11eb-3ef2-b760b008fb14
# ╠═cd923730-0154-11eb-3e02-33b79ee903be
# ╠═e1db7e9a-0154-11eb-0a41-7f2837f418ce
# ╠═e1bf4dec-0154-11eb-051a-b55a685d7170
# ╠═ff398f4c-0154-11eb-3ac4-63c6ec0bfb05
# ╠═15769e9c-0155-11eb-1ba0-759435d17c81
# ╟─23fecdee-0156-11eb-255b-01d42a613fb6
# ╟─374d0bc8-0155-11eb-2aed-eb3cd8375efc
# ╠═456e13d2-0155-11eb-3d34-8726e7fe3843
# ╠═45578fe0-0155-11eb-3cd2-f38ed0c93472
# ╟─514a29ac-0155-11eb-198f-9f058848a7bc
# ╟─45404c5e-0155-11eb-12ae-7db74de07d8f
# ╠═45253a68-0155-11eb-38e6-2b1192eb9f85
# ╠═7825a4b4-0155-11eb-0736-75b8dde5d64c
# ╠═7cb46940-0155-11eb-2b2f-0da764f1a40e
# ╠═893f8e8a-0155-11eb-0d24-8d58745004e1
# ╟─89265668-0155-11eb-0b12-379e13ea632c
# ╠═88ed8a0c-0155-11eb-0980-d3a09251cfa1
# ╠═940932d0-0158-11eb-1daf-4feff31ec9a1
# ╠═a0f1caa2-0158-11eb-033f-1b376595e81b
# ╠═abc8ca2a-0158-11eb-2359-198f30e8000a
# ╠═a90f7234-0158-11eb-193e-d1c1b7f6e522
# ╠═be385874-0158-11eb-1510-63c80ff6cf23
# ╠═c50c4e30-0158-11eb-16da-3feda2e1c425
# ╠═c8c2da9e-0158-11eb-30be-fb97e9a3abf5
# ╟─d30c3536-0158-11eb-0119-b911b1822c4b
