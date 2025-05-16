# Retrieve stored credentials
$cred = Get-StoredCredential -Target '192.168.1.116'

# Define the server IP address
$server = '192.168.1.116'

# Execute the command on the remote server
Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock {
    $filePath = "C:\Temp\Sample.txt"
    $content = "This is a sample file."
    Set-Content -Path $filePath -Value $content
}