# 🛡️ Windows 11 DISA STIG PowerShell Remediation

This repository contains PowerShell scripts developed to automate the remediation and validation of selected **Windows 11 DISA Security Technical Implementation Guide (STIG)** security controls.

The project demonstrates practical Windows security hardening through PowerShell, local security policy configuration, Windows Registry modification, event logging configuration, and automated compliance verification.

The goal is to translate security compliance requirements into repeatable technical remediation steps that can be applied and validated on Windows endpoints.

---

## 🔐 Project Overview

DISA STIGs provide security configuration standards designed to reduce risk and strengthen systems against common attack techniques and insecure configurations.

The scripts in this repository address Windows 11 security controls related to:

* Account and password policies
* Account lockout protections
* Windows event logging
* AutoPlay and removable-media security
* Lock-screen configuration
* Windows Installer privilege restrictions
* Built-in account security

Each script is associated with an individual Windows 11 STIG ID and performs the configuration necessary to bring the applicable setting into compliance.

---

## 🧰 Technologies & Skills Demonstrated

| Technology / Skill                | Application                                                   |
| --------------------------------- | ------------------------------------------------------------- |
| **PowerShell**                    | Automated Windows security configuration and validation       |
| **DISA STIGs**                    | Security baseline and compliance requirements                 |
| **Windows Registry**              | System and security policy configuration                      |
| **Windows Local Security Policy** | Password and account-policy hardening                         |
| **Windows Event Logging**         | Audit-log capacity configuration                              |
| **Security Automation**           | Repeatable remediation of security findings                   |
| **Compliance Validation**         | Verification that security settings were successfully applied |
| **Windows 11 Hardening**          | Reduction of insecure/default configurations                  |

---

# 📋 STIG Remediations

| STIG ID            | Security Requirement                    | Remediation Performed                                                                      | Script                                     |
| ------------------ | --------------------------------------- | ------------------------------------------------------------------------------------------ | ------------------------------------------ |
| **WN11-AC-000005** | Account lockout duration                | Configures the account lockout duration to at least **15 minutes**                         | [WN11-AC-000005.ps1](./WN11-AC-000005.ps1) |
| **WN11-AC-000020** | Password history                        | Configures Windows to remember the previous **24 passwords**                               | [WN11-AC-000020.ps1](./WN11-AC-000020.ps1) |
| **WN11-AC-000030** | Minimum password age                    | Configures the minimum password age to **1 day**                                           | [WN11-AC-000030.ps1](./WN11-AC-000030.ps1) |
| **WN11-AU-000500** | Application event log size              | Configures the Windows Application event log maximum size to at least **32 MB / 32768 KB** | [WN11-AU-000500.ps1](./WN11-AU-000500.ps1) |
| **WN11-CC-000010** | Lock-screen slideshow                   | Disables slideshow functionality on the Windows lock screen                                | [WN11-CC-000010.ps1](./WN11-CC-000010.ps1) |
| **WN11-CC-000180** | AutoPlay for non-volume devices         | Disables AutoPlay for non-volume devices                                                   | [WN11-CC-000180.ps1](./WN11-CC-000180.ps1) |
| **WN11-CC-000190** | AutoPlay on drives                      | Disables AutoPlay across all drive types                                                   | [WN11-CC-000190.ps1](./WN11-CC-000190.ps1) |
| **WN11-CC-000315** | Always Install with Elevated Privileges | Disables Windows Installer's **AlwaysInstallElevated** configuration                       | [WN11-CC-000315.ps1](./WN11-CC-000315.ps1) |
| **WN11-SO-000025** | Built-in Guest account                  | Renames the built-in SID-501 Guest account to reduce exposure of the default account name  | [WN11-SO-000025.ps1](./WN11-SO-000025.ps1) |

---

# 🔎 Remediation Details

## WN11-AC-000005 — Account Lockout Duration

This remediation configures the Windows account lockout duration to **15 minutes**.

