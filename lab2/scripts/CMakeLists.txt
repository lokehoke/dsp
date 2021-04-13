project(dft LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)

set(SRC_LIST main.cpp dsp.cpp)
add_executable(dft ${SRC_LIST})
