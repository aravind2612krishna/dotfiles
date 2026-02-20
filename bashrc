if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Local variables
REPOS_PATH=/mnt/work/repos
COMMON_UTILS_PATH=${REPOS_PATH}/CommonUtils/

[ -n "$SSH_TTY" ] && export TERM=xterm-256color

if [ "$BASHRC_SOURCED" != "1" ]; then
    gsettings set org.gnome.shell.keybindings toggle-overview "['Super_L']" 2> /dev/null

    export BASHRC_SOURCED=1

    export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
    export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
    export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
    export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}"
    export PATH="/home/aravk/.local/kitty.app/bin/${PATH+:$PATH}"
    export PATH="/home/linuxbrew/.linuxbrew/opt/node@22/bin:$PATH"
    export MANPATH="/home/linuxbrew/.linuxbrew/share/man${MANPATH+:$MANPATH}:"
    export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}"

    # User specific environment
    # Define an array of paths
    paths=(
        "/workarea/third_party/python/python3.8.10/linux64/bin"
        "$HOME/sources/git-2.43.2"
        "$HOME/.local/bin"
        "$HOME/.yarn/bin"
        "$HOME/.config/yarn/global/node_modules/.bin"
        "$HOME/.local/bin"
        "${COMMON_UTILS_PATH}/util_scripts"
        "$HOME/local/bin"
        "$HOME/.cargo/bin"
        "$HOME/nvim/bin"
        "/usr/local/go/bin"
    )

    # Loop through each path and add it to PATH if it exists
    for path in "${paths[@]}"; do
        if [ -d "$path" ]; then
            PATH="$path:$PATH"
        fi
    done

    export PATH

    # WEBHOOK_URL
    # export WEBHOOK_URL=https://outlook.office.com/webhook/eab20538-f8e4-4e77-9b8f-42cb8a02fedc@2bae5b57-0eb8-48fb-ba47-990259da89d2/IncomingWebhook/72a09b82912b40fc8f76394f3281e35d/eab20538-f8e4-4e77-9b8f-42cb8a02fedc

    # ALTAIR RELATED
    export P4USER=aravk
    # export P4PORT=blrperforce2:1999
    export P4PORT=10.182.129.7:1666
    # export P4EDITOR=/home/aravk/go/bin/src
    export P4EDITOR=nvim
    # export P4PORT=10.75.11.75:1999
    #export P4PORT=blrperforce:1999
    # HW_THIRDPARTY=${REPOS_PATH}/HmMshgFbNxtThpty_AK_1204
    if [ -d /workarea ]; then
        [ -z "$HW_THIRDPARTY" ] && export HW_THIRDPARTY=/workarea/third_party
        [ -z "$HW_THIRDPARTY" ] && export HW_INTERNALS=/workarea/internal
    fi
    [ -z "$HW_THIRDPARTY" ] && export HW_THIRDPARTY=${REPOS_PATH}/third_party
    [ -z "$HW_INTERNALS" ] && export HW_INTERNALS=${REPOS_PATH}/internal
    export HW_SHOW_UNITY_DEV_CONSOLE=1
    export HM_MSHG_REGRESSION_SUITE_PATH=${REPOS_PATH}/regressionsuite
    export HM_MIDMESH_ENABLE_VIZ=1 # MidMesh
    export HM_TIMESTAMP=1
    export HWDISPLAY_BUILD=1
    export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${HW_THIRDPARTY}/tcl/tcl8.5.9/linux64/lib
    export LD_LIBRARY_PATH=~/sources/neovim/build/lib/:$LD_LIBRARY_PATH

    if [ -e /home/aravk/altlic.dat ]; then
        export ALTAIR_LICENSE_PATH=/home/aravk/altlic.dat
    else
        export ALTAIR_LICENSE_PATH="6200@blrlicsrv01:6200@blrlicsrv03:6200@trlicsrv03"
    fi
    [ -f ${REPOS_PATH}/pat ] && export persTkn=$(cat ${REPOS_PATH}/pat)
    export P4IGNORE=~/P4IGNORE
    export HM_QA_VALIDATE_API=1
    export HM_EXPOSE_MDI=1
    export HW_STUDIO_TOOLS=1

    export PYTHONPATH=${COMMON_UTILS_PATH}/linux_scripts:$PYTHONPATH

    export EDITOR=nvim

    export QT_API=5.13.0
    export QT_DIR=/home/aravk/Qt1/
    export QT_VERSION=5.15.2

    # history
    export HISTSIZE=1000000
    export HISTFILESIZE=100000000

    export HW_DEBUG_INDEX=1
    export HM_GEOMETRY_DEBUG_CTX_ENABLE=1
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# alias docker='podman' # not needed as using docker-podman
# alias tmux='tmux-non-dead.tmux'
# alias nv='nvim-qt --fullscreen --no-ext-tabline --no-ext-popupmenu'
[ -f ~/sources/neovide/target/release/neovide ] && alias nv='~/sources/neovide/target/release/neovide &'
if command -v "exa" 1>/dev/null; then
    alias ll='exa -a -l -snew -F'
