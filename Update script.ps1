# Retrieve credentials from Windows Credential Manager
$cred = Get-StoredCredential -Target "Server1Creds"
if (-not $cred) {
    Write-Host "ERROR: Could not find credentials named 'Server1Creds' in Credential Manager." -ForegroundColor Red
    exit 1
}

# Convert to PSCredential
$secPassword = ConvertTo-SecureString $cred.Password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($cred.Username, $secPassword)

try {
    # Try creating a session
    $session = New-PSSession -ComputerName 192.168.1.116 -Credential $credential -ErrorAction Stop
}
catch {
    Write-Host "ERROR: Failed to create remote session to 192.168.1.116 - $_" -ForegroundColor Red
    exit 1
}

# Proceed only if session is valid
if ($session) {
    try {
        $result = Invoke-Command -Session $session -ScriptBlock {
            try {
                Import-Module PSWindowsUpdate -ErrorAction Stop
                Install-WindowsUpdate -AcceptAll -AutoReboot -ErrorAction Stop
                return "SUCCESS: Windows Update completed successfully on $(hostname)."
            }
            catch {
                return "FAILURE: Windows Update failed on $(hostname): $_"
            }
        }

        Write-Host $result -ForegroundColor Green
    }
    catch {
        Write-Host "ERROR: Remote command execution failed: $_" -ForegroundColor Red
    }
    finally {
        Remove-PSSession $session
    }
} else {
    Write-Host "ERROR: Session object is null. Cannot continue." -ForegroundColor Red
}