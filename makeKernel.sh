#!/bin/bash

# Fix the Makefiles so that they compile on the device
patch /usr/src/kernel/kernel-4.4/drivers/devfreq/Makefile ./diffs/devfreq/devfreq.patch
patch /usr/src/kernel/nvgpu/drivers/gpu/nvgpu/Makefile ./diffs/nvgpu/nvgpu.patch
patch /usr/src/kernel/kernel-4.4/sound/soc/tegra-alt/Makefile ./diffs/tegra-alt/tegra-alt.patch
patch /usr/src/kernel/kernel-4.4/include/linux/irqchip/arm-gic.h ./diffs/irqchip/arm-gic.patch
# vmipi is in a sub directory without a Makefile, there was an include problem
cp /usr/src/kernel/kernel-4.4/drivers/media/platform/tegra/mipical/mipi_cal.h /usr/src/kernel/kernel-4.4/drivers/media/platform/tegra/mipical/vmipi/mipi_cal.h

# Build kernel part

# Builds the kernel and modules
# Assumes that the .config file is available
cd /usr/src/kernel/kernel-4.4
make prepare
make modules_prepare
# Make alone will build the dts files too
# make -j6
make -j6 Image
make modules
make modules_install
