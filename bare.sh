DOTFILES="$HOME/.dotfiles"
DOTFILES_REPO="git@github.com:pochemuto/dotfiles.git"

dots () {
  git --git-dir="$DOTFILES" --work-tree="$HOME" "$@"
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
  git clone --bare $DOTFILES_REPO $DOTFILES
  dots config --local status.showUntrackedFiles no
  dots switch -c base

  echo "Please add and commit additional files"
  echo "using 'dots add' and 'dots commit', then run"
  echo "dots push -u origin base"
}

restore-dots () {
  git clone -b base --bare $DOTFILES_REPO $DOTFILES
  dots config --local status.showUntrackedFiles no
  dots checkout  && \
  dots submodule init && \
  dots submodule update || echo -e 'Deal with conflicting files, then run (possibly with -f flag if you are OK with overwriting)\ndots checkout'
}