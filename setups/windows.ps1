# Install basic tools
winget install -e --id Neovim.Neovim --accept-package-agreements --accept-source-agreements
winget install -e --id Git.Git --accept-package-agreements --accept-source-agreements
winget install -e --id Microsoft.VCRedist.2015+.x64 --accept-package-agreements --accept-source-agreements
winget install -e --id Microsoft.DotNet.DesktopRuntime.7 --accept-package-agreements --accept-source-agreements
winget install -e --id Starship.Starship --accept-package-agreements --accept-source-agreements
winget install -e --id Microsoft.Powershell --accept-package-agreements --accept-source-agreements --source winget
winget install -e --id Google.Chrome --accept-package-agreements --accept-source-agreements 
winget install -e --id Microsoft.WindowsTerminal --accept-package-agreements --accept-source-agreements 
winget install -e --id Microsoft.dotnet --accept-package-agreements --accept-source-agreements 
winget install -e --id Yarn.Yarn --accept-package-agreements --accept-source-agreements 
winget install -e --id Schniz.fnm --accept-package-agreements --accept-source-agreements 
winget install -e --id Microsoft.VisualStudioCode --accept-package-agreements --accept-source-agreements 
winget install -e --id 7zip.7zip --accept-package-agreements --accept-source-agreements 
winget install -e --id zig.zig --accept-package-agreements --accept-source-agreements 

# Envs
$executingDir = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

# Setup configs
$nvimLinkPath = Join-Path $HOME "AppData\Local\nvim"
$nvimTargetPath = Join-Path $HOME "AppData\Local\configurations\nvim"
New-Item -ItemType SymbolicLink -Path $nvimLinkPath -Target $nvimTargetPath

# Setup profile
$profilePath = $PROFILE.CurrentUserCurrentHost
$profileDirectory = [System.IO.Path]::GetDirectoryName($profilePath)

if (-not (Test-Path -Path $profileDirectory -PathType Container)) {
    New-Item -ItemType Directory -Path $profileDirectory -Force
}

$windowsPowershellPath = Join-Path $PSScriptRoot "windowsPowershell.ps1"
$windowsPowershellContent = Get-Content -Path $windowsPowershellPath -Raw
Set-Content -Path $profilePath -Value $windowsPowershellContent -Force

# Setup terminal
$terminalProfilePath = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$windowsTerminalPath = Join-Path $PSScriptRoot "windowsTerminal.json"
$windowsTerminalContent = Get-Content -Path $windowsTerminalPath -Raw

if (-not (Test-Path -Path $terminalProfilePath -PathType Leaf)) {
    New-Item -ItemType File -Path $terminalProfilePath -Force
}

Set-Content -Path $terminalProfilePath -Value $windowsTerminalContent -Force

# Setup starship
$starshipDownloadUrl = "https://github.com/dracula/starship/archive/master.zip"
$starshipDownloadPath = Join-Path $env:TEMP "starship.zip"
$starshipExtractPath = Join-Path $env:TEMP "starship"

Invoke-WebRequest -Uri $starshipDownloadUrl -OutFile $starshipDownloadPath
Expand-Archive -Path $starshipDownloadPath -DestinationPath $starshipExtractPath -Force

$starshipConfigPath = Join-Path $HOME ".config\starship.toml"
Move-Item -Path (Join-Path $starshipExtractPath "starship-master\starship.toml") -Destination $starshipConfigPath -Force

Remove-Item -Path $starshipDownloadPath -Force
Remove-Item -Path $starshipExtractPath -Force

# Add font
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DroidSansMono.zip"
$downloadPath = "$env:TEMP\DroidSansMono.zip"
$extractPath = "$env:TEMP\DroidSansMono"

Invoke-WebRequest -Uri $fontUrl -OutFile $downloadPath
Expand-Archive -Path $downloadPath -DestinationPath $extractPath

$fontFiles = Get-ChildItem -Path $extractPath -Filter "*.ttf"
foreach ($fontFile in $fontFiles) {
    Add-Font -LiteralPath $fontFile.FullName
}

Remove-Item -Path $downloadPath -Force
Remove-Item -Path $extractPath -Force

