$cred = Get-StoredCredential -Target '192.168.1.116'
Invoke-Command -ComputerName '192.168.1.116' -Credential $cred -ScriptBlock {
    Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* |
    Select-Object DisplayName, DisplayVersion, Publisher | 
    Where-Object { $_.DisplayName }
}