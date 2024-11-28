from phe import paillier

# Step 1: Generate Paillier public and private keys
public_key, private_key = paillier.generate_paillier_keypair()

# Step 2: Encrypt numbers
num1, num2, num3 = 2, 4, 6  # Your numbers to encrypt
enc_num1 = public_key.encrypt(num1)
enc_num2 = public_key.encrypt(num2)
enc_num3 = public_key.encrypt(num3)

# Step 3: Add encrypted numbers
enc_sum = enc_num1 + enc_num2 + enc_num3

# Step 4: Decrypt the sum
decrypted_sum = private_key.decrypt(enc_sum)

print(f"Original numbers: {num1}, {num2}, {num3}")
print(f"Decrypted sum: {decrypted_sum}")
