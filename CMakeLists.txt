cmake_minimum_required(VERSION 3.12.0)
project(TADB-adb VERSION 1.0.0 LANGUAGES C CXX ASM)

# Use C11 with GNU extensions
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_EXTENSIONS ON)
set(CMAKE_C_STANDARD_REQUIRED ON)

# Use C++20 with GNU extensions
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Disable warnings
add_compile_options(-Wno-attributes)

# 64-bit off_t for lseek
add_compile_definitions(_FILE_OFFSET_BITS=64)

# Tools version
set(ANDROID_VERSION "34.0.0")
set(ANDROID_VENDOR "TADB-custom")

# Generate config files
configure_file(version.h.in android/build/version.h @ONLY)
configure_file(platform_tools_version.h.in android/platform_tools_version.h @ONLY)

#
# Building
#
# libprotobuf.a
add_library(protobuf STATIC IMPORTED)
set_target_properties(protobuf PROPERTIES IMPORTED_LOCATION
    "${PROJECT_SOURCE_DIR}/external/protobuf/lib/${ANDROID_ABI}/libprotobuf.a")

# libcrypto.a
add_library(crypto STATIC IMPORTED)
set_target_properties(crypto PROPERTIES IMPORTED_LOCATION
    "${PROJECT_SOURCE_DIR}/external/boringssl/lib/${ANDROID_ABI}/libcrypto.a")

# libcrypto.a
add_library(ssl STATIC IMPORTED)
set_target_properties(ssl PROPERTIES IMPORTED_LOCATION
    "${PROJECT_SOURCE_DIR}/external/boringssl/lib/${ANDROID_ABI}/libssl.a")

# libfmt.a, libzstd.a, liblz4.a, libbrotli.a
add_subdirectory(external/fmtlib EXCLUDE_FROM_ALL)
add_subdirectory(external/zstd/build/cmake EXCLUDE_FROM_ALL)
add_subdirectory(external/lz4/build/cmake EXCLUDE_FROM_ALL)
add_subdirectory(external/brotli EXCLUDE_FROM_ALL)

# libusb.a
add_library(libusb STATIC
    external/libusb/libusb/core.c
    external/libusb/libusb/descriptor.c
    external/libusb/libusb/hotplug.c
    external/libusb/libusb/io.c
    external/libusb/libusb/sync.c
    external/libusb/libusb/strerror.c
    external/libusb/libusb/os/linux_usbfs.c
    external/libusb/libusb/os/events_posix.c
    external/libusb/libusb/os/threads_posix.c
    external/libusb/libusb/os/linux_netlink.c)
target_compile_options(libusb PRIVATE -fvisibility=hidden -pthread)
target_include_directories(libusb PRIVATE external/libusb/libusb
    external/libusb/libusb/os external/libusb/android)
target_include_directories(libusb PUBLIC external/libusb/libusb external/libusb)

# libz.a
add_library(libz STATIC
    external/zlib/adler32.c
    external/zlib/compress.c
    external/zlib/cpu_features.c
    external/zlib/crc32.c
    external/zlib/deflate.c
    external/zlib/gzclose.c
    external/zlib/gzlib.c
    external/zlib/gzread.c
    external/zlib/gzwrite.c
    external/zlib/infback.c
    external/zlib/inffast.c
    external/zlib/inflate.c
    external/zlib/inftrees.c
    external/zlib/trees.c
    external/zlib/uncompr.c
    external/zlib/zutil.c)
target_compile_definitions(libz PRIVATE -DHAVE_HIDDEN -DZLIB_CONST)
target_include_directories(libz PRIVATE external/zlib)
target_include_directories(libz PUBLIC external/zlib)

# Android libs
include_directories("${CMAKE_CURRENT_BINARY_DIR}/android")
include(android.cmake)
include(libadb.cmake)
