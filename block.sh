#!/bin/bash
# ------------------------------------------------------------------
#                   [Ruvik M] Several functions
# ------------------------  Description ----------------------------
#           Block Devices / File-system / Partitions
# ------------------------------------------------------------------

# --- Get block devices --------------------------------------------
get_block_devices () {
fdisk -l | grep Disk | grep -v identifier | awk '{print $2}' | cut -d : -f1
}

# --- List File-system --------------------------------------------
list_filesystems () {
ls /lib/modules/$(uname -r)/kernel/fs
}

# --- Select File-system -------------------------------------------
select_filesystem () {
select filesystem in $(list_filesystems)
do
    case $filesystem in
        *)
            echo "selected: $filesystem"
	    echo "block_device: $block_devices"
	    echo "mkfs -t $filesystem $block_devices"
            ;;
    esac
done
}

# --- Select block devices  ----------------------------------------
select_block_devices () {
select block_devices in $(get_block_devices)
do
   case $block_devices in
     *) 
         echo "selected: $block_devices"
         select_filesystem
         ;;
      none) 
         break 
      ;;
   esac
done
}

select_block_devices
