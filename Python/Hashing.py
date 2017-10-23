from passlib.hash import sha256_crypt

password = sha256_crypt.encrypt("password")
password2 = sha256_crypt.encrypt("password")

print(password)
print(password2)

print(sha256_crypt.verify("password", password))

'''Here we're bringing in passlib's hashing ability, and using SHA256 as the algorithm. SHA256 is inherently better than md5, but you're free to replace "md5" with "sha256" in our above examples to see the hash that is output still remains the same, just a bit longer.
Next, we show that we use the sha256_crypt from passlib to hash "password" twice. Once to the variable of password and once more to password2.
Then we output the hashes of both, noticing they are different.
Finally, we validate that the two separate hashes came from the same source.'''
---------------------------------------------------------------------------------------------------------------		
import hashlib
password = 'pa$$w0rd'
h = hashlib.md5(password.encode())
print(h.hexdigest())

'''Import hashlib, set an example password, create the hash object, print the hash:
6c9b8b27dea1ddb845f96aa2567c6754'''
---------------------------------------------------------------------------------------------------------------
import hashlib

user_entered_password = 'pa$$w0rd'
salt = "5gz"
db_password = user_entered_password+salt
h = hashlib.md5(db_password.encode())
print(h.hexdigest())
		
'''Here, the only major difference is we just have a salt that we append to the very end. Then, any time the user enters their password, we append the salt, hash it, and then compare those hashes.
de6e389819bdaa9e0ca60bb52cabccae'''

'''https://pythonprogramming.net/password-hashing-flask-tutorial/'''


