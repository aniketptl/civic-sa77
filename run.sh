#!/bin/bash
echo "Kernel Building Script"
echo "by Aniket Patil"
echo "First cleaning your old source"
sh clean.sh
TOOLCHAIN="/home/aniket/toolchain/android_prebuilt_toolchains/arm-eabi-4.7/bin/arm-eabi"
KERNEL="/home/aniket/Kernel/civic-sa77"
MODULES="/home/aniket/modules"
echo "Creating defconfig"
echo " "
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN- sa77_defconfig
echo "Perform over the counter defconfig changes"
echo " "
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN- ARM=arm menuconfig
make ARCH=arm CROSS_COMPILE=$TOOLCHAIN- -j8
if [ -a $KERNEL/arch/arm/boot/zImage ];
then
echo "Removing the old modules"
echo " "
cd $MODULES
sh clear.sh
echo "**********************Move the modules***************************"
find . -name '*.ko' -exec cp {} $MODULES_DIR/ \;
cd $MODULES_DIR
echo "****************Stripping modules for size***********************"
echo " "
$TOOLCHAIN-strip --strip-unneeded *.ko
cd $KERNEL_DIR
else
echo "******************Fix the errors!********************************"
fi


