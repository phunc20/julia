## Installation
```bash
[downloads] >>> ll
total 222600
-rw-r--r--  1 phunc20 wheel    260945 Oct  4 09:38  12.pdf
-rw-r--r--  1 phunc20 wheel    119963 Oct  4 09:45  principal_components.pdf
-rw-r--r--  1 phunc20 wheel  93052469 Oct 26 14:31  Miniconda3-latest-Linux-x86_64.sh
-rw-r--r--  1 phunc20 wheel    917416 Oct 26 15:03  Gilbert_Strang__Introduction_to_Linear_Algebra_5th_Edition_Solutions__2016.pdf
-rw-r--r--  1 phunc20 wheel   4882081 Oct 26 15:04 'Linear Algebra and Its Applications ( PDFDrive ).pdf'
-rw-r--r--  1 phunc20 wheel     78850 Oct 26 15:13  linearalgebra5_7-1.pdf
-rw-r--r--  1 phunc20 wheel  23267423 Oct 26 17:28 'How to Install, Use and Extend LaTeX-720p.mp4'
drwxr-xr-x  3 phunc20 wheel      4096 Oct 26 19:24  denjiro-x220
-rw-r--r--  1 phunc20 wheel       150 Oct 26 20:23  typora-test.md
-rw-r--r--  1 phunc20 wheel       866 Oct 26 20:32  julia-1.5.2-linux-x86_64.tar.gz.asc
-rw-r--r--  1 phunc20 wheel      3112 Oct 26 20:32  juliareleases.asc
-rw-r--r--  1 phunc20 wheel 105324048 Oct 26 20:32  julia-1.5.2-linux-x86_64.tar.gz
drwx------ 24 phunc20 wheel      4096 Oct 26 20:38  ..
-rw-r--r--  1 phunc20 wheel      1203 Oct 26 20:40  julia-1.5.2.sha256
drwxr-xr-x  3 phunc20 wheel      4096 Oct 26 20:40  .
[downloads] >>> sha256sum -c julia-1.5.2.sha256 2>/dev/null | grep julia-1.5.2-linux-x86_64.tar.gz
julia-1.5.2-linux-x86_64.tar.gz: OK
[downloads] >>> gpg --import juliareleases.asc
gpg: directory '/home/phunc20/.gnupg' created
gpg: keybox '/home/phunc20/.gnupg/pubring.kbx' created
gpg: /home/phunc20/.gnupg/trustdb.gpg: trustdb created
gpg: key 66E3C7DC03D6E495: public key "Julia (Binary signing key) <buildbot@julialang.org>" imported
gpg: Total number processed: 1
gpg:               imported: 1
[downloads] >>> gpg --verify julia-1.5.2-linux-x86_64.tar.gz.asc
gpg: assuming signed data in 'julia-1.5.2-linux-x86_64.tar.gz'
gpg: Signature made Thu 24 Sep 2020 11:13:53 AM +07
gpg:                using RSA key 3673DF529D9049477F76B37566E3C7DC03D6E495
gpg:                issuer "buildbot@julialang.org"
gpg: Good signature from "Julia (Binary signing key) <buildbot@julialang.org>" [unknown]
gpg: WARNING: This key is not certified with a trusted signature!
gpg:          There is no indication that the signature belongs to the owner.
Primary key fingerprint: 3673 DF52 9D90 4947 7F76  B375 66E3 C7DC 03D6 E495
[downloads] >>>
```
How to use? `tar xvf julia-1.5.2-linux-x86_64.tar.gz`
And then just run the binary file named __`julia`__.
```bash
[downloads] >>> cd julia-1.5.2/
bin/        etc/        include/    lib/        libexec/    LICENSE.md  share/
[downloads] >>> cd julia-1.5.2/bin/
[bin] >>> ls
julia
[bin] >>> ./julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.5.2 (2020-09-23)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia> π
π = 3.1415926535897...

julia>
```


```bash
[downloads] >>> mv julia-1.5.2 ~/.local/bin/
[downloads] >>> cd ~/.local/bin/
[bin] >>> ln -s julia-1.5.2/bin/julia .
[bin] >>> ll julia
lrwxrwxrwx 1 phunc20 wheel 21 Oct 26 20:51 julia -> julia-1.5.2/bin/julia
[bin] >>> julia
               _
   _       _ _(_)_     |  Documentation: https://docs.julialang.org
  (_)     | (_) (_)    |
   _ _   _| |_  __ _   |  Type "?" for help, "]?" for Pkg help.
  | | | | | | |/ _` |  |
  | | |_| | | | (_| |  |  Version 1.5.2 (2020-09-23)
 _/ |\__'_|_|_|\__'_|  |  Official https://julialang.org/ release
|__/                   |

julia>
```


