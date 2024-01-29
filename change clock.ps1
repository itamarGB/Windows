<#
    .SYNOPSIS
    Time Zone Adjustment Script for Israel Standard Time

    .DESCRIPTION
    This PowerShell script is designed to update the Windows Registry to set the time zone information for Israel Standard Time.
    It handles the necessary adjustments and configurations for the system's time zone settings.

    .AUTHOR
    Script written by Itamar.
    For more scripts and projects, visit my GitHub: https://github.com/itamarGB

    .NOTES
    Created: 01/29/2024

    .EXAMPLE
    To run this script, just execute it in a PowerShell session with administrative privileges.
    Ensure that you understand the changes being made to the system's registry.

    
#>
# Set the values
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones\Israel Standard Time"
Set-ItemProperty -Path $registryPath -Name "Display" -Value "(UTC+02:00) Jerusalem"
Set-ItemProperty -Path $registryPath -Name "Dlt" -Value "Jerusalem Daylight Time"
Set-ItemProperty -Path $registryPath -Name "MUI_Display" -Value "@tzres.dll,-370"
Set-ItemProperty -Path $registryPath -Name "MUI_Dlt" -Value "@tzres.dll,-371"
Set-ItemProperty -Path $registryPath -Name "MUI_Std" -Value "@tzres.dll,-372"
Set-ItemProperty -Path $registryPath -Name "Std" -Value "Jerusalem Standard Time"

#binary data
$TZIValue = [byte[]](0x88,0xff,0xff,0xff,0x00,0x00,0x00,0x00,0xc4,0xff,0xff,0xff,0x00,0x00,0x0a,0x00,0x00,0x00,0x05,0x00,0x02,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x03,0x00,0x05,0x00,0x05,0x00,0x02,0x00,0x00,0x00,0x00,0x00,0x00,0x00)
Set-ItemProperty -Path $registryPath -Name "TZI" -Value $TZIValue -Type Binary

# Set the values for 'Israel Standard Time\Dynamic DST'
$dynamicDSTPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Time Zones\Israel Standard Time\Dynamic DST"

# Function to convert hex string to byte array
function HexToByteArray($hexString) {
    $hexString = $hexString -replace "\\s|\\,", '' # Remove spaces and commas
    [byte[]]$byteArray = for ($i = 0; $i -lt $hexString.Length; $i += 2) {
        [Convert]::ToByte($hexString.Substring($i, 2), 16)
    }
    return $byteArray
}

$dynamicDSTValues = @{
    "2004" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,09,00,03,00,04,00,01,00,00,00,00,00,00,00,00,00,04,00,03,00,01,00,01,00,00,00,00,00,00,00"
    "2005" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,02,00,02,00,00,00,00,00,00,00,00,00,04,00,05,00,01,00,02,00,00,00,00,00,00,00"
    "2006" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,01,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2007" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,09,00,00,00,03,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2008" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,01,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2009" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,09,00,00,00,05,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2010" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,09,00,00,00,02,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2011" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,01,00,02,00,00,00,00,00,00,00,00,00,04,00,05,00,01,00,02,00,00,00,00,00,00,00"
    "2012" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,09,00,00,00,04,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2013" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,05,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2014" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,05,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2015" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,05,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2016" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,05,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2017" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,05,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,04,00,02,00,00,00,00,00,00,00"
    "2018" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,05,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,04,00,02,00,00,00,00,00,00,00"
    "2019" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,05,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2020" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,05,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2021" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,05,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2022" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,05,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
    "2023" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,05,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,04,00,02,00,00,00,00,00,00,00"
    "2024" = "88,ff,ff,ff,00,00,00,00,c4,ff,ff,ff,00,00,0a,00,00,00,05,00,02,00,00,00,00,00,00,00,00,00,03,00,05,00,05,00,02,00,00,00,00,00,00,00"
}

foreach ($year in $dynamicDSTValues.Keys) {
    $byteArray = HexToByteArray $dynamicDSTValues[$year]
    Set-ItemProperty -Path $dynamicDSTPath -Name $year -Value $byteArray -Type Binary
}

Set-ItemProperty -Path $dynamicDSTPath -Name "FirstEntry" -Value 0x000007d4 -Type DWord
Set-ItemProperty -Path $dynamicDSTPath -Name "LastEntry" -Value 0x000007e8 -Type DWord
