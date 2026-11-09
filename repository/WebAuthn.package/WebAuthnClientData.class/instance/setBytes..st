initialization
setBytes: aByteArray
	bytes := aByteArray.
	json := [JsonParser parse: aByteArray decodeFromUTF8ToString]
		on: Error
		do: [:ex | ^WebAuthnError signal: 'clientDataJSON is not valid JSON'].
	(json isKindOf: AbstractDictionary) ifFalse: [^WebAuthnError signal: 'clientDataJSON is not a JSON object']