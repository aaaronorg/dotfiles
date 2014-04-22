# ~/.bashrc: Allan C. Lloyds <acl@acl.im>
# vim: set et ff=unix ft=sh fdm=marker ts=2 sw=2 sts=2 tw=0: 
# see ~/.profile for ksh/bash/zsh startup file loading order

# Nothing exciting here as I mainly use zsh. This is the default .bashrc

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
if [[ -n "$PS1" ]] ; then

  if [ -e ~/.localpaths ]; then
    #import localpaths for environment specific paths
    . ~/.localpaths
  fi

  # don't put duplicate lines in the history. See bash(1) for more options
  # don't overwrite GNU Midnight Commander's setting of `ignorespace'.
  HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
  # ... or force ignoredups and ignorespace
  HISTCONTROL=ignoreboth

  # append to the history file, don't overwrite it
  shopt -s histappend

  # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

  # check the window size after each command and, if necessary,
  # update the values of LINES and COLUMNS.
  shopt -s checkwinsize

  # make less more friendly for non-text input files, see lesspipe(1)
  [ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

  # set variable identifying the chroot you work in (used in the prompt below)
  if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
      debian_chroot=$(cat /etc/debian_chroot)
  fi

  # set a fancy prompt (non-color, unless we know we "want" color)
  case "$TERM" in
      xterm-color) color_prompt=yes;;
      xterm-16color)  color_prompt=yes;;
      xterm-256color) color_prompt=yes;;
  esac

  # uncomment for a colored prompt, if the terminal has the capability; turned
  # off by default to not distract the user: the focus in a terminal window
  # should be on the output of commands, not on the prompt
  #force_color_prompt=yes

  if [ -n "$force_color_prompt" ]; then
      if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
      else
    color_prompt=
      fi
  fi

