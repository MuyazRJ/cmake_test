cmake_minimum_required(VERSION 3.20)
project(fortran_python LANGUAGES Fortran C)

# 1. Ask CMake for a Python interpreter (and where to install the module)
find_package(Python3 REQUIRED COMPONENTS Interpreter)

# 2. Base name of the extension module
set(MODNAME _mycode)

# 3. Build the final file name:  _mycode${Python3_SOABI}
set(EXT_FILE "${CMAKE_CURRENT_BINARY_DIR}/${MODNAME}${Python3_SOABI}")


class Mysoftware(CMakePackage):
    """Example Spack package that needs BLAS/LAPACK and Intel MKL."""

    homepage = "https://example.org"
    url      = "https://example.org/mysoftware-1.2.3.tar.gz"
    version('1.2.3', sha256='...')

    # Generic BLAS/LAPACK interface (could be OpenBLAS, MKL, Netlib…)
    depends_on('blas')
    depends_on('lapack')

    # Explicitly say we want MKL as the provider
    depends_on('intel-oneapi-mkl threads=openmp', when='+mkl')

        def cmake_args(self):
        spec = self.spec
        args = []

        # BLAS / LAPACK (works no matter which implementation was chosen)
        args.append(self.define(
            'BLAS_LIBRARIES',   spec['blas'].libs.joined(';')))
        args.append(self.define(
            'LAPACK_LIBRARIES', spec['lapack'].libs.joined(';')))

        # MKL: headers, libraries, extra flags — already in the right order
        if '+mkl' in spec:
            args.extend([
                self.define('MKL_INCLUDE_DIR',
                            spec['intel-oneapi-mkl'].headers.directories[0]),
                self.define('MKL_LIBRARIES',
                            spec['intel-oneapi-mkl'].libs.joined(';')),
                # if your CMakeLists.txt needs the root directory:
                self.define('MKLROOT', spec['intel-oneapi-mkl'].prefix),
            ])

        return args