Account lockout policies help reduce the effectiveness of password-guessing and brute-force attacks by temporarily preventing authentication attempts after an account reaches the configured lockout threshold.

```powershell
net.exe accounts /lockoutduration:15
```

**Security Area:** Account Policy / Authentication Security

[View Script](./WN11-AC-000005.ps1)

---

## WN11-AC-000020 — Password History

This remediation configures Windows to remember the previous **24 passwords**.

Maintaining sufficient password history helps prevent users from repeatedly cycling through a small set of passwords in order to reuse previously compromised credentials.

```powershell
net.exe accounts /uniquepw:24
```

**Security Area:** Password Policy / Credential Security

[View Script](./WN11-AC-000020.ps1)

---

## WN11-AC-000030 — Minimum Password Age

This remediation configures the local minimum password age to **1 day**.

A minimum password age helps prevent users from rapidly changing passwords multiple times to bypass password-history requirements.

```powershell
net.exe accounts /minpwage:1
```

**Security Area:** Password Policy / Credential Security

[View Script](./WN11-AC-000030.ps1)

---

## WN11-AU-000500 — Application Event Log Size

This remediation configures the Windows **Application Event Log** to maintain a maximum size of at least **32768 KB (32 MB)**.

Maintaining sufficient event-log capacity supports security monitoring, incident investigation, troubleshooting, and forensic analysis by reducing the likelihood that important historical events are overwritten prematurely.

```powershell
$Path = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'
$SizeKB = 32768

New-Item -Path $Path -Force | Out-Null
New-ItemProperty -Path $Path -Name 'MaxSize' -PropertyType DWord -Value $SizeKB -Force | Out-Null

wevtutil sl Application /ms:$($SizeKB * 1KB)
```

**Security Area:** Auditing / Logging

[View Script](./WN11-AU-000500.ps1)

---

## WN11-CC-000010 — Disable Lock-Screen Slideshow

This remediation disables slideshow functionality on the Windows lock screen through Group Policy-backed Registry configuration.

```powershell
$P = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'

New-Item $P -Force | Out-Null

New-ItemProperty `
    $P `
    -Name NoLockScreenSlideshow `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null
```

The script then validates that the expected registry value is configured.

**Security Area:** Windows Configuration / System Hardening

[View Script](./WN11-CC-000010.ps1)

---

## WN11-CC-000180 — Disable AutoPlay for Non-Volume Devices

This remediation disables AutoPlay functionality for non-volume devices.

Disabling unnecessary AutoPlay functionality reduces opportunities for automatically initiated or socially engineered execution involving removable or connected devices.

```powershell
$P = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'

New-Item $P -Force | Out-Null

New-ItemProperty `
    $P `
    -Name NoAutoplayfornonVolume `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null
```

**Security Area:** Device Security / Execution Control

[View Script](./WN11-CC-000180.ps1)

---

## WN11-CC-000190 — Disable AutoPlay on All Drives

This remediation configures Windows to disable AutoPlay across all drive types.

```powershell
$P = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'

New-Item $P -Force | Out-Null

New-ItemProperty `
    $P `
    -Name NoDriveTypeAutoRun `
    -PropertyType DWord `
    -Value 255 `
    -Force | Out-Null
```

The script verifies that `NoDriveTypeAutoRun` is configured with the expected value of `255`.

**Security Area:** Removable Media / Execution Control

[View Script](./WN11-CC-000190.ps1)

---

## WN11-CC-000315 — Disable AlwaysInstallElevated

This remediation disables the Windows Installer **AlwaysInstallElevated** policy.

Enabling this setting can allow MSI packages to execute with elevated privileges and may provide a path for local privilege escalation if improperly configured.

```powershell
$P = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer'

New-Item $P -Force | Out-Null

New-ItemProperty `
    $P `
    -Name AlwaysInstallElevated `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null
```

The script verifies that `AlwaysInstallElevated` has been configured to `0`.

