# CMake generated Testfile for 
# Source directory: C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24
# Build directory: C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/build
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
include("C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/build/hello_tests[1]_include.cmake")
if(CTEST_CONFIGURATION_TYPE MATCHES "^([Dd][Ee][Bb][Uu][Gg])$")
  add_test(hello_tests "C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/build/Debug/hello_tests.exe")
  set_tests_properties(hello_tests PROPERTIES  _BACKTRACE_TRIPLES "C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/CMakeLists.txt;53;add_test;C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
  add_test(hello_tests "C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/build/Release/hello_tests.exe")
  set_tests_properties(hello_tests PROPERTIES  _BACKTRACE_TRIPLES "C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/CMakeLists.txt;53;add_test;C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Mm][Ii][Nn][Ss][Ii][Zz][Ee][Rr][Ee][Ll])$")
  add_test(hello_tests "C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/build/MinSizeRel/hello_tests.exe")
  set_tests_properties(hello_tests PROPERTIES  _BACKTRACE_TRIPLES "C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/CMakeLists.txt;53;add_test;C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/CMakeLists.txt;0;")
elseif(CTEST_CONFIGURATION_TYPE MATCHES "^([Rr][Ee][Ll][Ww][Ii][Tt][Hh][Dd][Ee][Bb][Ii][Nn][Ff][Oo])$")
  add_test(hello_tests "C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/build/RelWithDebInfo/hello_tests.exe")
  set_tests_properties(hello_tests PROPERTIES  _BACKTRACE_TRIPLES "C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/CMakeLists.txt;53;add_test;C:/Users/Admin/csad_2025_KI407_TsiaputaMykhailoPetrovych_24/CMakeLists.txt;0;")
else()
  add_test(hello_tests NOT_AVAILABLE)
endif()
subdirs("_deps/googletest-build")
