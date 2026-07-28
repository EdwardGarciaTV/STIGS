<#
.SYNOPSIS
    This PowerShell script ensures that Autoplay is disabled to all drives.

.NOTES
    Author          : Eduardo Garcia
    LinkedIn        : linkedin.com/in/eduardogarciait/
    GitHub          : github.com/EdwardGarciaTV
    Date Created    : 2026-07-28
    Last Modified   : 2026-07-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000190
    Documentation   : https://stigaview.com/products/win11/v2r8/WN11-CC-000190/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> (STIG-ID-WN11-CC-000190).ps1 

$P='HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
New-Item $P -Force|Out-Null
New-ItemProperty $P -Name NoDriveTypeAutoRun -PropertyType DWord -Value 255 -Force|Out-Null

if((Get-ItemPropertyValue $P NoDriveTypeAutoRun)-eq 255){
    Write-Host 'WN11-CC-000190: Compliant'
}else{
    Write-Error 'Remediation failed'
}
