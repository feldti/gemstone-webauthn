utilities
bytesFromBase64Url: aString
	(aString isKindOf: String) ifFalse: [^WebAuthnError signal: 'base64url string expected'].
	^[ByteArray fromBase64UrlString: aString]
		on: Error
		do: [:ex | ^WebAuthnError signal: 'Invalid base64url data']