# mkdir -p ~/.config/zellij/
rsync --archive --delete zellij/*.kdl ~/.config/zellij
rsync --archive zellij/\.* ~ 

