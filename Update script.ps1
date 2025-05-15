# Import necessary modules
Import-Module CredentialManager
Import-Module PSWindowsUpdate

# Retrieve stored credentials
$cred = Get-StoredCredential -Target '192.168.1.116'

# Check if credentials are retrieved
if ($cred) {
    # Execute the Windows Update job on the remote server
    Invoke-WUJob -ComputerName '192.168.1.116' -Credential $cred -Script {
        Import-Module PSWindowsUpdate
        Install-WindowsUpdate -AcceptAll -AutoReboot
    } -Confirm:$false -RunNow
} else {
    Write-Host "Credentials for 192.168.1.116 not found in Credential Manager." -ForegroundColor Red
}