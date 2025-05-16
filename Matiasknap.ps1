Add-Type -AssemblyName System.Windows.Forms

# Boksen kommer frem
$resultat = [System.Windows.Forms.MessageBox]::Show(
    "Vil du gøre Michael glad?",
    "Et vigtigt spørgsmål",
    [System.Windows.Forms.MessageBoxButtons]::YesNo,
    [System.Windows.Forms.MessageBoxIcon]::Question
)

if ($resultat -eq [System.Windows.Forms.DialogResult]::Yes) {
    # Åben 
    Start-Process "https://shattereddisk.github.io/rickroll/rickroll.mp4"
}
else {
    # Vis din dominans
    [System.Windows.Forms.MessageBox]::Show(
        "Så må du tage konsekvensen...",
        [System.Windows.Forms.MessageBoxButtons]::OK,
        [System.Windows.Forms.MessageBoxIcon]::Warning
    )
    # Genstart computeren
    Restart-Computer -Force
}
