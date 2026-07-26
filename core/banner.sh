#!/usr/bin/env bash

# ============================================================
# اسم الملف : banner.sh
# المشروع   : Muteb SOC
# المطور    : Muteb Albalawi
# الوظيفة   : عرض هوية المشروع عند بدء التشغيل
# ============================================================

# استيراد مكتبة الألوان
source "$(dirname "$0")/colors.sh"

# ============================================================
# دالة عرض Banner المشروع
# ============================================================
show_banner() {

    # تنظيف شاشة الطرفية قبل عرض المعلومات
    clear

    # عنوان المشروع
    echo -e "${CYAN}============================================================${RESET}"
    echo -e "${BOLD}${GREEN}                     Muteb SOC${RESET}"
    echo -e "${CYAN}============================================================${RESET}"

    echo

    # معلومات المشروع
    echo -e "${BOLD}Developer :${RESET} Muteb Albalawi"
    echo -e "${BOLD}Role      :${RESET} SOC Analyst | Blue Team"
    echo -e "${BOLD}Platform  :${RESET} Linux"
    echo -e "${BOLD}Version   :${RESET} v1.0.0"
    echo -e "${BOLD}License   :${RESET} MIT License"
    echo -e "${BOLD}Status    :${RESET} Active Development"

    echo

    # معلومات الجلسة الحالية
    echo -e "${YELLOW}Started   :${RESET} $(date)"
    echo -e "${YELLOW}Hostname  :${RESET} $(hostname)"
    echo -e "${YELLOW}User      :${RESET} $(whoami)"

    echo

    echo -e "${CYAN}============================================================${RESET}"

    echo
}
#!/usr/bin/env bash

# ============================================================
# مشروع        : Muteb SOC
# الملف        : banner.sh
# الوصف        : عرض معلومات المشروع عند بدء التشغيل.
# ============================================================

show_banner() {

    clear

    print_separator

    echo "${PROJECT_NAME}"

    print_separator

    echo
    echo "Developer : ${PROJECT_DEVELOPER}"
    echo "Role      : ${PROJECT_ROLE}"
    echo "Platform  : ${PROJECT_PLATFORM}"
    echo "Version   : ${PROJECT_VERSION}"
    echo "License   : ${PROJECT_LICENSE}"
    echo "Status    : ${PROJECT_STATUS}"
    echo
    echo "Started   : $(current_timestamp)"
    echo "Hostname  : $(hostname)"
    echo "User      : $(whoami)"
    echo

    print_separator

}
