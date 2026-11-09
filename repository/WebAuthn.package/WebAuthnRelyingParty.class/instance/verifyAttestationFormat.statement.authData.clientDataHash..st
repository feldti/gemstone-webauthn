private
verifyAttestationFormat: aFormat statement: aStatement authData: authData clientDataHash: aHash
	"'none' and packed self attestation are verified. Other formats (or packed with x5c)
	 would require trust anchors (e.g. FIDO MDS); they are accepted only as unverified when the
	 RP requested attestation 'none'."

	(aStatement isKindOf: AbstractDictionary) ifFalse: [^WebAuthnError signal: 'attStmt is not a map'].
	aFormat = 'none' ifTrue: [
		aStatement isEmpty ifFalse: [^WebAuthnError signal: 'attStmt must be empty for fmt none'].
		^self].
	(aFormat = 'packed' and: [(aStatement includesKey: 'x5c') not]) ifTrue: [
		(aStatement at: 'alg' ifAbsent: [nil]) = authData credentialPublicKey alg
			ifFalse: [^WebAuthnError signal: 'packed self attestation: alg mismatch'].
		(authData credentialPublicKey
			verifySignature: (self required: 'sig' in: aStatement)
			of: authData bytes , aHash)
				ifFalse: [^WebAuthnError signal: 'packed self attestation: invalid signature'].
		^self].
	attestation = 'none' ifTrue: [^self].
	^WebAuthnError signal: 'Attestation format not supported: ' , aFormat printString