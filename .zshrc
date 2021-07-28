# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH=$HOME/.oh-my-zsh
export TERMINFO=/usr/share/terminfo  # Backspace in Python (through minconda)
export SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

CASE_SENSITIVE="false"

source $ZSH/oh-my-zsh.sh
source "$HOME/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme"
source "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source /usr/share/autojump/autojump.zsh

ZSH_THEME="powerlevel10k/powerlevel10k"
# ORDER

DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
plugins=(
  git
  colorize
  copydir
  django
)
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
ZSH_HIGHLIGHT_STYLES[alias]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=orange,bold'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=green,bold'
ZSH_HIGHLIGHT_STYLES[function]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[command]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green, bold'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=6'

bindkey '^ ' autosuggest-toggle

export LANG=en_US.UTF-8
#alias cat="colorize"
alias cpd="copydir"
alias l="ls"
alias ll="ls -l"
alias la="ls -la"
alias pmr="python manage.py runserver"
alias pms="python manage.py shell"
alias pmm="python manage.py makemigrations"
alias pmi="python manage.py migrate"
alias pmt="python manage.py test"
alias jup="j polyticket"
alias jd="j deeppoint"
alias gd="git diff | egrep 'console.log|print\('"
alias gc="git checkout"
alias update_code="wget -O code.deb https://code.visualstudio.com/sha/download\?build\=stable\&os\=linux-deb-x64 && sudo dpkg -i code.deb && rm code.deb"

xpwd() {
    pwd | xclip -selection clipboard
}
gall() {
    git add .
    git commit -a -m"$1"
    git push
}
manage() {
    python manage.py $1
}
dotup() {
  ./mngDotF.sh
  git add .
  git commit -m "sync"
  git push origin master
}
gsvcred() {
  git config --global credential.helper 'cache --timeout=36000'
}
cpr() {
  rsync -ahr --info=progress2 $1 $2
}

jp() {
  j polyticket
  tilix -a session-add-down -x "mailhog"
  tilix -a session-add-down -x "stripe listen --forward-to localhost:8000/api/v1/modules_payments/stripe/webhooks/"
  pmr
}

gpull() {
  git pull origin $(git branch --show-current)
}

#fpath=($fpath "$HOME/.zfunctions")
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/home/steven/.config/composer/vendor/bin:/home/steven/.scc/scc.py:/home/steven/.npm-global/bin:$HOME/.local/bin:$HOME/bin:/snap/bin"
alias scc='/home/steven/.scc/scc.py'
alias dotFiles='/usr/bin/git --git-dir=$HOME/.dotFiles/ --work-tree=$HOME'

fpath=(~/Documents/cheatsheets/ $fpath)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

source /opt/conda_auto_env/conda_auto_env.sh
autoload -U add-zsh-book
autoload -U compinit && compinit
add-zsh-hook chpwd conda_auto_env

zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
