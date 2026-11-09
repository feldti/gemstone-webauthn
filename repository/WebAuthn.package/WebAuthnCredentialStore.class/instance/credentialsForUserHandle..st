accessing
credentialsForUserHandle: aByteArray
	^(credentials values select: [:each | each userHandle = aByteArray]) asArray