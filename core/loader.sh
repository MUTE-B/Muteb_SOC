#!/usr/bin/env bash

# ============================================================
# اسم الملف : loader.sh
# المشروع   : Muteb SOC
# المطور    : Muteb Albalawi
# الوظيفة   : تحميل جميع مكتبات ووحدات المشروع
# ============================================================

# ============================================================
# تحديد مسار المشروع
# ============================================================

readonly PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# ============================================================
# تحميل مكتبات Core
# ============================================================

source "${PROJECT_ROOT}/core/colors.sh"
source "${PROJECT_ROOT}/core/banner.sh"
source "${PROJECT_ROOT}/core/logger.sh"

# ============================================================
# تحميل وحدات Monitoring
# ============================================================

# سيتم إضافتها لاحقاً

# source "${PROJECT_ROOT}/monitoring/system_check.sh"
# source "${PROJECT_ROOT}/monitoring/network_check.sh"

# ============================================================
# تحميل وحدات Security
# ============================================================

# سيتم إضافتها لاحقاً

# source "${PROJECT_ROOT}/security/ssh_check.sh"
# source "${PROJECT_ROOT}/security/user_check.sh"

# ============================================================
# تحميل وحدات Reporting
# ============================================================

# سيتم إضافتها لاحقاً

# source "${PROJECT_ROOT}/reporting/report.sh"
#!/usr/bin/env bash

# ============================================================
# Project Name : Muteb SOC
# Developer    : Muteb Albalawi
# Role         : SOC Analyst | Blue Team
# Platform     : Linux
# Version      : v1.0.0
# License      : MIT License
# Status       : Active Development
#
# File         : loader.sh
# Description  : Core module loader
# ============================================================

# ============================================================
# تحميل ملف واحد والتحقق من نجاح العملية
# ============================================================

load_module() {

    # اسم الملف المراد تحميله
    local module_path="$1"

    # التحقق من وجود الملف
    if [[ ! -f "$module_path" ]]; then

        echo "[ERROR] Missing module: $module_path"

        exit 1

    fi

    # تحميل الملف داخل الجلسة الحالية
    source "$module_path"

}

# ============================================================
# تحميل جميع ملفات Core بالترتيب الصحيح
# ============================================================

load_core_modules() {

    echo "[INFO] Loading Core Framework..."

    load_module "core/constants.sh"

    load_module "core/helpers.sh"

    load_module "core/colors.sh"

    load_module "core/logger.sh"

    load_module "core/banner.sh"

    load_module "core/validator.sh"

    load_module "core/health.sh"

    echo "[INFO] Core Framework Loaded Successfully."

}
#!/usr/bin/env bash

# ============================================================
# مشروع        : Muteb SOC
# الملف        : loader.sh
# الوصف        : تحميل جميع ملفات Core بالترتيب الصحيح.
# ============================================================

# تحميل ملف واحد
load_module() {

    local module_path="$1"

    if [[ ! -f "$module_path" ]]; then
        echo "[FATAL] Module not found: $module_path"
        exit 1
    fi

    source "$module_path"

}

# تحميل جميع ملفات Core
load_core_modules() {

    load_module "core/constants.sh"
    load_module "core/helpers.sh"
    load_module "core/colors.sh"
    load_module "core/logger.sh"
    load_module "core/banner.sh"
    load_module "core/validator.sh"
    load_module "core/health.sh"
    load_module "core/bootstrap.sh"
    load_module "core/shutdown.sh"

}
