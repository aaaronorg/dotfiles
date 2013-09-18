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
    PS1='${debian_chroot:+($debian_chroot)}\[\033[0;32m\]\u@\[\033[48;5;124m\]\h\[\033[00m\]:\[\033[0;34m\]$(_dir_chomp "$(pwd)" 20)$(__git_ps1 " \[\033[0;31m\](%s)") \[\033[0;36m\]\$ $(tput sgr0)'
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
