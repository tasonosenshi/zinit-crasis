#!/usr/bin/env zsh

emulate -LR zsh -o warncreateglobal -o typesetsilent -o extendedglob

source data/test_body
fpath+=( $PWD $PWD/data/functions/crasis )

autoload is-at-least
autoload -- -zcrasis-process-buffer
autoload -- -zcrasis_dbg_msg -zcrasis_dbg_msg_arr
autoload -- -zcrasis-process-zplugin-commands -zcrasis-process-zsh-rc -zcrasis-tokenize-zsh-rc
autoload -- -zcrasis_verify_tokenization -zcrasis_tokenization_failed
autoload -- -zcrasis_action_add_plugin -zcrasis_action_add_snippet
autoload -- -zcrasis_util_swap -zcrasis_action_move_down -zcrasis_action_move_up
autoload -- -zcrasis_action_reload -zcrasis_action_save
autoload -- -zcrasis_compose
autoload -- -zcrasis_update_ice_cmd -zcrasis_update_main_cmd

local -A ZUI
local -a ZCR_DEBUG_MSGS
-zui_std_stalog() { print -r -- "${(j: :)@}"; }
-zcrasis_clear_visual_state() {}

cmdlist=()
coidx=1
stats=()

cd "$1"
command cp -vf "zshrc" "zshrc.test"
zshrc_path=`pwd`/"zshrc.test"

command rm -f skip
source ./script

if [[ -n "$2" ]]; then
    print -- "---------------------------------------------------------------------------------"
    print -rl -- "${ZCR_DEBUG_MSGS[@]}"
    print -- "---------------------------------------------------------------------------------"
fi

return 0
