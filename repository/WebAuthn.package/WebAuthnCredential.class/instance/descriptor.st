converting
descriptor
	"PublicKeyCredentialDescriptor (JSON form) for allowCredentials / excludeCredentials."

	| d |
	d := Dictionary new.
	d at: 'type' put: 'public-key'; at: 'id' put: self credentialIdString.
	self transports isEmpty ifFalse: [d at: 'transports' put: self transports asArray].
	^d