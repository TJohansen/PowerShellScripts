#Script must be run as Admin or the lastlogondate property will be blanked out
#Requires -RunAsAdministrator

import-module ActiveDirectory 

#Set the domain to search at the Server parameter. Run powershell as a user with privilieges in that domain to pass different credentials to the command. 
#Searchbase is the OU you want to search. By default the command will also search all subOU's. To change this behaviour, change the searchscope parameter. Possible values: Base, onelevel, subtree 
#Ignore the filter and properties parameters 

$ADUserParams=@{ 
'Server' = '*' 
'Searchbase' = '*'
'Searchscope'= 'subtree' 
'Filter' = 'enabled -eq $true'
'Properties' = '*' 
} 

#Change if different properties are required. 
 
$SelectParams=@{ 
'Property' = 'SAMAccountname', 'mobilephone', 'EmailAddress', 'lastlogondate'
} 

# 'Property' = 'SAMAccountname','Userprincipalname', 'CN', 'title', 'DisplayName', 'Description', 'EmailAddress', 'mobilephone', 'office', 'officephone', 'state', 'streetaddress', 'city', 'employeeID', 'Employeenumber', 'enabled', 'lockedout', 'lastlogondate', 'badpwdcount', 'passwordlastset', 'created' 
#Export-csv exports the output to the current working folder

get-aduser @ADUserParams | select-object @SelectParams | Sort-Object -Property lastlogondate | export-csv -delimiter ";" -Encoding UTF8 ".\ADUsersLastLogonDate.csv" -NoTypeInformation
