<#
.SYNOPSIS
    This PowerShell script ensures that the built-in guest account name is rechanged. 

.NOTES
    Author          : Eduardo Garcia
    LinkedIn        : linkedin.com/in/eduardogarciait/
    GitHub          : github.com/EdwardGarciaTV
    Date Created    : 2026-07-28
    Last Modified   : 2026-07-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-SO-000025
    Documentation   : https://stigaview.com/products/win11/v2r8/WN11-SO-000025/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> (STIG-ID-WN11-SO-000025).ps1 

$G=Get-LocalUser|Where-Object SID -Match '-501$'
if((Get-LocalUser User -EA SilentlyContinue) -and $G.Name-ne'User'){throw "'User' already exists"}
if($G.Name-ne'User'){Rename-LocalUser $G.Name -NewName User}
if((Get-LocalUser|Where-Object SID -Match '-501$').Name-eq'User'){Write-Host 'Compliant'}else{Write-Error 'Failed'}
