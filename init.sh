#! /bin/sh -ex

rm -rf $HOME/.oh-my-zsh

sh -c "CHSH=no RUNZSH=no KEEP_ZSHRC=yes $(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

for plugin in zsh-autosuggestions zsh-completions zsh-history-substring-search zsh-syntax-highlighting
do
    git clone https://github.com/zsh-users/$plugin.git $HOME/.oh-my-zsh/custom/plugins/$plugin
done


rm -rf $HOME/.tmux/plugins/tpm

mkdir -p ~/.tmux/plugins

git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm


for x in .zshrc .emacs .jupyter .gdbinit .tmux.conf .gitconfig
do
    ln -f -s $HOME/etc/$x $HOME/$x
done

case "$(uname -s)" in
    Linux*)
        sudo apt-get install clangd
    ;;

    Darwin*)
        brew install llvm
    ;;

    *)
        echo "unknown OS, clangd was not installed"
esac

pip3 install 'python-lsp-server[all]'

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install rls
rustup component add rls
