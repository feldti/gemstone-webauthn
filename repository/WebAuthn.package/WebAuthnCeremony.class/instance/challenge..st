accessing
challenge: aByteArray
	challenge := aByteArray.
	options ifNotNil: [options at: 'challenge' put: (WebAuthnRelyingParty base64UrlFrom: aByteArray)]