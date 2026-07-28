<#
.SYNOPSIS
    This PowerShell script ensures that "Always install with elevated privileges" is disabled. 

.NOTES
    Author          : Eduardo Garcia
    LinkedIn        : linkedin.com/in/eduardogarciait/
    GitHub          : github.com/EdwardGarciaTV
    Date Created    : 2026-07-28
    Last Modified   : 2026-07-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000315
    Documentation   : https://stigaview.com/products/win11/v2r8/WN11-CC-000315/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> (STIG-ID-WN11-CC-000315).ps1 
#>

$P='HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer'
New-Item $P -Force|Out-Null
New-ItemProperty $P -Name AlwaysInstallElevated -PropertyType DWord -Value 0 -Force|Out-Null
if((Get-ItemPropertyValue $P AlwaysInstallElevated)-eq 0){Write-Host 'Compliant'}else{Write-Error 'Failed'}
