export PROMPT_COMMAND='history -a' #keep all history

HISTTIMEFORMAT='%F %T '
HISTFILESIZE=-1
HISTSIZE=99999
HISTCONTROL=ignoreboth:erasedups
HISTIGNORE=?:??
shopt -s histappend                 # append to history, don't overwrite it
# attempt to save all lines of a multiple-line command in the same history entry
shopt -s cmdhist
# save multi-line commands to the history with embedded newlines
shopt -s lithist

git_branch() {
    # -- Finds and outputs the current branch name by parsing the list of all branches
    # -- Current branch is identified by an asterisk at the beginning
    # -- If not in a Git repository, error message goes to /dev/null and no output is produced
    git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

function git_status() {
    # Outputs a series of indicators based on the status of the
    # working directory:
    # + changes are staged and ready to commit
    # ! unstaged changes are present
    # ? untracked files are present
    # S changes have been stashed
    # P local commits need to be pushed to the remote
    local status="$(git status --porcelain 2>/dev/null)"
    local output=''
    [[ -n $(egrep '^[MADRC]' <<<"$status") ]] && output="$output+"
    [[ -n $(egrep '^.[MD]' <<<"$status") ]] && output="$output!"
    [[ -n $(egrep '^\?\?' <<<"$status") ]] && output="$output?"
    [[ -n $(git stash list) ]] && output="${output}S"
    [[ -n $(git log --branches --not --remotes) ]] && output="${output}P"
    [[ -n $output ]] && output="|$output"  # separate from branch name
    echo $output
}

git_color() {
    # Receives output of git_status as argument; produces appropriate color
    # code based on status of working directory:
    # - White if everything is clean
    # - Green if all changes are staged
    # - Red if there are uncommitted changes with nothing staged
    # - Yellow if there are both staged and unstaged changes
    # - Blue if there are unpushed commits
    local staged=$([[ $1 =~ \+ ]] && echo yes)
    local dirty=$([[ $1 =~ [!\?] ]] && echo yes)
    local needs_push=$([[ $1 =~ P ]] && echo yes)
    if [[ -n $staged ]] && [[ -n $dirty ]]; then
        echo -e '\033[1;33m'  # bold yellow
    elif [[ -n $staged ]]; then
        echo -e '\033[1;32m'  # bold green
    elif [[ -n $dirty ]]; then
        echo -e '\033[1;31m'  # bold red
    elif [[ -n $needs_push ]]; then
        echo -e '\033[1;36m' # bold cyan (was blue)
    else
        echo -e '\033[1;37m'  # bold white
    fi
}

git_prompt() {
    # First, get the branch name...
    local branch=$(git_branch | sed "s|^.*/||") # lame hack to truncate branch name
    # Empty output? Then we're not in a Git repository, so bypass the rest
    # of the function, producing no output
    if [[ -n $branch ]]; then
        local state=$(git_status)
        local color=$(git_color $state)
        # Now output the actual code to insert the branch and status
        echo -e "\x01$color\x02[$branch$state]\x01\033[00m\x02" # last bit resets color
    fi
}

# Sample prompt declaration. Tweak as you see fit, or just stick
# "$(git_prompt)" into your favorite prompt.
# \u to add back user
export PS1='$(date -u +%R)|$(basename \w)$(git_prompt)\[\033[00m\]\$ '

# alias dumpl='PGDATABASE=datamonster PGUSER=datamonster  PGPORT=5432 PGHOST=localhost psql -c "delete from luigi.daily_target;"'

export DMPATH="/Users/maxlebedev/dm-combined"
 
alias grep='grep --include=\*.{js,py,html}'
  
function dmgrep {
grep -r $@ $DMPATH --exclude=*.pyc --exclude=*.swp --exclude=*.swo --exclude=test_results*.xml --exclude=tags --exclude-dir=$DMPATH/{.git,.idea} --exclude-dir=$DMPATH/data-sources/{common,models} --exclude-dir=$DMPATH/datamonster/{common,models} --exclude-dir=$DMPATH/datamonster/static/js/{coverage,dist,node_modules,Phantom*}
}

function steal_table () {
    pg_dump -t $1 -U datamonster -h 127.0.0.1 -p 1755 -W datamonster | psql -U datamonster -h localhost -p 5432 datamonster
}

export PATH="/usr/local/sbin:$PATH"
# export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH=~/go/bin:$PATH

export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

export PROJECT_HOME=$HOME/Devel
export VIRTUALENVWRAPPER_PYTHON=python

# cool reverse search thing
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# eval $(thefuck --alias fck)

export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_172.jdk/Contents/Home

alias cat='bat'
