DOTFILES="$HOME/.dotfiles"
DOTFILES_REPO="git@github.com:pochemuto/dotfiles.git"

dots-status() {
  dots ls-tree -rtd --format='%(path)' HEAD ./ | awk -F '/' '{print $1}' | sort | uniq | xargs git --git-dir="$DOTFILES" --work-tree="$HOME" "$@" st --ignore-submodules=untracked -u "{}" \;
  dots st
}

dots () {
  git --git-dir="$DOTFILES" --work-tree="$HOME" "$@"
}

commit-dots() {
  set -e
  local message="$1"
  dots add -u
  if [[ -z "$message" ]]; then 
    message=$(dots status --porcelain)
  fi
  dots ci -m "$message"
  dots push
}

add-dots() {
	for x in $(find "$1" -type d); do
		if [ -d "${x}/.git" ]; then
		cd "${x}"
		origin="$(git config --get remote.origin.url)"
		cd - 1>/dev/null
		dots submodule add "${origin}" "${x}"
		fi
	done
}

new-dots () {
  set -e
  git clone --bare $DOTFILES_REPO $DOTFILES
  dots config --local status.showUntrackedFiles no
  dots switch -c base

  echo "Please add and commit additional files"
  echo "using 'dots add' and 'dots commit', then run"
  echo "dots push -u origin base"
}

restore-dots () {
  set -e
  git clone -b base --bare $DOTFILES_REPO $DOTFILES
  dots config --local status.showUntrackedFiles no
  dots checkout  && \
  dots submodule init && \
  dots submodule update || echo -e 'Deal with conflicting files, then run (possibly with -f flag if you are OK with overwriting)\ndots checkout'
}

compdef dots='git'
