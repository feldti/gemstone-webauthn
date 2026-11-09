tests
testOtherUsersCredentialFails
	self register: self vectorEs256Reg.
	self should: [self authenticate: self vectorEs256Auth userHandle: 'someone-else' asByteArray] raise: WebAuthnError