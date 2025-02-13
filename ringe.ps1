# PowerShell script for the COFECHA program

# Function to simulate key presses
function Send-Keys {
    param ([string]$keys)
    Add-Type -AssemblyName System.Windows.Forms
    [System.Windows.Forms.SendKeys]::SendWait($keys)
}

# Function to run COFECHA with specific input files
function Run-Cofecha {
    param (
        [string]$identifier,
        [string]$inputFile,
        [string]$undatedFile,
        [string]$outputFile
    )
    
    Start-Process -FilePath "C:\cofecha\cofecha.exe" -PassThru
    Start-Sleep -Seconds 5
    
    Send-Keys "$identifier"
    Start-Sleep -Seconds 2
    Send-Keys "{ENTER}"
    Start-Sleep -Seconds 2
    Send-Keys "$inputFile"
    Start-Sleep -Seconds 2
    Send-Keys "{ENTER}"
    Start-Sleep -Seconds 2
    Send-Keys "{ENTER}"
    Start-Sleep -Seconds 2
    Send-Keys "$undatedFile"
    Start-Sleep -Seconds 2
    Send-Keys "{ENTER}"
    Start-Sleep -Seconds 2
    Send-Keys "{ENTER}"
    Start-Sleep -Seconds 2
    Send-Keys "ringe"
    Start-Sleep -Seconds 2
    Send-Keys "{ENTER}"
    Start-Sleep -Seconds 2
    Send-Keys "8"
    Start-Sleep -Seconds 2
    Send-Keys "{ENTER}"
    Start-Sleep -Seconds 2
    Send-Keys "8"
    Start-Sleep -Seconds 4
    Send-Keys "{ENTER}"
    Start-Sleep -Seconds 2
    Send-Keys "{ENTER}"
    Start-Sleep -Seconds 2
    Send-Keys "{ENTER}"
    Start-Sleep -Seconds 2
    Send-Keys "{ENTER}"
    Start-Sleep -Seconds 2
    Send-Keys "^s"
    Start-Sleep -Seconds 2
    Send-Keys "$outputFile"
    Start-Sleep -Seconds 2
    Send-Keys "{ENTER}"
    Start-Sleep -Seconds 2
    Send-Keys "%{F4}"
    Start-Sleep -Seconds 2
}

# Run COFECHA for different datasets
Run-Cofecha -identifier "br050" -inputFile "C:\cofecha\brit050.rwl" -undatedFile "C:\cofecha\ringe22.rwl" -outputFile "out6.rwl"
Run-Cofecha -identifier "au001" -inputFile "C:\cofecha\aust001.rwl" -undatedFile "C:\cofecha\ringe22.rwl" -outputFile "out6.rwl"
Run-Cofecha -identifier "au002" -inputFile "C:\cofecha\aust002.rwl" -undatedFile "C:\cofecha\ringe22.rwl" -outputFile "out7.rwl"

# Open PowerShell and process output files
Start-Process -FilePath "powershell.exe"
Start-Sleep -Seconds 2
Send-Keys "Get-Process{ENTER}"
Start-Sleep -Seconds 5
Send-Keys "Get-Content C:\cofecha\BR050COF.OUT, C:\cofecha\AU001COF.OUT, C:\cofecha\AU002COF.OUT | Set-Content C:\cofecha\ringe12kurz.txt{ENTER}"
Start-Sleep -Seconds 2
Send-Keys "EXIT{ENTER}"

# Close all open programs
Get-Process | Where-Object { $_.MainWindowTitle } | ForEach-Object { Stop-Process -Id $_.Id -Force }
