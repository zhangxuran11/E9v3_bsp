
./build.sh init #同步构建系统
./build.sh make #构建镜像
sudo dd if=build/image/u-boot-dtb.imx of=/dev/sdx bs=1k seek=1 conv=fsync

./build.sh uboot #编译uboot
./build.sh kernel #编译kernel

所有的结果文件  uboot kernel  dtb   rootfs 全部在build/image/

并行
BB_NUMBER_THREADS = "16"
PARALLEL_MAKE = "-j 16"

所有组件包可从此处找到
http://downloads.yoctoproject.org/mirror/sources/

kernel_4.14.98:
http://sources.openembedded.org/git2_source.codeaurora.org.external.imx.linux-imx.git.tar.gz

cpuburn-neon:
http://sources.openembedded.org/cpuburn-neon-20140626/  下载放到downloads/cpuburn-neon-20140626/

制作sd启动卡
$ sudo fdisk /dev/sdx
Type the following parameters (each followed by <ENTER>):
    p [lists the current partitions]
    d [to delete existing partitions. Repeat this until no unnecessary partitions are reported by the 'p' command to start fresh.]
    n [create a new partition]
    p [create a primary partition - use for both partitions]
    1 [the first partition]
    20480 [starting at offset sector]
    1024000 [size for the first partition to be used for the boot images]
    p [to check the partitions]
    
    n
    p
    2
    1228800 [starting at offset sector, which leaves enough space for the kernel,the bootloader and its configuration data]
    <enter> [using the default value will create a partition that extends to the last sector of the media]
    p       [to check the partitions]
    w       [this writes the partition table to the media and fdisk exits]
sudo mkfs.fat /dev/sdc1

烧写uboot
sudo dd if=build/image/u-boot.imx of=/dev/sdc bs=1k seek=1 conv=fsync
烧写内核及dtb
sudo mount /dev/sdc1 /xxx
sudo cp build/image/zImage /xxx
sudo cp build/image/imx6q-sabresd.dtb /xxx

烧写文件系统
sudo dd if=build/image/fsl-image-qt5-imx6qsabresd.ext4 of=/dev/sdc2 conv=fsync
