# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

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

# Simple BASH function that shortens
# a very long path for display by removing
# the left most parts and replacing them
# with a leading ...
#
# the first argument is the path
#
# the second argument is the maximum allowed
# length including the '/'s and ...
#
shorten_path()
 {
  x=${1}
  len=${#x}
  max_len=$2

  if [ $len -gt $max_len ]
  then
      # finds all the '/' in
      # the path and stores their
      # positions
      #
      pos=()
      for ((i=0;i<len;i++))
      do
          if [ "${x:i:1}" == "/" ]
          then
              pos=(${pos[@]} $i)
          fi
      done
      pos=(${pos[@]} $len)

      # we have the '/'s, let's find the
      # left-most that doesn't break the
      # length limit
      #
      i=0
      while [ $((len-pos[i])) -gt $((max_len-3)) ]
      do
          i=$((i+1))
      done

      # let us check if it's OK to
      # print the whole thing
      #
      if [ ${pos[i]} == 0 ]
      then
          # the path is shorter than
          # the maximum allowed length,
          # so no need for ...
          #
          echo ${x}

      elif [ ${pos[i]} == $len ]
      then
          # constraints are broken because
          # the maximum allowed size is smaller
          # than the last part of the path, plus
          # '...'
          #
          echo ...${x:((len-max_len+3))}
      else
          # constraints are satisfied, at least
          # some parts of the path, plus ..., are
          # shorter than the maximum allowed size
          #
          echo ...${x:pos[i]}
      fi
  else
      echo ${x}
  fi
 }


# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
PS1="\[\e[40m\]\[\e[1;37m\] \u \[\e[47m\]\[\e[1;30m\] \w \[\e[0m\]\[\e[1;37m\]\[\e[42m\] > \[\e[0m\]"
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
PS1="\[\e[40m\]\[\e[1;37m\] \u \[\e[47m\]\[\e[1;30m\] \w \[\e[0m\]\[\e[1;37m\]\[\e[42m\] > \[\e[0m\]"
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
PS1='\[\e[40m\]\[\e[1;37m\] \u \[\e[47m\]\[\e[1;30m\] $(shorten_path "\w" 50) \[\e[0m\]\[\e[1;37m\]\[\e[42m\] > \[\e[0m\]'
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#if [ -f ~/.bash_aliases ]; then
#    . ~/.bash_aliases
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

export ALTERNATE_EDITOR=""
export EDITOR="emacsclient -c"
alias emacs=$EDITOR