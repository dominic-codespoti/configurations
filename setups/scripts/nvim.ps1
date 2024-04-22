# Install
winget install  --id Neovim.Neovim --accept-package-agreements --accept-source-agreements

# Link nvim
$nvimLinkPath = Join-Path $HOME "AppData\Local\nvim"
$nvimTargetPath = Join-Path $HOME "AppData\Local\configurations\nvim"
New-Item -ItemType SymbolicLink -Path $nvimLinkPath -Target $nvimTargetPath