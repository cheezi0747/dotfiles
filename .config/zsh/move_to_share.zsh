#!/bin/zsh

# Configuration
MOUNT_POINT="/Volumes/shared_folder"
SHARE_PATH="//cheezi-server/shared_folder"
TARGET_DIR="${MOUNT_POINT}/Ingest"
SOURCE_DIR="${HOME}/Downloads"
FILE_PATTERNS=("*.stl" "*.3mf" "*.step")

# Function to check if the share is mounted
is_mounted() {
    mount | grep -q " on ${MOUNT_POINT} "
}

# Function to mount the share
mount_share() {
    echo "Mounting SMB share..."
    if ! mount -t smbfs "${SHARE_PATH}" "${MOUNT_POINT}"; then
        echo "Failed to mount SMB share at ${MOUNT_POINT}."
        exit 1
    fi
}

# Function to move files
move_files() {
    local files_found=0

    for pattern in "${FILE_PATTERNS[@]}"; do
        # Use find to get a list of files matching the pattern, handling spaces correctly
        while IFS= read -r file; do
            files_found=1
            echo "Moving file: $file to ${TARGET_DIR}/"
            mv "$file" "${TARGET_DIR}/"
            if (($? != 0)); then
                echo "Failed to move file: $file"
            fi
        done < <(find "${SOURCE_DIR}" -type f \( -iname "*.stl" -o -iname "*.3mf" -o -iname "*.step" \))

        if ((files_found == 0)); then
            echo "No files matching ${pattern} found."
        else
            echo "Files matching ${pattern} have been moved."
        fi
    done
}

# Main script logic
if ! is_mounted; then
    mount_share
fi

if is_mounted; then
    move_files
else
    echo "The SMB share is not mounted, and the script was unable to mount it."
    exit 1
fi
