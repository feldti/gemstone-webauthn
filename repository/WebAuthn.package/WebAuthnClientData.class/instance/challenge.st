accessing
challenge
	"The challenge as ByteArray (decoded from base64url)."

	| string |
	string := self at: 'challenge'.
	(string isKindOf: String) ifFalse: [^WebAuthnError signal: 'clientDataJSON: challenge missing'].
	^[ByteArray fromBase64UrlString: string]
		on: Error
		do: [:ex | ^WebAuthnError signal: 'clientDataJSON: challenge is not base64url']