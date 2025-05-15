# Import necessary modules
Import-Module CredentialManager
Import-Module PSWindowsUpdate

# Retrieve stored credentials
$cred = Get-StoredCredential -Target '192.168.1.116'

# Define the server
$server = "192.168.1.116"

# Check for available updates
Write-Host "Checking for available updates on $server..." -ForegroundColor Cyan
$updates = Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock {
    Import-Module PSWindowsUpdate
    Get-WindowsUpdate
}

if ($updates) {
    Write-Host "Updates found, installing now..." -ForegroundColor Yellow
    # Install available updates
    Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock {
        Import-Module PSWindowsUpdate
        Install-WindowsUpdate -AcceptAll -AutoReboot
    }
    Write-Host "Updates have been installed successfully." -ForegroundColor Green
} else {
    Write-Host "No updates available at this time." -ForegroundColor Green
}
