# Define variables
$server = '192.168.1.116'
$targetFolder = "C:\TempCSV\CSV"
$localFilePath = "C:\Path\To\Your\LocalFile.txt"  # <-- Change this to your actual file path
$remoteFileName = [System.IO.Path]::GetFileName($localFilePath)
$remoteFilePath = Join-Path -Path $targetFolder -ChildPath $remoteFileName

# Get stored credential for the server IP
$cred = Get-StoredCredential -Target $server

if (-not $cred) {
    Write-Error "No stored credential found for $server"
    exit
}

# Create the remote folder if it doesn't exist
Invoke-Command -ComputerName $server -Credential $cred -ScriptBlock {
    param ($path)
    if (-not (Test-Path -Path $path -PathType Container)) {
        New-Item -Path $path -ItemType Directory -Force | Out-Null
        Write-Output "Created folder $path on server."
    }
} -ArgumentList $targetFolder

# Copy the file to the remote server
Copy-Item -Path $localFilePath -Destination "\\$server\C$\TempCSV\CSV" -Credential $cred -Force

Write-Output "File copied to $remoteFilePath on server $server."