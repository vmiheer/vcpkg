# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   CURRENT_INSTALLED_DIR     = ${VCPKG_ROOT_DIR}\installed\${TRIPLET}
#   DOWNLOADS                 = ${VCPKG_ROOT_DIR}\downloads
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#   VCPKG_TOOLCHAIN           = ON OFF
#   TRIPLET_SYSTEM_ARCH       = arm x86 x64
#   BUILD_ARCH                = "Win32" "x64" "ARM"
#   MSBUILD_PLATFORM          = "Win32"/"x64"/${TRIPLET_SYSTEM_ARCH}
#   DEBUG_CONFIG              = "Debug Static" "Debug Dll"
#   RELEASE_CONFIG            = "Release Static"" "Release DLL"
#   VCPKG_TARGET_IS_WINDOWS
#   VCPKG_TARGET_IS_UWP
#   VCPKG_TARGET_IS_LINUX
#   VCPKG_TARGET_IS_OSX
#   VCPKG_TARGET_IS_FREEBSD
#   VCPKG_TARGET_IS_ANDROID
#   VCPKG_TARGET_IS_MINGW
#   VCPKG_TARGET_EXECUTABLE_SUFFIX
#   VCPKG_TARGET_STATIC_LIBRARY_SUFFIX
#   VCPKG_TARGET_SHARED_LIBRARY_SUFFIX
#
# 	See additional helpful variables in /docs/maintainers/vcpkg_common_definitions.md

# # Specifies if the port install should fail immediately given a condition
# vcpkg_fail_port_install(MESSAGE "isl currently only supports Linux and Mac platforms" ON_TARGET "Windows")

# vcpkg_from_github(
#     OUT_SOURCE_PATH SOURCE_PATH
#     REPO vmiheer/isl
#     HEAD_REF patch-1
#     REF 0ba59d683d0abbecc54a5bec2901084be2550049
#     SHA512 1
# )

vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL C:/Users/mvaidya/source/repos/isl
    REF 276fe83f9cb3f0485181460df80485ef588ffd39
)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    # PREFER_NINJA
    OPTIONS
        ${OPTIONS}
        -DISL_INT=gmp
        -DISL_SMALL_INT_OPT=OFF
)
vcpkg_install_cmake()
vcpkg_copy_pdbs()

# vcpkg_install_cmake()

# # Moves all .cmake files from /debug/share/isl/ to /share/isl/
# # See /docs/maintainers/vcpkg_fixup_cmake_targets.md for more details

vcpkg_fixup_cmake_targets(CONFIG_PATH cmake TARGET_PATH share/isl)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
# # Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/isl RENAME copyright)
