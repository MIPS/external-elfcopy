LOCAL_PATH:= $(call my-dir)

#
# libelfcopy
#

include $(CLEAR_VARS)

LOCAL_SRC_FILES += \
	common.c \
	debug.c \
	elfcopy.c \
	hash.c \
	rangesort.c \
	fixdwarf.c \
	dwarf.c

ifeq ($(HOST_OS),linux)
endif
ifeq ($(HOST_OS),darwin)
endif

LOCAL_MODULE:=libelfcopy

#LOCAL_LDLIBS += -ldl
LOCAL_CFLAGS += -O2 -g
LOCAL_CFLAGS += -fno-function-sections -fno-data-sections -fno-inline
LOCAL_CFLAGS += -Wall -Wno-unused-function #-Werror
LOCAL_CFLAGS += -DBIG_ENDIAN=1
LOCAL_CFLAGS += -DDEBUG
LOCAL_CFLAGS += -DSTRIP_SECTIONS
LOCAL_CFLAGS += -DSTRIP_STATIC_SYMBOLS
LOCAL_CFLAGS += -DMOVE_SECTIONS_IN_RANGES
#LOCAL_CFLAGS += -DSORT_LOCATION_LIST_OFFSETS

ifeq ($(TARGET_ARCH), arm)
LOCAL_CFLAGS += -DARCH_ARM
LOCAL_CFLAGS += -DARM_SPECIFIC_HACKS
endif

ifeq ($(TARGET_ARCH), mips)
LOCAL_CFLAGS += -DARCH_MIPS
LOCAL_CFLAGS +=
endif

# dwarf.c
LOCAL_CFLAGS += -DATTRIBUTE_UNUSED="__attribute__((unused))"
LOCAL_CFLAGS += -DTRUE=1
LOCAL_CFLAGS += -DFALSE=0
LOCAL_CFLAGS += -Dprogram_name=\"libelfcopy\"

LOCAL_STATIC_LIBRARIES := libelf libebl

ifeq ($(TARGET_ARCH), arm)
LOCAL_STATIC_LIBRARIES += libebl_arm
endif

LOCAL_C_INCLUDES:= \
	$(LOCAL_PATH)/ \
	external/elfutils/lib/ \
	external/elfutils/libelf/ \
	external/elfutils/libebl/

include $(BUILD_HOST_STATIC_LIBRARY)
