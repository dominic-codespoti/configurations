# Install basic tools
winget install -e --id Neovim.Neovim --accept-package-agreements --accept-source-agreements
winget install -e --id Git.Git --accept-package-agreements --accept-source-agreements
winget install -e --id Microsoft.VCRedist.2015+.x64 --accept-package-agreements --accept-source-agreements
winget install -e --id Microsoft.DotNet.DesktopRuntime.7 --accept-package-agreements --accept-source-agreements
winget install -e --id "Flow Launcher" --accept-package-agreements --accept-source-agreements
winget install -e --id Starship.Starship --accept-package-agreements --accept-source-agreements

# Install C++ compiler
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install zig

# Setup configs
Set-Location ~/AppData/Local
New-Item -ItemType SymbolicLink -Path "~/AppData/Local/nvim" -Target "~/AppData/Local/configurations/nvim"
New-Item -ItemType SymbolicLink -Path "~/AppData/Local/alacritty" -Target "~/AppData/Local/configurations/alacritty"

# Setup profile
$profilePath = $PROFILE.CurrentUserAllHosts
New-Item -ItemType File -Path $profilePath -Force

$linesToAdd = @"
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

# Starship
Invoke-Expression (&starship init powershell)
"@

Add-Content -Path $profilePath -Value $linesToAdd -Force

# Setup starship
Invoke-WebRequest -Uri "https://github.com/dracula/starship/archive/master.zip" -OutFile "$HOME\Downloads\starship.zip"
Expand-Archive -Path "$HOME\Downloads\starship.zip" -DestinationPath "$HOME\.config" -Force
Move-Item -Path "$HOME\.config\starship-master\starship.toml" -Destination "$HOME\.config\starship.toml" -Force
Remove-Item -Path "$HOME\Downloads\starship.zip" -Force
