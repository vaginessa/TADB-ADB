# libbase.a
add_library(libbase STATIC
    android/libbase/errors_unix.cpp
    android/libbase/abi_compatibility.cpp
	android/libbase/chrono_utils.cpp
	android/libbase/cmsg.cpp
	android/libbase/file.cpp
	android/libbase/hex.cpp
	android/libbase/logging.cpp
	android/libbase/mapped_file.cpp
	android/libbase/parsebool.cpp
	android/libbase/parsenetaddress.cpp
	android/libbase/posix_strerror_r.cpp
	android/libbase/process.cpp
	android/libbase/properties.cpp
	android/libbase/stringprintf.cpp
	android/libbase/strings.cpp
	android/libbase/threads.cpp
	android/libbase/test_utils.cpp)
target_include_directories(libbase PRIVATE
    android/libbase/include android/core/libcutils/include android/core/libutils/include 
    android/core/libsystem/include android/logging/liblog/include)
target_include_directories(libbase PUBLIC android/libbase/include external/fmtlib/include)
target_link_libraries(libbase PUBLIC fmt::fmt)

# libutils.a
add_library(libutils STATIC
	android/core/libutils/FileMap.cpp
	android/core/libutils/SharedBuffer.cpp
	android/core/libutils/String8.cpp
	android/core/libutils/String16.cpp
	android/core/libutils/Unicode.cpp
	android/core/libutils/VectorImpl.cpp)
target_include_directories(libutils PRIVATE
    android/core/libcutils/include android/core/libutils/include
    android/core/libsystem/include android/logging/liblog/include android/libbase/include)
target_include_directories(libutils PUBLIC android/core/libutils/include)

# libcutils.a
add_library(libcutils STATIC
    android/core/libcutils/socket_inaddr_any_server_unix.cpp
	android/core/libcutils/socket_local_client_unix.cpp
	android/core/libcutils/socket_local_server_unix.cpp
	android/core/libcutils/socket_network_client_unix.cpp
	android/core/libcutils/sockets_unix.cpp
	android/core/libcutils/sockets.cpp
	android/core/libcutils/fs.cpp
	android/core/libcutils/hashmap.cpp
	android/core/libcutils/multiuser.cpp
	android/core/libcutils/str_parms.cpp
	android/core/libcutils/ashmem-host.cpp
	android/core/libcutils/canned_fs_config.cpp
	android/core/libcutils/fs_config.cpp
	android/core/libcutils/trace-host.cpp
	android/core/libcutils/config_utils.cpp
	android/core/libcutils/iosched_policy.cpp
	android/core/libcutils/load_file.cpp
	android/core/libcutils/native_handle.cpp
	android/core/libcutils/properties.cpp
	android/core/libcutils/record_stream.cpp
	android/core/libcutils/strlcpy.c
	android/core/libcutils/threads.cpp)
target_compile_definitions(libcutils PRIVATE -D_GNU_SOURCE)
target_include_directories(libcutils PRIVATE
    android/libbase/include android/core/libutils/include
    android/core/libcutils/include android/logging/liblog/include)
target_include_directories(libcutils PUBLIC android/core/libcutils/include)
    
# liblog.a
add_library(liblog STATIC
    android/logging/liblog/log_event_list.cpp
    android/logging/liblog/log_event_write.cpp
    android/logging/liblog/logger_name.cpp
    android/logging/liblog/logger_read.cpp
    android/logging/liblog/logger_write.cpp
    android/logging/liblog/properties.cpp
    android/logging/liblog/logprint.cpp)
target_compile_definitions(liblog PRIVATE -DLIBLOG_LOG_TAG=1006 -D_XOPEN_SOURCE=700 -DFAKE_LOG_DEVICE=1)
target_include_directories(liblog PRIVATE
    android/core/libcutils/include android/core/libutils/include android/core/libsystem/include
    android/logging/liblog/include android/libbase/include)
target_include_directories(liblog PUBLIC android/logging/liblog/include)

# libandroidfw.a
add_library(libandroidfw STATIC
    android/base/libs/androidfw/ApkAssets.cpp
	android/base/libs/androidfw/Asset.cpp
	android/base/libs/androidfw/AssetDir.cpp
	android/base/libs/androidfw/AssetManager.cpp
	android/base/libs/androidfw/AssetManager2.cpp
	android/base/libs/androidfw/AssetsProvider.cpp
	android/base/libs/androidfw/AttributeResolution.cpp
	android/base/libs/androidfw/ChunkIterator.cpp
	android/base/libs/androidfw/ConfigDescription.cpp
	android/base/libs/androidfw/Idmap.cpp
	android/base/libs/androidfw/LoadedArsc.cpp
	android/base/libs/androidfw/Locale.cpp
	android/base/libs/androidfw/LocaleData.cpp
	android/base/libs/androidfw/misc.cpp
	android/base/libs/androidfw/ObbFile.cpp
	android/base/libs/androidfw/PosixUtils.cpp
	android/base/libs/androidfw/ResourceTypes.cpp
	android/base/libs/androidfw/ResourceUtils.cpp
	android/base/libs/androidfw/StreamingZipInflater.cpp
	android/base/libs/androidfw/TypeWrappers.cpp
	android/base/libs/androidfw/Util.cpp
	android/base/libs/androidfw/ZipFileRO.cpp
	android/base/libs/androidfw/ZipUtils.cpp)
target_compile_definitions(libandroidfw PUBLIC -DSTATIC_ANDROIDFW_FOR_TOOLS)
target_compile_definitions(libandroidfw PRIVATE -D_GNU_SOURCE -DNDEBUG)
target_include_directories(libandroidfw PRIVATE
    android/base/libs/androidfw/include android/core/libcutils/include
    android/logging/liblog/include android/core/libsystem/include android/core/libutils/include android/libbase/include
    android/libziparchive/include android/incremental_delivery/incfs/util/include external/fmtlib/include)
target_include_directories(libandroidfw PUBLIC android/base/libs/androidfw/include)
target_link_libraries(libandroidfw PUBLIC fmt::fmt)

# libziparchive.a
add_library(libziparchive STATIC
    android/libziparchive/zip_archive.cc
    android/libziparchive/zip_archive_stream_entry.cc
    android/libziparchive/zip_cd_entry_map.cc
    android/libziparchive/zip_writer.cc
    android/libziparchive/zip_error.cpp
    android/libziparchive/incfs_support/signal_handling.cpp)
target_compile_definitions(libziparchive PRIVATE -DZLIB_CONST)
target_include_directories(libziparchive PRIVATE
    android/libziparchive/include android/libziparchive/incfs_support/include
    android/libbase/include android/logging/liblog/include)
target_include_directories(libziparchive PUBLIC android/libziparchive/include)

# libcrypto_utils.a
add_library(libcrypto_utils STATIC android/core/libcrypto_utils/android_pubkey.cpp)
target_include_directories(libcrypto_utils PRIVATE
    android/core/libcrypto_utils/include external/boringssl/include)
target_include_directories(libcrypto_utils PUBLIC
    android/core/libcrypto_utils/include external/boringssl/include)

# libdiagnoseusb.a
add_library(libdiagnoseusb STATIC android/core/diagnose_usb/diagnose_usb.cpp)
target_include_directories(libdiagnoseusb PRIVATE
    android/core/diagnose_usb/include android/core/libutils/include
    android/core/libcutils/include android/libbase/include)
target_include_directories(libdiagnoseusb PUBLIC android/core/diagnose_usb/include)