BASE_PATH=$PWD

# apt-get update &&
apt-get install -y curl wget libssl-dev git-core build-essential vim-nox zsh || exit 10

# installing n, nodejs stable and latest
# [ -d "/usr/local/lib/node_modules" ] || {
  cd /root
  git clone --depth=1 "https://github.com/tj/n.git" /root/n &&
  cd n && make install && n io 1.6.2 && cd /root &&
  rm -rf /root/n || echo 'nodejs install failed'
  # using stable nodejs, and installing basic global pkgs.
  npm config set prefix="/usr/local" &&
  npm install -g pm2 yo bower gulp grunt-cli &&
  cd $BASE_PATH || echo 'npm install failed'
# }

