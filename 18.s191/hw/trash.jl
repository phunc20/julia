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
"

function matrix_to_vecvec(matrix)
    n_rows, n_cols = size(matrix)
    return [matrix[:,i] for i in 1:n_cols]
end
