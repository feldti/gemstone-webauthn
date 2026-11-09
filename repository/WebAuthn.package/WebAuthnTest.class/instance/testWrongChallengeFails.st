tests
testWrongChallengeFails
	| ceremony |
	ceremony := rp registrationOptionsForUserHandle: self userHandle name: 'alice' displayName: 'Alice'.
	self should: [rp verifyRegistrationResponse: self vectorEs256Reg ceremony: ceremony] raise: WebAuthnError.
	self assert: rp credentialStore size equals: 0