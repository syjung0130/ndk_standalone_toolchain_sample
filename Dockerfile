FROM ubuntu:14.04

RUN sed -i s/archive.ubuntu.com/ftp.daumkakao.com/g /etc/apt/sources.list
RUN apt-get clean
RUN apt-get update 


RUN apt-get install -y make 
RUN apt-get install -y git unzip 
RUN apt-get install -y wget

RUN apt-get install -y build-essential

#cmake
RUN wget -O cmake.tar.gz "https://cmake.org/files/v3.7/cmake-3.7.0.tar.gz" \
    && mkdir -p /usr/src/cmake \
	&& tar -xvzf cmake.tar.gz -C /usr/src/cmake --strip-components=1 \
	&& rm cmake.tar.gz \
	&& cd /usr/src/cmake \
	&& ./bootstrap \
	&& make \
	&& make install \
	&& ldconfig 

RUN mkdir -p /workdir/build

# Download NDK standalone toolchain, python
RUN wget -O /workdir/ndk_18b.zip "https://dl.google.com/android/repository/android-ndk-r18b-linux-x86_64.zip" \
	&& cd /workdir \
    && unzip /workdir/ndk_18b.zip \
    && cd -

RUN	yes | apt-get install python    

RUN echo "======== NDK dir : ========" \
	&& echo "$(ls -al /workdir |grep ndk)" \
	&& echo "============================"

# Install StandAlone NDK Toolchain
RUN /workdir/android-ndk-r18b/build/tools/make_standalone_toolchain.py --arch arm64 --api 26 --verbose --force --install-dir /tmp/ndk-toolchain

RUN echo "======== StandAlone dir ========" \
	&& echo ": $(ls -al /tmp |grep ndk)" \
	&& echo "============================"

# Set environment variables
ENV PATH=$PATH:/tmp/ndk-toolchain/bin
ENV ANDROID_NDK_HOME=/workdir/android-ndk-r16b
ENV ANDROID_STANDALONE_TOOLCHAIN=/tmp/ndk-toolchain
ENV SDKTARGETSYSROOT=${ANDROID_STANDALONE_TOOLCHAIN}/sysroot
ENV PREFIX=${SDKTARGETSYSROOT}
ENV ANDROID_OS=26

# Tell configure what tools to use.
RUN echo " Set environment variables for android-ndk"
ENV target_host=aarch64-linux-android
ENV CC="${ANDROID_STANDALONE_TOOLCHAIN}/bin/${target_host}-gcc -march=armv8-a --sysroot=${SDKTARGETSYSROOT}"
ENV CXX="${ANDROID_STANDALONE_TOOLCHAIN}/bin/${target_host}-g++ -march=armv8-a --sysroot=${SDKTARGETSYSROOT}"
ENV CPP="${ANDROID_STANDALONE_TOOLCHAIN}/bin/${target_host}-gcc -E -march=armv8-a --sysroot=${SDKTARGETSYSROOT}"

ENV LD="${ANDROID_STANDALONE_TOOLCHAIN}/bin/${target_host}-ld --sysroot=${SDKTARGETSYSROOT}"
ENV AS="${ANDROID_STANDALONE_TOOLCHAIN}/bin/${target_host}-as"
ENV AR="${ANDROID_STANDALONE_TOOLCHAIN}/bin/${target_host}-ar"
ENV NM="${ANDROID_STANDALONE_TOOLCHAIN}/bin/${target_host}-nm"
ENV GDB="${ANDROID_STANDALONE_TOOLCHAIN}/bin/${target_host}-gdb"
ENV STRIP="${ANDROID_STANDALONE_TOOLCHAIN}/bin/${target_host}-strip"
# ENV RANLIB="${ANDROID_STANDALONE_TOOLCHAIN}/bin/${target_host}-ranlib"
# ENV OBJCOPY="${ANDROID_STANDALONE_TOOLCHAIN}/bin/${target_host}-objcopy"
# ENV OBJDUMP="${ANDROID_STANDALONE_TOOLCHAIN}/bin/${target_host}-objdump"
ENV ARCH=arm64
ENV TARGET=aarch64-linux-android

RUN apt-get install android-tools-adb

# Make cm.sh for running cmake
# build argument for android: https://developer.android.com/ndk/guides/cmake#variables
RUN echo "cmake \
 -DCMAKE_PREFIX_PATH=${PREFIX} \
 -DTARGET=${TARGET} \
  /workdir/ndk_single_example" > /workdir/cm.sh && chmod +x /workdir/cm.sh


VOLUME /workdir/ndk_single_example
VOLUME /workdir/build

WORKDIR /workdir/build

CMD ["/bin/bash"]
