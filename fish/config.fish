

# OPAM configuration
source /home/tbraibant/.opam/opam-init/init.fish > /dev/null 2> /dev/null or true


function opamc
         # reset the opam environment
         eval (opam config --shell fish env)
end
