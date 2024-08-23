{ pkgs }:

with pkgs; [
  # General packages for development and system management
  kitty
  bat
  gcc
  htop
  coreutils
  killall
  neofetch
  openssh
  sqlite
  wget
  zip

  # Cloud-related tools and SDKs
  docker
  docker-compose

  yt-dlp
  yabai
  wireguard-tools
  wireguard-go
  zathura

  # Encryption and security tools
  _1password
  age
  age-plugin-yubikey
  gnupg
  libfido2

  # Cloud-related tools and SDKs
  # docker
  # docker-compose
  # awscli2 - marked broken Mar 22
  flyctl
  google-cloud-sdk
  go
  gopls
  ngrok
  ssm-session-manager-plugin
  terraform
  terraform-ls
  tflint

  # Media-related packages
  imagemagick
  ffmpeg
  fd
  font-awesome
  glow
  hack-font
  jpegoptim
  meslo-lgs-nf
  noto-fonts
  noto-fonts-emoji
  pngquant

  # PHP
  #php82
  #php82Packages.composer
  #php82Packages.php-cs-fixer
  #php82Extensions.xdebug
  #php82Packages.deployer
  #phpunit

  # Node.js development tools
  fzf
  nodePackages.live-server
  nodePackages.nodemon
  nodePackages.prettier
  nodePackages.npm
  nodejs

  # Source code management, Git, GitHub tools
  gh

  # Text and terminal utilities
  htop
  hunspell
  iftop
  jq
  ripgrep
  slack
  tree
  tmux
  unrar
  unzip
  #pinentry
  zsh-powerlevel10k

  # Python packages
  black
  python3
  python3Packages.virtualenv
  python3Packages.ipython
  python3Packages.nose
  python3Packages.pyflakes
  python3Packages.pygments
  python3Packages.pytest
  python3Packages.python-lsp-server

  feh
  lsd
  scrot
  xclip
  vlc
  cmake
]
