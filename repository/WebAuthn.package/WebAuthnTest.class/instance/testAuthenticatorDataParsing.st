tests
testAuthenticatorDataParsing
	| json attObj data |
	json := JsonParser parse: self vectorEs256Reg.
	attObj := Cbor decode: (WebAuthnRelyingParty bytesFromBase64Url: ((json at: 'response') at: 'attestationObject')).
	data := WebAuthnAuthenticatorData fromBytes: (attObj at: 'authData').
	self assert: data rpIdHash equals: 'example.com' asByteArray sha256SumBytes.
	self assert: data isUserPresent.
	self assert: data isUserVerified.
	self assert: data isBackupEligible.
	self deny: data isBackedUp.
	self assert: data isAttestedCredentialDataIncluded.
	self assert: data aaguid equals: (ByteArray new: 16).
	self assert: data credentialId equals: (WebAuthnRelyingParty bytesFromBase64Url: (json at: 'rawId')).
	self assert: data credentialPublicKey kty equals: 2.
	self assert: data credentialPublicKey alg equals: -7.
	self assert: (data credentialPublicKey publicKey isKindOf: GsTlsPublicKey)