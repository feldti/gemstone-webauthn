converting
subjectPublicKeyInfo
	"DER encoded SubjectPublicKeyInfo of the key (validated first)."

	self validate.
	self kty = 2 ifTrue: [^self class ecP256SpkiPrefix , (self param: -2) , (self param: -3)].
	self kty = 1 ifTrue: [^self class ed25519SpkiPrefix , (self param: -2)].
	self kty = 3 ifTrue: [
		^self class
			der: 48
			content: self class rsaAlgorithmIdentifier
				, (self class
					der: 3
					content: (ByteArray with: 0)
						, (self class
							der: 48
							content: (self class derInteger: (self param: -1)) , (self class derInteger: (self param: -2))))].
	^WebAuthnError signal: 'Unsupported COSE key type'