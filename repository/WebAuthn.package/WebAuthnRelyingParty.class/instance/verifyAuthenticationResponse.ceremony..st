verifying
verifyAuthenticationResponse: aJsonStringOrDictionary ceremony: aCeremony
	"Verify an assertion (PublicKeyCredential.toJSON() of navigator.credentials.get()).
	 Answers the updated WebAuthnCredential; signals WebAuthnError on any failure."

	| json credential response authBytes clientData authData credentialId responseUserHandle signature |
	aCeremony consumeFor: #authentication.
	json := self parseResponse: aJsonStringOrDictionary.
	(self required: 'type' in: json) = 'public-key'
		ifFalse: [^WebAuthnError signal: 'Credential type is not public-key'].
	credentialId := self class bytesFromBase64Url: (self required: 'rawId' in: json).
	(self class bytesFromBase64Url: (self required: 'id' in: json)) = credentialId
		ifFalse: [^WebAuthnError signal: 'id and rawId differ'].
	(aCeremony allowCredentialIds isEmpty or: [aCeremony allowCredentialIds includes: credentialId])
		ifFalse: [^WebAuthnError signal: 'Credential not allowed for this ceremony'].
	credential := credentialStore at: credentialId ifAbsent: [^WebAuthnError signal: 'Unknown credential'].
	response := self required: 'response' in: json.
	responseUserHandle := response at: 'userHandle' ifAbsent: [nil].
	(responseUserHandle notNil and: [responseUserHandle isEmpty not])
		ifTrue: [
			(self class bytes: (self class bytesFromBase64Url: responseUserHandle) equals: credential userHandle)
				ifFalse: [^WebAuthnError signal: 'userHandle does not match credential owner']]
		ifFalse: [
			aCeremony userHandle isNil ifTrue: [^WebAuthnError signal: 'userHandle missing for discoverable login']].
	(aCeremony userHandle notNil and: [(self class bytes: aCeremony userHandle equals: credential userHandle) not])
		ifTrue: [^WebAuthnError signal: 'Credential does not belong to the expected user'].
	clientData := WebAuthnClientData fromBytes: (self class bytesFromBase64Url: (self required: 'clientDataJSON' in: response)).
	self verifyClientData: clientData type: 'webauthn.get' ceremony: aCeremony.
	authBytes := self class bytesFromBase64Url: (self required: 'authenticatorData' in: response).
	authData := WebAuthnAuthenticatorData fromBytes: authBytes.
	self verifyAuthenticatorData: authData.
	authData isBackupEligible = credential backupEligible
		ifFalse: [^WebAuthnError signal: 'Backup eligibility of the credential changed'].
	signature := self class bytesFromBase64Url: (self required: 'signature' in: response).
	(credential publicKey verifySignature: signature of: authBytes , clientData clientDataHash)
		ifFalse: [^WebAuthnError signal: 'Invalid signature'].
	(checkSignCount and: [(authData signCount ~= 0 or: [credential signCount ~= 0])
		and: [authData signCount <= credential signCount]])
			ifTrue: [^WebAuthnError signal: 'Signature counter did not increase (possible cloned authenticator)'].
	credential
		signCount: authData signCount;
		backupState: authData isBackedUp;
		lastUsedAt: DateAndTime now.
	authData isUserVerified ifTrue: [credential uvInitialized: true].
	^credential