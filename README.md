# hands-on-devops-gen2

## Preface

The future home of the second edition of my hands-on DevOps course building upon [nemonik/hands-on-DevOps](https://github.com/nemonik/hands-on-DevOps).

The content of this course is presently under development.

Since GitHub's mobile app doesn't permit access to the projact Kanban board I've moved to Todoist.


## Install Docker Desktop

If your host (e.g., your laptop, personal computer) is running Windows 10 or OSX you will need to install Docker Desktop.  If you're using Arch Linux, the Ansible automation will taked care of installing doker for you and you can skip ahead to installing Ansible.  If you are using a version of Linux other than Arch then what's wrong with you?  I'm kidding.  You can use the Vagrant to execute the factory.

This class will use Docker and so Docker Desktop must be installed and
configured.

### Installing Docker Desktop on OSX

If you're on an OSX host perform the following:

1. Download https://www.docker.com/products/docker-desktop
2. Drag the Docker app to your Application folder.
3. Find the Docker app in your applications folder and click to start the application.
3. You will need to verify that you want to trust the application by clicking
   `Open`.
5. The Docker Engine, actually a virtual machine (VM), will take sometime to start. You will then be asked to deny or accept `com.docker.backend` from accepting incoming network connections.  Click `Allow`.
6. Find docker icon on the right side of your Apple menu bar and click and then
   select `preferences` from the menu.
7. In the `docker` window that opens, select the gear icon in the upper-right
   portion of the window.
9. Under `General` make sure `Start Docker Desktop when you log in` is checked
   off otherwise you will need to start docker everytime you restart your
   host.
10. Then select `Resources` on the left-hand side of the window.
11. As Docker runs its containers in a virtual machine, you will need to give this VM more processing power and host memory to run heavier container load. What you give the Docker Desktop VM is dependent on two factors the resources your host can spare and the load the class containers will place on your host.  I'd advise trying 8 CPUs and 12 GBs of memory and scale as you see fit.
12. Click `Apply and Restart` to restart the Docker Desktop VM.  The VM will take some amount of time to restart. The containers on the back of the whale icon (Moby Dock) will cycle the Apple Menu Bar will cycle until Docker is ready.

### Installing Docker Desktop on Windows 10

To be completed, but until such time make sure to select the default option to install the WSL2 components is selected.

Skip ahead to installing the software factory.

## Install iTerm2

If your using an OSX host, you can use Apple's default Terminal app for command line terminal, but I'd  advise you to install the superior iTerm2.

Perform the following tasks:

1. Download the latest release from

   https://iterm2.com/downloads/stable/latest
2. Find the iTerm release zip file in your Downloads folder and double click.
3. Drag the iTerm app to your Application folder to install.
4. You will need to verify that you want to trust the application by clicking `Open`.
5. Use iTerm2 to perform the remaining command line tasks for this class.

# Installing the software factory

This class uses a software factory hosted on a Kubernetes cluster.  To spin up the k8s cluster you will need to perform the following tasks in the command line.

## Install Ansible

The class uses Ansible to install operating systems dependencies necessary for the class.

Ansible is a "configuration management" tool that automates software provisioning, configuration management and application deployment, two core repeated practices in DevOps, so for the class Ansible addresses this concern in the configuration of either your host operating system or a VM, if you've chosen to execute the class from a Vagrant.

Ansible was open-sourced and then later subsumed by Red Hat.

There are other notable open-source "configuration management" tools, such as Chef and Puppet. Further, still there are others, such as BOSH and Salt, but they hold little or no community of practice or market share.

In his seminal essay, "The Cathedral and the Bazaar", Eric S. Raymond states

> while coding remains an essentially solitary activity, the really great hacks
> come from harnessing the attention and brainpower of entire communities
>
> You want to leverage the work of vibrate community and not some back water
> effort.

In Ansible one defines playbooks to manage configuration. Each Ansible playbook is written in a YAML-based DSL (domain specific language) enumerating all the the tasks to be performed.  It alsos possilbe to collect these tasks into a collection referred to as a `role`.

The following sub-sections detail how to install Ansible. Skip to the section that applies to your host.

## Installing Ansible

If your host is running

* OSX drop to [Installing Xcode Command Line Tools.
* Windows drop to (TODO: complete.)
* Linux drop to (TODO: complete.)

### Install the Xcode Command Line tools

Install Xcode Command Line tools

1. In iTerm2 enter the following into the commmand line.

   ```bash
   xcode-select —install
   ```

   It is possible your host may already have the Xcode Command Line Tools installed and will be immediately told so if this is the case skip to the next section
2. A dialog will pop on the screen asking if you'd like to install the command line developer tools.  Click `Install`.
3. You will then be presented a License Agreement. After consulting your lawyer, click `Agree`.
4. Wait fo the download and install to complete, then click `Done`.

### Installing HomeBrew

Homebrew is as the project refers to itself, "The Missing Package Manager for macOS."  These days the project also tacks on "(or Linux)". Package managers  A package manager automates the process of installing, upgrading, configuring, and removing binaries from an operating system.

I could of had the Ansible playbook install this dependency, but I'd rather you become familiar with the fact there is in fact a community driven package manager for OSX.

Install brew by performing the following:

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Success resembles

```
Password:
==> This script will install:
/usr/local/bin/brew
/usr/local/share/doc/homebrew
/usr/local/share/man/man1/brew.1
/usr/local/share/zsh/site-functions/_brew
/usr/local/etc/bash_completion.d/brew
/usr/local/Homebrew

Press RETURN to continue or any other key to abort
==> /usr/bin/sudo /usr/sbin/chown -R nemonik:admin /usr/local/Homebrew
==> Downloading and installing Homebrew...
remote: Enumerating objects: 20, done.
remote: Counting objects: 100% (8/8), done.
remote: Total 20 (delta 8), reused 8 (delta 8), pack-reused 12
Unpacking objects: 100% (20/20), 4.12 KiB | 175.00 KiB/s, done.
From https://github.com/Homebrew/brew
 * [new branch]          dependabot/bundler/Library/Homebrew/sorbet-0.5.6442 -> origin/dependabot/bundler/Library/Homebrew/sorbet-0.5.6442
Updating files: 100% (2703/2703), done.
HEAD is now at 63ed6da2c Merge pull request #11564 from cnnrmnn/new-maintainer-checklist-typo
Updated 2 taps (homebrew/core and homebrew/cask).
==> Installation successful!

==> Homebrew has enabled anonymous aggregate formulae and cask analytics.
Read the analytics documentation (and how to opt-out) here:
  https://docs.brew.sh/Analytics
No analytics data has been sent yet (or will be during this `install` run).

==> Homebrew is run entirely by unpaid volunteers. Please consider donating:
  https://github.com/Homebrew/brew#donations

==> Next steps:
- Run `brew help` to get started
- Further documentation:
    https://docs.brew.sh
```

### Installing pyenv

The Ansible framework is based on Python. OSX comes with both Python 2 and Python 3 installed, but the ddefault is to run Python 2. Let's install the latest Python 3 in user space.  To do this we will use [pyenv](https://github.com/pyenv/pyenv).  Pyenv permits you to install and easily be able to switch between multiple version of Python.

On an OSX host, we'll use `brew` to install `pyenv`.

To do this perform the following in the command line

```sh
brew install pyenv
```

Success will resemble

```
bash-5.1$ brew install pyenv
==> Downloading https://ghcr.io/v2/homebrew/core/pyenv/manifests/2.0.1
Already downloaded: /Users/nemonik/Library/Caches/Homebrew/downloads/07da90c263974a39cb64c45a6479f73431c9f428e37641e7c15efe29cea1c799--pyenv-2.0.1.bottle_manifest.json
==> Downloading https://ghcr.io/v2/homebrew/core/pyenv/blobs/sha256:06646f2a7779fc545226e0a79b26e3c7a3e50f55e0843
Already downloaded: /Users/nemonik/Library/Caches/Homebrew/downloads/710577998526e867d6a4511bdc1dc329e09fdb569e775d63902604d1c765bce2--pyenv--2.0.1.big_sur.bottle.tar.gz
==> Reinstalling pyenv
==> Pouring pyenv--2.0.1.big_sur.bottle.tar.gz
🍺  /usr/local/Cellar/pyenv/2.0.1: 760 files, 2.6MB
```

One Windows 10 and Arch Linux  we'll use (TODO: complete.)

You will need to configure your shell to use `pyenv`.

First determine what shell you are using by performing the following in the
command line

```sh
echo $SHELL
```

The default shell in OS X is now `zshell`, so it is likely you are using `zsh`.  If you are then perform the following in the shell

```sh
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zprofile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zprofile
echo 'eval "$(pyenv init --path)"' >> ~/.zprofile
source ~/.zprofile
```

If your shell ends in `bash` perform the following

```sh
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile
echo 'eval "$(pyenv init --path)"' >> ~/.bash_profile
source ~/.bash_profile
```

If you're using `fish` like I am perform the following

```sh
set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
```

And add the following to `~/.config/fish/config.fish`

```sh
status is-login; and pyenv init --path | source
pyenv init - | source
```

Close your terminal window and open a new one for the changes to take effect.

### Installing the latest Python

First, let's list the available versions of Python by executing the following in the command line

```sh
pyenv versions
```

On an OSX host the output will resemble

```
* system (set by /Users/nemonik/.pyenv/version)
```

The asterisk symbol indicate this is the current version of Python we'd default to using.

Lets now install the latest version of Python 3.

To do this we could enter into the command line the following

```sh
pyenv install $(pyenv install --list | grep -v - | grep -v b | tail -1)
```

But Python is always updating, so lets pin to version 3.9.5 and install using

```sh
pyenv install 3.9.5
```

Success on an OSX host resembles

```
bash-5.1$ pyenv install $(pyenv install --list | grep -v - | grep -v b | tail -1)
python-build: use openssl@1.1 from homebrew
python-build: use readline from homebrew
Downloading Python-3.9.5.tar.xz...
-> https://www.python.org/ftp/python/3.9.5/Python-3.9.5.tar.xz
Installing Python-3.9.5...
python-build: use readline from homebrew
python-build: use zlib from xcode sdk
Installed Python-3.9.5 to /Users/nemonik/.pyenv/versions/3.9.5
```

So, you've installed Python 3.9.5, but if you enter the following into the
commmand line in the case of OSX.

```sh
python --version
```

The command will return

```
Python 2.7.16
```

We're still defaulting to the host's Python. Not quite Python 3.9.5. We can
change that by executing the following in the command line

```sh
pyenv global 3.9.5
pyenv versions
python --version
```

Output will resemble

```
⋊> ~ pyenv versions                                                                                                    15:55:08
  system
* 3.9.5 (set by /Users/nemonik/.pyenv/version)
⋊> ~ python --version                                                                                                  15:55:15
Python 3.9.5
⋊> ~ which python                                                                                                      15:55:54
/Users/nemonik/.pyenv/shims/python
```

Pyenv also installs `pip`, the package manager for Python.

You can upgrade `pip` via -- well, `pip` like so

```sh
pip install --upgrade pip
```

Output will resemble

```
⋊> ~ pip install --upgrade pip                                                                                         15:58:36
Requirement already satisfied: pip in ./.pyenv/versions/3.9.5/lib/python3.9/site-packages (21.1.1)
Collecting pip
  Downloading pip-21.1.2-py3-none-any.whl (1.5 MB)
     |████████████████████████████████| 1.5 MB 1.9 MB/s
Installing collected packages: pip
  Attempting uninstall: pip
    Found existing installation: pip 21.1.1
    Uninstalling pip-21.1.1:
      Successfully uninstalled pip-21.1.1
Successfully installed pip-21.1.2
```

### Installing Ansible

In the command line perform the following task:

Type the following

```sh
python -m pip install --user ansible
```

Output in the case of an OSX host resembles

```
⋊> ~ pip install --user ansible                                                                                        15:58:40
Collecting ansible
  Downloading ansible-4.1.0.tar.gz (34.0 MB)
     |████████████████████████████████| 34.0 MB 8.8 MB/s
Collecting ansible-core<2.12,>=2.11.1
  Downloading ansible-core-2.11.1.tar.gz (6.1 MB)
     |████████████████████████████████| 6.1 MB 2.8 MB/s
Collecting jinja2
  Downloading Jinja2-3.0.1-py3-none-any.whl (133 kB)
     |████████████████████████████████| 133 kB 7.7 MB/s
Collecting PyYAML
  Downloading PyYAML-5.4.1-cp39-cp39-macosx_10_9_x86_64.whl (259 kB)
     |████████████████████████████████| 259 kB 13.6 MB/s
Collecting cryptography
  Downloading cryptography-3.4.7-cp36-abi3-macosx_10_10_x86_64.whl (2.0 MB)
     |████████████████████████████████| 2.0 MB 17.4 MB/s
Collecting packaging
  Downloading packaging-20.9-py2.py3-none-any.whl (40 kB)
     |████████████████████████████████| 40 kB 7.8 MB/s
Collecting resolvelib<0.6.0,>=0.5.3
  Downloading resolvelib-0.5.4-py2.py3-none-any.whl (12 kB)
Collecting cffi>=1.12
  Downloading cffi-1.14.5-cp39-cp39-macosx_10_9_x86_64.whl (177 kB)
     |████████████████████████████████| 177 kB 7.9 MB/s
Collecting pycparser
  Using cached pycparser-2.20-py2.py3-none-any.whl (112 kB)
Collecting MarkupSafe>=2.0
  Downloading MarkupSafe-2.0.1-cp39-cp39-macosx_10_9_x86_64.whl (13 kB)
Collecting pyparsing>=2.0.2
  Using cached pyparsing-2.4.7-py2.py3-none-any.whl (67 kB)
Using legacy 'setup.py install' for ansible, since package 'wheel' is not installed.
Using legacy 'setup.py install' for ansible-core, since package 'wheel' is not installed.
Installing collected packages: pycparser, pyparsing, MarkupSafe, cffi, resolvelib, PyYAML, packaging, jinja2, cryptography, ansible-core, ansible
    Running setup.py install for ansible-core ... done
    Running setup.py install for ansible ... done
Successfully installed MarkupSafe-2.0.1 PyYAML-5.4.1 ansible-4.1.0 ansible-core-2.11.1 cffi-1.14.5 cryptography-3.4.7 jinja2-3.0.1 packaging-20.9 pycparser-2.20 pyparsing-2.4.7 resolvelib-0.5.4
```

In order to use the paramiko connection plugin or modules that require paramiko, install paramiko

``` sh
pip install --user paramiko
```

Output will resemble

```
⋊> ~ pip install --user paramiko                                                                                       16:09:13
Collecting paramiko
  Downloading paramiko-2.7.2-py2.py3-none-any.whl (206 kB)
     |████████████████████████████████| 206 kB 2.0 MB/s
Requirement already satisfied: cryptography>=2.5 in ./.local/lib/python3.9/site-packages (from paramiko) (3.4.7)
Collecting bcrypt>=3.1.3
  Downloading bcrypt-3.2.0-cp36-abi3-macosx_10_9_x86_64.whl (31 kB)
Collecting pynacl>=1.0.1
  Downloading PyNaCl-1.4.0-cp35-abi3-macosx_10_10_x86_64.whl (380 kB)
     |████████████████████████████████| 380 kB 5.5 MB/s
Requirement already satisfied: cffi>=1.1 in ./.local/lib/python3.9/site-packages (from bcrypt>=3.1.3->paramiko) (1.14.5)
Collecting six>=1.4.1
  Downloading six-1.16.0-py2.py3-none-any.whl (11 kB)
Requirement already satisfied: pycparser in ./.local/lib/python3.9/site-packages (from cffi>=1.1->bcrypt>=3.1.3->paramiko) (2.20)
Installing collected packages: six, pynacl, bcrypt, paramiko
Successfully installed bcrypt-3.2.0 paramiko-2.7.2 pynacl-1.4.0 six-1.16.0
```

We can then verify `ansible` has been installed via

```sh
ansible-playbook --version
```

Output will resemble

```
⋊> ~ ansible-playbook --version                                                                                        16:10:31
ansible-playbook [core 2.11.1]
  config file = None
  configured module search path = ['/Users/nemonik/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /Users/nemonik/.local/lib/python3.9/site-packages/ansible
  ansible collection location = /Users/nemonik/.ansible/collections:/usr/share/ansible/collections
  executable location = /Users/nemonik/.local/bin/ansible-playbook
  python version = 3.9.5 (default, Jun 19 2021, 14:57:12) [Clang 12.0.5 (clang-1205.0.22.9)]
  jinja version = 3.0.1
  libyaml = True
```

Let's test to see if Ansible works on our host now by executing

```sh
ansible localhost -m ping
```

Output should resemble

```
[WARNING]: No inventory was parsed, only implicit localhost is available
localhost | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

The fact that `ping` returned `pong` indicates Ansible has been isntalled
correctly.

For Ansible to manage Homebrew packages on OSX you will need to perform the
following in the command line

```sh
ansible-galaxy collection install community.general
```

Successful output should resemble

```
⋊> ~ ansible-galaxy collection install community.general                                                                                             21:02:54
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Downloading https://galaxy.ansible.com/download/community-general-3.2.0.tar.gz to /Users/mjwalsh/.ansible/tmp/ansible-local-15492hy2jc4ra/tmpgxsef_0a/community-general-3.2.0-y1c4ikxr
Installing 'community.general:3.2.0' to '/Users/nemonik/.ansible/collections/ansible_collections/community/general'
community.general:3.2.0 was installed successfully
⋊> ~/D/w/h/ansible on master ⨯
```

If you host is running Windows or Linux you will not need to run this command.

## Run the Ansible playbook

The rest of the class will require a number of operating system dependencies
be installed.  We will accomplish the via executing an Ansible playbook.

First we will set up clone the class repository by performing the following
in the command line

```sh
mkdir -p $HOME/Development/workspace
cd $HOME/Development/workspace
git clone https://github.com/nemonik/hands-on-DevOps-gen2.git
```

Enter the project's ansible folder

```sh
cd hands-on-DevOps-gen2/ansible
```

Before we execute the playbook or any playboojk for that matter it is probably a good idea to review the content of the playbook.  The outer most playboook is `main.yaml` whose content is

```yaml
---
- name: Install factory dependencies
  hosts: factory
  remote_user: root
  vars:
    default_delay: 10
    default_retries: 60

  tasks:
  - name: Echo ansible distribution
    ansible.builtin.debug:
      msg: "{{ inventory_hostname }} host is running {{ ansible_distribution }}:{{ ansible_distribution_release }} with an IP address if {{ ansible_default_ipv4.address }}"

  - name: Fail if OS is not Arch or OSX
    fail:
      msg: "{{ ansible_distribution }} - {{ ansible_distribution_release }} is not Ubuntu-bionic or Alpine"
    when: ( ansible_distribution != 'MacOSX' )

  - name: Include MacOSX.yml, when MacOSX
    include: MacOSX.yaml
    when:
      - ansible_distribution == 'MacOSX'
```

The script isn't yet complete, but will either fail if the host operating system is not support or include and execute the appropriate OS specific playbook.

For OSX the `MacOSX.yaml` playbook is included and executed. The playbook at present contains

```yaml
---
  - name: Update homebrew and upgrade all packages
    community.general.homebrew:
      update_homebrew: yes
      upgrade_all: yes

  - name: Ensure Homebrew packages are installed
    block:
      - name: Ensure bash-completion is not installed, so bash-completion@2 can be installed
        shell: brew unlink bash-completion

      - name: Ensure HomeBrew packages are installed
        community.general.homebrew:
          name: "{{ packages }}"
          state: latest
        retries: "{{ default_retries }}"
        delay: "{{ default_delay }}"
        register: result
        until: result is succeeded
        vars:
          packages:
            - bash
            - bash-completion@2
            - zsh
            - zsh-completion
            - fish
            - nvim
            - nano
            - pwgen
            - openssl
            - watch
            - gettext
            - k3d
            - helm
            - curl
            - wget
            - git-secrets

  - name: Get brew_prefix
    block:
      - name: Execute brew --prefix
        shell: brew --prefix
        register: brew_prefix
      - name: Create brew_fact with stdout of of prior command
        ansible.builtin.set_fact:
          brew_prefix: "{{ brew_prefix.stdout }}"

  - name: Install Oh My Zsh
    block:
      - name: Check if ~/.oh-my-zsh exists
        ansible.builtin.stat:
          path: ~/.oh-my-zsh
        register: oh_my_zsh

      - name: Install, only if ~/.oh-my-zsh doesn't exist
        ansible.builtin.shell: sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
        when: not oh_my_zsh.stat.exists

  # See: https://github.com/jorgebucaran/fisher

  - name: Install Fisher
    ansible.builtin.shell: 'fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"'

  # As per https://docs.docker.com/docker-for-mac/#bash

  - name: Ensure bash completions exist for Docker Desktop
    block:
      - name: Ensure bash completions for docker are configured
        ansible.builtin.file:
          src: /Applications/Docker.app/Contents/Resources/etc/docker.bash-completion
          dest: "{{ brew_prefix }}/etc/bash_completion.d/docker"
          state: link

      - name: Ensure bash completions for docker-compose are configured
        ansible.builtin.file:
          src: /Applications/Docker.app/Contents/Resources/etc/docker-compose.bash-completion
          dest: "{{ brew_prefix }}/etc/bash_completion.d/docker-compose"
          state: link

      - name: Ensure bash completion is activated for Bash shell
        lineinfile:
          path: ~/.bash_profile
          state: present
          regexp: '^if\s+\[\s+-f\s+\$\(brew\s+--prefix\)/etc/bash_completion\s+\];\s+then\s+\.\s+\$\(brew\s+--prefix\)/etc/bash_completion;\s+fi$'
          line: 'if [ -f $(brew --prefix)/etc/bash_completion ]; then . $(brew --prefix)/etc/bash_completion; fi'

  # As per https://docs.docker.com/docker-for-mac/#zsh

  - name: Ensure zsh completions exist for Docker Desktop
    block:
      - name: Ensure zsh completions for docker is configured
        ansible.builtin.file:
          src: /Applications/Docker.app/Contents/Resources/etc/docker.zsh-completion
          dest: "{{ brew_prefix }}/share/zsh/site-functions/_docker"
          state: link

      - name: Ensure zsh completions for docker-compose is configured
        ansible.builtin.file:
          src: /Applications/Docker.app/Contents/Resources/etc/docker-compose.zsh-completion
          dest: "{{ brew_prefix }}/share/zsh/site-functions/_docker-compose"
          state: link

  # As per https://docs.docker.com/docker-for-mac/#fish-shell

  - name: Ensure fish completions for Docker Desktop exist
    block:
      - name: Ensure fish completions directory exists
        ansible.builtin.file:
          path: ~/.config/fish/completions
          state: directory

      - name: Ensure bash completions for docker is configured
        ansible.builtin.file:
          src: /Applications/Docker.app/Contents/Resources/etc/docker.fish-completion
          dest: ~/.config/fish/completions/docker.fish
          state: link

      - name: Ensure bash completions for docker-compose is configured
        ansible.builtin.file:
          src: /Applications/Docker.app/Contents/Resources/etc/docker-compose.fish-completion
          dest: ~/.config/fish/completions/docker-compose.fish
          state: link

  # As per https://k3d.io/usage/commands/k3d_completion/ (Sorta the docs are a bit weak)

  - name: Ensure bash completions for k3d is configured
    lineinfile:
      path: ~/.bash_profile
      state: present
      regexp: '^source\s+-\(k3d\s+completion\s+bash\)$'
      line: 'source <(k3d completion bash)'

  - name: Ensure zsh completion for k3d is configured
    lineinfile:
      path: ~/.zshrc
      state: present
      regexp: '^source\s+-\(k3d\s+completion\s+zsh\)$'
      line: 'source <(k3d completion zsh)'

  - name: Ensure fish completions for k3d is configured
    block:
      - name: Ensure fish completions directory exists
        ansible.builtin.file:
          path: ~/.config/fish/completions
          state: directory

      - name: Ensure fish completions for k3d is configured
        shell: k3d completion fish >> ~/.config/fish/completions/k3d.fish

  # As per `kubectl completion --help`

  - name: Ensure bash completions for kubectl is configured
    shell: kubectl completion bash > $(brew --prefix)/etc/bash_completion.d/kubectl

  # As per https://v1-20.docs.kubernetes.io/docs/tasks/tools/included/optional-kubectl-configs-zsh/

  - name: Ensure zsh completion for kubectl is configured
    lineinfile:
      path: ~/.zshrc
      state: present
      regexp: '^source\s+<\(kubectl\s+completion\s+zsh\)$'
      line: 'source <(kubectl completion zsh)'

  # There are no batteries included fish completions for kubectl, but @evanlucas maintains a project in regards.  Thank you @evanlucas.

  - name: Ensure fish completions for kubectl is configured
    ansible.builtin.shell: 'fish -c "fisher install evanlucas/fish-kubectl-completions"'
```

Each `task` and group of `task`s organized in a `block`s will be executed.

The `ansible-playbook` will execute the playbook across an inventory of hosts. For the class we have one single host and this is localhost, your host.

The contents of `hosts` file is in `ansible` folder and resembles

```
localhost ansible_host=localhost ansible_connection=local ansible_python_interpreter=$HOME/.pyenv/shims/python

[factory]
localhost
```

`localhost` is the alias of the host.

`ansible_host`, `ansible_connection` and `ansible_python_interpreter` are
behavioral inventory parameters used to control haw Ansible interacts with
the host.

`ansible_host` describes the name of the host to connect to.  This parameter is
redundant in this instance.

`ansible_connection` describes the connection type used to connect to the
host. In our case this set to `local`.

`ansible_python_interpreter` desribes the target host's python path.  We're
using the Python we configured via

Now that we've reviewed the playbook lets execute it via the  `ansible-playbook`
command

```sh
ansible-playbook -vvv -i hosts main.yaml
```

The `-vvv` parameter will output more verbose and so the output is a bit to
large to capture here, but the last few lines of the output  will resemble

```
TASK [Ensure fish completions for kubectl is configured] ***********************
task path: /Users/mjwalsh/Development/workspace/hands-on-DevOps-gen2/ansible/MacOSX.yaml:166
<localhost> ESTABLISH LOCAL CONNECTION FOR USER: mjwalsh
<localhost> EXEC /bin/sh -c 'echo ~mjwalsh && sleep 0'
<localhost> EXEC /bin/sh -c '( umask 77 && mkdir -p "` echo /Users/mjwalsh/.ansible/tmp `"&& mkdir "` echo /Users/mjwalsh/.ansible/tmp/ansible-tmp-1624174275.782391-45206-203459829769422 `" && echo ansible-tmp-1624174275.782391-45206-203459829769422="` echo /Users/mjwalsh/.ansible/tmp/ansible-tmp-1624174275.782391-45206-203459829769422 `" ) && sleep 0'
Using module file /Users/mjwalsh/.local/lib/python3.9/site-packages/ansible/modules/command.py
<localhost> PUT /Users/mjwalsh/.ansible/tmp/ansible-local-35909ogyaa6xi/tmpsr8xnzyg TO /Users/mjwalsh/.ansible/tmp/ansible-tmp-1624174275.782391-45206-203459829769422/AnsiballZ_command.py
<localhost> EXEC /bin/sh -c 'chmod u+x /Users/mjwalsh/.ansible/tmp/ansible-tmp-1624174275.782391-45206-203459829769422/ /Users/mjwalsh/.ansible/tmp/ansible-tmp-1624174275.782391-45206-203459829769422/AnsiballZ_command.py && sleep 0'
<localhost> EXEC /bin/sh -c '$HOME/.pyenv/shims/python /Users/mjwalsh/.ansible/tmp/ansible-tmp-1624174275.782391-45206-203459829769422/AnsiballZ_command.py && sleep 0'
<localhost> EXEC /bin/sh -c 'rm -f -r /Users/mjwalsh/.ansible/tmp/ansible-tmp-1624174275.782391-45206-203459829769422/ > /dev/null 2>&1 && sleep 0'
changed: [localhost] => {
    "changed": true,
    "cmd": "fish -c \"fisher install evanlucas/fish-kubectl-completions\"",
    "delta": "0:00:01.490587",
    "end": "2021-06-20 03:31:17.645862",
    "invocation": {
        "module_args": {
            "_raw_params": "fish -c \"fisher install evanlucas/fish-kubectl-completions\"",
            "_uses_shell": true,
            "argv": null,
            "chdir": null,
            "creates": null,
            "executable": null,
            "removes": null,
            "stdin": null,
            "stdin_add_newline": true,
            "strip_empty_ends": true,
            "warn": false
        }
    },
    "rc": 0,
    "start": "2021-06-20 03:31:16.155275",
    "stderr": "",
    "stderr_lines": [],
    "stdout": "\u001b[1mfisher install version 4.3.0\u001b(B\u001b[m\nFetching \u001b[4mhttps://codeload.github.com/evanlucas/fish-kubectl-completions/tar.gz/HEAD\u001b(B\u001b[m\nInstalling \u001b[1mevanlucas/fish-kubectl-completions\u001b(B\u001b[m\n           /Users/mjwalsh/.config/fish/completions/kubectl.fish\nUpdated 1 plugin/s",
    "stdout_lines": [
        "\u001b[1mfisher install version 4.3.0\u001b(B\u001b[m",
        "Fetching \u001b[4mhttps://codeload.github.com/evanlucas/fish-kubectl-completions/tar.gz/HEAD\u001b(B\u001b[m",
        "Installing \u001b[1mevanlucas/fish-kubectl-completions\u001b(B\u001b[m",
        "           /Users/mjwalsh/.config/fish/completions/kubectl.fish",
        "Updated 1 plugin/s"
    ]
}
META: ran handlers
META: ran handlers

PLAY RECAP *********************************************************************
localhost                  : ok=24   changed=6    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0

```

TODO: the rest of the content...
