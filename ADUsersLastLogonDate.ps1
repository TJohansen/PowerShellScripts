import-module ActiveDirectory 
 
#Set the domain to search at the Server parameter. Run powershell as a user with privilieges in that domain to pass different credentials to the command. 
#Searchbase is the OU you want to search. By default the command will also search all subOU's. To change this behaviour, change the searchscope parameter. Possible values: Base, onelevel, subtree 
#Ignore the filter and properties parameters 
 
$ADUserParams=@{ 
'Server' = '*' 
'Searchbase' = '*'
'Searchscope'= 'subtree' 
'Filter' = 'enabled -eq $true'
'Properties' = 'lastLogonDate' 
} 
 
#This is where to change if different properties are required. 
 
$SelectParams=@{ 
'Property' = 'employeeID', 'SAMAccountname','Userprincipalname', 'mobilephone', 'EmailAddress', 'lastlogondate'
} 

# 'Property' = 'SAMAccountname','Userprincipalname', 'CN', 'title', 'DisplayName', 'Description', 'EmailAddress', 'mobilephone', 'office', 'officephone', 'state', 'streetaddress', 'city', 'employeeID', 'Employeenumber', 'enabled', 'lockedout', 'lastlogondate', 'badpwdcount', 'passwordlastset', 'created' 
 
get-aduser @ADUserParams | select-object @SelectParams | export-csv -delimiter ";" -Encoding UTF8 "c:\service\ADUsersLastLogonDate.csv"