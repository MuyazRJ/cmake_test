from spack import *
import os

class Ando(Package):
    """Your package description"""

    homepage = "https://example.com"
    version('1.0', sha256='...')  # Replace with actual version and checksum

    # Define variants for the debug and production presets
    variant('preset', default='debug', values=('debug', 'production'), description='Choose build preset')

    depends_on('cmake@3.19:', type='build')  # Require a version of CMake
    depends_on('python@3.11')  # Your Python requirement

    def cmake_args(self):
        """Set CMake arguments based on the variant selected"""
        preset = self.spec.variants['preset'].value
        return ['--preset', preset]  # Pass the preset selected by the user

    def install(self, spec, prefix):
        # Step 1: Configure the build using the selected preset
        preset = spec.variants['preset'].value
        cmake_args = self.cmake_args()
        cmake_args.append('..')  # Point to the source directory (adjust if needed)

        # Run cmake to configure
        with working_dir(self.build_directory):
            # Setup CMake with the selected preset
            print(f"Configuring with preset {preset}...")
            cmake(*cmake_args)

            # Step 2: Build the project
            print(f"Building with preset {preset}...")
            build_args = ['--preset', preset]
            cmake('--build', '.', *build_args)

            # Step 3: Run tests
            print("Running tests with ctest...")
            ctest()

            # Step 4: Install the project
            print("Installing...")
            cmake('--install', '.')

    @property
    def build_directory(self):
        """Override to specify the build directory"""
        return join_path(self.stage.path, 'build')
