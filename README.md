# 🛡️ MUTEB SOC v1.3.0

![Version](https://img.shields.io/badge/version-v1.3.0-blue)
![Platform](https://img.shields.io/badge/platform-Linux-orange)
![Python](https://img.shields.io/badge/python-3.x-green)
![Security](https://img.shields.io/badge/focus-SOC%20%7C%20Blue%20Team-red)

## 📌 About

MUTEB SOC is a defensive security operations toolkit designed for SOC Analysts and Blue Team engineers.

The project provides monitoring, detection engineering, threat hunting, incident response and Linux security automation capabilities.

## 🚀 Features

### 🔍 Security Monitoring

- System Monitoring
- Service Monitoring
- Authentication Monitoring
- Security Event Logging

### 🧠 Detection Engineering

- MITRE ATT&CK Mapping
- Sigma Detection Rules
- YARA Malware Rules
- Detection Rule Engine

### 🚨 Incident Response

- Incident Documentation
- Security Reports
- Evidence Collection
- Backup and Recovery

### 🔐 Linux Security

- SSH Monitoring
- Firewall Monitoring
- Permission Auditing
- Security Automation

## 🏗️ Architecture

             MUTEB SOC

                 |

    +------------+------------+

    |                         |

Core Engine Dashboard

    |                         |

Detection Engine Flask API

    |

+------+------+------+------+

| | | |

MITRE Sigma YARA SIEM


## ⚙️ Installation

```bash
git clone https://github.com/MUTE-B/Muteb_SOC.git

cd Muteb_SOC

chmod +x INSTALL.sh

./INSTALL.sh
▶️ Usage

Dashboard:

python3 web_dashboard/dashboard_api.py

Detection Engine:

python3 engine/rule_engine.py

System Test:

bash tests/final_system_test.sh
📂 Project Modules
core/
engine/
detections/
sigma_rules/
yara_rules/
web_dashboard/
automation/
incident/
docs/
tests/
🛡️ Security Coverage
Capability	Status
SOC Monitoring	✅
Threat Hunting	✅
MITRE ATT&CK	✅
Sigma Rules	✅
YARA Detection	✅
SIEM Integration	✅
Docker Support	✅
🗺️ Roadmap
v1.4.0
Advanced Threat Hunting
More Detection Rules
Improved Dashboard
v2.0.0
Multi Host Monitoring
Cloud Security Modules
Advanced Analytics
👨‍💻 Author

MUTEB ALBALAWI

SOC Analyst | Blue Team | Cyber Security

