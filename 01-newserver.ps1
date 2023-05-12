Clear-Host
Write-Host "This script will perform Windows Updates, then join the server to the domain `n You will be prompted to enter the duracell\domainjoiner.im password before it is joined to the domain."

if (get-command get-windowsupdate) { 
    Get-WindowsUpdate
    Install-WindowsUpdate -AcceptAll
}
else { 
    Install-Module -Name PSWindowsUpdate -SkipPublisherCheck -Force -acceptlicense 
    Get-WindowsUpdate
    Install-WindowsUpdate -AcceptAll    
}

Rename-LocalUser -name "administrator" -NewName "DefaultAdmin"
Rename-LocalUser -name "guest" -NewName "DefaultGuest"
Disable-LocalUser -name "DefaultAdmin"
Disable-LocalUser -name "DefaultGuest"
Disable-LocalUser -name "DefaultAccount"

#$domainjoinerPASS = Read-Host Enter domainjoiner.im Password -AsSecureString -Force
#$domainjoinerCRED = New-Object pscredential -ArgumentList ([[PSCustomObject]@{
#    UserName = duracell\domainjoiner.im
#    Password = $domainjoinerPASS
#}])
Add-Computer -domain "corp.duracell.com" -Credential "duracell\domainjoiner.im" -Force -OUPath "OU=Servers,DC=corp,DC=duracell,DC=com"
