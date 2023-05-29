# Install basic tools
winget install -e --id Neovim.Neovim --accept-package-agreements --accept-source-agreements
winget install -e --id Git.Git --accept-package-agreements --accept-source-agreements
winget install -e --id Microsoft.VCRedist.2015+.x64 --accept-package-agreements --accept-source-agreements
winget install -e --id Microsoft.DotNet.DesktopRuntime.7 --accept-package-agreements --accept-source-agreements
winget install -e --id "Flow Launcher" --accept-package-agreements --accept-source-agreements

# Install C++ compiler
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
choco install zig

# Setup configs
Set-Location ~/AppData/Local
New-Item -ItemType SymbolicLink -Path "~/AppData/Local/nvim" -Target "~/AppData/Local/configurations/nvim"
New-Item -ItemType SymbolicLink -Path "~/AppData/Local/alacritty" -Target "~/AppData/Local/configurations/alacritty"

