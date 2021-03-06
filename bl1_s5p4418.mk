$(info "======= bl1.mk enter =========")

BL1_BIN := $(PRODUCT_OUT)/bl1-emmcboot.bin

$(BL1_BIN) :
	$(hide) echo "=========== BL1 USB boot Building !!! ==========";
	$(MAKE) -C $(TARGET_BL1_SRC) clean;
	$(MAKE) -C $(TARGET_BL1_SRC) CHIPNAME="$(CHIPNAME)" BOARD="$(BL1_BOARD_NAME)" KERNEL_VER="4" SYSLOG="n" DEVICE_PORT="$(DEVICE_PORT)" SUPPORT_USB_BOOT="y"	SUPPORT_SDMMC_BOOT="n" ;
	$(shell cp -af $(TARGET_BL1_SRC)/out/bl1-$(BL1_BOARD_NAME).bin $(PRODUCT_OUT)/bl1-usbboot.bin);
	$(hide) echo "=========== BL1 SDMMC boot Building !!! ==========";
	$(MAKE) -C $(TARGET_BL1_SRC) clean;
	$(MAKE) -C $(TARGET_BL1_SRC) CHIPNAME="$(CHIPNAME)" BOARD="$(BL1_BOARD_NAME)" KERNEL_VER="4" SYSLOG="n" DEVICE_PORT="$(DEVICE_PORT)" SUPPORT_USB_BOOT="n" SUPPORT_SDMMC_BOOT="y" QUICKBOOT="$(QUICKBOOT)" OTA_AB_UPDATE=y PRODUCT_CAR="$(PRODUCT_CAR)";
	$(shell cp -af $(TARGET_BL1_SRC)/out/bl1-emmcboot.bin $(BL1_BIN) );

.PHONY : $(BL1_BIN)

bl1image: $(BL1_BIN)

ALL_DEFAULT_INSTALLED_MODULES += $(BL1_BIN)
$(info "======= bl1.mk exit =========")
