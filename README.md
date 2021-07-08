# hands-on-devops-gen2

## Preface

The future home of the second edition of my hands-on DevOps course building upon [nemonik/hands-on-DevOps](https://github.com/nemonik/hands-on-DevOps).

The content of this course is presently under development.

This newest version of my Hands-on DevOps class is a replaitforming of sorts -- A sort of rewrite if you will. The prior version relied on multiple Vagrants and was a beast to maintain. Vagrants are virtual machines, when singular is abbreviated as "VM". Several Vagrants were created through automation to run a multi-node Kubernetes cluster as well asa development VM. The approach modeled how I preflighted my work on my laptop vice using [minikube](https://github.com/kubernetes/minikube). The Kubernetes cluster my class used made use of was [k3s](https://k3s.io/) and as it matured [k3d](https://k3d.io/) was introduced. K3d is a lightweight wrapper to run k3s in [Docker](https://docker.com) and provides a rather elegant solution to create and manage a single or multi-node k3s cluster for development vice standing up multi-VMs and the burden they impose on the host (in my case my laptop). Around this same time I was considerinf using k3d I gave [Docker Desktop's](https://www.docker.com/products/docker-desktop) means of providing a Kubernetes cluster a try, but I found it lacking, so I stuck with k3d. Around this same time I also moved fully off my MacBook for personal development moving to [Arch Linux](https://archlinux.org/) where I used [docker-ce](https://github.com/docker/docker-ce). This new version of my class infrastructure-as-code automation focuses instead of directly configuring the host or if need be a single Vagrant for the purpose of development.

# DevOps

A hands-on DevOps course covering the culture, methods and repeated practices of modern software development involving Vagrant, VirtualBox, Ansible, Kubernetes, k3s, k3d, Traefik, Docker-Compose, Docker, Taiga, GitLab, Drone CI, SonarQube, Selenium, InSpec, Heimdall, Arch Linux...

A reveal.js presentation written to accompany this course can found at [https://nemonik.github.io/hands-on-DevOps/](https://nemonik.github.io/hands-on-DevOps/).

This course will

1. Discuss DevOps,
2. Have you spin up a DevOps toolchain and development environment, and then
3. Author two applications and their accompanying pipelines, the first a continuous integration (CI) and the second a continuous delivery (CD) pipeline.

After this course, you will

1. Be able to describe and have hands-on experience DevOps methods and repeated practices (e.g., use of Agile methods, configuration management, build automation, test automation and deployment automation orchestrated under a CICD orchestrator), and why it matters;
2. Address challenges transitioning to DevOps methods and repeated practices;
3. Have had hands-on experience infrastructure-as-code to provision and configure an entire DevOps Factory (i.e. a toolchain and development environment) including Docker Registry, a Kubernetes cluster, Taiga, GitLab, Drone CI, SonarQube, Heimdall;
4. Have had hands-on experience authoring code to include authoring and running automated tests in a CICD pipeline all under Configuration Management to ensure an application follows style, adheres to good coding practices, builds, identify security issues, and functions as expected;
5. Have had hands-on experience with
   1. using Infrastructure as Code (IaC) in Vagrant and Ansible;
   2. creating and using Kanban board in Taiga;
   3. code configuration in git and GitLab;
   4. authoring code in Go;
   5. using style checkers and linters;
   6. authoring a Makefile;
   7. various commands in Docker (e.g., building a container image, pushing a container into a registry, creating and running a container);
   8. authoring a pipeline for Drone CI;
   9. using Sonar Scanner CLI to perform static analysis;
   10. authoring security test in InSpec;
   11. author an automated functional test in Selenium;
   12. authoring a dynamic security test in OWASP Zap; and
   13. using container platform to author and scale services;
6. Have had hands-on experience authoring code to include authoring and running automated tests in a CICD pipeline all under Configuration Management to ensure an application follows style, adheres to good coding practices, builds, identify security issues, and functions as expected.

We will be spending most of the course hands-on working with the tools and in the Unix command line making methods and repeated practices of DevOps happen, so as to grow an understanding of how DevOps actually works. Although, not necessary I would encourage you to pick up a free PDF of [The Linux Command Line by William Shotts](http://linuxcommand.org/tlcl.php) if you are no familiar wit the Linux command line.

Don't fixate on the tools used, nor the apps we develop in the course of learning how and why. How and why is far more important. This course like DevOps is not about tools although we'll be using them. You'll spend far more time writing code. (Or at the very least cutting-and-pasting code.)

# Author

- Michael Joseph Walsh [mjwalsh@mitre.org](mailto:mjwalsh@mitre.org), [walsh@nemonik.com](mailto:walsh@nemonik.com)

# Copyright and license

See the [License file](LICENCE) at the root of this project.

# Prerequisites

The supported host operating systems for this class are OSX, Windows 11 and Arch Linux. By "host operating system", I mean the computer you will use to work the class.

## Manual inspection

It's a good idea to inspect the install scripts from projects you don't yet know. You can do that now by tromping around the projet on GitHub. The project makes use of a Makefile, several Bash scripts, Vagrant and Ansible code. Looking through everything before you run it. If you dork up your host this was never my intention, but I've made every effort to prevent this from happening.

## Shell configuration

The class automation will configure Bash, Zsh and [fish](https://github.com/neovim/neovim) shells, as well as [neovim](https://github.com/neovim/neovim) (nvim). A Unix shell is a command-line iterpreter, a command-line interface for the Unix or Unix-like operating systems, such as Linux. The shell exists in a terminal emulator. In this course we will either be [iTerm2](https://iterm2.com/) for OSX or Arch Linux' terminal interface.

If you are on OSX and already have iTerm2 installed open a terminal window or use OSX built-in Terminal application by searching for "Terminal".

If you have spent considerable time configuring your chosen shell, neovim editor, etc it is advisable to back up your configuration by peforming the following in the shell:

**NOTE**

- This class will link to an application, tool, library, etc's canonical git repository whenever possible.
- This class makes use of **NOTE** sections to call out things that are important to know or to drop a few tidbits. Reading these notes may save you some aggravation.

```sh
cp ~/.bash_profile ~/.bash_profile.orig
cp ~/.zshrc ~/.zshrc.orig
cp ~/.config/fish/config.fish ~/.config/fish/config.fish.orig
cp ~/.config/nvim/init.vim ~/.config/nvim/init.vim.orig
cp ~/.config/nvim/coc-settings.json ~/.config/nvim/coc-settings.json.orig
```

On or more of the above commands may fail if you don't have the files on your host. If you are sure you typed the command correctly you can ignore the error

Now, we're going to to reset our configuration by performing the following

```sh
rm ~/.bash_profile
rm ~/.zshrc
rm ~/.config/fish/config.fish
rm ~/.config/nvim/init.vim
rm ~/.config/nvim/coc-settings.json
```

## Installing upfront dependencies

You will need to install a number of upfront dependencies.

## OS X or Windows 11, install Docker Desktop

If your host (e.g., your laptop, personal computer) is running Windows 10 or OSX you will need to install Docker Desktop. If you're using Arch Linux, the Ansible automation will take care of installing Docker for you and you can skip ahead to installing Ansible. If you are using a version of Linux other than Arch then what's wrong with you? I'm kidding. You can use the Vagrant to execute the factory.

This class will use Docker and so Docker Desktop must be installed and configured.

### On OSX install Docker Desktop

If you're on an OSX host perform the following:

1. Download https://www.docker.com/products/docker-desktop
2. Drag the Docker app to your Application folder.
3. Find the Docker app in your applications folder and click to start the application.
4. You will need to verify that you want to trust the application by clicking
   `Open`.
5. The Docker Engine, actually a virtual machine (VM), will take sometime to start. You will then be asked to deny or accept `com.docker.backend` from accepting incoming network connections. Click `Allow`.
6. Find docker icon on the right side of your Apple menu bar and click and then
   select `preferences` from the menu.
7. In the `docker` window that opens, select the gear icon in the upper-right
   portion of the window.
8. Under `General` make sure `Start Docker Desktop when you log in` is checked
   off otherwise you will need to start docker everytime you restart your
   host.
9. Then select `Resources` on the left-hand side of the window.
10. As Docker runs its containers in a virtual machine, you will need to give this VM more processing power and host memory to run heavier container load. What you give the Docker Desktop VM is dependent on two factors the resources your host can spare and the load the class containers will place on your host. I'd advise trying 8 CPUs and 12 GBs of memory and scale as you see fit.
11. Click `Apply and Restart` to restart the Docker Desktop VM. The VM will take some amount of time to restart. The containers on the back of the whale icon (Moby Dock) will cycle the Apple Menu Bar will cycle until Docker is ready.

### On Windows install Docker Desktop

To be completed, but until such time make sure to select the default option to install the WSL2 components is selected.

Skip ahead to installing the software factory.

### On Arch Linux

Docker will be installed for you via the Ansible automation. More on Ansible later.

## On OSX install iTerm2

If your using an OSX host, you can use Apple's default Terminal app for command line terminal, but I'd advise you to install the superior iTerm2.

Perform the following tasks:

1. Download the latest release from

   [https://iterm2.com/downloads/stable/latest](https://iterm2.com/downloads/stable/latest)

2. Find the iTerm release zip file in your Downloads folder and double click.
3. Drag the iTerm app to your Application folder to install.
4. You will need to verify that you want to trust the application by clicking `Open`.
5. Use iTerm2 to perform the remaining command line tasks for this class.

# Installing the software factory

This class uses a software factory hosted on a Kubernetes cluster. To spin up the k8s cluster you will need to perform the following tasks in the command line.

## Ansible

The class uses [Ansible](https://github.com/ansible/ansible) to install operating systems dependencies necessary for the class.

Ansible is a "configuration management" tool that automates software provisioning, configuration management and application deployment, two core repeated practices in DevOps, so for the class Ansible addresses this concern in the configuration of either your host operating system or a VM, if you've chosen to execute the class from a Vagrant.

Ansible was open-sourced and then later subsumed by Red Hat.

There are other notable open-source "configuration management" tools, such as [Chef](https://github.com/chef/chef) and [Puppet](https://github.com/chef/chef). Further, still there are others, such as [BOSH](https://github.com/cloudfoundry/bosh) and [Salt](https://github.com/saltstack/salt), but they hold little or no community of practice or market share.

In his seminal essay, "The Cathedral and the Bazaar", Eric S. Raymond states

> while coding remains an essentially solitary activity, the really great hacks
> come from harnessing the attention and brainpower of entire communities
>
> You want to leverage the work of vibrate community and not some back water
> effort.

In Ansible, one defines [playbooks](https://docs.ansible.com/ansible/latest/user_guide/playbooks.html) to declaratively state desired configuration of a host. Yes, utilizing declarative programming vice imperative programming. With declarative programming your code essentially describes what you want, but not how to get what you want. With imperative programming, ones' code states what you want to happen step-by-step. The class will makes use of Ansible, Kubernetes resource files and Helm charts to declare the desired end-state. These will be unpacked later in the class material. The truth is the two are often intermixed. Your Ansible playbooks can be a mix of declarative and imperative programming. One strives for the former rather than the later.

Each Ansible playbook is written in a [YAML](https://yaml.org/)-based DSL (domain specific language) following the [ansible-playbook schema](https://json.schemastore.org/ansible-playbook.json) enumerating all the tasks to be performed.

The playbooks for this class are located in the [ansible/](./ansible/) project sub-folder

```
ansible/
├── common.yaml
├── files
│   ├── coc-settings.json
│   └── init.vim
├── go.yaml
├── inspec.yaml
├── inventory.yaml
├── main.yaml
├── neovim.yaml
├── package.json
├── pyenv.yaml
├── ruby.yaml
└── sonar-scanner-cli.yaml
```

Each playbook is responsible for a unit of configuration. [ansible/files/](./ansible/files/) contains a number of files copied into the userspace to configure the [neovim](https://github.com/neovim/neovim) editor.

It also possible to collect these tasks into a collection referred to as a `role`. This class presently doesn't make use of roles.

### Installing Ansible

The following sub-sections detail how to install Ansible. Skip to the section that applies to your host.

If your host is running

- OSX drop to [Installing Xcode Command Line Tools.
- Windows drop to (TODO: complete.)
- Linux drop to (TODO: complete.)

### On OSX, install the Xcode Command Line tools

I prefer to install the Xcode Command Line tools myself, but you could skip this step and have HomeBrew install it for you.

1. In iTerm2 enter the following into the commmand line.

   ```sh
   xcode-select --install
   ```

   It is possible your host may already have the Xcode Command Line Tools installed and will be immediately told so if this is the case skip to the next section

2. A dialog will pop on the screen asking if you'd like to install the command line developer tools. Click `Install`.
3. You will then be presented a License Agreement. After consulting your lawyer, click `Agree`.
4. Wait fo the download and install to complete, then click `Done`.

### On OSX, install HomeBrew

Homebrew is as the project refers to itself, "The Missing Package Manager for macOS." These days the project also tacks on "(or Linux)". Package managers A package manager automates the process of installing, upgrading, configuring, and removing binaries from an operating system.

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

### All hosts, Add `/usr/local/bin` to your PATH

First determine what shell you are using by performing the following in the
command line

```sh
echo $SHELL
```

The default shell in OS X is now `zsh`, so it is likely you are using `zsh`. If you are then perform the following in the shell

```sh
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

If your shell is `bash` perform the following

```sh
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
```

If you're using `fish` perform the following

```sh
echo "set -U fish_user_paths /usr/local/bin $fish_user_paths" >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish
```

The `source` command in each of the above will apply the changes in your current shell.

### Install Ansible

Ansible is based on [Python](https://www.python.org/) ans distributed as a Python module that you can install by [pip](https://pip.pypa.io). Pip refers to itself as "the package installer for Python". There are [others](https://packaging.python.org/guides/tool-recommendations/), but most everyone uses pip.

In the command line perform the following task:

Type the following

```sh
python3 -m pip install --user ansible
```

This will install the ansible module into the Python user install directory for your platform. Typically into the `.local/` sub-folder of the user's home directory.

Output will resemble

```
⋊> ~ python3 -m pip install --user ansible
Collecting ansible
  Downloading ansible-4.2.0.tar.gz (35.0 MB)
     |████████████████████████████████| 35.0 MB 6.0 MB/s
Collecting ansible-core<2.12,>=2.11.2
  Downloading ansible-core-2.11.2.tar.gz (7.1 MB)
     |████████████████████████████████| 7.1 MB 2.1 MB/s
Collecting jinja2
  Downloading Jinja2-3.0.1-py3-none-any.whl (133 kB)
     |████████████████████████████████| 133 kB 13.8 MB/s
Collecting PyYAML
  Downloading PyYAML-5.4.1-cp39-cp39-manylinux1_x86_64.whl (630 kB)
     |████████████████████████████████| 630 kB 2.8 MB/s
Collecting cryptography
  Downloading cryptography-3.4.7-cp36-abi3-manylinux2014_x86_64.whl (3.2 MB)
     |████████████████████████████████| 3.2 MB 3.1 MB/s
Collecting packaging
  Downloading packaging-21.0-py3-none-any.whl (40 kB)
     |████████████████████████████████| 40 kB 9.6 MB/s
Collecting resolvelib<0.6.0,>=0.5.3
  Downloading resolvelib-0.5.4-py2.py3-none-any.whl (12 kB)
Collecting cffi>=1.12
  Downloading cffi-1.14.5-cp39-cp39-manylinux1_x86_64.whl (406 kB)
     |████████████████████████████████| 406 kB 4.0 MB/s
Collecting pycparser
  Downloading pycparser-2.20-py2.py3-none-any.whl (112 kB)
     |████████████████████████████████| 112 kB 3.0 MB/s
Collecting MarkupSafe>=2.0
  Downloading MarkupSafe-2.0.1-cp39-cp39-manylinux2010_x86_64.whl (30 kB)
Collecting pyparsing>=2.0.2
  Downloading pyparsing-2.4.7-py2.py3-none-any.whl (67 kB)
     |████████████████████████████████| 67 kB 3.4 MB/s
Using legacy 'setup.py install' for ansible, since package 'wheel' is not installed.
Using legacy 'setup.py install' for ansible-core, since package 'wheel' is not installed.
Installing collected packages: pycparser, pyparsing, MarkupSafe, cffi, resolvelib, PyYAML, packaging, jinja2, cryptography, ansible-core, ansible
    Running setup.py install for ansible-core ... done
    Running setup.py install for ansible ... done
Successfully installed MarkupSafe-2.0.1 PyYAML-5.4.1 ansible-4.2.0 ansible-core-2.11.2 cffi-1.14.5 cryptography-3.4.7 jinja2-3.0.1 packaging-21.0 pycparser-2.20 pyparsing-2.4.7 resolvelib-0.5.4
```

In order to use the paramiko connection plugin or modules that require paramiko, install paramiko

```sh
python3 -m pip3 install --user paramiko
```

Output will resemble

```
⋊> ~ python3 -m pip install --user paramiko
Collecting paramiko
  Downloading paramiko-2.7.2-py2.py3-none-any.whl (206 kB)
     |████████████████████████████████| 206 kB 1.7 MB/s
Collecting bcrypt>=3.1.3
  Downloading bcrypt-3.2.0-cp36-abi3-manylinux2010_x86_64.whl (63 kB)
     |████████████████████████████████| 63 kB 1.5 MB/s
Requirement already satisfied: cryptography>=2.5 in /home/nemonik/.local/lib/python3.9/site-packages (from paramiko) (3.4.7)
Collecting pynacl>=1.0.1
  Downloading PyNaCl-1.4.0-cp35-abi3-manylinux1_x86_64.whl (961 kB)
     |████████████████████████████████| 961 kB 4.2 MB/s
Requirement already satisfied: cffi>=1.1 in /home/nemonik/.local/lib/python3.9/site-packages (from bcrypt>=3.1.3->paramiko) (1.14.5)
Collecting six>=1.4.1
  Downloading six-1.16.0-py2.py3-none-any.whl (11 kB)
Requirement already satisfied: pycparser in /home/nemonik/.local/lib/python3.9/site-packages (from cffi>=1.1->bcrypt>=3.1.3->paramiko) (2.20)
Installing collected packages: six, pynacl, bcrypt, paramiko
Successfully installed bcrypt-3.2.0 paramiko-2.7.2 pynacl-1.4.0 six-1.16.0
```

Ansible is now installed in your home directory in `$HOME/.local/bin` path, where is `$HOME` is an environment variable holding the path to your home directory.

But if you enter the following into the shell

```sh
which ansible-playbook
```

the output will likely be

```
ansible-playbook not found
```

The [`which`](https://linux.die.net/man/1/which) command will attempt to locate a program file in the user's path.

If you are using `bash` perform the following:

```sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bash_profile
source ~/.bash_profile
```

If your shell is `zsh`:

```sh
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

If you're using `fish`:

```sh
echo 'set -U fish_user_paths $HOME/.local/bin $fish_user_paths' >> ~/.config/fish/config.fish
source ~/.config/fish/config.fish
```

to add the Ansible executables to your path. The `PATH` environment variable is a list of directories that your shell searches through when you enter a command.

Not that we updated our `PATH` and sourced our shell configuratiion thereby updating our present shell we can verify `ansible` has been installed via

```sh
ansible-playbook --version
```

Output will resemble

```
⋊> ~ ansible-playbook --version
ansible-playbook [core 2.11.2]
  config file = None
  configured module search path = ['/home/nemonik/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /home/nemonik/.local/lib/python3.9/site-packages/ansible
  ansible collection location = /home/nemonik/.ansible/collections:/usr/share/ansible/collections
  executable location = /home/mjwalnemonik/.local/bin/ansible-playbook
  python version = 3.9.5 (default, Jul  5 2021, 10:39:40) [GCC 11.1.0]
  jinja version = 3.0.1
  libyaml = True
```

Let's test to see if Ansible works on our host by executing

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

The fact that `ping` returns `pong` indicates Ansible has been installed correctly.

You will need to perform the following in the shell to add [community.general](https://galaxy.ansible.com/community/general) Ansible module from [Ansible Galaxy](https://galaxy.ansible.com/), Ansible’s official hub for sharing Ansible content.

For example, on an OSX host, we'll need this to install `brew` packages and for Arch Linux we'll need this to install operating systems package via [pacman](https://wiki.archlinux.org/title/Pacman) package manager.

```sh
ansible-galaxy collection install community.general
```

Successful output should resemble

```
⋊> ~ ansible-galaxy collection install community.general
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Downloading https://galaxy.ansible.com/download/community-general-3.3.1.tar.gz to /home/nemonik/.ansible/tmp/ansible-local-1333943849hwygv/tmplq_el1ud/community-general-3.3.1-d99hf7_o
Installing 'community.general:3.3.1' to '/home/nemonik/.ansible/collections/ansible_collections/community/general'
community.general:3.3.1 was installed successfully
```

## Run the Ansible playbook

The rest of the class will require a number of operating system dependencies be installed. We will accomplish the via executing the [ansible/main.yaml](ansible/main.yaml) playbook.

First we will need to [git clone](https://git-scm.com/docs/git-clone) the class repository by performing the following in your shell

```sh
mkdir -p $HOME/Development/workspace
cd $HOME/Development/workspace
git clone https://github.com/nemonik/hands-on-DevOps-gen2.git
```

Enter the project's [ansible/](./ansible) sub-folder

```sh
cd ansible
```

### Review the class Ansible playbook

If you haven't reviewed the playbook, now is a good time to do so.

The `ansible-playbook` command will execute a series of playbooks across an inventory of hosts. For the class we have just one host and this is `localhost`, your host.

The contents of `inventory.yaml` file is in `ansible` folder written in [YAML](https://yaml.org/) following [Ansible Inventory shema](https://json.schemastore.org/ansible-inventory.json) and resembles

```
all:
  children:
    factory:
      hosts:
        localhost:
          ansible_connection: local
          ansible_host: localhost
          ansible_python_interpreter: /usr/bin/python3
      vars:
        default_delay: 10
        default_retries: 60
        ruby_version: 3.0.1
        supported_host_os:
          - MacOSX
          - Archlinux
    ungrouped: {}
```

Where

- `factory` is a group name used in classifying hosts.
- `localhost` is the alias for your host.
- `ansible_host`, `ansible_connection` and `ansible_python_interpreter` are behavioral inventory parameters used to control haw Ansible interacts with your host.
  - `ansible_host` describes the name of the host to connect to. This parameter is redundant in this instance.
  - `ansible_connection` describes the connection type used to connect to the host. In our case this set to `local`. Another type would be `ssh` if the host was remote.
  - `ansible_python_interpreter` describes the target host's python path. Python is "batteries included" on OSX and will be found on Arch Linux.
- `vars` describes a number of variables uses across the playbooks: `default_delay`, `default_retries`, `ruby_version` and `supported_host_os`.
  - `default_delay` sets the number of seconds to delay between retries.
  - `default_retries` sets the number times a task will be retried before Ansible gives up.
  - `ruby_version` sets the ruby version to install, and
  - `supported_host_os` is a list of supported operating systems.

A playbook is composed of one or more _plays_ in an ordered list, where plays are executed in order from top to bottom. Most Ansible modules (also referred to as “task plugins” or “library plugins”) check whether the desired state has already been achieved and the playbook will move on without performing any actions once the desired state has been achieved. This is refered to as being _idempotent_.

Let's look at the [ansible/main.yaml](./ansible/main.yaml) playbook.

```
---
- name: Install factory dependencies
  hosts: factory
  tasks:
    - name: Echo ansible distribution
      ansible.builtin.debug:
        msg: "{{ inventory_hostname }} host is running {{ ansible_distribution }}:{{ ansible_distribution_release }} with an IP address if {{ ansible_default_ipv4.address }}"

    - name: Fail if OS is not MacOSX or ArchLinux
      ansible.builtin.fail:
        msg: "{{ ansible_distribution }} - {{ ansible_distribution_release }} is not MacOSX or ArchLinux"
      when: ansible_distribution not in supported_host_os
```

The lines above name the playbook and state the group name (in this case `factory` correlated with the inventory) this playbook will be applied to. Followed by two tasks that will be executed.

The first task, `ansible.builtin.debug` is used for debugging purposes. The second, `ansible.builtin.fail` tests whether or not the host is supported.

We can retrieve the documentation for both in the shell via using the [`ansible-doc`](https://docs.ansible.com/ansible/latest/cli/ansible-doc.html) command. For example, if we enter

```sh
ansible-doc ansible.builtin.debug
```

into the shell, it will return

```
> ANSIBLE.BUILTIN.DEBUG    (/Users/nemonik/.local/lib/python3.9/site-packages/ansible/modules/debug.py)

        This module prints statements during execution and can be useful for debugging variables or
        expressions without necessarily halting the playbook. Useful for debugging together with the
        'when:' directive. This module is also supported for Windows targets.

  * note: This module has a corresponding action plugin.

OPTIONS (= is mandatory):

- msg
        The customized message that is printed. If omitted, prints a generic message.
        [Default: Hello world!]
        type: str

- var
        A variable name to debug.
        Mutually exclusive with the `msg' option.
        Be aware that this option already runs in Jinja2 context and has an implicit `{{ }}' wrapping,
        so you should not be using Jinja2 delimiters unless you are looking for double interpolation.
        [Default: (null)]
        type: str

- verbosity
        A number that controls when the debug is run, if you set to 3 it will only run debug when -vvv
        or above.
        [Default: 0]
        type: int
        version_added: 2.1
        version_added_collection: ansible.builtin


NOTES:
      * This module is also supported for Windows targets.


SEE ALSO:
      * Module ansible.builtin.assert
           The official documentation on the ansible.builtin.assert module.
           https://docs.ansible.com/ansible/2.11/modules/ansible.builtin.assert_module.html
      * Module ansible.builtin.fail
           The official documentation on the ansible.builtin.fail module.
           https://docs.ansible.com/ansible/2.11/modules/ansible.builtin.fail_module.html


AUTHOR: Dag Wieers (@dagwieers), Michael DeHaan

VERSION_ADDED_COLLECTION: ansible.builtin

EXAMPLES:

- name: Print the gateway for each host when defined
  ansible.builtin.debug:
    msg: System {{ inventory_hostname }} has gateway {{ ansible_default_ipv4.gateway }}
  when: ansible_default_ipv4.gateway is defined

- name: Get uptime information
  ansible.builtin.shell: /usr/bin/uptime
  register: result

- name: Print return information from the previous task
  ansible.builtin.debug:
    var: result
    verbosity: 2

- name: Display all variables/facts known for a host
  ansible.builtin.debug:
    var: hostvars[inventory_hostname]
    verbosity: 4

- name: Prints two lines of messages, but only if there is an environment value set
  ansible.builtin.debug:
    msg:
    - "Provisioning based on YOUR_KEY which is: {{ lookup('env', 'YOUR_KEY') }}"
    - "These servers were built using the password of '{{ password_used }}'. Please retain this for later use."
```

And the playbook continues on to importing and executing each of the following playbooks

```ansible
- name: Ensure common dependencies are installed
  ansible.builtin.import_playbook: common.yaml

- name: Ensure pyenv is installed and configured
  ansible.builtin.import_playbook: pyenv.yaml

- name: Ensure Go is installed and configured
  ansible.builtin.import_playbook: go.yaml

- name: Ensure sonar-scanner cli is installed and configured
  ansible.builtin.import_playbook: sonar-scanner-cli.yaml

- name: Ensure rvm and ruby {{ ruby_version }} is installed
  ansible.builtin.import_playbook: ruby.yaml

- name: Ensure InSpec is installed
  ansible.builtin.import_playbook: inspec.yaml

- name: Ensure neovim is installed and configured
  ansible.builtin.import_playbook: neovim.yaml
```

I'd encourage you to review them all, but lets look at a portion of the first to be imported and executed, the [ansible/common.yaml](./ansible/common.yaml) playbook

```ansible
---
- name: Ensure common dependencies are installed
  hosts: factory
```

Again, the playbook is named and states the group name this playbook will be applied to.

```ansible
  tasks:
    - name: Set fact for $HOME
      ansible.builtin.set_fact:
        HOME: "{{ lookup('env', 'HOME') }}"
```

Followed in by executing a number of tasks. The first being to create a fact to hold the HOME environment variable.

```ansible
    - name: When MacOSX ensure Homebrew packages are installed
      block:
        - name: Update homebrew and upgrade all packages
          community.general.homebrew:
            update_homebrew: yes
            upgrade_all: yes

        - name: Check if /usr/local/Cellar/bash-completion exists
          ansible.builtin.stat:
            path: /usr/local/Cellar/bash-completion
          register: bash_completion

        - name: Ensure bash-completion is not installed, so bash-completion@2 can be installed
          ansible.builtin.shell: brew unlink bash-completion
          when: bash_completion.stat.exists

        - name: Ensure HomeBrew packages are installed
          community.general.homebrew:
            name:
              - bash
              - bash-completion@2
              - zsh
              - zsh-completion
              - fish
              - vim
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
              - tmux
              - yamllint
              - jq
              - tree
              - htop
              - pyenv
            state: latest
          retries: "{{ default_retries }}"
          delay: "{{ default_delay }}"
          register: result
          until: result is succeeded

        - name: Get HOMEBREW_PREFIX
          block:
            - name: Execute brew --prefix
              ansible.builtin.shell: brew --prefix
              register: brew_prefix

            - name: Create brew_fact with stdout of of prior command
              ansible.builtin.set_fact:
                HOMEBREW_PREFIX: "{{ brew_prefix.stdout }}"
      when: ( ansible_distribution == 'MacOSX' )
```

First, the `when` condition will be evaluated to determine if the host to be "ansible-ized" is running OSX before Ansible runs each of the tasks in the block.

The block collects the following tasks:

1. `community.general.homebrew` is used to update the host's installed packages,
2. `ansible.builtin.stat` checks and holds in a register where or not the `/usr/local/Cellar/bash-completion` path exists on the host.
3. `ansible.builtin.shell` executes `brew` to unlink `bash-completion` thereby ensuring the the wrong `bash-completions` package is not installed, but only if the path had been found.
4. `community.general.homebrew` tries repeatedly to install a list of HomeBrew packages until they're installed or the maximum number of retries are reached.
5. A sub-block ends out the run with
   1. `ansible.builtin.shell` executing `brew --prefix` and storing the result in a register
   2. `ansible.builtin.set_fact` is used to hold the standard output (stdout) of `brew--prefix` command in a Ansible fact, `HOMEBREW_PREFIX`.

The [ansible/common.yaml](./ansible/common.yaml) playbook continues until completion and then you are returned to the [ansible/main.yaml](./ansible/main.yaml) to execute the next playbook. I'd encourage you to review each.

If your on LinkedIn or search many of the job boards you'll find many employers equate infrastructure-as-code as DevOps. Infrastructure-as-code is a DevOps methodology but not the entirety of DevOps.

Now that we've reviewed the playbook lets execute it via the `ansible-playbook` command

```sh
ansible-playbook -vvv -i hosts main.yaml
```

The `-vvv` optional argument will output verbose output. You can strip off this argument and the output will be succinct. As is the output is a bit to large to capture here, so I've only capture the last few lines of the output below. I will resemble

```
<localhost> EXEC /bin/sh -c '( umask 77 && mkdir -p "` echo /Users/mjwalsh/.ansible/tmp `"&& mkdir "` echo /Users/mjwalsh/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439 `" && echo ansible-tmp-1625702462.673148-73856-255765969896439="` echo /Users/mjwalsh/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439 `" ) && sleep 0'
Using module file /Users/mjwalsh/.local/lib/python3.9/site-packages/ansible/modules/lineinfile.py
<localhost> PUT /Users/mjwalsh/.ansible/tmp/ansible-local-27240d5jcmaum/tmp50wpeyk8 TO /Users/mjwalsh/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439/AnsiballZ_lineinfile.py
<localhost> EXEC /bin/sh -c 'chmod u+x /Users/mjwalsh/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439/ /Users/mjwalsh/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439/AnsiballZ_lineinfile.py && sleep 0'
<localhost> EXEC /bin/sh -c '/usr/bin/python3 /Users/mjwalsh/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439/AnsiballZ_lineinfile.py && sleep 0'
<localhost> EXEC /bin/sh -c 'rm -f -r /Users/mjwalsh/.ansible/tmp/ansible-tmp-1625702462.673148-73856-255765969896439/ > /dev/null 2>&1 && sleep 0'
changed: [localhost] => (item={'line': 'set -U fish_user_paths $HOME/.local/bin $fish_user_paths'}) => {
    "ansible_loop_var": "item",
    "backup": "",
    "changed": true,
    "diff": [
        {
            "after": "",
            "after_header": "/Users/mjwalsh/.config/fish/config.fish (content)",
            "before": "",
            "before_header": "/Users/mjwalsh/.config/fish/config.fish (content)"
        },
        {
            "after_header": "/Users/mjwalsh/.config/fish/config.fish (file attributes)",
            "before_header": "/Users/mjwalsh/.config/fish/config.fish (file attributes)"
        }
    ],
    "invocation": {
        "module_args": {
            "attributes": null,
            "backrefs": false,
            "backup": false,
            "create": false,
            "dest": "/Users/mjwalsh/.config/fish/config.fish",
            "firstmatch": false,
            "group": null,
            "insertafter": "EOF",
            "insertbefore": null,
            "line": "set -U fish_user_paths $HOME/.local/bin $fish_user_paths",
            "mode": null,
            "owner": null,
            "path": "/Users/mjwalsh/.config/fish/config.fish",
            "regexp": null,
            "search_string": null,
            "selevel": null,
            "serole": null,
            "setype": null,
            "seuser": null,
            "state": "present",
            "unsafe_writes": false,
            "validate": null
        }
    },
    "item": {
        "line": "set -U fish_user_paths $HOME/.local/bin $fish_user_paths"
    },
    "msg": "line added"
}
META: ran handlers
META: ran handlers

PLAY RECAP ******************************************************************************************************************************************************************************
localhost                  : ok=135  changed=65   unreachable=0    failed=0    skipped=34   rescued=0    ignored=1
```

If `failed ` is something other than `0` then you have an issue to debug. Debuging will require you to review the task that resulted in the failure likely the last task run. Review the output, determine what playbook you were in, open and review the playbook and the offending task and then try the equivalent in the command line to debug the issue. The host may be in a state the playbook cannot handle. Perhaps a dependency is missing. Perhaps. Perhaps. Perhaps.

### On OSX, enable nerd fonts in XTerm2

To complete the configuration for OS X hosts configure XTerm2 to use `Meslo Nerd Font` and use `Solarized Dark` color them. Optionally, you can install your own [Nerd font](https://www.nerdfonts.com/font-downloads).

1. Open iTerm2's `Preferences`.
2. In the `Preference` window that opens, select `Profile`.
3. In the `Default` profile, select `Text`.
4. In the `Text` profile, select `from the`Font` pannel.
5. Optionally, check off `Use ligatures`.
6. In the `Preferences` window, select `Color`.
7. Click `Color Preserts...` and select `Solarized Dark`.
8. Close the `Preference` windows, and re-start your terminal window for your changes to take effect.

TODO: the rest of the content...
