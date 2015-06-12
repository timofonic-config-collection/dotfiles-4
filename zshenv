# ~/.zshenv
# sourced by zsh for every single shell
#
# /!\ MUST be sourceable by plain /bin/sh too! and with set -u too!
# In addition to interactive shells, will be used by:
# - cron jobs that need my usual environnement
# - xprofile on boxes that run X
#
# /!\ should be idempotent!
# can't use guards for that since PATH is reset by login shells (eg in tmux)

# PATH adjustments
path_prepend() {
    test -d "$1" || return

    PATH=$( printf "$PATH" | tr ':' '\n' | grep -v -F "$1" | tr '\n' ':' )
    PATH="$1:${PATH%:}"
}
path_postpend() {
    test -d "$1" || return

    PATH=$( printf "$PATH" | tr ':' '\n' | grep -v -F "$1" | tr '\n' ':' )
    PATH="${PATH%:}:$1"
}
test -d "/usr/local/Cellar" && path_prepend "/usr/local/bin"
path_prepend "$HOME/usr/infer-osx-v0.1.0/infer/infer/bin"
#path_prepend "/usr/local/Cellar/ccache/3.2/libexec"
path_prepend "/usr/lib/ccache/bin"
path_prepend "$HOME/usr/texlive/2014/bin/x86_64-linux"
for dir in "$HOME"/usr/*/bin; do path_prepend "$dir"; done; unset dir
path_prepend "$HOME/bin"
export PATH

# locale: default, overriden in zshrc for interctive shells
LANG="fr_FR.UTF-8"
LC_COLLATE="C"
export LANG LC_COLLATE

# TeX Live development
if [ -d "$HOME/tl" ]; then
    TEXLIVE="$HOME/tl"
    TLROOT="$TEXLIVE/trunk/Master"
    CTAN="$TEXLIVE/ctan"
    TEX_CATALOGUE="$TEXLIVE/catalogue/entries"
    path_postpend "$TLROOT/tlpkg/bin"
    PERL5LIB="$TLROOT/tlpkg"
    export TEXLIVE TLROOT CTAN TEX_CATALOGUE PERL5LIB
fi

# texdoc dev
if [ -d "$HOME/texdoc/tl-checkout" ]; then
    TEXDOCDEV="$HOME/texdoc/tl-checkout"
    export TEXDOCDEV
fi

# local additions not tracked in the git repo
test -r "$HOME/.zenv-local" && . "$HOME/.zenv-local"
