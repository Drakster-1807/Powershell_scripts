$server = "192.168.1.116"
$credTarget = "192.168.1.116"

Write-Host "🧪 PowerShell Remoting Diagnostic - Server: $server" -ForegroundColor Cyan

# Check 1: Test WinRM availability
Write-Host "`n[1] Testing WinRM connectivity..." -ForegroundColor Yellow
try {
    Test-WSMan -ComputerName $server -ErrorAction Stop
    Write-Host "✅ WinRM is accessible on $server." -ForegroundColor Green
} catch {
    Write-Host "❌ Cannot connect to $server via WinRM: $_" -ForegroundColor Red
}

# Check 2: Check TrustedHosts configuration
Write-Host "`n[2] Checking TrustedHosts setting..." -ForegroundColor Yellow
$trusted = Get-Item WSMan:\localhost\Client\TrustedHosts
if ($trusted.Value -eq $server -or $trusted.Value -eq "*") {
    Write-Host "✅ TrustedHosts includes $server." -ForegroundColor Green
} else {
    Write-Host "⚠️ TrustedHosts does NOT include $server. Current value: $($trusted.Value)" -ForegroundColor DarkYellow
    Write-Host "👉 Suggested fix: Set-Item WSMan:\localhost\Client\TrustedHosts -Value '$server' -Force" -ForegroundColor Gray
}

# Check 3: Verify credentials from CredentialManager
Write-Host "`n[3] Checking stored credentials..." -ForegroundColor Yellow
Import-Module CredentialManager
$cred = Get-StoredCredential -Target $credTarget
if ($cred) {
    Write-Host "✅ Credential '$credTarget' found." -ForegroundColor Green
    if ($cred.Username -match "\\") {
        Write-Host "✅ Username format looks valid: $($cred.Username)" -ForegroundColor Green
    } else {
        Write-Host "⚠️ Username may need prefix (e.g., '$server\\Administrator'): $($cred.Username)" -ForegroundColor DarkYellow
    }
} else {
    Write-Host "❌ Credential '$credTarget' not found in Credential Manager." -ForegroundColor Red
    exit 1
}

# Check 4: Attempt test connection with credential
Write-Host "`n[4] Testing remote PowerShell session..." -ForegroundColor Yellow
$secPass = ConvertTo-SecureString $cred.Password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($cred.Username, $secPass)

try {
    $session = New-PSSession -ComputerName $server -Credential $credential -ErrorAction Stop
    Invoke-Command -Session $session -ScriptBlock {
        "✅ Remote PowerShell test command succeeded on $env:COMPUTERNAME."
    }
    Remove-PSSession $session
} catch {
    Write-Host "❌ Remote PowerShell session FAILED: $_" -ForegroundColor Red
    Write-Host "👉 Troubleshoot: Check username, enable remoting, or try CredSSP authentication." -ForegroundColor Gray
}

Write-Host "`n✅ Diagnostic complete." -ForegroundColor Cyan