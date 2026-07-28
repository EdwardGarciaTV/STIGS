<#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Eduardo Garcia
    LinkedIn        : linkedin.com/in/eduardogarciait/
    GitHub          : github.com/EdwardGarciaTV
    Date Created    : 2026-07-27
    Last Modified   : 2026-07-27
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000500
    Documentation   : https://stigaview.com/products/win11/v2r7/WN11-AU-000500/

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> (STIG-ID-WN10-AU-000500).ps1 
#>

$Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'
$SizeKB = 32768

New-Item -Path $Path -Force | Out-Null
New-ItemProperty -Path $Path -Name 'MaxSize' -PropertyType DWord -Value $SizeKB -Force | Out-Null
wevtutil sl Application /ms:$($SizeKB * 1KB)

Write-Host 'WN11-AU-000500 remediated: Application log set to 32768 KB.'
