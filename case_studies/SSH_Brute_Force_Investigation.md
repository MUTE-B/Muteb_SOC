# Incident Case Study: SSH Brute Force Attack


## Incident ID

INC-0001


## Incident Title

SSH Brute Force Attempt


## Severity

HIGH


## Incident Type

Unauthorized Login Attempts


## Description

Multiple failed SSH authentication attempts were detected against a Linux server.

The activity indicates a possible brute force attack targeting remote access.


## Detection

Tool:

MUTEB SOC Authentication Monitor


Log Source:

/var/log/auth.log


Detection Method:

- Multiple failed login attempts
- Repeated usernames
- Suspicious source IP activity


## Investigation Steps

1. Reviewed authentication logs.

2. Identified suspicious IP addresses.

3. Analyzed failed login patterns.

4. Generated incident timeline.


## MITRE ATT&CK Mapping

Technique:

T1110 - Brute Force


Tactic:

Credential Access


## Response Actions

- Block malicious IP address.
- Review SSH configuration.
- Disable unnecessary accounts.
- Enable stronger authentication controls.


## Lessons Learned

- Enable MFA.
- Monitor privileged accounts.
- Apply SSH hardening.
- Maintain continuous log monitoring.


## Analyst

MUTEB ALBALAWI

SOC Analyst | Blue Team

