vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO libsdl-org/SDL_rtf
    REF b637ae21281f69fb4d31ec7fe244daf9935e8af1 #v2.0.0
    SHA512 041a489871624dababc2f7cc95e48728c3276f087f11bef9fe102907caf0345bc3424c0a2bd9c517af6d1da59691c6690fc07898088ccc98e52d81c53e443c6f
    HEAD_REF main
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
#        -DSDL2RTF_VENDORED=OFF
        -DSDL2RTF_SAMPLES=OFF
#        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
if(EXISTS "${CURRENT_PACKAGES_DIR}/cmake")
    vcpkg_cmake_config_fixup(PACKAGE_NAME SDL2_rtf CONFIG_PATH cmake)
else()
    vcpkg_cmake_config_fixup(PACKAGE_NAME SDL2_rtf CONFIG_PATH lib/cmake/SDL2_rtf)
endif()

vcpkg_fixup_pkgconfig()

vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/licenses")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
