set -g theme_nerd_fonts yes

{% if ansible_distribution == 'MacOSX' %}
set -Ux HOMEBREW_PREFIX "{{ HOMEBREW_PREFIX }}"
{% endif %}

set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

status is-interactive; and pyenv init --path | source

set -Ux SONAR_HOST_URL "{{ lookup('env', 'sonarqube_protocol') }}://{{ lookup('env', 'sonarqube_fdqn') }}:{{ lookup('env', 'sonarqube_port') }}"

rvm default

set -Ux EDITOR nvim
set -Ux VISUAL nvim

set -Ux FZF_DEFAULT_OPTS '—height=40% —preview="cat {}" —preview-window=right:60%:wrap'

alias vim="nvim"
alias nano="nvim"

fish_add_path $HOME/.local/bin

set -Ux GOBIN $HOME/go/bin
set -Ux GOPATH $HOME/go

fish_add_path $GOBIN

set PATH /usr/local/bin $PATH

{% if ansible_distribution == 'MacOSX' %}
fish_add_path $HOMEBREW_PREFIX/opt/openssl/bin
{% endif %}
