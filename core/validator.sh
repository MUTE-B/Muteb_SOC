#!/usr/bin/env bash

# ============================================================
# اسم الملف : validator.sh
# المشروع   : Muteb SOC
# المطور    : Muteb Albalawi
# الوظيفة   : التحقق من جاهزية بيئة التشغيل
# ============================================================

# ============================================================
# التحقق من إصدار Bash
# ============================================================

validate_bash() {

    if (( BASH_VERSINFO[0] < 5 )); then

        log_error "Bash version 5 or later is required."

        exit "$EXIT_CONFIGURATION"

    fi

}

# ============================================================
# التحقق من وجود المجلدات الأساسية
# ============================================================

validate_directories() {

    local directories=(
        "$LOG_DIR"
        "$REPORT_DIR"
        "$CONFIG_DIR"
        "$CORE_DIR"
    )

    for dir in "${directories[@]}"; do

        if ! directory_exists "$dir"; then

            log_error "Missing directory: $dir"

            exit "$EXIT_CONFIGURATION"

        fi

    done

}

# ============================================================
# التحقق من وجود الملفات الأساسية
# ============================================================

validate_files() {

    local files=(
        "$VERSION_FILE"
        "$README_FILE"
        "$LICENSE_FILE"
    )

    for file in "${files[@]}"; do

        if ! file_exists "$file"; then

            log_error "Missing file: $file"

            exit "$EXIT_CONFIGURATION"

        fi

    done

}

# ============================================================
# التحقق من وجود الأوامر المطلوبة
# ============================================================

validate_commands() {

    local commands=(
        awk
        grep
        cut
        date
        hostname
        uname
        df
        free
        uptime
    )

    for cmd in "${commands[@]}"; do

        if ! command_exists "$cmd"; then

            log_error "Required command not found: $cmd"

            exit "$EXIT_CONFIGURATION"

        fi

    done

}

# ============================================================
# تنفيذ جميع عمليات التحقق
# ============================================================

run_validation() {

    log_info "Validating execution environment"

    validate_bash

    validate_directories

    validate_files

    validate_commands

    log_info "Environment validation completed"

}
#!/usr/bin/env bash

# ============================================================
# مشروع        : Muteb SOC
# الملف        : validator.sh
# الوصف        : التحقق من جاهزية البيئة.
# ============================================================

validate_environment() {

    command_exists bash || return 1
    command_exists grep || return 1
    command_exists awk || return 1
    command_exists find || return 1
    command_exists hostname || return 1

    create_directory "$LOG_DIR"
    create_directory "$REPORT_DIR"
    create_directory "$TMP_DIR"

    return 0

}