else
    alias ll='ls -larth --color'
fi

[ -f "$HOME"/.fzf.bash ] && source "$HOME"/.fzf.bash

# for wsls
if [ -f "${COMMON_UTILS_PATH}/util_scripts/wsls.bash" ]; then
    # shellcheck source=/home/aravk/repos/CommonUtils/util_scripts/wsls.bash
    source "${COMMON_UTILS_PATH}"/util_scripts/wsls.bash
    alias ws='cd $REPOS_PATH; wsls'
fi

function nvq {
    local session_file=~/${HW_CLIENT}.vim
    if [[ -e $session_file ]]; then
        nvim-qt --fullscreen --no-ext-tabline --no-ext-popupmenu -- -S ~/"${HW_CLIENT}".vim
    else
        nvim-qt --fullscreen --no-ext-tabline --no-ext-popupmenu
    fi
}

set -o vi
export HW_MSG_HELP=/tmp

[ -f "$HOME"/.cargo/env ] && source "$HOME/.cargo/env"

# Bash status with colors, git branch and status
export GIT_PS1_SHOWDIRTYSTATE=1
# Define color codes
RED="\[\033[0;31m\]"
GREEN="\[\033[0;32m\]"
YELLOW="\[\033[0;33m\]"
BLUE="\[\033[0;34m\]"
PURPLE="\[\033[0;35m\]"
CYAN="\[\033[0;36m\]"
WHITE="\[\033[0;37m\]"
RESET="\[\033[0m\]"

# Function to get the current git branch
git_branch() {
    git symbolic-ref --short HEAD 2>/dev/null
}

update_ps1() {
    local exit_status=$?
    local status_color

    if [ $exit_status -eq 0 ]; then
        status_color="${WHITE}"
    else
        status_color="${RED}"
    fi

    PS1="${GREEN}\u${WHITE}@${CYAN}\h${WHITE}:${BLUE}\w${WHITE}$(
        branch=$(git_branch)
        if [ -n "$branch" ]; then
            echo " ${PURPLE}(${branch})"
        fi
    )${YELLOW} \t${status_color} \$?${RESET} $ "
}

# Set the PROMPT_COMMAND to call update_ps1 before displaying each prompt
PROMPT_COMMAND=update_ps1

# Export the PS1 variable
export PS1

export DENO_INSTALL="/home/aravk/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# __GLX_VENDOR_LIBRARY_NAME=nvidia __NV_PRIME_RENDER_OFFLOAD=1
# export  __NV_PRIME_RENDER_OFFLOAD=1
# export __GLX_VENDOR_LIBRARY_NAME=nvidia
# unset  __NV_PRIME_RENDER_OFFLOAD
# unset __GLX_VENDOR_LIBRARY_NAME

# source ~/dlang/dmd-2.107.1/activate
alias kittyupdate='curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin' 

if [ ! -e ~/.hwrc ]; then
    echo ". ~/.bashrc" > ~/.hwrc
    echo ". ${COMMON_UTILS_PATH}/ml_build_scripts/linux/HMBuildUtils.sh" >> ~/.hwrc
fi

if [ ! -e ~/.hwdockerrc ]; then
    echo ". ~/.bashrc" > ~/.hwdockerrc
    echo ". ${COMMON_UTILS_PATH}/ml_build_scripts/linux/HMBuildUtils.sh" >> ~/.hwdockerrc
    echo "docker_run" >> ~/.hwdockerrc
fi

if command -v "fzf" 1>/dev/null; then
    eval "$(fzf --bash)"
fi
