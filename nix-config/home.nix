{ inputs
, outputs
, lib
, pkgs
, ...
}: let
    username = "victor";

    shellAliases = {
        ".." = "cd ..";
        "..." = "cd ../..";
        cat = "bat";
        cd = "z";
        ll = "ls -al";
        ls = "eza --color=always --long --git --icons=always";
        vi = "vim";
    };

    tmux-catppuccin = pkgs.tmuxPlugins.mkTmuxPlugin {
        pluginName = "catppuccin";
        version = "v2.1.2";
        src = pkgs.fetchFromGitHub {
            owner = "catppuccin";
            repo = "tmux";
            rev = "v2.1.2";
            sha256 = "sha256-vBYBvZrMGLpMU059a+Z4SEekWdQD0GrDqBQyqfkEHPg=";
        };
    };
in {
    nixpkgs.config.allowUnfree = true;

    fonts = {
        fontconfig = {
            enable = true;
        };
    };

    home = {
        packages = with pkgs; [
            _1password-cli
            awscli2
            bat
            bash-completion
            eza
            fastfetch
            fd
            fzf
            git
            google-chrome
            granted
            jq
            fira-code-nerdfont
            mise
            podman
            ripgrep
            ssm-session-manager-plugin
            starship
            stow
            strace
            tmux
            tree
            vim
            wget
            zoxide
            zsh-syntax-highlighting
            zsh-history-substring-search
            _1password-gui
            obsidian
            slack
            #sublime4
            #sublime-merge
            (vscode-with-extensions.override {
                vscodeExtensions = with vscode-extensions; [
                    ms-python.python
                ];
            })
        ];

        file = {
            ".inputrc".text = ''
                set bell-style visible
            '';
            ".config/git/ignore".text = ''
                .DS_Store
            '';
            ".config/git/commit-template".source = config/git/commit-template;
            ".config/git/scripts".source = config/git/scripts;
            ".config/vim/vimrc".source = config/vim/vimrc;
            ".config/zsh/functions".source = config/zsh/functions;
        };

        inherit username;

        homeDirectory = "/home/${username}";

        #environment.pathsToLink = [ "/share/zsh" ];

        stateVersion = "24.11";
    };

    programs = {
        awscli = {
            enable = true;
            settings = import ./aws/config.nix;
        };

        bash = {
            enable = true;
            enableCompletion = true;

            inherit shellAliases;

            bashrcExtra = ''
                if [ -f /etc/bashrc ]; then
                    . /etc/bashrc
                fi
            '';
        };

        bat = {
            enable = true;
            config = {
                # $ bat --list-languages
                # map-syntax = [
                #  "*.jenkinsfile:Groovy"
                #  "*.props:Java Properties"
                #];
                pager = "less -FR";
                theme = "catppuccin";
            };
            themes = {
                catppuccin = {
                    src = pkgs.fetchFromGitHub {
                        owner = "catppuccin";
                        repo = "bat";
                        rev = "d2bbee4f7e7d5bac63c054e4d8eca57954b31471";
                        sha256 = "x1yqPCWuoBSx/cI94eA+AWwhiSA42cLNUOFJl7qjhmw=";
                    };
                    file = "themes/Catppuccin Mocha.tmTheme";
                };
            };
        };

        zsh = {
            enable = true;
            enableCompletion = true;

            dotDir = ".config/zsh";

            autosuggestion = {
                enable = true;
                highlight = "fg=#171438,bg=white,bold,underline";
                strategy = [ "history" "completion" ];
            };

            completionInit = "autoload -Uz compinit && compinit && zstyle ':completion:*' menu select";

            syntaxHighlighting = {
                enable = true;
                highlighters = [
                    "main"
                    "brackets"
                    "pattern"
                    "cursor"
                    "root"
                    "line"
                ];
                patterns = {
                    "rm -rf *" = "fg=white,bold,bg=red";
                };
                styles = {
                    comment = "fg=yellow";
                };
            };

            history = {
                expireDuplicatesFirst = true;
                extended = true;
                ignoreAllDups = false;
                ignoreDups = true;
                ignoreSpace = true;
                save = 10000;
                share = true;
                size = 10000;
            };

            historySubstringSearch = {
                enable = true;
                searchDownKey = [ "^[[B" ];
                searchUpKey = [ "^[[A" ];
            };

            initExtraFirst = ''
                # Where to look for autoload function definitions
                fpath=(
                    ~/.config/zsh/functions
                    "''${fpath[@]}"
                )

                # Autoload all shell functions from all directories in $fpath (following
                # symlinks) that have the executable bit on (the executable bit is not
                # necessary, but gives you an easy way to stop the autoloading of a
                # particular shell function). $fpath should not be empty for this to work.
                for func in $^fpath/*(N-.x:t); autoload $func
                #for func in $^fpath/**/*(N-.x:t); do
                #    autoload $func
                #done

                # automatically remove duplicates from these arrays
                # typeset -U path cdpath fpath manpath
            '';


            initExtra = ''
                # Use fd (https://github.com/sharkdp/fd) for listing path candidates.
                # - The first argument to the function ($1) is the base path to start traversal
                # - See the source code (completion.{bash,zsh}) for the details.
                _fzf_compgen_path() {
                  fd --hidden --exclude .git . "$1"
                }

                # Use fd to generate the list for directory completion
                _fzf_compgen_dir() {
                  fd --type=d --hidden --exclude .git . "$1"
                }

                # Advanced customization of fzf options via _fzf_comprun function
                # - The first argument to the function is the name of the command.
                # - You should make sure to pass the rest of the arguments to fzf.
                _fzf_comprun() {
                  local command=$1
                  shift

                  show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

                  case "$command" in
                    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
                    export|unset) fzf --preview "eval 'echo ''${}'"         "$@" ;;
                    ssh)          fzf --preview 'dig {}'                   "$@" ;;
                    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
                  esac
                }

                # Can add comments on commandline
                setopt interactivecomments

                # Move over words with alphanumeric characters as "words"
                #  man zshall - ZLE FUNCTIONS
                autoload -U select-word-style
                select-word-style bash

                # Key Bindings
                bindkey "^[[H"    beginning-of-line  # home
                bindkey "^[[F"    end-of-line        # end
                bindkey "^[[1;3C" forward-word       # alt + right-arrow
                bindkey "^[[1;3D" backward-word      # alt + left-arrow
                bindkey "^[[3~"   delete-char        # delete character under cursor

                # Key Bindings for tmux
                bindkey "\E[1~"    beginning-of-line  # home
                bindkey "\E[4~"    end-of-line        # end
            '';

            profileExtra = ''
                # Enables GDM to find the .desktop files installed by Nix Home Manager
                export XDG_DATA_DIRS="/home/${username}/.nix-profile/share:$XDG_DATA_DIRS"

                # Automatically resassume roles
                export GRANTED_ENABLE_AUTO_REASSUME=true
            '';

            inherit shellAliases;

        };

        fd = {
            enable = true;
            extraOptions = [
                #"--no-ignore"
                "--strip-cwd-prefix"
                "--absolute-path"
            ];
            hidden = true;
            ignores = [
                ".git/"
                ".bare/"
                "*.bak"
            ];
        };

        fzf = {
            enable = true;
            enableZshIntegration = true;
            colors = {
                fg = "#CBE0F0";
                "fg+" = "#CBE0F0";
                bg = "#011628";
                "bg+" = "#143652";
                hl = "#B388FF";
                "hl+" = "#B388FF";
                info = "#06BCE4";
                prompt = "#2CF9ED";
                pointer = "#2CF9ED";
                marker = "#2CF9ED";
                spinner = "#2CF9ED";
                header = "#2CF9ED";
            };
            defaultCommand = "fd --hidden --strip-cwd-prefix --exclude .git --exclude .bare";
            defaultOptions = [
            ];
            fileWidgetCommand = "fd --hidden --strip-cwd-prefix --exclude .git --exclude .bare";
            fileWidgetOptions = [
                "--preview 'if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi'"
            ];
            changeDirWidgetCommand = "fd --type=d --hidden --strip-cwd-prefix --exclude .git";
            changeDirWidgetOptions = [
                "--preview 'eza --tree --color=always {} | head -200'"
            ];
        };

        git = {
            enable = true;
            userName = "Victor Louie";
            userEmail = "git@victorlouie.com";

            aliases = {
                worktree-clone-bare = "!sh ~/.config/git/scripts/worktree-clone-bare.sh";
                co = "checkout";
                cob = "checkout -b";
                del = "branch -D";
                s = "status";
            };

            delta = {
                enable = true;
                options = {
                    navigate = "true";
                    side-by-side= "true";

                    decorations = {
                        commit-decoration-style = "bold yellow box ul";
                        file-decoration-style = "none";
                        file-style = "bold yellow ul";
                    };

                    features = "decorations";
                    whitespace-error-style = "22 reverse";
                };
            };

            extraConfig = {
                core = {
                    editor = "vim";
                    excludes = "~/.config/git/ignore";
                };
                commit = {
                    template = "~/.config/git/commit-template";
                };
                diff = {
                    colorMoved = "default";
                };
                merge = {
                    conflictstyle = "zdiff3";
                };
                pull = {
                    ff = "only";
                };
            };
        };

        granted = {
            enable = true;
            enableZshIntegration = true;
        };

        starship = {
            enable = true;
            enableBashIntegration = true;
            enableZshIntegration = true;
            settings = import ./starship/starship.nix;
        };

        gnome-terminal = {
            enable = true;
            showMenubar = false;

            profile."67861064-a036-4a1c-8016-221a4c40eeb0" = {
                audibleBell = false;
                default = true;
                visibleName = "${username}";
                cursorBlinkMode = "off";
                cursorShape = "ibeam";
                showScrollbar = true;
                transparencyPercent = 5;
                font = "FiraCode Nerd Font 12";

# colors are messing with my zsh color settings
#                colors = {
#                    palette = [
#                        "#1c2023"
#                        "#c7ae95"
#                        "#95c7ae"
#                        "#aec795"
#                        "#ae95c7"
#                        "#c795ae"
#                        "#95aec7"
#                        "#c7ccd1"
#                        "#747c84"
#                        "#c7ae95"
#                        "#95c7ae"
#                        "#aec795"
#                        "#ae95c7"
#                        "#c795ae"
#                        "#95aec7"
#                        "#f3f4f5"
#                    ];
#
#                    backgroundColor = "#1c2023";
#                    foregroundColor = "#c7ccd1";
#                };
            };
        };

        mise = {
            enable = true;
            enableZshIntegration = true;
        };

        tmux = {
            enable = true;
            terminal = "screen-256color";
            shell = "/home/victor/.nix-profile/bin/zsh";
            prefix = "C-s";
            keyMode = "vi";
            mouse= true;
            escapeTime = 0;

            plugins = with pkgs; [
                {
                    plugin = tmux-catppuccin;
                    extraConfig = ''
                        set -g @catppuccin_flavor "mocha"
                        set -g @catppuccin_window_status_style "rounded"
                        set -g @catppuccin_window_text "#W"
                        set -g @catppuccin_window_current_text "#W"

                        # Make the status line pretty and add some modules
                        set -g status-right-length 100
                        set -g status-left-length 100
                        set -g status-left ""
                        set -g status-right   "#{E:@catppuccin_status_application}"
                        set -agF status-right "#{E:@catppuccin_status_cpu}"
                        set -ag status-right  "#{E:@catppuccin_status_session}"
                        set -ag status-right  "#{E:@catppuccin_status_uptime}"
                        set -agF status-right "#{E:@catppuccin_status_battery}"
                    '';
                }
                {
                    plugin = tmuxPlugins.yank;
                    extraConfig = ''
                        set -g @yank_selection_mouse 'clipboard'
                    '';
                }
                tmuxPlugins.cpu
                tmuxPlugins.battery
            ];

            extraConfig = ''
                # Shortcut for reloading config
                unbind r
                bind r source-file ~/.config/tmux/tmux.conf

                # Vim inspired pane navigation
                bind-key h select-pane -L
                bind-key j select-pane -D
                bind-key k select-pane -U
                bind-key l select-pane -R

                # Change splits to match nvim and easier to remember
                # Open new split at cwd of current split
                unbind %
                unbind '"'
                bind | split-window -h -c "#{pane_current_path}"
                bind - split-window -v -c "#{pane_current_path}"

                # Shortcut for mirroring output across panes
                bind-key m setw synchronize-panes \; display-message 'Pane synchronization toggled'

                # Rename sessions/windows
                unbind b
                unbind v
                bind b command-prompt "rename-session '%%'"
                bind v command-prompt "rename-window '%%'"

                bind -T copy-mode-vi v send -X begin-selection
                bind-key -T copy-mode-vi y send -X copy-selection-and-cancel
                bind P paste-buffer

                set-option -g status-position top
                set -g base-index 1
                set -g renumber-windows on
            '';
        };

        zoxide = {
            enable = true;
            enableZshIntegration = true;
        };

        home-manager = {
            enable = true;
        };
    };

    targets = {
        genericLinux = {
            enable = true;
        };
    };

    xdg = {
        enable = true;
        mime.enable = false;
    };
}

