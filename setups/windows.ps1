param (
  [string[]]$packagesToSkip = @()
)

# Install basic tools
foreach ($package in $packagesToInstall) {
    winget install --id $package --accept-package-agreements --accept-source-agreements
}

# Install NVIM
$nvimPowershellPath = Join-Path $PSScriptRoot "scripts/nvim.ps1"
& $nvimPowershellPath

# Setup profile
$profilePath = $PROFILE.CurrentUserCurrentHost
$profileDirectory = [System.IO.Path]::GetDirectoryName($profilePath)
if (-not (Test-Path -Path $profileDirectory -PathType Container)) {
    New-Item -ItemType Directory -Path $profileDirectory -Force
}

$windowsPowershellPath = Join-Path $PSScriptRoot "content/powershell.ps1"
$windowsPowershellContent = Get-Content -Path $windowsPowershellPath -Raw
Set-Content -Path $profilePath -Value $windowsPowershellContent -Force

# Add font
$fontUrl = "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/DroidSansMono.zip"
$downloadPath = "$env:TEMP\DroidSansMono.zip"
$extractPath = "$env:TEMP\DroidSansMono"

Invoke-WebRequest -Uri $fontUrl -OutFile $downloadPath
Expand-Archive -Path $downloadPath -DestinationPath $extractPath

$fontFiles = Get-ChildItem -Path $extractPath -Filter "*.ttf"
$installFontScript = Join-Path $PSScriptRoot "lib/Add-Font.ps1"
foreach ($fontFile in $fontFiles) {
  & $installFontScript -FontFile $fontFile.FullName
}

Remove-Item -Path $downloadPath -Force
Remove-Item -Path $extractPath -Force

# Setup terminal
$terminalProfilePath = "$HOME\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$windowsTerminalPath = Join-Path $PSScriptRoot "content/windowsTerminal.json"
$windowsTerminalContent = Get-Content -Path $windowsTerminalPath -Raw

if (-not (Test-Path -Path $terminalProfilePath -PathType Leaf)) {
    New-Item -ItemType File -Path $terminalProfilePath -Force
}

Set-Content -Path $terminalProfilePath -Value $windowsTerminalContent -Force

# Setup WezTerm
$weztermPath = Join-Path $PSScriptRoot "content/wezterm.lua"
$weztermContent = Get-Content -Path $weztermPath -Raw
$weztermNewPath = "$HOME\.wezterm.lua"
Set-Content -Path $weztermNewPath -Value $weztermContent -Force

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

# Locals
$packagesToInstall = @(
    'Git.Git',
    'Microsoft.VCRedist.2015+.x64',
    'Starship.Starship',
    'Microsoft.Powershell',
    'Microsoft.WindowsTerminal',
    'zig.zig',
    'BurntSushi.ripgrep.MSVC',
    'OpenJS.Node.js',
    'Flow Launcher',
    'wez.wezterm'
) | Where-Object { $_ -notin $packagesToSkip }
