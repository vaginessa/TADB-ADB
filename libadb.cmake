# ========================= adb proto ============================
set(ADB_PROTO_SRC)  # adb proto source files
set(ADB_PROTO_HDRS) # adb proto head files
set(ADB_PROTO_DIR adb/proto)

file(GLOB_RECURSE PROTO_FILES ${ADB_PROTO_DIR}/*.proto)

foreach(proto ${PROTO_FILES})
    get_filename_component(FIL_WE ${proto} NAME_WE)
    
    set(TARGET_CPP_FILE "${ADB_PROTO_DIR}/${FIL_WE}.pb.cc")
    set(TARGET_HEAD_FILE "${ADB_PROTO_DIR}/${FIL_WE}.pb.h")
    
    if(EXISTS ${TARGET_CPP_FILE} AND EXISTS ${TARGET_HEAD_FILE})
        list(APPEND ADB_PROTO_SRC ${TARGET_CPP_FILE})
        list(APPEND ADB_PROTO_HDRS ${TARGET_HEAD_FILE})
    endif()
endforeach()

# set_source_files_properties(${ADB_PROTO_SRC} PROPERTIES GENERATED TRUE)
# set_source_files_properties(${ADB_PROTO_HDRS} PROPERTIES GENERATED TRUE)
# ========================= adb proto ============================

# adb
add_executable(adb
    adb/client/main.cpp
    adb/client/adb_client.cpp
    adb/client/commandline.cpp
    adb/client/bugreport.cpp
    adb/client/file_sync_client.cpp
    adb/client/console.cpp
    adb/client/adb_install.cpp
    adb/client/line_printer.cpp
    adb/client/incremental.cpp
    adb/client/incremental_server.cpp
    adb/client/incremental_utils.cpp
    adb/client/auth.cpp
    adb/client/adb_wifi.cpp
    adb/client/usb_libusb.cpp
    adb/client/transport_local.cpp
    adb/client/transport_usb.cpp
    adb/client/pairing/pairing_client.cpp
    adb/client/usb_linux.cpp
    adb/shell_service_protocol.cpp
    adb/adb.cpp
    adb/adb_io.cpp
    adb/adb_listeners.cpp
    adb/adb_trace.cpp
    adb/adb_unique_fd.cpp
    adb/adb_utils.cpp
    adb/fdevent/fdevent.cpp
    adb/fdevent/fdevent_epoll.cpp
    adb/services.cpp
    adb/sockets.cpp
    adb/socket_spec.cpp
    adb/sysdeps/env.cpp
    adb/sysdeps/errno.cpp
    adb/sysdeps_unix.cpp
    adb/sysdeps/posix/network.cpp
    adb/sysdeps/env.cpp
    adb/transport.cpp
    adb/transport_fd.cpp
    adb/types.cpp
    adb/crypto/key.cpp
    adb/crypto/rsa_2048_key.cpp
    adb/crypto/x509_generator.cpp
    adb/tls/adb_ca_list.cpp
    adb/tls/tls_connection.cpp
    adb/pairing_connection/pairing_connection.cpp
    adb/pairing_auth/aes_128_gcm.cpp
    adb/pairing_auth/pairing_auth.cpp
    ${ADB_PROTO_SRC} ${ADB_PROTO_HDRS})
    
target_compile_definitions(adb PRIVATE -D_GNU_SOURCE -DADB_HOST=1)

target_include_directories(adb PRIVATE
    adb adb/proto adb/crypto/include adb/pairing_auth/include adb/pairing_connection/include adb/tls/include
    external/protobuf/src external/boringssl/include external/lz4/lib external/zstd/lib external/brotli/c/include
    android/incremental_delivery/incfs/util/include)

target_link_libraries(adb
    crypto ssl protobuf brotlicommon-static brotlidec-static brotlienc-static libzstd_static lz4_static libusb libz
    libbase liblog libutils libcutils libdiagnoseusb libandroidfw libziparchive libcrypto_utils)
