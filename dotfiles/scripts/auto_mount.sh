#!/bin/bash

# Function to get the first unmounted device
function get_first_unmounted_device {
    lsblk -pno NAME,MOUNTPOINT | awk '$2 == "" {print $1}' | head -n 1
}

# Get the first unmounted device automatically
DEVICE=$(get_first_unmounted_device)

# Check if a device was found
if [ -z "$DEVICE" ]; then
    echo "Error: No unmounted devices found."
    exit 1
fi

echo "Using device: $DEVICE"

# Define the mount point
MOUNT_POINT="/mnt/$(basename "$DEVICE")"

# Create the mount point directory automatically
if [ ! -d "$MOUNT_POINT" ]; then
    sudo mkdir -p "$MOUNT_POINT" || { echo "Error: Could not create mount point."; exit 1; }
    echo "Created mount point: $MOUNT_POINT"
else
    # Check if it is already mounted
    if mountpoint -q "$MOUNT_POINT"; then
        echo "Error: Mount point $MOUNT_POINT is already mounted."
        exit 1
    else
        echo "Warning: Mount point $MOUNT_POINT exists but is not mounted."
    fi
fi

# Get the UUID of the device
UUID=$(blkid -s UUID -o value "$DEVICE")

# Check if UUID was found
if [ -z "$UUID" ]; then
    echo "Error: Could not get UUID for $DEVICE. Ensure it has a valid filesystem."
    exit 1
fi

# Determine filesystem type
FILESYSTEM=$(blkid -s TYPE -o value "$DEVICE")

# Check if filesystem type was found
if [ -z "$FILESYSTEM" ]; then
    echo "Error: Could not determine filesystem type for $DEVICE."
    exit 1
fi

# Handle NTFS specific options
if [ "$FILESYSTEM" == "ntfs" ]; then
    MOUNT_OPTIONS="defaults,uid=$(id -u),gid=$(id -g),umask=0002"
else
    MOUNT_OPTIONS="defaults"
fi

# Add entry to /etc/fstab if it doesn't already exist
if ! grep -q "UUID=$UUID" /etc/fstab; then
    echo "UUID=$UUID $MOUNT_POINT $FILESYSTEM $MOUNT_OPTIONS 0 0" | sudo tee -a /etc/fstab > /dev/null
else
    echo "Warning: Entry for UUID=$UUID already exists in /etc/fstab."
fi

# Attempt to mount the new entry
if sudo mount "$DEVICE" "$MOUNT_POINT"; then
    echo "Device $DEVICE mounted at $MOUNT_POINT with UUID $UUID."
else
    echo "Error: Failed to mount $DEVICE."
    exit 1
fi

