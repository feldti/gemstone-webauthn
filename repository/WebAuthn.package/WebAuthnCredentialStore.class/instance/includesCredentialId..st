accessing
includesCredentialId: aByteArray
	^credentials includesKey: (self keyFor: aByteArray)