cmake_minimum_required(VERSION 3.0.0)
project(bfWakePc VERSION 0.1.0)

include(CTest)
enable_testing()

# 添加头文件扫描
include_directories(./lib/paho.mqtt.embedded-c/MQTTPacket/src)
include_directories(./lib/paho.mqtt.embedded-c/MQTTClient-C/src)
include_directories(./lib/paho.mqtt.embedded-c/MQTTClient-C/src/linux)

# 添加子目录，目录中有 CMakeLists.txt，这将会把依赖安装上
add_subdirectory(./lib/paho.mqtt.embedded-c/MQTTPacket/src)
add_subdirectory(./lib/paho.mqtt.embedded-c/MQTTClient-C/src)

# 链接静态库
link_libraries(paho-embed-mqtt3c)
link_libraries(paho-embed-mqtt3cc)

# 添加可执行文件
add_executable(bfWakePc main.c)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
