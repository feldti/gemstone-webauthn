verifying
verifyRegistrationResponse: aJsonStringOrDictionary ceremony: aCeremony
	"Verify an attestation (PublicKeyCredential.toJSON() of navigator.credentials.create()).
	 On success the new WebAuthnCredential is added to the credential store and answered;
	 on failure WebAuthnError is signalled."

	| credential response clientData attestationObject authData coseKey format credentialId record |
	aCeremony consumeFor: #registration.
	credential := self parseResponse: aJsonStringOrDictionary.
	(self required: 'type' in: credential) = 'public-key'
		ifFalse: [^WebAuthnError signal: 'Credential type is not public-key'].
	response := self required: 'response' in: credential.
	clientData := WebAuthnClientData fromBytes: (self class bytesFromBase64Url: (self required: 'clientDataJSON' in: response)).
	self verifyClientData: clientData type: 'webauthn.create' ceremony: aCeremony.
	attestationObject := [Cbor decode: (self class bytesFromBase64Url: (self required: 'attestationObject' in: response))]
		on: CborError
		do: [:ex | ^WebAuthnError signal: 'attestationObject: ' , ex messageText].
	(attestationObject isKindOf: AbstractDictionary)
		ifFalse: [^WebAuthnError signal: 'attestationObject is not a CBOR map'].
	authData := WebAuthnAuthenticatorData fromBytes: (self required: 'authData' in: attestationObject).
	self verifyAuthenticatorData: authData.
	authData isAttestedCredentialDataIncluded
		ifFalse: [^WebAuthnError signal: 'No attested credential data'].
	coseKey := authData credentialPublicKey.
	coseKey validate.
	(supportedAlgorithms includes: coseKey alg)
		ifFalse: [^WebAuthnError signal: 'Algorithm not allowed: ' , coseKey alg printString].
	format := self required: 'fmt' in: attestationObject.
	self
		verifyAttestationFormat: format
		statement: (self required: 'attStmt' in: attestationObject)
		authData: authData
		clientDataHash: clientData clientDataHash.
	credentialId := authData credentialId.
	(self class bytesFromBase64Url: (self required: 'rawId' in: credential)) = credentialId
		ifFalse: [^WebAuthnError signal: 'rawId does not match the attested credentialId'].
	(credentialStore includesCredentialId: credentialId)
		ifTrue: [^WebAuthnError signal: 'credentialId already registered'].
	record := WebAuthnCredential new.
	record
		credentialId: credentialId;
		userHandle: aCeremony userHandle;
		publicKeyBytes: coseKey bytes;
		signCount: authData signCount;
		aaguid: authData aaguid;
		backupEligible: authData isBackupEligible;
		backupState: authData isBackedUp;
		uvInitialized: authData isUserVerified;
		attestationFormat: format;
		transports: (response at: 'transports' ifAbsent: [#()]) asArray;
		createdAt: DateAndTime now.
	^credentialStore add: record