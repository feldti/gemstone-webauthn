validating
validate
	"Check that kty, alg and curve fit together and the key material is complete."

	| alg kty |
	alg := self alg.
	kty := self kty.
	alg = -7 ifTrue: [
		(kty = 2 and: [self crv = 1]) ifFalse: [^WebAuthnError signal: 'ES256 requires an EC2 key on P-256'].
		((self param: -2) size = 32 and: [(self param: -3) size = 32])
			ifFalse: [^WebAuthnError signal: 'Invalid P-256 coordinates'].
		^self].
	alg = -8 ifTrue: [
		(kty = 1 and: [self crv = 6]) ifFalse: [^WebAuthnError signal: 'EdDSA requires an OKP key on Ed25519'].
		(self param: -2) size = 32 ifFalse: [^WebAuthnError signal: 'Invalid Ed25519 key'].
		^self].
	(alg = -257 or: [alg = -37]) ifTrue: [
		kty = 3 ifFalse: [^WebAuthnError signal: 'RS256/PS256 require an RSA key'].
		(self param: -1) size >= 256 ifFalse: [^WebAuthnError signal: 'RSA modulus shorter than 2048 bits'].
		self param: -2.
		^self].
	^WebAuthnError signal: 'Unsupported COSE algorithm: ' , alg printString