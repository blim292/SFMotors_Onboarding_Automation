#$TAG = Read-Host -Prompt 'Enter your TAG#: '

# Define the variables

$TAG = Read-Host -Prompt 'Enter your TAG#: '

# 1.  Specify the new computer name.
$NewHostName = $TAG

# 2.  Specify the domain to join.
$DomainToJoin = "sfmotors.local"

# 3.  Specify the OU where to put the computer account in the domain.  Use the OU's distinguished name.
$OU = "OU=SCB1,OU=Computer,OU=1-Site-SC,DC=sfmotors,DC=local"


# Join the computer to the domain, rename it, and restart it.
Add-Computer -DomainName $DomainToJoin -OUPath $OU -NewName $NewHostName -Credential SFMOTORS\brian.lim -Restart
