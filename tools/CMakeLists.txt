add_subdirectory(temps)

file(GLOB PY_FILES "*.py")
install(FILES ${PY_FILES} DESTINATION ./tools)