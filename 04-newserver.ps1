$SQLServer = read-host "Is this going to be a SQL server (y/n)"
while("y","n" -notcontains $SQLServer ) { $SQLServer = Read-Host "Please enter your response (y/n)" }

$servername = hostname
if (($servername -like 'cndg*') -or ($servername -like 'cnnc*')) { $region = 'APAC' }
elseif (($servername -like 'aar*') -or ($servername -like 'hei*')) { $region = 'EU' }
elseif (($servername -like 'bect*') -or ($servername -like 'cvtn*') -or ($servername -like 'fbga*') -or ($servername -like 'chil*') -or ($servername -like 'lgga*')) { $region = 'NA' }
else { 
    $region = Read-Host "Enter region server is built in (na/eu/apac)"
    while("eu","na","apac" -notcontains $region ) { $region = Read-Host "Enter region code (na/eu/apac)" }
}

Add-LocalGroupMember -Group Administrators -Member "duracell\s-igmonms", "duracell\s-veeam", "duracell\DUR-$region-LocalWinSrvAdm"

if ( $SQLServer -eq "y" ) { 
    Add-LocalGroupMember -Group Administrators -Member duracell\DUR-$region-LocalWinSQLSrvAdm
}