#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Bootstrap Engine
# ==========================================================

bootstrap() {

clear

create_directories

check_requirements

initialize_logger

log_info "Initializing $APP_NAME"

log_info "Version : $APP_VERSION"

log_info "Author  : $APP_AUTHOR"

log_info "Hostname: $HOSTNAME"

log_info "Kernel  : $KERNEL"

log_info "Architecture : $ARCH"

}

