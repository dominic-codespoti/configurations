# Aliases
New-Alias v nvim

# Tab autocomplete
Set-PSReadLineOption -EditMode Emacs

# Remove bell noise
Set-PSReadlineOption -BellStyle None

# History
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Clipboard
Set-PSReadLineKeyHandler -Key Ctrl+C -Function Copy
Set-PSReadLineKeyHandler -Key Ctrl+v -Function Paste

# Git
git config --global push.default current
git config --global push.autoSetupRemote true

# Starship
Invoke-Expression (&starship init powershell)

