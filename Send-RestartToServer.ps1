# Indstillinger for serveren
$server = "192.168.1.116"
$username = "Administrator"  # Brug den korrekte brugernavn for serveren
$password = "Kode1234!"   # Brug den korrekte adgangskode for serveren

# Opret en PSCredential objekt
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $securePassword)

# Kommando til at genstarte serveren
$restartCommand = "shutdown.exe /r /f /t 0"  # Genstart med det samme uden ventetid

# Kør kommandoen på serveren via PowerShell Remoting
Invoke-Command -ComputerName $server -Credential $credential -ScriptBlock {
    param($cmd)
    Invoke-Expression $cmd
} -ArgumentList $restartCommand
