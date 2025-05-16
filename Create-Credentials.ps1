# Define username and password variables
$Username = "UserNameHere"
$Password = "PasswordHere"

# Convert plain text password to secure string
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

# Create credential object
$cred = New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)

# Save credential to Credential Manager for IP 192.168.1.116
cmdkey /generic:"192.168.1.116" /user:$cred.UserName /pass:$Password

Write-Output "Credential for 192.168.1.116 saved successfully."