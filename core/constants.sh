#!/usr/bin/env bash

# ============================================================
# اسم الملف : constants.sh
# المشروع   : Muteb SOC
# المطور    : Muteb Albalawi
# الوظيفة   : تعريف جميع الثوابت المستخدمة داخل المشروع
# ============================================================

# ============================================================
# معلومات المشروع
# ============================================================

readonly PROJECT_NAME="Muteb SOC"

readonly PROJECT_VERSION="v1.0.0"

readonly PROJECT_AUTHOR="Muteb Albalawi"

readonly PROJECT_ROLE="SOC Analyst | Blue Team"

readonly PROJECT_PLATFORM="Linux"

readonly PROJECT_LICENSE="MIT License"

readonly PROJECT_STATUS="Enterprise Build"

# ============================================================
# المجلدات الرئيسية
# ============================================================

readonly LOG_DIR="logs"

readonly REPORT_DIR="reports"

readonly CONFIG_DIR="config"

readonly TMP_DIR="tmp"

readonly DOCS_DIR="docs"

readonly TEST_DIR="tests"

readonly BASELINE_DIR="baseline"

readonly SECURITY_DIR="security"

readonly MONITORING_DIR="monitoring"

readonly REPORTING_DIR="reporting"

readonly CORE_DIR="core"

# ============================================================
# أسماء الملفات
# ============================================================

readonly LOG_FILE="${LOG_DIR}/muteb_soc.log"

readonly REPORT_FILE="${REPORT_DIR}/Muteb_SOC_Report_$(date +%F).txt"

readonly VERSION_FILE="VERSION"

readonly README_FILE="README.md"

readonly LICENSE_FILE="LICENSE"

# ============================================================
# أكواد إنهاء البرنامج
# ============================================================

readonly EXIT_SUCCESS=0

readonly EXIT_FAILURE=1

readonly EXIT_PERMISSION=2

readonly EXIT_CONFIGURATION=3
#!/usr/bin/env bash

# ============================================================
# مشروع        : Muteb SOC
# المطور       : Muteb Albalawi
# الدور        : SOC Analyst | Blue Team
# المنصة       : Linux
# الإصدار      : v1.0.0
# الترخيص      : MIT License
# الحالة       : Active Development
#
# الملف        : constants.sh
# الوصف        : يحتوي على جميع الثوابت المستخدمة داخل المشروع.
#
# ملاحظة:
# يمنع كتابة أي قيمة ثابتة داخل الملفات الأخرى.
# أي قيمة ثابتة يجب تعريفها هنا فقط.
# ============================================================

# ============================================================
# معلومات المشروع
# ============================================================

readonly PROJECT_NAME="Muteb SOC"
readonly PROJECT_VERSION="v1.0.0"
readonly PROJECT_DEVELOPER="Muteb Albalawi"
readonly PROJECT_ROLE="SOC Analyst | Blue Team"
readonly PROJECT_PLATFORM="Linux"
readonly PROJECT_LICENSE="MIT License"
readonly PROJECT_STATUS="Active Development"

# ============================================================
# المسار الرئيسي للمشروع
# ============================================================

readonly ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# ============================================================
# المجلدات الرئيسية
# ============================================================

readonly CORE_DIR="$ROOT_DIR/core"
readonly CONFIG_DIR="$ROOT_DIR/config"
readonly LOG_DIR="$ROOT_DIR/logs"
readonly REPORT_DIR="$ROOT_DIR/reports"
readonly SECURITY_DIR="$ROOT_DIR/security"
readonly MONITORING_DIR="$ROOT_DIR/monitoring"
readonly REPORTING_DIR="$ROOT_DIR/reporting"
readonly DOCS_DIR="$ROOT_DIR/docs"
readonly TMP_DIR="$ROOT_DIR/tmp"
readonly TESTS_DIR="$ROOT_DIR/tests"

# ============================================================
# اسم ملف التقرير الافتراضي
# ============================================================

readonly REPORT_FILE="$REPORT_DIR/Muteb_SOC_Report_$(date +%F).txt"

# ============================================================
# حالات تشغيل الـ Framework
# ============================================================

readonly STATE_INITIALIZING="INITIALIZING"
readonly STATE_LOADING="LOADING"
readonly STATE_VALIDATING="VALIDATING"
readonly STATE_READY="READY"
readonly STATE_RUNNING="RUNNING"
readonly STATE_REPORTING="REPORTING"
readonly STATE_COMPLETED="COMPLETED"
readonly STATE_FAILED="FAILED"

# ============================================================
# أكواد الخروج القياسية
# ============================================================

readonly EXIT_SUCCESS=0
readonly EXIT_WARNING=1
readonly EXIT_ERROR=2
readonly EXIT_CRITICAL=99

# ============================================================
# نهاية الملف
# ============================================================
