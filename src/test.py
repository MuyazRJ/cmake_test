import sys, os

# Print the list of directories Python searches
print("Python is searching the following directories:\n")
print('\n'.join(sys.path) + '\n')

if "VIRTUAL_ENV" in os.environ:
    print(f"Running inside a virtual environment: {os.environ['VIRTUAL_ENV']}")
else:
    print("Not running inside a virtual environment")