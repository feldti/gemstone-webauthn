accessing
remove: aWebAuthnCredential
	^credentials removeKey: (self keyFor: aWebAuthnCredential credentialId) ifAbsent: [nil]