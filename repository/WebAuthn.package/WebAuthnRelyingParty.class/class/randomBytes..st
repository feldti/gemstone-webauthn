utilities
randomBytes: anInteger
	"Cryptographically random bytes (OpenSSL RAND_bytes via the ByteArray primitive)."

	^ByteArray withRandomBytes: anInteger