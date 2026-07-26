#!/usr/bin/env bash

# ============================================================
# اسم الملف : bootstrap.sh
# المشروع   : Muteb SOC
# المطور    : Muteb Albalawi
# الوظيفة   : تهيئة بيئة المشروع قبل بدء التشغيل
# ============================================================

# ============================================================
# إنشاء المجلدات الأساسية إذا لم تكن موجودة
# ============================================================

initialize_directories() {

    mkdir -p logs
    mkdir -p reports
    mkdir -p tmp

}

# ============================================================
# التأكد من وجود ملف VERSION
# ============================================================

check_version_file() {

    if [[ ! -f VERSION ]]; then

        echo "VERSION file not found."

        exit 1

    fi

}

# ============================================================
# قراءة إصدار المشروع
# ============================================================

load_version() {

    PROJECT_VERSION=$(cat VERSION)

}

# ============================================================
# بدء عملية التهيئة
# ============================================================

bootstrap() {

    initialize_directories

    check_version_file

    load_version

    log_info "Bootstrap completed successfully."

}
#!/usr/bin/env bash

# ============================================================
# مشروع        : Muteb SOC
# الملف        : bootstrap.sh
# الوصف        : تهيئة الـ Framework.
# ============================================================

bootstrap_framework() {

    show_banner

    log_info "Initializing Framework..."

    framework_health_check || {

        log_critical "Framework initialization failed."

        exit 1

    }

    log_success "Framework Ready."

}
