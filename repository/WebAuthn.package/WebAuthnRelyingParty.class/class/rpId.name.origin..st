instance creation
rpId: anRpId name: aName origin: anOrigin
	^self new
		rpId: anRpId;
		rpName: aName;
		addOrigin: anOrigin;
		yourself