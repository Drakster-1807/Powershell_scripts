# Define variables
$server = '192.168.1.116'
$targetFolder = "TempCSV\CSV"
$localFilePath = "C:\TestFolder\TestDocument.txt"  # Your specific file path
$remoteDriveLetter = "Z:"  # Temporary drive letter to map

# Get stored credential
$cred = Get-StoredCredential -Target $server

if (-not $cred) {
    Write-Error "No stored credential found for $server"
    exit
}

# Map network drive to admin share C$ on the server
New-PSDrive -Name "Z" -PSProvider FileSystem -Root "\\$server\C$" -Credential $cred -ErrorAction Stop

try {
    # Ensure remote directory exists
    $remoteFullPath = Join-Path "$remoteDriveLetter\" $targetFolder
    if (-not (Test-Path $remoteFullPath)) {
        New-Item -Path $remoteFullPath -ItemType Directory -Force | Out-Null
        Write-Output "Created remote directory $remoteFullPath"
    }

    # Copy the file
    $destinationFilePath = Join-Path $remoteFullPath ([System.IO.Path]::GetFileName($localFilePath))
    Copy-Item -Path $localFilePath -Destination $destinationFilePath -Force
    Write-Output "Copied $localFilePath to $destinationFilePath"
}
finally {
    # Remove the mapped drive
    Remove-PSDrive -Name "Z" -Force
}