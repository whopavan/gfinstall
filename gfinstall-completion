#/usr/bin/env bash
_gfinstall_completions()
{
        COMPREPLY=($(compgen -W "$(echo `cat /usr/share/bash-completion/completions/gfinstall/gflist.txt`;)" "${COMP_WORDS[1]}"))
}

complete -F _gfinstall_completions gfinstall