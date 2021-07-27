{% if ansible_distribution == 'MacOSX' %}
export HOMEBREW_PREFIX="{{ HOMEBREW_PREFIX }}"

if [ -f $HOMEBREW_PREFIX/etc/bash_completion ]; then . $HOMEBREW_PREFIX/etc/bash_completion; fi
{% elif ansible_distribution == 'Archlinux' %}
source /usr/share/bash-completion/bash_completion
{% endif %}

source <(k3d completion bash)

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

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
export PATH="$HOMEBREW_PREFIX/opt/openssl/bin:$PATH"
{% endif %}

{% if ansible_distribution == 'Archlinux' %}
export PATH="/opt/sonar-scanner/bin:$PATH"
{% endif %}
