project(t2lp)
CMAKE_MINIMUM_REQUIRED (VERSION 2.6.0)



SET (ROOT_PATH /home/zhoutengteng/Documents/ide_t2lp/t2lp)
MESSAGE (STATUS "ROOT PATH IS ${ROOT_PATH}")



INCLUDE_DIRECTORIES (${ROOT_PATH}/src)
INCLUDE_DIRECTORIES (${ROOT_PATH}/include)

add_subdirectory(include)
add_subdirectory(src)



add_executable(t2lp main.cpp)

TARGET_LINK_LIBRARIES (t2lp Common)

install(TARGETS t2lp RUNTIME DESTINATION bin)