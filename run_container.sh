#!/bin/sh
docker run -it --volume="$PWD/../..:/workdir/ndk_single_example" --volume="$PWD/build:/workdir/build" ndk-sample:imx-1
