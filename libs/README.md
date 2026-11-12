# Build output

Generated libraries now live in the consuming project's CMake build directory
(`build/lib` by default), so separate builds do not overwrite each other or
write into the openFrameworks installation.
