# MUTEB SOC Architecture


mkdir -p docs/screenshots


cat > docs/PROJECT_ARCHITECTURE.md << 'EOF'
# MUTEB SOC Architecture


            MUTEB SOC
                |
    +-----------+------------+
    |                        |

Core Engine Dashboard
| |
| Flask API
|
+------+-------+---------+
| | | |
SOC Hunting Detection Response
| | | |
Logs IOC Sigma/YARA Cases



## Components


### Core

System management engine


### Monitoring

Live system and security monitoring


### Detection

MITRE ATT&CK

Sigma

YARA


### Response

Incident handling and reporting


