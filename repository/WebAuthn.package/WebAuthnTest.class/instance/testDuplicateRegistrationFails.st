tests
testDuplicateRegistrationFails
	self register: self vectorEs256Reg.
	self should: [self register: self vectorEs256Reg] raise: WebAuthnError