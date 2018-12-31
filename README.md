# Docker build  
 - docker build -t ndk-sample:imx-1 .
  
# Run Docker container 
  - docker run -it --volume="$PWD/../..:/workdir/ndk_single_example" --volume="$PWD/build:/workdir/build" ndk-sample:imx-1
  - or ./run_container.sh

# (참고) NDK 관련 내용
 - NDK Standalone C++ STL Support(https://developer.android.com/ndk/guides/standalone_toolchain?hl=en)  
 (C++ STL Support 절 참고)  
static 버전을 쓰려면 -static-libstdc++ 플래그를 쓰면 된다.  
shared 버전은 디폴트이며 앱에 libc++_shared.so를 패키징을 해주어야 한다.  

 - Selecting a C++ Runtime(https://developer.android.com/ndk/guides/cpp-support?hl=en)  
 (위 url에서 "Selecting a  C++ Runtime"절 참고)  
 링커플래그로 -static-libstdc++ 플래그를 사용하면 static c++ library를 사용할 수 있다.  
 디폴트로 shared library를 사용하고 있고, shared library를 사용할 경우 libc++_shared.so를 앱에서 직접 링킹을 해야한다.  
When using a Standalone Toolchain, the toolchain will use the shared STL by default.  
To use the static variant, add -static-libstdc++ to your linker flags.  

 - aarch64-linux-android gcc 옵션 참고  
https://gcc.gnu.org/onlinedocs/gcc/AArch64-Options.html#aarch64-feature-modifiers  


 - Android NDK 공식 github  
NDK에 대한 이슈 리포팅과 sample파일들이 있음.(https://github.com/android-ndk/ndk/issues)  
r18에서 변경된 내용 (https://github.com/android-ndk/ndk/wiki/Changelog-r18)  
r16, r17과 libc++ 링킹 관련 이슈들
r17버전에서 -static-libstdc++ flag동작하지 않는 문제(https://github.com/android-ndk/ndk/issues/692)  
r15이하 버전에서 libc++이 정상 링크되지 않는 문제(https://github.com/android-ndk/ndk/issues/379)  
올바를 빌드 프로세스에 대해서는 이 url을 참고하라고 함(https://android.googlesource.com/platform/ndk/+/master/docs/BuildSystemMaintainers.md#Unwinding)  

 - Android NDK sample 코드 github  
NDK sample code repository (https://github.com/googlesamples/android-ndk)  
라이브러리 만드는 CMake 샘플 (https://github.com/googlesamples/android-ndk/blob/master/hello-libs)  

 - ndk toolchain 설치 옵션
<pre>
usage: make_standalone_toolchain.py [-h] --arch
                                    {arm,arm64,mips,mips64,x86,x86_64}
                                    [--api API]
                                    [--unified-headers | --deprecated-headers]
                                    [--force] [-v]
                                    [--package-dir PACKAGE_DIR | --install-dir INSTALL_DIR]
</pre>

 - selinux 관련 설정
기본적으로 selinux옵션을 Enforcing을 사용하고 있음..
옵션 변경은 setenforce 0 으로 permissive모드로 변경 가능, setenforce 1으로 enforce 모드로 변경 가능함.
 - 현재 selinux 설정값 가져오기  
 $ getenforce  
또는  
getprop |grep selinux

 - selinux 옵션을 permissive 모드로 변경  
 $ setenforce 0
