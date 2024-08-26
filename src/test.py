import os

current_path = os.getcwd()
print("Current Working Directory:", current_path)

import examples
examples.calla()
print(dir(examples))
#examples.call()