### How to open a notebook of Julia code in Jupyter?
There might exist several ways:
01. In bash, do <code><b>julia -e 'using IJulia; IJulia.notebook()'</b></code>


### Configure the <code>python</code> to be used in <code>PyCall</code> in Julia
<pre>
set <b>ENV["PYTHON"]</b> to the path/name of the python
executable you want to use, run Pkg.build("PyCall"), and re-launch Julia.
</pre>



