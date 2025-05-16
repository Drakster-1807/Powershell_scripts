# Retrieve credentials stored in Windows Credential Manager
$cred = Get-StoredCredential -Target "Server1Creds"
$secPassword = ConvertTo-SecureString $cred.Password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($cred.Username, $secPassword)

try {
    # Establish remote session
    $session = New-PSSession -ComputerName 192.168.1.116 -Credential $credential

    # Run Windows Update remotely
    $result = Invoke-Command -Session $session -ScriptBlock {
        try {
            Import-Module PSWindowsUpdate
            Install-WindowsUpdate -AcceptAll -AutoReboot -ErrorAction Stop
            return "Windows Update completed successfully on $(hostname)."
        }
        catch {
            return "Windows Update FAILED on $(hostname): $_"
        }
    }

    # Clean up session
    Remove-PSSession $session

    # Display result
    Write-Host $result -ForegroundColor Green
}
catch {
    Write-Host "Remote session or update failed: $_" -ForegroundColor Red
}