import re 

s = "TOP SECRET"

pattern = "^(atomic|official|official sensitive|top secret)"
match = re.fullmatch(pattern, s.strip(), re.IGNORECASE)
print(bool(match))