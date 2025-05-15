# Server IP or name
$server = "192.168.1.116"

# Credentials (hardcoded)
$username = "administrator"

# Convert plain text password to secure string
$password = ConvertTo-SecureString "Kode1234!" -AsPlainText -Force

# Create PSCredential object
$cred = New-Object System.Management.Automation.PSCredential ($username, $password)

# Invoke the Restart-Computer command remotely
Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock {
    Restart-Computer -Force
}
