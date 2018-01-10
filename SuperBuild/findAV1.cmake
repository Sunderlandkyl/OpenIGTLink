# - The AV1 library
# Once done this will define
#
#  AV1_ROOT - A list of search hints
#
#  AV1_FOUND - found AV1
#  AV1_INCLUDE_DIR - the AV1 include directory
#  AV1_LIBRARY_DIR - AV1 library directory

if(NOT CMAKE_SYSTEM_NAME STREQUAL "Windows") 
  SET( AV1_PATH_HINTS 
      ${AV1_ROOT} 
      ${AV1_INCLUDE_DIR}
      ${AV1_LIBRARY_DIR} 
      )
  unset(AV1_INCLUDE_DIR CACHE)
  find_path(AV1_INCLUDE_DIR NAMES aomenc.h aomstats.h
    HINTS ${AV1_PATH_HINTS} 
    )
    
  unset(AV1_LIBRARY_DIR CACHE)
  find_path(AV1_LIBRARY_DIR
     NAMES aom.lib
     PATH_SUFFIXES ${Platform}/${CMAKE_BUILD_TYPE}
     HINTS ${AV1_PATH_HINTS}
     )
  include(FindPackageHandleStandardArgs)
  FIND_PACKAGE_HANDLE_STANDARD_ARGS(AV1 REQUIRED_VARS AV1_LIBRARY_DIR AV1_INCLUDE_DIR)

  mark_as_advanced(AV1_INCLUDE_DIR AV1_LIBRARY_DIR)
else()
	SET(AV1_PATH_HINTS 
      ${AV1_ROOT} 
      ${AV1_INCLUDE_DIR}
      )
  
  unset(AV1_INCLUDE_DIR CACHE)
  find_path(AV1_INCLUDE_DIR NAMES aomenc.h aomstats.h
    HINTS ${AV1_PATH_HINTS} 
    )
  
  if(NOT AV1_INCLUDE_DIR)
    MESSAGE(FATAL_ERROR "AV1 include files not found, specify the file path")
  endif()  
  
  set(AV1_LIBRARY_DIR "" CACHE PATH "")
  SET(AV1_PATH_HINTS 
      ${AV1_ROOT}
      ${AV1_LIBRARY_DIR}/Win32/Release 
      ${AV1_LIBRARY_DIR}/Win32/Debug 
      ${AV1_LIBRARY_DIR}/x64/Release 
      ${AV1_LIBRARY_DIR}/x64/Debug
      )

  find_path(AV1_LIBRARY_DIRECT_DIR aom.lib
     HINTS  ${AV1_PATH_HINTS}
     )	 
  if(NOT AV1_LIBRARY_DIRECT_DIR)
    unset(AV1_LIBRARY_DIRECT_DIR  CACHE) # don't expose the AV1_LIBRARY_DIRECT_DIR to user, force the user to set the variable AV1_LIBRARY_DIR
    MESSAGE(FATAL_ERROR "AV1 library file not found, specify the path where the av1 project was build, if av1 was built in source, then set the library path the same as include path")
  else()
    unset(AV1_LIBRARY_DIRECT_DIR  CACHE)
    add_library(AV1_lib STATIC IMPORTED GLOBAL)
    set_property(TARGET AV1_lib PROPERTY IMPORTED_LOCATION_RELEASE ${AV1_LIBRARY_DIR}/lib/Release/aom.lib)
    set_property(TARGET AV1_lib PROPERTY IMPORTED_LOCATION_DEBUG ${AV1_LIBRARY_DIR}/lib/Debug/aom.lib)   
  endif()
endif()
