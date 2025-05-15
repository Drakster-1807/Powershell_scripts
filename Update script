# Hent gemt legitimationsoplysninger
$cred = Get-StoredCredential -Target '192.168.1.116'

# Indstillinger for serveren
$server = "192.168.1.116"

# Ensure the PSWindowsUpdate module is loaded
Import-Module PSWindowsUpdate

# Check for available updates
Write-Host "Checking for available updates..." -ForegroundColor Cyan
$updates = Get-WindowsUpdate

if ($updates) {
    Write-Host "Updates found, installing now..." -ForegroundColor Yellow
    # Install available updates
    $updates | Install-WindowsUpdate -AcceptAll -AutoReboot
    Write-Host "Updates have been installed successfully." -ForegroundColor Green
} else {
    Write-Host "No updates available at this time." -ForegroundColor Green
}
