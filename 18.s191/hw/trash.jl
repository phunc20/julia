function mean(x)
    s = 0
    for i in 1:length(x)
        s += x[i]
    return s / length(x)
end


function demean(x)
	return x .- mean(x)
end


function create_bar()
    n = 100
    tmp_vec = zeros(n)
    k = 20
    ind_start = n \div	2 - k \div	2
    tmp_vec[ind_start: ind_start+k-1]
end


function vecvec_to_matrix(vecvec)
end

begin
    a = [1, 2]
    b = [3, 4]
    Array([a, b])
end

md"
I kind of **grasp the logic**:

Vectors like `Int64[1, 2]` are **thought of as column vectors** in Julia, and if we have two such vectors `a` and `b`, then
`hcat(a, b)` will put those vectors side by side, i.e. **horizontally**, thus generating a **`2 by 2` matrix**, **whereas** `vcat` will concatenate them
**vertically**, the result of which is a **`4 by 1` matrix**, or equiv., still **a vector (of length `4` now)**.


$f: t \to t^2$ is an increasing function on $\mathbf{R}$

	Whichever of `x/a` and `a` is smaller, we see that $\frac{x}{a} \times a = x = \sqrt{x} ^2$ lies btw $(\frac{x}{a})^2$ and $a^2$, whence

$$\sqrt{x} \text{lies btw} a \text{and} \frac{x}{a}$$



"

function matrix_to_vecvec(matrix)
    n_rows, n_cols = size(matrix)
    return [matrix[:,i] for i in 1:n_cols]
end

function newton_sqrt(x, error_margin=0.01, a=x / 2) # a=x/2 is the default value of `a`
	while abs(x/a - a) > error_margin
		a = (x/a + a) / 2
	end
	return a
end

function newton_sqrt(x, error_margin=0.01, a=x / 2) # a=x/2 is the default value of `a`
	if abs(x/a - a) < error_margin
		a
	else
		newton_sqrt(x, error_margin=error_margin, a=(x/a + a) / 2)
	end
end



# recursive
function area_sierpinski(n)
	if n == 0
		1
	else
		(3/4) area_sierpinski(n-1)
	end
end


function mean_colors(image)
	return (mean(rouge.(image)), mean(green.(image)), mean(blue.(image)))
end



begin
	function quantize(x::Number)
		return floor(x; digits=1)
	end
	
	function quantize(color::AbstractRGB)
		#return RGB{Float32}((quantize.(color.r), quantize.(color.g), quantize.(color.b)))
		return RGB(quantize.(color.r), quantize.(color.g), quantize.(color.b))
		return RGB{Float32}(quantize.(color.r), quantize.(color.g), quantize.(color.b))
	end
	
	function quantize(image::AbstractMatrix)		
		return quantize.(image)
	end
end


md"#### Why not `Slider(0:0.01:**1**, show_value=true)`"


begin
	function myclamp(x::Number, low=0, high=1)
		return max(low, min(high, x))
	end

	function noisify(x::Number, s)
		noise = (rand() - 0.5)*(2s)
		return myclamp(x + noise)
	end

	function noisify(color::AbstractRGB, s)
		# you will write me in a later exercise!
		#return noisify.(color, s)
		return RGB(noisify.(color.r, s), noisify.(color.g, s), noisify.(color.b, s))
	end

	function noisify(image::AbstractMatrix, s)
		# you will write me in a later exercise!
		return noisify.(image, s)
	end
end



begin
	colored_line(x::Vector{<:Real}) = Gray.(Float64.((hcat(x)')))
	colored_line(x::Any) = nothing
end


function extend(v, i)
	if i < 1
		return v[1]
	elseif i > length(v)
		return v[end]
	else
		return v[i]
end


function blur_1D(v, l)
	#v_blur = zeros(T=, length(v))
	v_blur = zeros(length(v))
	for i in 1:length(v)
		new_px_value = 0
		for j in -l:l
			new_px_value += extend(v, i+j)
		new_px_value /= 2l
		v_blur[i] = new_px_value
	return v_blur
end

@bind philip_noise Slider(0:0.01:8, show_value=true)
@bind l_box Slider(0:20, show_value=true)


function blur_1D(v, l)
	#v_blur = zeros(T=, length(v))
	#v_blur = zeros(length(v))
	v_blur = copy(v)
	if l != 0
		for i in 1:length(v)
			new_px_value = 0
			for j in -l:l
				new_px_value += extend(v, i+j)
			new_px_value /= 2l
			v_blur[i] = new_px_value
			end
		end
	end
	return v_blur
end




function convolve_vector(v, k)
	l = (length(k) - 1) ÷ 2
	vprime = zeros(length(v))
	for i in 1:length(v)
		vprime[i] = [extend(v,i+j) for j in l:-1:-l] ⋅ k
	end
	return vprime
end


function gaussian(x, σ=1)
	1/√(2πσ^2) * ℯ^(-x^2/(2σ^2))
end

function gaussian_kernel(n)
	k = [gaussian(x) for x in -n:n]
	return k ./ sum(k)
end



function extend_mat(M::AbstractMatrix, i, j)
	n_rows, n_cols = size(M)
	ii = min(max(1, i), n_rows)
	jj = min(max(1, j), n_rows)
	return M[ii, jj]
end


function convolve_image(M::AbstractMatrix, K::AbstractMatrix)
	half_h_K, half_w_K = size(K) .÷ 2
	return [ sum([extend_mat(M,i-k,j-l)*K[k+half_h_K+1,l+half_w_K+1] for k in -half_h_K:half_h_K, l in -half_w_K:half_w_K]) for i in 1:size(M,1), j in 1:size(M,2) ]
end
