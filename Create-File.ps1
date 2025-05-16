# Retrieve stored credentials
$cred = Get-StoredCredential -Target '192.168.1.116'

# Define the server IP address
$server = '192.168.1.116'

# Execute the command on the remote server
Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock {
    $folderPath = "C:\Temp"
    $filePath = Join-Path -Path $folderPath -ChildPath "Sample.txt"
    $content = "This is a sample file."

    # Check if the folder exists; if not, create it
    if (-not (Test-Path -Path $folderPath -PathType Container)) {
        New-Item -ItemType Directory -Path $folderPath
    }

    # Create the file with the specified content
    Set-Content -Path $filePath -Value $content
}