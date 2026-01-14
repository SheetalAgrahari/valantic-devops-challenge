#!/bin/bash

set -e

# Configuration
ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
RELEASE_DIR="$ROOT_DIR/release"
DELIVERY_DIR="$ROOT_DIR/delivery"
LOG_FILE="$ROOT_DIR/build.log"
VERSION_FILE="$ROOT_DIR/VERSION"

TIMESTAMP=$(date +"%Y%m%d_%H%M")

# Logging function
log() {
    local level="$1"
    local message="$2"
    echo "[$(date +"%Y-%m-%d %H:%M:%S")] $level  $message" | tee -a "$LOG_FILE"
}

# Start build
log "INFO" "Starting build process"

# Validate VERSION file
if [[ ! -f "$VERSION_FILE" ]]; then
    log "ERROR" "VERSION file not found. Aborting build."
    exit 1
fi

VERSION=$(cat "$VERSION_FILE" | tr -d '[:space:]')
ARCHIVE_NAME="app-${VERSION}-${TIMESTAMP}.tar.gz"

# Prepare directories
log "INFO" "Preparing release and delivery directories"
mkdir -p "$RELEASE_DIR" "$DELIVERY_DIR"

# Cleanup old artifacts
log "INFO" "Cleaning old build artifacts"
rm -f "$RELEASE_DIR"/*.tar.gz

# Packaging source files
log "INFO" "Creating archive: $ARCHIVE_NAME"

tar --exclude=".git" \
    --exclude="node_modules" \
    --exclude="target" \
    --exclude="release" \
    --exclude="delivery" \
    --exclude="build.log" \
    -czf "$RELEASE_DIR/$ARCHIVE_NAME" \
    $(find "$ROOT_DIR" -type f \( -name "*.py" -o -name "*.sh" -o -name "*.js" \))

# Delivery step
log "INFO" "Delivering artifact to delivery directory"
cp "$RELEASE_DIR/$ARCHIVE_NAME" "$DELIVERY_DIR/"

# Build successful
log "INFO" "Build completed successfully"
log "INFO" "Artifact available at: $RELEASE_DIR/$ARCHIVE_NAME"
