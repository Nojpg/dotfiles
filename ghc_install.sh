curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
source ~/.bashrc
ghcup install ghc --set recommended
ghcup install cabal latest
ghcup install stack latest
ghcup install hls latest
cabal update
#echo 'PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"' >> ~/.bashrc
echo "$PATH" 
