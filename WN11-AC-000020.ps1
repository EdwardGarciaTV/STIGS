<#
.SYNOPSIS
    This PowerShell script ensures that password history for the last 24 passwords in remembered.

.NOTES
    Author          : Eduardo Garcia
    LinkedIn        : linkedin.com/in/eduardogarciait/
    GitHub          : github.com/EdwardGarciaTV
    Date Created    : 2026-07-28
    Last Modified   : 2026-07-28
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000020
    Documentation   : https://stigaview.com/products/win11/v2r8/WN11-AC-000020/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> (STIG-ID-WN11-AC-000020).ps1 

# WN11-AC-000020
net.exe accounts /uniquepw:24

if ($LASTEXITCODE -eq 0) {
    Write-Host 'WN11-AC-000020 remediated: Password history set to 24.' -ForegroundColor Green
}
else {
    Write-Error 'Remediation failed. Run PowerShell as Administrator.'
}
