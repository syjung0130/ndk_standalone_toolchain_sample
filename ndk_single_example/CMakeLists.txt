CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

project(HelloWorld)

set(NDK_STANDALONE_TOOLCHAIN /tmp/ndk-toolchain)
set(CMAKE_SYSTEM_NAME Android)
set(ANDROID_NDK /workdir/android-ndk-r18b)

set(CMAKE_SYSTEM_VERSION 26)
set(CMAKE_C_COMPILER ${NDK_STANDALONE_TOOLCHAIN}/bin/aarch64-linux-android-gcc)
set(CMAKE_CXX_COMPILER ${NDK_STANDALONE_TOOLCHAIN}/bin/aarch64-linux-android-g++)
set(CMAKE_LINKER ${NDK_STANDALONE_TOOLCHAIN}/bin/aarch64-linux-android-ld)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pipe -g -O0 -std=c++11 -frtti -fexceptions")


set(ANDROID_STL=c++_shared)

set(ANDROID_ABI arm64-v8a)
set(CMAKE_FIND_ROOT_PATH ${NDK_STANDALONE_TOOLCHAIN})
add_definitions("--sysroot=${NDK_STANDALONE_TOOLCHAIN}/sysroot")

set(CMAKE_C_COMPILER ${NDK_STANDALONE_TOOLCHAIN}/bin/aarch64-linux-android-gcc)
set(CMAKE_CXX_COMPILER ${NDK_STANDALONE_TOOLCHAIN}/bin/aarch64-linux-android-g++)
set(CMAKE_LINKER ${NDK_STANDALONE_TOOLCHAIN}/bin/aarch64-linux-android-ld)
set(CMAKE_AR ${NDK_STANDALONE_TOOLCHAIN}/bin/aarch64-linux-android-ar)
set(CMAKE_AS ${NDK_STANDALONE_TOOLCHAIN}/bin/aarch64-linux-android-as)


set(NDK_STANDALONE_TOOLCHAIN_SYSROOT ${NDK_STANDALONE_TOOLCHAIN}/sysroot)

# r18
set(CMAKE_C_FLAGS "-isystem ${NDK_STANDALONE_TOOLCHAIN_SYSROOT}/usr/include/aarch64-linux-android -D__ANDROID_API__=26 -g -DANDROID -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes -Wno-error=format-security  -Wall -Wvariadic-macros -std=c99 -O0")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -isystem ${NDK_STANDALONE_TOOLCHAIN_SYSROOT}/usr/include/aarch64-linux-android -D__ANDROID_API__=26 -g -DANDROID -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes  -Wno-error=format-security -frtti -fexceptions  -Wall -Wvariadic-macros -O0")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -pipe -O0 -frtti -fexceptions")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -isystem ${NDK_STANDALONE_TOOLCHAIN_SYSROOT}/usr/include/aarch64-linux-android -D__ANDROID_API__=26 -g -DANDROID -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes -Wno-error=format-security")
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} ${NDK_STANDALONE_TOOLCHAIN_SYSROOT}/usr/include/aarch64-linux-android -D__ANDROID_API__=26 -g -DANDROID -ffunction-sections -funwind-tables -fstack-protector-strong -no-canonical-prefixes -Wno-error=format-security")

set(CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG} -O0 -g")
set(CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG} -O0 -g")
set(CMAKE_ASM_FLAGS_DEBUG "${CMAKE_ASM_FLAGS_DEBUG} -O0")
set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} -O0 -DNDEBUG -O0 -DNDEBUG")
set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} -O0 -DNDEBUG -O0 -DNDEBUG")
set(CMAKE_ASM_FLAGS_RELEASE "${CMAKE_ASM_FLAGS_RELEASE} -O0 -DNDEBUG")

# r18
set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -Wl,--exclude-libs,libgcc.a -Wl,--exclude-libs,libatomic.a --sysroot ${NDK_STANDALONE_TOOLCHAIN_SYSROOT} -Wl,--build-id -Wl,--warn-shared-textrel -Wl,--fatal-warnings -Wl,-z,execstack -Wl,-z,relro -Wl,-z,now -static-libstdc++")
set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -Wl,--exclude-libs,libgcc.a -Wl,--exclude-libs,libatomic.a --sysroot ${NDK_STANDALONE_TOOLCHAIN_SYSROOT} -Wl,--build-id -Wl,--warn-shared-textrel -Wl,--fatal-warnings -Wl,-z,execstack -Wl,-z,relro -Wl,-z,now -static-libstdc++")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--exclude-libs,libgcc.a -Wl,--exclude-libs,libatomic.a --sysroot ${NDK_STANDALONE_TOOLCHAIN_SYSROOT} -Wl,--build-id -Wl,--warn-shared-textrel -Wl,--fatal-warnings -Wl,-z,execstack -Wl,-z,relro -Wl,-z,now -Wl,--gc-sections -Wl,-z,nocopyreloc -static-libstdc++")
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES "${CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES} ${NDK_STANDALONE_TOOLCHAIN}/include/c++/4.9.x;${NDK_STANDALONE_TOOLCHAIN}/include/c++/4.9.x/aarch64-linux-android/;${NDK_STANDALONE_TOOLCHAIN}/include/c++/4.9.x/backward -static-libstdc++")


message(STATUS "#####################################################################################")
message(STATUS "==== CMAKE_C_FLAGS              : ${CMAKE_C_FLAGS} ====")
message(STATUS "==== CMAKE_CXX_FLAGS            : ${CMAKE_CXX_FLAGS} ====")
message(STATUS "==== CMAKE_ASM_FLAGS            : ${CMAKE_ASM_FLAGS} ====")
message(STATUS "==== CMAKE_C_FLAGS_DEBUG        : ${CMAKE_C_FLAGS_DEBUG} ====")
message(STATUS "==== CMAKE_CXX_FLAGS_DEBUG      : ${CMAKE_CXX_FLAGS_DEBUG} ====")
message(STATUS "==== CMAKE_ASM_FLAGS_DEBUG      : ${CMAKE_ASM_FLAGS_DEBUG} ====")
message(STATUS "==== CMAKE_C_FLAGS_RELEASE      : ${CMAKE_C_FLAGS_RELEASE} ====")
message(STATUS "==== CMAKE_CXX_FLAGS_RELEASE    : ${CMAKE_CXX_FLAGS_RELEASE} ====")
message(STATUS "==== CMAKE_ASM_FLAGS_RELEASE    : ${CMAKE_ASM_FLAGS_RELEASE} ====")
message(STATUS "==== CMAKE_SHARED_LINKER_FLAGS  : ${CMAKE_SHARED_LINKER_FLAGS} ====")
message(STATUS "==== CMAKE_MODULE_LINKER_FLAGS  : ${CMAKE_MODULE_LINKER_FLAGS} ====")
message(STATUS "==== CMAKE_EXE_LINKER_FLAGS     : ${CMAKE_EXE_LINKER_FLAGS} ====")
message(STATUS "==== CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES: ${CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES} ====")
message(STATUS "#####################################################################################")

ADD_LIBRARY( MySharedLib SHARED
             Structure.cpp )

SET( APP_EXE SharedTest )

ADD_EXECUTABLE( ${APP_EXE}
                main.cpp ) 

TARGET_LINK_LIBRARIES( ${APP_EXE}
                       MySharedLib 
                       log
                       )
