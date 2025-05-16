$cred = Get-StoredCredential -Target '192.168.1.116'

Invoke-Command -ComputerName '192.168.1.116' -Credential $cred -ScriptBlock {
    $results = @()

    $paths = @(
        'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*',
        'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
    )

    foreach ($path in $paths) {
        $items = Get-ItemProperty $path -ErrorAction SilentlyContinue |
                 Where-Object { $_.DisplayName } |
                 Select-Object DisplayName, DisplayVersion, Publisher
        $results += $items
    }

    return $results
}