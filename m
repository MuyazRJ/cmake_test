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




packages:
  all:
    compiler: [gcc@13.2.0]   # use this compiler unless the spec says otherwise

  gcc:                       # mark the system GCC as external
    externals:
    - spec: gcc@13.2.0
      prefix: /sw/pkgs/gcc/13.2.0
    buildable: False         # forbid Spack from building another one


spack:
  # 1. What you want Spack to build in this environment
  specs:
    # “%gcc@12.2.0” means “build with that compiler”
    - hdf5@1.14.3  %gcc@12.2.0

  # 2. Optionally make that compiler the default for *everything*,
  #    so you don’t have to write “%gcc@12.2.0” on every spec.
  packages:
    all:
      compiler: [gcc@12.2.0]

  # 3. (Only needed if this compiler isn’t already in your
  #    ~/.spack/linux/compilers.yaml.)  Tell Spack where the binaries live.
  compilers:
    - compiler:
        spec: gcc@12.2.0
        paths:
          cc:  /usr/bin/gcc-12
          cxx: /usr/bin/g++-12
          f77: /usr/bin/gfortran-12
          fc:  /usr/bin/gfortran-12
        flags: {}
        operating_system: ubuntu22.04   # adjust to match your host
        target: x86_64
        modules: []
        environment: {}

