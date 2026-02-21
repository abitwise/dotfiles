# Add /usr/local/sbin to path
export PATH=/usr/local/sbin:$PATH;

# Add ~/.local/bin to path
export PATH="$HOME/.local/bin:$PATH";

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

# Add Python 3 bins to path
export PATH="$HOME/Library/Python/3.6/bin:$PATH";

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
if which brew &> /dev/null && [ -r "$(brew --prefix)/etc/profile.d/bash_completion.sh" ]; then
	# Ensure existing Homebrew v1 completions continue to work
	export BASH_COMPLETION_COMPAT_DIR="$(brew --prefix)/etc/bash_completion.d";
	source "$(brew --prefix)/etc/profile.d/bash_completion.sh";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

# Python environment for Mac
#VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3;
#export WORKON_HOME=$HOME/.virtualenvs;
#export PROJECT_HOME=$HOME/dev;
#source /usr/local/bin/virtualenvwrapper.sh;

# Mac OS change max open files limit (first 4 lines are one-time)
# echo kern.maxfiles=65536 | sudo tee -a /etc/sysctl.conf
# echo kern.maxfilesperproc=65536 | sudo tee -a /etc/sysctl.conf
# sudo sysctl -w kern.maxfiles=65536
# sudo sysctl -w kern.maxfilesperproc=65536
ulimit -n 65536 65536;

# Increase Node.js threadpool size
export UV_THREADPOOL_SIZE=1024

# Go lang
export GOPATH=$HOME/dev/go

# NVM things
# export NVM_DIR="$HOME/.nvm"
# . "/usr/local/opt/nvm/nvm.sh"

# Homebrew
eval $(/opt/homebrew/bin/brew shellenv)

# Add gettext to path
export PATH="/usr/local/opt/libiconv/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/libiconv/lib"
export CPPFLAGS="-I/usr/local/opt/libiconv/include"

# Set language to US English
export LC_ALL=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# Android Studio stuff
export PATH="${HOME}/Library/Android/sdk/tools:${HOME}/Library/Android/sdk/platform-tools:${PATH}"

# Bun.js (bun.sh)
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Java
export JAVA_23_HOME="/opt/homebrew/opt/openjdk@23/"
export JAVA_25_HOME="/opt/homebrew/opt/openjdk@25/"

export JAVA_23_CPPFLAGS='echo "-I"$JAVA_23_HOME"include"'
export JAVA_25_CPPFLAGS='echo "-I"$JAVA_25_HOME"include"'

alias java23='export JAVA_HOME=$JAVA_23_HOME'
alias java25='export JAVA_HOME=$JAVA_25_HOME'

alias java23flags='export CPPFLAGS=$JAVA_23_CPPFLAGS'
alias java25flags='export CPPFLAGS=$JAVA_25_CPPFLAGS'

# Set default java to Java 25
export JAVA_HOME=$JAVA_25_HOME
export CPPFLAGS='echo "-I"$JAVA_25_HOME"include"'
export PATH=$PATH:$JAVA_HOME/bin

# Added by flyctl installer
export FLYCTL_INSTALL="/Users/olgeroeselg/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
