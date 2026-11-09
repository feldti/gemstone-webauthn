tests
testSignCountMustIncrease
	self register: self vectorEs256Reg.
	self authenticate: self vectorEs256Auth.
	self should: [self authenticate: self vectorEs256Auth] raise: WebAuthnError