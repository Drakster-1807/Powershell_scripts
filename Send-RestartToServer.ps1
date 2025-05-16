# Hent gemt legitimationsoplysninger
$cred = Get-StoredCredential -Target '192.168.1.116'

# Indstillinger for serveren
$server = "192.168.1.116"

# Kommando til at genstarte serveren
$restartCommand = "shutdown.exe /r /f /t 0"  # Genstart med det samme uden ventetid

# Kør kommandoen på serveren via PowerShell Remoting
$response = Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock {
    param($cmd)
    Invoke-Expression $cmd
} -ArgumentList $restartCommand

Write-Host $response;;;;;
