accessing
alg
	"COSE algorithm identifier, e.g. -7 (ES256), -8 (EdDSA), -257 (RS256), -37 (PS256)."

	^map at: 3 ifAbsent: [nil]