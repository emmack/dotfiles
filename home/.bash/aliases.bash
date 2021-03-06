#! /bin/bash

# Commonly-used aliases.
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../../'
alias rm='/bin/rm -i'
alias cp='/bin/cp -i'

if [ "`uname`" = 'Darwin' ]; then
  alias ll='ls -lFG'
else
  alias ll='ls -lF --color=auto'
fi

alias llh='ll -h'
alias lla='ll -a'
alias cls='/usr/bin/clear && ll'
alias clsa='cls -a'
alias g='grep --color'
alias gr='g -rnI'
alias gri='gr -i'
alias grep='grep --color'
alias egrep='egrep --color'
alias lgrep='ll | grep '
alias cgrep='cls | grep '
alias gdu="grep -v -e '^..K' -e '^...K' -e '^..M' -e '^.\..M' -e '^0'"
alias less='less -iR'
alias loc='locate'
alias su='/bin/su -'
alias v='view'
alias sv='/usr/bin/sudo vim'
alias sl='cd ~/src/shelflife'
alias slm='cd ~/src/shelflife-misc'
alias vi='vim -p'


if [ "`uname`" = 'Darwin' ]; then
  alias p='/bin/ps aux'
  alias pl='/bin/ps aux | less'
else
  alias p='/bin/ps auxf'
  alias pl='/bin/ps auxf | less'
fi

# APT
# These only work on Linux.
if [ "`uname`" == 'Linux' ]; then
  alias atu='sudo aptitude -V update'
  alias atug='sudo aptitude -V safe-upgrade'
  alias ati='sudo aptitude -V install'
  alias atr='sudo aptitude remove'
  alias atp='sudo aptitude purge'
  alias ats='aptitude search'
  alias atsh='aptitude show'
  alias acs='apt-cache search'
  alias acsh='apt-cache show'
  alias acsn='apt-cache search --names-only'
  alias afs='apt-file search'
  alias afsh='apt-file show'
  alias d='dpkg'
fi

# Development
alias ri='ri -T'
alias spec='spec -c'
alias ss='script/server'
alias sc='script/console'
alias migration_date='date +"%Y%m%d%H%M%S"'
alias bi='bundle install'
alias be='bundle exec'
alias berc='be rails console'
alias ura='gfop && bundle install && bundle exec rake db:migrate db:test:prepare'

# tmux
alias tmux='tmux -2'
alias tms='tmux new-session -s'
alias yak='mux yak'

# Vagrant
alias vu='vagrant up'
alias vsu='vagrant suspend'
alias vr='vagrant resume'
alias vs='cd ~/src/vagrant/ && vagrant ssh'

# Shopify
alias hpc='script/heroku_production run rails console'

# Miscellaneous
alias showcpu='/bin/ps auxf | head -1; /bin/ps auxf | sort -nr -k 3'
alias showmem='/bin/ps auxf | head -1; /bin/ps auxf | sort -nr -k 4'
alias pv='pv -N "pv"'
alias shred='shred -u'
alias echo_ruby_load_commands="for i in \`pwd\`/*; do echo \"load '\$i'\"; done"
alias format_json='python -c "import sys, json; print json.dumps(json.load(sys.stdin), sort_keys=True, indent=2)"'
alias http_proxy='echo "Starting Squid3 on deadorange.com" ; ssh -t deadorange.com sudo service squid3 restart ; ssh -vN -L 127.0.0.1:3128:localhost:3128 deadorange.com ; echo "Stopping Squid3 on deadorange.com ..."; ssh -t deadorange.com sudo service squid3 stop'
alias open-ports="sudo lsof -iTCP -sTCP:LISTEN -P"

# For my external monitor at home.
if [ "`uname`" == 'Linux' ]; then
  alias lcd_on='lenovo_acer_lcd_on'
  alias lcd_off='lenovo_lcd_off'
  alias lenovo_acer_lcd_on='xrandr --output HDMI1 --mode 1920x1080 --pos 0x0 --output LVDS1 --mode 1600x900 --pos 0x1080'
  alias lenovo_samsung_lcd_on='xrandr --output HDMI1 --mode 1680x1050 --pos 0x0 --output LVDS1 --mode 1600x900 --pos 0x1050'
  alias lenovo_lcd_off='xrandr --output HDMI1 --off'
fi

# For backing up my data at home.
if [ "`uname`" == 'Linux' ]; then
  alias rsync-backup-home='sudo rsync -avzh --hard-links --inplace --numeric-ids --itemize-changes --delete-after --ignore-errors /home/ /mnt/backup-home'
  alias rsync-backup-os='sudo rsync -avzhx --hard-links --inplace --numeric-ids --itemize-changes --delete-after --ignore-errors --exclude /dev --exclude /mnt --exclude /proc --exclude /sys --exclude /tmp / /mnt/backup-os/'
fi

# Show network connections.
if [ "`uname`" = 'Darwin' ]; then
  alias nst='sudo netstat -taun'
else
  alias nst='sudo netstat -taunp'
fi

# This is for smart running of tests. If .zeus.sock exists, then we run the
# tests with Zeus, otherwise, fall back to Ruby.
function rt {
  if grep -q "spring-commands-testunit" Gemfile; then
    bundle exec spring testunit $@
  elif [ -d 'spec' ]; then
    bundle exec rspec $1
  else
    bundle exec ruby -Itest $@
  fi
}

# Run tests that contain "focus" in their name.
function rtf {
  rt $@ -n /focus/
}

# Load Shopify-specific aliases and functions.
source ~/.bash/aliases.shopify.bash