_dir_chomp () {
    local IFS=/ c=1 n d
    local p=(${1/#$HOME/\~}) r=${p[*]}
    local s=${#r}
    while ((s>$2&&c<${#p[*]}-1))
    do
        d=${p[c]}
        n=1;[[ $d = .* ]]&&n=2
        ((s-=${#d}-n))
        p[c++]=${d:0:n}
    done
    echo "${p[*]}"
}


  if [ "$color_prompt" = yes ]; then
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[0;32m\]\u@\[\033[48;5;124m\]\h\[\033[00m\]:\[\033[0;34m\]$(_dir_chomp "$(pwd)" 20)$(__git_ps1 " \[\033[0;31m\](%s)") \[\033[0;36m\]\$ $(tput sgr0)'
    PS1='${debian_chroot:+($debian_chroot)}\[\033[0;32m\]\u@\[\033[48;5;124m\]\h\[\033[00m\]:\[\033[0;34m\]$(_dir_chomp "$(pwd)" 20)$(__git_ps1 " \[\033[0;31m\](%s)") \[\033[0;36m\]\$ \[\033[00m\]'
  else
      #PS1='${debian_chroot:+($debian_chroot)}@:\w\$ '
      PS1='${debian_chroot:+($debian_chroot)}@:$(_dir_chomp "$(pwd)" 20)\$ '
  fi
  unset color_prompt force_color_prompt

  # Coling's prompt need to combine this with the above to implement the directory chomp function
  # if [ "$(type -t __git_ps1)" = "function" ]; then
  #   export PS1="$(echo -n "$PS1" | sed "s|\\\W\]|\\\W\$(type __git_ps1 >/dev/null  2>\&1 \&\& __git_ps1 \" (%s)\")\]|")"
  # fi


  # If this is an xterm set the title to user@host:dir
  case "$TERM" in
  xterm*|rxvt*)
      PS1="\[\e]0;${debian_chroot:+($debian_chroot)}@: \w\a\]$PS1"
      ;;
  *)
      ;;
  esac

  # enable color support of ls and also add handy aliases
  # if [ -x /usr/bin/dircolors ]; then
  #     test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  #     alias ls='ls --color=auto'
  #     #alias dir='dir --color=auto'
  #     #alias vdir='vdir --color=auto'

  #     alias grep='grep --color=auto'
  #     alias fgrep='fgrep --color=auto'
  #     alias egrep='egrep --color=auto'
  # fi

  # some more ls aliases
  #alias ll='ls -l'
  #alias la='ls -A'
  #alias l='ls -CF'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


  # Alias definitions.
  # You may want to put all your additions into a separate file like
  # ~/.bash_aliases, instead of adding them here directly.
  # See /usr/share/doc/bash-doc/examples in the bash-doc package.

  if [ -e ~/.bash_aliases ]; then
    . ~/.bash_aliases
  fi

  if [ -e ~/.aliases ]; then
    . ~/.aliases
  fi

  # enable programmable completion features (you don't need to enable
  # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
  # sources /etc/bash.bashrc).
  if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
      . /etc/bash_completion
  fi

  # development stuff
  export PYTHONSTARTUP=~/.pythonstartup
fi

#add osx style pbcopy and pbpaste
if ! which pbcopy >/dev/null && which xsel >/dev/null; then
  alias pbcopy='xsel --clipboard --input'
  alias pbpaste='xsel --clipboard --output'
fi

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting


export __CF_USER_TEXT_ENCODING=0x1F5
. $HOME/.bashrc.load

#Mike Evans aliases

alias m=less
alias l='ls -AF --color'
alias ll='ls -lAF --color'
alias llm='ls -AlF --color'
alias lm='ls -xAF --color'
alias lr='ls -xARF --color'
alias lrm='ls -xARF --color'
alias lld='ls -lAF --color | grep ^d'
alias f='/usr/bin/find . -name $1'
alias p='pwd'
alias ..=up
alias q='clear'
alias pu='ps -u $LOGNAME' 
alias h=history
alias pt="ps -ef | grep"
function cl { 
  if [ $# = 0 ]; then
    cd
    ls -AF --color
    export PWD=`pwd`
  elif [ -d "$*" ]; then
    cd "$*"
    ls -AF --color
    export PWD=`pwd`
  else
    echo $1: directory not found
  fi
}
function up {
  cd ..
  pwd
  ls -AF --color
  export PWD=`pwd`
}
alias b='cd -'
alias go='pushd $1; ls -AF; PWD=`pwd`; export PWD'
alias og='popd +$1; ls -AF; PWD=`pwd`; export PWD'
function gf {
    grep -sn $1 * | grep -v .svn*
}
function ggf {
    grep -sn $1 */* | grep -v .svn*
}
function gggf {
    grep -sn $1 */*/* | grep -v .svn*
}
function gfa {
    grep -sn $1 .* * 
}
alias g='grep -sn'
#k is to set directory
alias k1='k1="$PWD"; ls -F'
alias k2='k2="$PWD"; ls -F'
alias k3='k3="$PWD"; ls -F'
alias k4='k4="$PWD"; ls -F'
alias k5='k5="$PWD"; ls -F'
alias k6='k6="$PWD"; ls -F'
alias k7='k7="$PWD"; ls -F'
alias k8='k8="$PWD"; ls -F'
alias k9='k9="$PWD"; ls -F'
alias mark='M="$PWD"; export M'
#j is to 'jump' to directory index N
alias j1='[ -d "$k1" ] && cd "$k1";p;l'
alias j2='[ -d "$k2" ] && cd "$k2";p;l'
alias j3='[ -d "$k3" ] && cd "$k3";p;l'
alias j4='[ -d "$k4" ] && cd "$k4";p;l'
alias j5='[ -d "$k5" ] && cd "$k5";p;l'
alias j6='[ -d "$k6" ] && cd "$k6";p;l'
alias j7='[ -d "$k7" ] && cd "$k7";p;l'
alias j8='[ -d "$k8" ] && cd "$k8";p;l'
alias j9='[ -d "$k9" ] && cd "$k9";p;l'
#print index N
alias ek1='echo k1: $k1'
alias ek2='echo k2: $k2'
alias ek3='echo k3: $k3'
alias ek4='echo k4: $k4'
alias ek5='echo k5: $k5'
alias ek6='echo k6: $k6'
alias ek7='echo k7: $k7'
alias ek8='echo k8: $k8'
alias ek9='echo k9: $k9'
#list contents of directory referenced in index N
alias lk1='ek1;l $k1'
alias lk2='ek2;l $k2'
alias lk3='ek3;l $k3'
alias lk4='ek4;l $k4'
alias lk5='ek5;l $k5'
alias lk6='ek6;l $k6'
alias lk7='ek7;l $k7'
alias lk8='ek8;l $k8'
alias lk9='ek9;l $k9'
alias kk='(ek1);(ek2);(ek3);(ek4);(ek5);(ek6);(ek7);(ek8);(ek9)'
alias d='date +%a" "%b" "%e'
alias t='date +%H:%M:%S'
alias cpm='cp \!* $M'
alias mvm='mv \!* $M'
alias gom='cl $M'
alias lnm='ln -s $M/$1 .'
alias lsm='p;l $M'
alias difo='difforig'
alias ph='export PATH=$PATH:`pwd`'
function keep {
    mv $1 $1.keep
}
