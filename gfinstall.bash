#/usr/bin/env bash
_gfinstall()
{
        COMPREPLY=($(compgen -W "$(echo `cat /usr/share/bash-completion/completions/gflist.txt`;)" "${COMP_WORDS[1]}"))
}

complete -F _gfinstall gfinstall