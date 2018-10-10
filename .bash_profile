source ~/.profile

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

# Enable tab completion for git commands
# See tips and tricks here: https://git-scm.com/book/en/v1/Git-Basics-Tips-and-Tricks
# Must create 'git-completion.bash' file from https://github.com/git/git/blob/master/contrib/completion/git-completion.bash
source /usr/local/etc/bash_completion.d/git-completion.bash

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Check to see if the ssh-agent process is running
ps cax | grep ssh-agent
if [ $? -eq 0 ]; then
  #pink text
  tput setaf 198;
  echo "SSH Agent is already running.";
  #reset text color
  tput sgr0;
else
  # Start the ssh-agent process if it is not already
  eval "$(ssh-agent -s)";
  ssh-add -K ~/.ssh/id_rsa;
  #pink text
  tput setaf 198;
  echo "SSH Agent has started.";
  #reset text color
  tput sgr0;
fi
