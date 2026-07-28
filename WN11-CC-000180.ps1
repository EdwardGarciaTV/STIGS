<#
.SYNOPSIS
    This PowerShell script ensures that Autoplay is disabled for non-volume devices. 

.NOTES
    Author          : Eduardo Garcia
    LinkedIn        : linkedin.com/in/eduardogarciait/
    GitHub          : github.com/EdwardGarciaTV
    Date Created    : 2026-07-28
    Last Modified   : 2026-07-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000180
    Documentation   : https://stigaview.com/products/win11/v2r8/WN11-CC-000180/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> (STIG-ID-WN11-CC-000180).ps1 

$P='HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
New-Item $P -Force|Out-Null
New-ItemProperty $P -Name NoAutoplayfornonVolume -PropertyType DWord -Value 1 -Force|Out-Null
if((Get-ItemPropertyValue $P NoAutoplayfornonVolume)-eq 1){Write-Host 'WN11-CC-000180: Compliant'}else{Write-Error 'Remediation failed'}
