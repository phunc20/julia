```bash

julia> pwd
pwd (generic function with 1 method)

julia> !pwd
#64 (generic function with 1 method)

julia> pwd()
"/home/phunc20"

julia> %pwd
ERROR: syntax: "%" is not a unary operator
Stacktrace:
 [1] top-level scope at none:1
github/  others/   phunc20/
julia> cd("git-repos/phunc20/julia/18.s191/lecture_notebooks/")

julia> ls()
ERROR: UndefVarError: ls not defined
Stacktrace:
 [1] top-level scope at REPL[6]:1

julia> ls
ERROR: UndefVarError: ls not defined

julia> !ls
ERROR: UndefVarError: ls not defined
Stacktrace:
 [1] top-level scope at REPL[8]:1

julia> ls('.')
ERROR: UndefVarError: ls not defined
Stacktrace:
 [1] top-level scope at REPL[9]:1

julia>

julia> readdir()
7-element Array{String,1}:
 "seam_live_code.jl"
 "the_persistence_of_DaliHimself.jpg"
 "the_persistence_of_epongeBebe.jpg"
 "the_persistence_of_simpsons.jpg"
 "week01"
 "week02"
 "week03"

```
