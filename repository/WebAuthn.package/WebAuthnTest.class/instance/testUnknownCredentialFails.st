tests
testUnknownCredentialFails
	self should: [self authenticate: self vectorEs256Auth] raise: WebAuthnError