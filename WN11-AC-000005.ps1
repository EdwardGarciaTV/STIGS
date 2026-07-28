<#
.SYNOPSIS
    This PowerShell script ensures that account lockout duration is at least 15 minutes or greater. 

.NOTES
    Author          : Eduardo Garcia
    LinkedIn        : linkedin.com/in/eduardogarciait/
    GitHub          : github.com/EdwardGarciaTV
    Date Created    : 2026-07-28
    Last Modified   : 2026-07-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000005
    Documentation   : https://stigaview.com/products/win11/v2r8/WN11-AC-000005/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> (STIG-ID-WN11-AC-000005).ps1 


# WN11-AC-000005
net.exe accounts /lockoutduration:15

if ($LASTEXITCODE -eq 0) {
    Write-Host 'WN11-AC-000005 remediated: Lockout duration set to 15 minutes.' -ForegroundColor Green
}
else {
    Write-Error 'Remediation failed. Check the lockout threshold and reset-counter settings.'
}
