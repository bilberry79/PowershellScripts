# The 'Get-ADgroupMembers GROUPNAME -recursive' only works if all users have the 'Domain Users'
# as PrimaryGroup. If one user has a different PrimaryGroup, the user doesn't show up in the results.
# It's a know bug.
#
# 
#SOLUTION: Write a recursive function!
#

function Get-NestedADGroupMember ($group) {
    
    $items = Get-ADGroupMember $group
    
    foreach ($item in $items) {
        try{
                if ($item.objectclass -like "user") {
                    # get only the users back
                    $item
                }
  
                if (Get-ADGroup $item.samaccountname) {
                    Get-NestedADGroupMember $item.samaccountname
                }
            } catch{}
        
    }
}
