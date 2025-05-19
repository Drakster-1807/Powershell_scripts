$Username = "DETFEDEHOLD0\Administrator"
$Password = "Kode1234!"

# Convert plain text password to secure string
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

# Create credential object
$cred = New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)

# Build cmdkey command string
$cmd = "cmdkey /generic:`"192.168.1.116`" /user:`"$($cred.UserName)`" /pass:`"$Password`""

# Execute cmdkey command
Invoke-Expression $cmd

Write-Output "Credential for 192.168.1.116 saved successfully."