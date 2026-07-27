#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Global Constants
# ==========================================================

readonly APP_NAME="MUTEB SOC"
readonly APP_VERSION="1.0.0"
readonly APP_AUTHOR="Muteb Albalawi"

readonly BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

readonly CORE_DIR="$BASE_DIR/core"
readonly CONFIG_DIR="$BASE_DIR/config"
readonly LOG_DIR="$BASE_DIR/logs"
readonly REPORT_DIR="$BASE_DIR/reports"
readonly TMP_DIR="$BASE_DIR/tmp"
readonly SECURITY_DIR="$BASE_DIR/security"
readonly MONITOR_DIR="$BASE_DIR/monitoring"
readonly REPORTING_DIR="$BASE_DIR/reporting"
readonly UTILITIES_DIR="$BASE_DIR/utilities"

readonly LOG_FILE="$LOG_DIR/muteb_soc.log"

readonly DATE_NOW="$(date '+%Y-%m-%d')"
readonly TIME_NOW="$(date '+%H:%M:%S')"
readonly DATE_TIME="$(date '+%Y-%m-%d %H:%M:%S')"

readonly HOSTNAME="$(hostname)"
readonly KERNEL="$(uname -r)"
readonly ARCH="$(uname -m)"
readonly CPU_CORES="$(nproc)"

readonly REPORT_NAME="security_report_$(date +%F_%H-%M-%S).txt"
readonly REPORT_FILE="$REPORT_DIR/$REPORT_NAME"

readonly REQUIRED_COMMANDS=(
bash
awk
sed
grep
cut
sort
uniq
date
find
ss
ip
systemctl
hostname
free
df
uptime
)

mkdir -p "$LOG_DIR"
mkdir -p "$REPORT_DIR"
mkdir -p "$TMP_DIR"
