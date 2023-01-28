vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO icculus/SDL_sound
    REF 6cb07c21fab468be5f6a8b4c00c1b29697a9cc7a #v2.0.1
    SHA512 5cc2f8157ab441992b61fee1c2e783f3571ce6566a356d90dc28ab23cb00a6c08ea4ff883fa2b5f3893198dcef32beb943dafd123c5f256e77e1815ae00211d9
    HEAD_REF main
)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        shared        SDLSOUND_BUILD_SHARED
        static        SDLSOUND_BUILD_STATIC
        timidity      SDLSOUND_DECODER_MIDI
        tool          SDLSOUND_BUILD_TEST
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
if(EXISTS "${CURRENT_PACKAGES_DIR}/cmake")
    vcpkg_cmake_config_fixup(PACKAGE_NAME SDL2_sound CONFIG_PATH cmake)
else()
    vcpkg_cmake_config_fixup(PACKAGE_NAME SDL2_sound CONFIG_PATH lib/cmake/SDL2_sound)
endif()

vcpkg_fixup_pkgconfig()

vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/share/licenses")

file(INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}")
file(INSTALL "${SOURCE_PATH}/LICENSE.txt" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
