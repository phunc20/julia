## One way to call <code>julia</code>'s package manager
is to
- first enter into <code>julia</code> REPL
    ```julia
    [phunc20@denjiro-x220 ~]$ julia
                   _
       _       _ _(_)_     |  Documentation: https://docs.julialang.org
      (_)     | (_) (_)    |
       _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
      | | | | | | |/ _` |  |
      | | |_| | | | (_| |  |  Version 1.5.1 (2020-08-25)
     _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
    |__/                   |
    
    julia>
    ```
- then press <code><b>]</b></code>, and you'll see the change of <code>julia</code>'s prompt from <code>julia> </code> to <code>(@v1.5) pkg> </code>
    ```julia
    # `add` is the key word to install any packages, e.g. here we install the package `Pluto`
    (@v1.5) pkg> add Pluto
    ```
- Then in order to <b>escape</b> from the <code>pkg</code> mode back to <code>julia</code> REPL's normal prompt, just press <code><b>Backspace</b></code>















