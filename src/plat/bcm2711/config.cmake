#
# Copyright 2020, Arm Ltd
#
# Copyright 2017, Data61
# Commonwealth Scientific and Industrial Research Organisation (CSIRO)
# ABN 41 687 119 230.
#
# This software may be distributed and modified according to the terms of
# the GNU General Public License version 2. Note that NO WARRANTY is provided.
# See "LICENSE_GPLv2.txt" for details.
#
# @TAG(DATA61_GPL)
#

cmake_minimum_required(VERSION 3.7.2)

declare_platform(bcm2711 KernelPlatformRpi4 PLAT_BCM2711 KernelArchARM)

if(KernelPlatformRpi4)
    if("${KernelSel4Arch}" STREQUAL aarch32)
        declare_seL4_arch(aarch32)
    elseif("${KernelSel4Arch}" STREQUAL aarch64)
        declare_seL4_arch(aarch64)
    else()
        fallback_declare_seL4_arch(aarch64)
    endif()
    set(KernelArmCortexA72 ON)
    set(KernelArchArmV8a ON)
    set(KernelArmPASizeBits44 ON)
    config_set(KernelARMPlatform ARM_PLAT rpi4)
    set(KernelArmMachFeatureModifiers "+crc" CACHE INTERNAL "")
    list(APPEND KernelDTSList "tools/dts/rpi4.dts")
    list(APPEND KernelDTSList "src/plat/bcm2711/overlay-rpi4.dts")

    declare_default_headers(
        TIMER_FREQUENCY 54000000llu
        MAX_IRQ 512
        TIMER drivers/timer/arm_generic.h
        INTERRUPT_CONTROLLER arch/machine/gic_v2.h
    )
endif()

add_sources(
    DEP "KernelPlatformRpi4"
    CFILES src/arch/arm/machine/gic_v2.c src/arch/arm/machine/l2c_nop.c
)