**Security Area:** Privilege Management / Application Security

[View Script](./WN11-CC-000315.ps1)

---

## WN11-SO-000025 — Rename the Built-In Guest Account

This remediation identifies the Windows built-in Guest account using its well-known **SID ending in `-501`** rather than relying solely on the existing account name.

The account is then renamed to `User`.

```powershell
$G = Get-LocalUser | Where-Object SID -Match '-501$'

if ($G.Name -ne 'User') {
    Rename-LocalUser $G.Name -NewName 'User'
}
```

Identifying the account through its SID ensures the script can locate the built-in Guest account even if it has already been renamed.

**Security Area:** Local Account Security

[View Script](./WN11-SO-000025.ps1)

---

# ▶️ Running the Scripts

These scripts modify system-level Windows security settings and should be executed from an **elevated PowerShell session**.

Example:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

Navigate to the directory containing the scripts:

```powershell
cd C:\Path\To\STIGS
```

Execute an individual remediation:

```powershell
.\WN11-AC-000005.ps1
```

Another example:

```powershell
.\WN11-CC-000315.ps1
```

Administrator privileges may be required depending on the security control being modified.

---

# ✅ Validation

Several scripts perform an immediate validation after applying the remediation.

For registry-based controls, the configured registry value is queried and compared with the expected compliant value.

Example:

```powershell
if ((Get-ItemPropertyValue $P AlwaysInstallElevated) -eq 0) {
    Write-Host 'Compliant'
}
else {
    Write-Error 'Remediation failed'
}
```

This provides basic confirmation that the intended Windows security configuration was successfully applied.

In an enterprise environment, remediation should additionally be validated through the organization's approved compliance or vulnerability-management platform.

---

# 🏢 Enterprise Use Case

In a production environment, similar remediation scripts could be incorporated into centralized administration and configuration-management workflows such as:

| Platform / Method                  | Potential Use                                |
| ---------------------------------- | -------------------------------------------- |
| Microsoft Intune                   | Endpoint security configuration              |
| Microsoft Configuration Manager    | Enterprise software/configuration deployment |
| PowerShell Remoting                | Remote endpoint remediation                  |
| Group Policy                       | Centralized Windows policy enforcement       |
| Endpoint Management Platforms      | Security-baseline deployment                 |
| Vulnerability Management Platforms | Finding validation and remediation workflows |
| CI/CD or Automation Platforms      | Script testing and controlled deployment     |

Before organization-wide deployment, remediation scripts should be tested against representative systems and deployed through an established change-management process.

---

# ⚠️ Testing & Deployment Notice

These scripts are intended for **cybersecurity lab, educational, testing, and authorized administrative environments**.

Security configurations can affect system functionality, authentication behavior, applications, legacy services, and organizational workflows.

Before using a remediation in a production environment:

**Test → Validate → Document → Approve → Deploy → Revalidate**

Organizations should verify each configuration against their applicable Windows version, DISA STIG release, organizational policy, and operational requirements.

---

# 🎯 Project Purpose

This project demonstrates the ability to convert security-compliance requirements into practical technical controls using PowerShell.

Rather than simply identifying a failed compliance check, the scripts demonstrate the remediation side of vulnerability and configuration management:

**Identify → Understand → Remediate → Validate**

This workflow reflects common responsibilities across cybersecurity roles involving vulnerability management, system hardening, security engineering, compliance, and defensive security operations.

---

## 👤 Author

**Eduardo Garcia**

Cybersecurity | Threat Hunting | Vulnerability Management | Security Operations

**GitHub:** [github.com/EdwardGarciaTV](https://github.com/EdwardGarciaTV)

**LinkedIn:** [linkedin.com/in/eduardogarciait](https://linkedin.com/in/eduardogarciait)

---

## 📚 References

Individual scripts include references to the corresponding Windows 11 DISA STIG security requirement used during development.

For current production implementations, always verify security requirements against the latest applicable DISA STIG release before deployment.
