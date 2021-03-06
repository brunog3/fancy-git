#!/bin/bash
#
# Author: Diogo Alexsander Cavilha <diogocavilha@gmail.com>
# Date:   06.11.2018

. ~/.fancy-git/aliases
. ~/.fancy-git/fancygit-completion
. ~/.fancy-git/commands.sh

fancygit_prompt_builder() {
    . ~/.fancy-git/update_checker.sh && _fancygit_update_checker

    local branch_name=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)

    # Colors
    local bold="\\[\\e[1m\\]"
    local bold_none="\\[\\e[0m\\]"
    local light_green="\\[\\e[92m\\]"
    local light_yellow="\\[\\e[93m\\]"
    local none="\\[\\e[39m\\]"
    local orange="\\033[95;38;5;214m"
    local light_magenta="\\[\\e[95m\\]"

    # Prompt
    local user="${orange}\u${none}"
    local host="${light_yellow}\h${none}"
    local where="${light_green}\w${none}"
    local venv=""

    if ! fg_show_full_path
    then
        where="${light_green}\W${none}"
    fi

    if ! [ -z ${VIRTUAL_ENV} ]; then
        venv="${light_yellow}`basename \"$VIRTUAL_ENV\"`${none} for "
    fi

    if [ "$branch_name" != "" ]; then
        branch_name="on ${light_magenta}$branch_name${none}"
    fi

    PS1="${bold}${venv}${user} at ${host} in $where $branch_name$(fg_branch_status 1)${bold_none}\n\$ "
}

PROMPT_COMMAND="fancygit_prompt_builder"

