include(ExternalProject)

#===== GTSET =====#
set(GTEST_VERSION 1.8.0)
set(GTEST "${EXTERNAL_PROJECT_DIR}/googletest-${GTEST_VERSION}")
list(APPEND CMAKE_ARGS_GTEST  "-DCMAKE_INSTALL_PREFIX=${GTEST}" "-DBUILD_SHARED_LIBS=ON")

find_file(GTEST_IN_DEPS NAMES lib/libgtest.dylib PATHS ${GTEST}/)

if(GTEST_IN_DEPS)

else()
    ExternalProject_Add(
        gtest_project
        DOWNLOAD_DIR ${GTEST}
        GIT_REPOSITORY git@github.com:google/googletest.git
        SOURCE_DIR "${GTEST}"
        BUILD_IN_SOURCE 1
        UPDATE_COMMAND ""
        GIT_TAG release-${GTEST_VERSION}
        INSTALL_COMMAND make install
        CMAKE_ARGS ${CMAKE_ARGS_GTEST}
            
    )
endif()

set(CMAKE_PREFIX_PATH "${GTEST}/lib")
find_library(libgtest REQUIRED)
