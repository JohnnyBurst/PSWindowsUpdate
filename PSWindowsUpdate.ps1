#This is a multi-part script. The first part will pull a list of available updates from Microsoft. After the list has populated within the log file, ensure none are identified as a conflict to the OS and applications installed (Exchange, specific applications, and File server).
#Login to server to run updates from for the servers within the environment.
#Open powershell as an administrator. Run the following script.

Install-Module -Name PSWindowsUpdate

#If PSWindowsUpdate is already installed, add the flag -force to the end of the above line to force the install of a new version of PSWindowsUpdate

get-wulist -computername server1,server2,server3 | Out-File c:\PSWindowsUpdateToBeInstalled.log

#The following script will install Microsoft updates on the identified servers listed in the script. If the first script does not run properly, attempt the second script.

Invoke-WUInstall -ComputerName server1,server2,server3 -Script {ipmo PSWindowsUpdate; Get-WindowsUpdate -Install -AcceptAll -AutoReboot| Out-File C:\PSWindowsUpdate.log } -Confirm:$false -Verbose -SkipModuleTest –RunNow



$ServerNames = "server1,server2,server3"
Invoke-WUJob -ComputerName $ServerNames -Script {ipmo PSWindowsUpdate; Install-WindowsUpdate -AcceptAll | Out-File C:\PSWindowsUpdate.log } -RunNow -Confirm:$false
