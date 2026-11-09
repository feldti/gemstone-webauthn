options
registrationOptionsForUserHandle: aUserHandle name: aName displayName: aDisplayName
	"Start a registration ceremony for the user. aUserHandle is a ByteArray of at most 64 bytes
	 (see #newUserHandle). Keep the answered ceremony until the response arrives."

	| ceremony options user rp selection |
	(aUserHandle isKindOf: ByteArray) ifFalse: [^WebAuthnError signal: 'user handle must be a ByteArray'].
	(aUserHandle size between: 1 and: 64) ifFalse: [^WebAuthnError signal: 'user handle must be 1..64 bytes'].
	ceremony := WebAuthnCeremony kind: #registration.
	ceremony userHandle: aUserHandle; timeoutMs: timeoutMs.
	rp := Dictionary new.
	rp at: 'id' put: rpId; at: 'name' put: (rpName ifNil: [rpId]).
	user := Dictionary new.
	user
		at: 'id' put: (self class base64UrlFrom: aUserHandle);
		at: 'name' put: aName;
		at: 'displayName' put: (aDisplayName ifNil: [aName]).
	selection := Dictionary new.
	selection
		at: 'residentKey' put: residentKey;
		at: 'requireResidentKey' put: residentKey = 'required';
		at: 'userVerification' put: userVerification.
	options := Dictionary new.
	options
		at: 'rp' put: rp;
		at: 'user' put: user;
		at: 'pubKeyCredParams' put: (supportedAlgorithms collect: [:alg | | p |
			p := Dictionary new.
			p at: 'type' put: 'public-key'; at: 'alg' put: alg.
			p]) asArray;
		at: 'timeout' put: timeoutMs;
		at: 'attestation' put: attestation;
		at: 'authenticatorSelection' put: selection;
		at: 'excludeCredentials' put: ((credentialStore credentialsForUserHandle: aUserHandle)
			collect: [:each | each descriptor]) asArray.
	ceremony options: options.
	ceremony challenge: (self class randomBytes: challengeSize).
	^ceremony