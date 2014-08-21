
# Sets Preferences in the skype config XML
# Stops Skype, Sets preferences, saves xml and starts skype


# Stop Skype
Stop-Process -ProcessName skype

Start-Sleep -Seconds 2

# Find Skype Config XML
$SkypeConfigFile = Get-ChildItem -Path $env:APPDATA\Skype -Recurse | Where-Object {$_.Name -eq 'config.xml'}

# Backup File in case of any issues
Copy-Item $SkypeConfigFile.FullName -Destination ("$($SkypeConfigFile.FullName)" + ".backup")

[XML]$SkypeConfigAsXML = Get-Content $SkypeConfigFile.FullName

# Set the Font size, not number does not equate to exact size for some reason. 16 is 12
$SkypeConfigAsXML.config.ui.Chat.FontHeight = '16'

# Remove Taskbar icon
$SkypeConfigAsXML.config.ui.General.KeepTaskbarIcon = '0'

# Multiple Chat Windows
$SkypeConfigAsXML.config.ui.General.MultiWindowMode = '1'

# Disable Promotions and Tips
$SkypeConfigAsXML.config.Lib.DynContent.DisablePromo = '1'
$SkypeConfigAsXML.config.Lib.DynContent.DisableTip = '1'

# Save XML back to disk
$SkypeConfigAsXML.Save("$($SkypeConfigFile.FullName)")

Start-Sleep -Seconds 2

& 'C:\Program Files (x86)\Skype\Phone\Skype.exe'


