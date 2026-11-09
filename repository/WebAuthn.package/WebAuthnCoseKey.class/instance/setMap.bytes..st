initialization
setMap: aDictionary bytes: aByteArray
	(aDictionary isKindOf: AbstractDictionary)
		ifFalse: [^WebAuthnError signal: 'COSE key is not a CBOR map'].
	map := aDictionary.
	bytes := aByteArray