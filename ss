from spack.package import *

class MyPackage(Package):
    homepage = "http://yourpackagehomepage.com"
    url = "http://yourpackageurl.com"
    git = "https://github.com/yourusername/yourpackage.git"

    version('1.0.0', git=git, branch='main')

    # Specify dependencies (e.g., Python, NumPy)
    depends_on('python@3.11')
    depends_on('py-numpy')
    depends_on('intel-mkl')  # If you're using MKL

    def install(self, spec, prefix):
        # Installation steps for your package

        # Example: Custom environment settings during the install phase
        mkl_dir = spec['intel-mkl'].prefix  # Get MKL installation directory
        gcc_bin_dir = spec['gcc'].prefix.bin  # Path to GCC binaries

        # Setting environment variables for the install phase
        env['LD_LIBRARY_PATH'] = join_path(mkl_dir, 'lib', 'intel64') + ':' + env.get('LD_LIBRARY_PATH', '')
        env['MKL_DIR'] = join_path(mkl_dir, 'lib', 'intel64')

        # Optional: You can run commands here (e.g., copying files, running scripts)
        # Example of how to run cmake if needed
        # cmake(*self.cmake_args)
        pass

    def setup_run_environment(self, env):
        # Set up the environment variables for runtime (after install)
        
        mkl_dir = self.spec['intel-mkl'].prefix  # Get MKL directory

        # Set runtime environment variables
        env.set('LD_LIBRARY_PATH', join_path(mkl_dir, 'lib', 'intel64') + ':' + env.get('LD_LIBRARY_PATH', ''))
        env.set('MKL_DIR', join_path(mkl_dir, 'lib', 'intel64'))

        # You can also set additional variables if necessary
        env.set('MKL_INCLUDE', join_path(mkl_dir, 'include'))

    # Optional: Specify the CMake arguments (if you're using CMake)
    def cmake_args(self):
        return []
