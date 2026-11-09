tests
testTruncatedAuthenticatorDataFails
	self should: [WebAuthnAuthenticatorData fromBytes: (ByteArray new: 36)] raise: WebAuthnError.
	self should: [WebAuthnAuthenticatorData fromBytes: ((ByteArray new: 37) at: 33 put: 16r41; yourself)] raise: WebAuthnError