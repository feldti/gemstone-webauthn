tests
testCeremonyIsSingleUse
	| ceremony |
	ceremony := rp registrationOptionsForUserHandle: self userHandle name: 'alice' displayName: 'Alice'.
	ceremony challenge: self registrationChallenge.
	rp verifyRegistrationResponse: self vectorEs256Reg ceremony: ceremony.
	rp credentialStore remove: rp credentialStore allCredentials first.
	self should: [rp verifyRegistrationResponse: self vectorEs256Reg ceremony: ceremony] raise: WebAuthnError