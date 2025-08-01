Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$bsod = @"
A problem has been detected and Windows has been shut down to prevent damage to your computer.

The problem seems to be caused by the following file: prank.sys

PAGE_FAULT_IN_NONPAGED_AREA

If this is the first time you've seen this Stop error screen,
restart your computer. If this screen appears again, follow
these steps:

Check to make sure any new hardware or software is properly installed.
If this is a new installation, ask your hardware or software manufacturer
for any Windows updates you might need.

STOP: 0x00000050 (0xFFFFF880009AA000, 0x0000000000000000, 0xFFFFF80002AC8F32, 0x0000000000000000)
"@

$form = New-Object Windows.Forms.Form
$form.Text = "Windows Error"
$form.WindowState = "Maximized"
$form.BackColor = 'DarkBlue'
$form.FormBorderStyle = 'None'
$form.TopMost = $true

$label = New-Object Windows.Forms.Label
$label.Text = $bsod
$label.ForeColor = 'White'
$label.Font = New-Object Drawing.Font("Consolas", 16)
$label.Dock = 'Fill'
$label.TextAlign = 'TopLeft'

$form.Controls.Add($label)
$form.ShowDialog()
