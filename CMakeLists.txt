cmake_minimum_required(VERSION 3.24)
project(bam-troly VERSION 26.01.01 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

find_package(Qt6 REQUIRED COMPONENTS Core Gui Quick QuickControls2)
find_package(SQLite3 REQUIRED)

qt_add_executable(bam-troly
    src/main.cpp
    src/presentation/app_controller.cpp
    src/presentation/app_controller.hpp
    src/workflow/agent_workflow.cpp
    src/workflow/agent_workflow.hpp
    src/plugins/tool_registry.cpp
    src/plugins/tool_registry.hpp
    src/modules/storage/db_manager.cpp
    src/modules/storage/db_manager.hpp
    src/modules/ai/llama_engine.cpp
    src/modules/ai/llama_engine.hpp
)

qt_add_qml_module(bam-troly
    URI BamTroly
    VERSION 1.0
    QML_FILES
        qml/Main.qml
        qml/components/FloatingBubble.qml
        qml/components/StatusIndicator.qml
        qml/views/ChatWindow.qml
        qml/views/MessageList.qml
        qml/views/PromptInput.qml
)

target_include_directories(bam-troly PRIVATE src)

target_link_libraries(bam-troly PRIVATE
    Qt6::Core
    Qt6::Gui
    Qt6::Quick
    Qt6::QuickControls2
    SQLite::SQLite3
    llama
)
