{ config, pkgs, lib, ... }:

let name = "Adam Mischke";
    user = "vanities";
    email = "mischkeaa@gmail.com"; in
{
  # Shared shell configuration
  zsh = {
    enable = true;
    autocd = false;
    cdpath = [ "~/.local/share/src" ];
    plugins = [
      {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
          name = "powerlevel10k-config";
          src = lib.cleanSource ./config;
          file = "p10k.zsh";
      }
    ];
    initExtraFirst = ''
      if [[ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]]; then
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
        . /nix/var/nix/profiles/default/etc/profile.d/nix.sh
      fi

      # Define variables for directories
      export PATH=$HOME/.pnpm-packages/bin:$HOME/.pnpm-packages:$PATH
      export PATH=$HOME/.npm-packages/bin:$HOME/bin:$PATH
      export PATH=$HOME/.local/share/bin:$PATH

      # Remove history data we don't want to see
      export HISTIGNORE="pwd:ls:cd"

      # Ripgrep alias
      alias search=rg -p --glob '!node_modules/*'  $@

      # Emacs is my editor
      export ALTERNATE_EDITOR=""
      export EDITOR="nvim"
      export VISUAL="nvim"

      # nix shortcuts
      shell() {
          nix-shell '<nixpkgs>' -A "$1"
      }

      # pnpm is a javascript package manager
      alias pn=pnpm
      alias px=pnpx

      # Use difftastic, syntax-aware diffing
      alias diff=difft

      # Always color ls and group directories
      alias ls='ls --color=auto'
    '';
  };

  git = {
    enable = true;
    userName = name;
    userEmail = email;
    lfs = {
      enable = true;
    };
    ignores = [
      # ide
      ".idea"
      ".vs"
      ".vsc"
      ".vscode"
      # npm
      "node_modules"
      "npm-debug.log"
      # python
      "__pycache__"
      "*.pyc"

      ".ipynb_checkpoints" # jupyter
      "__sapper__" # svelte
      ".DS_Store" # mac
      "kls_database.db" # kotlin lsp
    ];
    extraConfig = {
      init.defaultBranch = "main";
      core = {
	    editor = "nvim";
        autocrlf = "input";
      };
      fetch = { prune = true; };
      commit.gpgsign = true;
      pull.rebase = true;
      rebase.autoStash = true;
      delta = { line-numbers = true; };
    };
    aliases = {
      a = "add --all";
      ai = "add -i";
      #############
      ap = "apply";
      as = "apply --stat";
      ac = "apply --check";
      #############
      ama = "am --abort";
      amr = "am --resolved";
      ams = "am --skip";
      #############
      b = "branch";
      ba = "branch -a";
      bd = "branch -d";
      bdd = "branch -D";
      br = "branch -r";
      bc = "rev-parse --abbrev-ref HEAD";
      bu = "!git rev-parse --abbrev-ref --symbolic-full-name "@{u}"";
      #############
      c = "commit";
      ca = "commit -a";
      cm = "commit -m";
      cam = "commit -am";
      cem = "commit --allow-empty -m";
      cd = "commit --amend";
      cad = "commit -a --amend";
      ced = "commit --allow-empty --amend";
      #############
      cl = "clone";
      cld = "clone --depth 1";
      clg = "!sh -c 'git clone git://github.com/$1 $(basename $1)' -";
      clgp = "!sh -c 'git clone git@github.com:$(git config --get user.username)/$1 $1' -";
      #############
      cp = "cherry-pick";
      cpa = "cherry-pick --abort";
      cpc = "cherry-pick --continue";
      #############
      d = "diff";
      dp = "diff --patience";
      dc = "diff --cached";
      dk = "diff --check";
      dck = "diff --cached --check";
      dt = "difftool";
      dct = "difftool --cached";
      #############
      f = "fetch";
      fo = "fetch origin";
      fu = "fetch upstream";
      #############
      fp = "format-patch";
      #############
      fk = "fsck";
      #############
      g = "grep -p";
      l = "log --oneline";
      lg = "log --oneline --graph --decorate";
      ls = "ls-files";
      lsf = "!git ls-files | grep -i";
      m = "merge";
      ma = "merge --abort";
      mc = "merge --continue";
      ms = "merge --skip";
      o = "checkout";
      ob = "checkout -b";
      pr = "prune -v";
      ps = "push";
      psf = "push -f";
      psu = "push -u";
      pst = "push --tags";
      pso = "push origin";
      psao = "push --all origin";
      psfo = "push -f origin";
      psuo = "push -u origin";
      psom = "push origin master";
      psaom = "push --all origin master";
      psfom = "push -f origin master";
      psuom = "push -u origin master";
      psoc = "!git push origin $(git bc)";
      psaoc = "!git push --all origin $(git bc)";
      psfoc = "!git push -f origin $(git bc)";
      psuoc = "!git push -u origin $(git bc)";
      psdc = "!git push origin :$(git bc)";
      pl = "pull";
      pb = "pull --rebase";
      plo = "pull origin";
      pbo = "pull --rebase origin";
      plom = "pull origin master";
      ploc = "!git pull origin $(git bc)";
      pbom = "pull --rebase origin master";
      pboc = "!git pull --rebase origin $(git bc)";
      plu = "pull upstream";
      plum = "pull upstream master";
      pluc = "!git pull upstream $(git bc)";
      pbum = "pull --rebase upstream master";
      pbuc = "!git pull --rebase upstream $(git bc)";
      rb = "rebase";
      rba = "rebase --abort";
      rbc = "rebase --continue";
      rbi = "rebase --interactive";
      rbs = "rebase --skip";
      re = "reset";
      rh = "reset HEAD";
      reh = "reset --hard";
      rem = "reset --mixed";
      res = "reset --soft";
      rehh = "reset --hard HEAD";
      remh = "reset --mixed HEAD";
      resh = "reset --soft HEAD";
      r = "remote";
      ra = "remote add";
      rr = "remote rm";
      rv = "remote -v";
      rn = "remote rename";
      rp = "remote prune";
      rs = "remote show";
      rao = "remote add origin";
      rau = "remote add upstream";
      rro = "remote remove origin";
      rru = "remote remove upstream";
      rso = "remote show origin";
      rsu = "remote show upstream";
      rpo = "remote prune origin";
      rpu = "remote prune upstream";
      rmf = "rm -f";
      rmrf = "rm -r -f";
      s = "status";
      sb = "status -s -b";
      sa = "stash apply";
      sc = "stash clear";
      sd = "stash drop";
      sl = "stash list";
      sp = "stash pop";
      ss = "stash save";
      ssk = "stash save -k";
      sw = "stash show";
      st = "!git stash list | wc -l 2>/dev/null | grep -oEi '[0-9][0-9]*'";
      t = "tag";
      td = "tag -d";
      w = "show";
      wp = "show -p";
      wr = "show -p --no-color";
      svnr = "svn rebase";
      svnd = "svn dcommit";
      svnl = "svn log --oneline --show-commit";
      subadd = "!sh -c 'git submodule add git://github.com/$1 $2/$(basename $1)' -";
      subup = "submodule update --init --recursive";
      subpull = "!git submodule foreach git pull --tags origin master";
      assume = "update-index --assume-unchanged";
      unassume = "update-index --no-assume-unchanged";
      assumed = "!git ls -v | grep ^h | cut -c 3-";
      unassumeall = "!git assumed | xargs git unassume";
      assumeall = "!git status -s | awk {'print $2'} | xargs git assume";
      bump = "!sh -c 'git commit -am \"Version bump v$1\" && git psuoc && git release $1' -";
      release = "!sh -c 'git tag v$1 && git pst' -";
      unrelease = "!sh -c 'git tag -d v$1 && git pso :v$1' -";
      merged = "!sh -c 'git o master && git plom && git bd $1 && git rpo' -";
      aliases = "!git config -l | grep alias | cut -c 7-";
      snap = "!git stash save 'snapshot: $(date)' && git stash apply 'stash@{0}'";
      bare = "!sh -c 'git symbolic-ref HEAD refs/heads/$1 && git rm --cached -r . && git clean -xfd' -";
      whois = "!sh -c 'git log -i -1 --author=\"$1\" --pretty=\"format:%an <%ae>\"' -";
      serve = "daemon --reuseaddr --verbose --base-path=. --export-all ./.git";
      behind = "!git rev-list --left-only --count $(git bu)...HEAD";
      ahead = "!git rev-list --right-only --count $(git bu)...HEAD";
      ours = ""!f() { git checkout --ours $@ && git add $@; }; f"";
      theirs = "!f() { git checkout --theirs $@ && git add $@; }; f"
      subrepo = "!sh -c 'git filter-branch --prune-empty --subdirectory-filter $1 master' -";
      human = "name-rev --name-only --refs=refs/heads/*";
      uncommit = "reset --soft HEAD^";
    };
  };

  /*
  gpg-agent = {
    enable = true;

    defaultCacheTtl = 86400;
    defaultCacheTtlSsh = 86400;
    maxCacheTtl = 86400;
    maxCacheTtlSsh = 86400;
    enableSshSupport = true;
    extraConfig = ''
      pinentry-program ${pkgs.pinentry-qt}/bin/pinentry
    '' + ''
      allow-loopback-pinentry
    '';
  };
  */

  vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ vim-airline vim-airline-themes vim-startify vim-tmux-navigator ];
    settings = { ignorecase = true; };
    extraConfig = ''
      "" General
      set number
      set history=1000
      set nocompatible
      set modelines=0
      set encoding=utf-8
      set scrolloff=3
      set showmode
      set showcmd
      set hidden
      set wildmenu
      set wildmode=list:longest
      set cursorline
      set ttyfast
      set nowrap
      set ruler
      set backspace=indent,eol,start
      set laststatus=2
      set clipboard=autoselect

      " Dir stuff
      set nobackup
      set nowritebackup
      set noswapfile
      set backupdir=~/.config/vim/backups
      set directory=~/.config/vim/swap

      " Relative line numbers for easy movement
      set relativenumber
      set rnu

      "" Whitespace rules
      set tabstop=8
      set shiftwidth=2
      set softtabstop=2
      set expandtab

      "" Searching
      set incsearch
      set gdefault

      "" Statusbar
      set nocompatible " Disable vi-compatibility
      set laststatus=2 " Always show the statusline
      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1

      "" Local keys and such
      let mapleader=","
      let maplocalleader=" "

      "" Change cursor on mode
      :autocmd InsertEnter * set cul
      :autocmd InsertLeave * set nocul

      "" File-type highlighting and configuration
      syntax on
      filetype on
      filetype plugin on
      filetype indent on

      "" Paste from clipboard
      nnoremap <Leader>, "+gP

      "" Copy from clipboard
      xnoremap <Leader>. "+y

      "" Move cursor by display lines when wrapping
      nnoremap j gj
      nnoremap k gk

      "" Map leader-q to quit out of window
      nnoremap <leader>q :q<cr>

      "" Move around split
      nnoremap <C-h> <C-w>h
      nnoremap <C-j> <C-w>j
      nnoremap <C-k> <C-w>k
      nnoremap <C-l> <C-w>l

      "" Easier to yank entire line
      nnoremap Y y$

      "" Move buffers
      nnoremap <tab> :bnext<cr>
      nnoremap <S-tab> :bprev<cr>

      "" Like a boss, sudo AFTER opening the file to write
      cmap w!! w !sudo tee % >/dev/null

      let g:startify_lists = [
        \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      }
        \ ]

      let g:startify_bookmarks = [
        \ '~/.local/share/src',
        \ ]

      let g:airline_theme='bubblegum'
      let g:airline_powerline_fonts = 1
      '';
     };

  kitty = {
    enable = true;
    extraConfig = builtins.readFile ./kitty.conf;
  };

  yabai = {
    enable = false;
    config = {
      layout = "bsp";
      auto_balance = "off";

      mouse_modifier = "fn";
      # set modifier + right-click drag to resize window (default: resize)
      mouse_action2 = "resize";
      # set modifier + left-click drag to resize window (default: move)
      mouse_action1 = "move";

      # gaps
      top_padding = 1;
      bottom_padding = 1;
      left_padding = 1;
      right_padding = 1;
      window_gap = 5;
    };
    extraConfig = ''
      # bar configuration
      yabai -m signal --add event=window_focused   action="sketchybar --trigger window_focus"
      yabai -m signal --add event=window_created   action="sketchybar --trigger windows_on_spaces"
      yabai -m signal --add event=window_destroyed action="sketchybar --trigger windows_on_spaces"

      yabai -m config mouse_follows_focus          on
      yabai -m config focus_follows_mouse          on
      yabai -m config window_origin_display        default
      yabai -m config window_placement             second_child
      yabai -m config window_topmost               off
      yabai -m config window_shadow                on
      yabai -m config window_opacity               off
      yabai -m config window_opacity_duration      0.0
      yabai -m config active_window_opacity        1.0
      yabai -m config normal_window_opacity        0.90
      yabai -m config window_border                on
      yabai -m config window_border_width          1
      yabai -m config active_window_border_color   0xFFE6E200
      yabai -m config normal_window_border_color   0xFFFFC428
      yabai -m config insert_feedback_color        0xffd75f5f
      yabai -m config split_ratio                  0.50
      yabai -m config auto_balance                 off
      yabai -m rule --add app="^Simulator.*$" sticky=on layer=above manage=off

      # rules
      yabai -m rule --add app="^System Settings$"    manage=off
      yabai -m rule --add app="^System Information$" manage=off
      yabai -m rule --add app="^System Preferences$" manage=off
      yabai -m rule --add title="Preferences$"       manage=off
      yabai -m rule --add title="Settings$"          manage=off

      # workspace management
      yabai -m space 1  --label todo
      yabai -m space 2  --label browser
      yabai -m space 3  --label chat
      yabai -m space 4  --label utils
      yabai -m space 5  --label code

      # assign apps to spaces
      yabai -m rule --add app="Reminder" space=todo
      yabai -m rule --add app="Mail" space=todo
      yabai -m rule --add app="Calendar" space=todo

      yabai -m rule --add app="Librefox" space=browser

      yabai -m rule --add app="Microsoft Teams" space=chat
      yabai -m rule --add app="Slack" space=chat
      yabai -m rule --add app="Signal" space=chat
      yabai -m rule --add app="Messages" space=chat

      yabai -m rule --add app="Strongbox" space=utils

      yabai -m rule --add app="Visual Studio Code" space=code
      yabai -m rule --add app="kitty" space=code
    '';
  };

  lsd = {
    enable = true;
    enableAliases = true;
  };

  ssh = {
    enable = true;
    includes = [
      (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
        "/home/${user}/.ssh/config_external"
      )
      (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
        "/Users/${user}/.ssh/config_external"
      )
    ];
    matchBlocks = {
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          (lib.mkIf pkgs.stdenv.hostPlatform.isLinux
            "/home/${user}/.ssh/id_github"
          )
          (lib.mkIf pkgs.stdenv.hostPlatform.isDarwin
            "/Users/${user}/.ssh/id_github"
          )
        ];
      };
    };
  };

  tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator
      sensible
      yank
      prefix-highlight
      {
        plugin = power-theme;
        extraConfig = ''
           set -g @tmux_power_theme 'gold'
        '';
      }
      {
        plugin = resurrect; # Used by tmux-continuum

        # Use XDG data directory
        # https://github.com/tmux-plugins/tmux-resurrect/issues/348
        extraConfig = ''
          set -g @resurrect-dir '$HOME/.cache/tmux/resurrect'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-pane-contents-area 'visible'
        '';
      }
      {
        plugin = continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
        '';
      }
    ];
    terminal = "screen-256color";
    escapeTime = 10;
    historyLimit = 50000;
    extraConfig = builtins.readFile ./tmux.conf;
    };
}
