#!/usr/bin/env bash

# ============================================================
# اسم الملف : logger.sh
# المشروع   : Muteb SOC
# المطور    : Muteb Albalawi
# الوظيفة   : تسجيل أحداث المشروع داخل ملف Log
# ============================================================

# تحميل مكتبة الألوان
source "$(dirname "$0")/colors.sh"

# ============================================================
# مسار ملف السجل
# ============================================================

readonly LOG_FILE="logs/muteb_soc.log"

# ============================================================
# إنشاء ملف السجل إذا لم يكن موجوداً
# ============================================================

touch "$LOG_FILE"

# ============================================================
# INFO
# ============================================================

log_info() {

    local MESSAGE="$1"

    echo "[INFO] $(date '+%F %T') : $MESSAGE" >> "$LOG_FILE"

    echo -e "${GREEN}[INFO]${RESET} $MESSAGE"

}

# ============================================================
# WARNING
# ============================================================

log_warning() {

    local MESSAGE="$1"

    echo "[WARNING] $(date '+%F %T') : $MESSAGE" >> "$LOG_FILE"

    echo -e "${YELLOW}[WARNING]${RESET} $MESSAGE"

}

# ============================================================
# ERROR
# ============================================================

log_error() {

    local MESSAGE="$1"

    echo "[ERROR] $(date '+%F %T') : $MESSAGE" >> "$LOG_FILE"

    echo -e "${RED}[ERROR]${RESET} $MESSAGE"

}
#!/usr/bin/env bash

# ============================================================
# مشروع        : Muteb SOC
# الملف        : logger.sh
# الوصف        : نظام التسجيل الموحد للمشروع.
# ============================================================

# تسجيل رسالة معلومات
log_info() {

    echo -e "${COLOR_CYAN}[$(current_timestamp)] [INFO]${COLOR_RESET} $1"

}

# تسجيل رسالة نجاح
log_success() {

    echo -e "${COLOR_GREEN}[$(current_timestamp)] [SUCCESS]${COLOR_RESET} $1"

}

# تسجيل رسالة تحذير
log_warning() {

    echo -e "${COLOR_YELLOW}[$(current_timestamp)] [WARNING]${COLOR_RESET} $1"

}

# تسجيل رسالة خطأ
log_error() {

    echo -e "${COLOR_RED}[$(current_timestamp)] [ERROR]${COLOR_RESET} $1"

}

# تسجيل رسالة حرجة
log_critical() {

    echo -e "${COLOR_MAGENTA}[$(current_timestamp)] [CRITICAL]${COLOR_RESET} $1"

}

