#!/usr/bin/env bash
docker exec cpp_tango mkdir -p /src/idl/build
docker exec cpp_tango mkdir -p /src/build

echo "Build tango-idl"
docker exec cpp_tango cmake -H/src/idl -B/src/idl/build
echo "Install tango-idl"
docker exec cpp_tango make -C /src/idl/build install
echo "Build cppTango:$CMAKE_BUILD_TYPE"
docker exec cpp_tango cmake -H/src -B/src/build -DCMAKE_VERBOSE_MAKEFILE=true -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE
docker exec cpp_tango make -C /src/build -j 2
echo "Test cppTango"
docker exec cpp_tango /bin/sh -c 'cd /src/build; exec ctest -V'