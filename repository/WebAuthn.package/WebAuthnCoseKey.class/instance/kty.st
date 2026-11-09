accessing
kty
	"COSE key type: 1 = OKP, 2 = EC2, 3 = RSA."

	^map at: 1 ifAbsent: [nil]