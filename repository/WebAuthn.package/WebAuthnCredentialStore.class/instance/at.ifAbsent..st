accessing
at: aCredentialIdByteArray ifAbsent: aBlock
	^credentials at: (self keyFor: aCredentialIdByteArray) ifAbsent: aBlock