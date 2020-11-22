### How to open a notebook of Julia code in Jupyter?
There might exist several ways:
01. In bash, do <code><b>julia -e 'using IJulia; IJulia.notebook()'</b></code>

**cf.** [https://github.com/JuliaLang/IJulia.jl](https://github.com/JuliaLang/IJulia.jl)


### Use shell commands in a jupyter cell
Taking the `ls` command as an example:
- **not** `!ls`
- **neither** simply `ls`
- **`;ls`** is one correct way
- another way is
  01. `macro bash_str(s) open(`bash`,"w",stdout) do io; print(io, s); end; end` in one cell
  02. `bash"du -hsx | sort -h"` in another, or (if you want to execute multiple lines)
    ```julia
    bash"""
    du -hsx | sort -h
    ls
    """
    ```


### Configure the <code>python</code> to be used in <code>PyCall</code> in Julia
<pre>
set <b>ENV["PYTHON"]</b> to the path/name of the python
executable you want to use, run Pkg.build("PyCall"), and re-launch Julia.
</pre>



