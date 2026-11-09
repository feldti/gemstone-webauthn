tests
testCeremonyKindIsChecked
	| ceremony |
	ceremony := rp authenticationOptions.
	ceremony challenge: self registrationChallenge.
	self should: [rp verifyRegistrationResponse: self vectorEs256Reg ceremony: ceremony] raise: WebAuthnError