options
authenticationOptionsForUserHandle: aByteArrayOrNil
	"Start an authentication ceremony. With a user handle, allowCredentials lists the
	 user's credentials; with nil, any discoverable credential for this RP is accepted.
	 Keep the answered ceremony (e.g. in the server-side session) until the response arrives."

	| ceremony options allowed |
	ceremony := WebAuthnCeremony kind: #authentication.
	ceremony userHandle: aByteArrayOrNil; timeoutMs: timeoutMs.
	allowed := aByteArrayOrNil isNil
		ifTrue: [#()]
		ifFalse: [credentialStore credentialsForUserHandle: aByteArrayOrNil].
	ceremony allowCredentialIds: (allowed collect: [:each | each credentialId]).
	options := Dictionary new.
	options
		at: 'rpId' put: rpId;
		at: 'timeout' put: timeoutMs;
		at: 'userVerification' put: userVerification;
		at: 'allowCredentials' put: (allowed collect: [:each | each descriptor]) asArray.
	ceremony options: options.
	ceremony challenge: (self class randomBytes: challengeSize).
	^ceremony