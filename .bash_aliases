alias md='mkdir'
alias rm='rm -rf'
alias head='grep -r "<<<<<<< HEAD"'
alias sync='repo sync -j32'
alias gco='git checkout'
alias add='git add -A'
alias ok='git commit -a'
alias gca='git commit --amend'
alias chk='git checkout -b'
alias grs='git reset --hard'
alias gb='git branch'
alias gl='git log'
alias pik='git cherry-pick'
alias stat='git status'
alias rvt='git revert'
alias rmt='git remote -v'
alias clob='make clobber'
alias update='sudo pacman -Syyu --noconfirm | lolcat'
alias yupdate='yaourt -Syua --noconfirm | lolcat'
alias install='sudo pacman -S'
alias remove='sudo pacman -Rs'
alias rmorphans='sudo pacman -Rns $(pacman -Qtdq)'
alias paccache='sudo paccache -r -k 2'

source ~/.bash-colors

# git status slightly adapted from https://coderwall.com/p/pn8f0g

function git_color {
  if [[ $EUID -ne 0 ]]; then
    local git_status="$(git status 2> /dev/null)"

    if [[ ! $git_status =~ "working directory clean" ]]; then
      echo -e $bldred
    elif [[ $git_status =~ "Your branch is ahead of" ]]; then
      echo -e $bldylw
    elif [[ $git_status =~ "nothing to commit" ]]; then
      echo -e $bldgrn
    else
      echo -e $txtylw
    fi
  else
    echo -e $bldred
  fi
}

function git_branch {
  local git_status="$(git status 2> /dev/null)"
  local on_branch="On branch ([^${IFS}]*)"
  local on_commit="HEAD detached at ([^${IFS}]*)"

  if [[ $git_status =~ $on_branch ]]; then
    local branch=${BASH_REMATCH[1]}
    echo " ($branch)"
  elif [[ $git_status =~ $on_commit ]]; then
    local commit=${BASH_REMATCH[1]}
    echo " ($commit)"
  fi
}

if [[ $EUID -ne 0 ]]; then
  usercolor=$txtgrn
  pathcolor=$bldblu
  gitcolor=$bldylw
  promptcolor=$bldgrn
  prompt='\$'
else
  usercolor=$txtred
  promptcolor=$bldred
  pathcolor=$bldred
  gitcolor=$txtred
  prompt='#'
fi

PS1="\[$usercolor\]\u@\h\[$txtrst\] \[$pathcolor\]\w\[$txtrst\]"
PS1+="\[\$(git_color)\]"
PS1+="\$(git_branch)"
PS1+=" \[$promptcolor\]$prompt\[$txtrst\] \[$bldwht\]"

function gcl { git clone https://github.com/DirtyUnicorns/"$1".git -b lollipop-caf; }
export -f gcl
function gerrit { git push ssh://chasmodo@gerrit.dirtyunicorns.com:29418/`echo ${PWD##*/}` *:*; }
export -f gerrit