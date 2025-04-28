# Simple installer using winget with check if app is already installed

# Check if running as admin
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "Please run this script as Administrator." -ForegroundColor Red
    exit 1
}

# Check if winget is installed
if (!(Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Host "Winget is not installed. Exiting." -ForegroundColor Red
    exit 1
}

# App list
$appList = @(
    @{ Name = "Google Chrome"; Id = "Google.Chrome" },
    @{ Name = "Spotify"; Id = "Spotify.Spotify" },
    @{ Name = "7zip"; Id = "7zip.7zip" },
    @{ Name = "Git"; Id = "Git.Git" },
    @{ Name = "Visual Studio Code"; Id = "Microsoft.VisualStudioCode" },
    @{ Name = "NodeJS"; Id = "OpenJS.NodeJS.LTS" },
    @{ Name = "Python 3.10"; Id = "Python.Python.3.10" },
    @{ Name = "VLC"; Id = "VideoLAN.VLC" },
    @{ Name = "XAMPP"; Id = "ApacheFriends.Xampp.8.2" },
    @{ Name = "Paint.NET"; Id = "dotPDN.PaintDotNet" },
    @{ Name = "Everything"; Id = "voidtools.Everything" },
    @{ Name = "Telegram"; Id = "Telegram.TelegramDesktop" },
    @{ Name = "ShareX"; Id = "ShareX.ShareX" },
    @{ Name = "Steam"; Id = "Valve.Steam" },
    @{ Name = "Valorant"; Id = "RiotGames.Valorant.EU" },
    @{ Name = "Revo Uninstaller"; Id = "RevoUninstaller.RevoUninstaller" },
    @{ Name = "MobaXterm"; Id = "Mobatek.MobaXterm" },
    @{ Name = "Discord Canary"; Id = "Discord.Discord.Canary" }
    @{ Name = "OBS Studio 30.2.3"; Id = "OBSProject.OBSStudio.30.2.3"}
)
    
foreach ($app in $appList) {
    $alreadyInstalled = winget list --id $app.Id -e | Select-String $app.Id

    if ($alreadyInstalled) {
        Write-Host "$($app.Name) is already installed. Skipping." -ForegroundColor Yellow
    } else {
        Write-Host "Installing $($app.Name)..." -ForegroundColor Cyan
        winget install --id $app.Id --accept-package-agreements --accept-source-agreements -e
        if ($LASTEXITCODE -eq 0) {
            Write-Host "$($app.Name) installed successfully!" -ForegroundColor Green
        } else {
            Write-Host "Failed to install $($app.Name)." -ForegroundColor Red
        }
    }
}

Write-Host "All installations completed!" -ForegroundColor Magenta
