Clear-Host
Write-Host "This script creates two user accounts, <servername>-ADM01 and <servername>-ADM02 in Active Directory for use in new server builds. `n It also moves the computer to the correct OU in Active Directory.`n"


$servername = read-host Enter Server Name
$temppasswd = ConvertTo-SecureString -String "Durw0rdP@ss2017!" -AsPlainText -Force

New-ADUser -name $servername-ADM01 -DisplayName $servername-ADM01 -SamAccountName $servername-ADM01 -UserPrincipalName $servername-ADM01@corp.duracell.com -Description 'Cyberark PAM' -Manager gentry.d -ChangePasswordAtLogon $false -CannotChangePassword $false -Enabled $true -Path "OU=Shared,OU=Accounts,DC=corp,DC=duracell,DC=com" -AccountPassword $temppasswd
New-ADUser -name $servername-ADM02 -DisplayName $servername-ADM02 -SamAccountName $servername-ADM02 -UserPrincipalName $servername-ADM02@corp.duracell.com -Description 'Cyberark PAM' -Manager gentry.d -ChangePasswordAtLogon $false -CannotChangePassword $false -Enabled $true -Path "OU=Shared,OU=Accounts,DC=corp,DC=duracell,DC=com" -AccountPassword $temppasswd

#Not needed, specified in domain join command in 01
#Move-ADObject -Identity "CN=$servername,CN=Computers,DC=corp,DC=duracell,DC=com" -TargetPath "OU=Servers,DC=corp,DC=duracell,DC=com"

#Add steps for MIM?