accessing
add: aWebAuthnCredential
	(self includesCredentialId: aWebAuthnCredential credentialId)
		ifTrue: [^WebAuthnError signal: 'credentialId already registered'].
	credentials at: (self keyFor: aWebAuthnCredential credentialId) put: aWebAuthnCredential.
	^aWebAuthnCredential