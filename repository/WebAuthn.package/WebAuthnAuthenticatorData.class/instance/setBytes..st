parsing
setBytes: aByteArray
	"Parse the authenticator data structure (WebAuthn Level 3, 6.1)."

	| pos credIdLength rest remainder |
	(aByteArray isKindOf: ByteArray) ifFalse: [^WebAuthnError signal: 'authenticatorData must be a ByteArray'].
	aByteArray size < 37 ifTrue: [^WebAuthnError signal: 'authenticatorData too short'].
	bytes := aByteArray.
	rpIdHash := aByteArray copyFrom: 1 to: 32.
	flags := aByteArray at: 33.
	signCount := self uint32At: 34.
	(self isBackedUp and: [self isBackupEligible not])
		ifTrue: [^WebAuthnError signal: 'authenticatorData: BS flag set without BE flag'].
	pos := 38.
	self isAttestedCredentialDataIncluded ifTrue: [
		aByteArray size < (pos + 17) ifTrue: [^WebAuthnError signal: 'attested credential data truncated'].
		aaguid := aByteArray copyFrom: pos to: pos + 15.
		credIdLength := ((aByteArray at: pos + 16) bitShift: 8) + (aByteArray at: pos + 17).
		pos := pos + 18.
		credIdLength > 1023 ifTrue: [^WebAuthnError signal: 'credentialId longer than 1023 bytes'].
		aByteArray size < (pos + credIdLength - 1) ifTrue: [^WebAuthnError signal: 'credentialId truncated'].
		credentialId := aByteArray copyFrom: pos to: pos + credIdLength - 1.
		pos := pos + credIdLength].
	pos > aByteArray size ifTrue: [
		self isAttestedCredentialDataIncluded ifTrue: [^WebAuthnError signal: 'credentialPublicKey missing'].
		self isExtensionDataIncluded ifTrue: [^WebAuthnError signal: 'extension data missing'].
		^self].
	(self isAttestedCredentialDataIncluded or: [self isExtensionDataIncluded])
		ifFalse: [^WebAuthnError signal: 'authenticatorData has trailing bytes'].
	rest := aByteArray copyFrom: pos to: aByteArray size.
	[
		self isAttestedCredentialDataIncluded ifTrue: [ | stream keyMap |
			stream := ReadStream on: rest.
			keyMap := (CborDecoder on: stream) decode.
			remainder := stream upToEnd.
			credentialPublicKey := WebAuthnCoseKey
				fromMap: keyMap
				bytes: (rest copyFrom: 1 to: rest size - remainder size).
			rest := remainder].
		self isExtensionDataIncluded ifTrue: [
			extensions := Cbor decode: rest.
			rest := ByteArray new]]
		on: CborError
		do: [:ex | ^WebAuthnError signal: 'authenticatorData: ' , ex messageText].
	rest isEmpty ifFalse: [^WebAuthnError signal: 'authenticatorData has trailing bytes']