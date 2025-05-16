# Retrieve stored credentials
$cred = Get-StoredCredential -Target '192.168.1.116'

# Define the server IP address
$server = '192.168.1.116'

# Define the message to be displayed
$message = "This is a message from Client1."

# Execute the command on the remote server
Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock {
    param ($msg)
    # Send message to all users on the remote server
    msg * /time:60 $msg
} -ArgumentList $message