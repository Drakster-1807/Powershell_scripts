$session = New-PSSession -ComputerName 192.168.1.116 -Credential $credential

Invoke-Command -Session $session -ScriptBlock {
    Import-Module PSWindowsUpdate
    Install-WindowsUpdate -AcceptAll -AutoReboot
}

Remove-PSSession $session