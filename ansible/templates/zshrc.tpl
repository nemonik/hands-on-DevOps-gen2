autoload -Uz compinit
compinit

export HOMEBREW_PREFIX="{{ HOMEBREW_PREFIX }}"

source $HOME/.config/powerlevel10/powerlevel10k.zsh-theme

source <(k3d completion zsh)

export ZSH="$HOME/.oh-my-zsh"

{% if ansible_distribution == 'MacOSX' %}
plugins=(git golang docker docker-compose kubectl)
{% elif ansible_distribution == 'MacOSX' %}
plugins=(git golang kubectl osx)
{% endif %}

source $ZSH/oh-my-zsh.sh

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"

export SONAR_HOST_URL="{{ lookup('env', 'sonarqube_protocol') }}://{{ lookup('env', 'sonarqube_fdqn') }}:{{ lookup('env', 'sonarqube_port') }}"

export EDITOR="nvim"
export VISUAL="nvim"

export FZF_DEFAULT_OPTS='—height=40% —preview="cat {}" —preview-window=right:60%:wrap'

alias vim="nvim"
alias nano="nvim"

export GOBIN="$HOME/go/bin"
export GOPATH="$HOME/go"
export PATH="$GOBIN:$PATH"

export PATH="$HOME/.local/bin:$PATH"

{% if ansible_distribution == 'MacOSX' %}
export PATH="$HOMEBREW_PREFIX/opt/openssl@1\.1/bin:$PATH"
{% endif %}
