tests
testWrongRpIdFails
	rp := WebAuthnRelyingParty rpId: 'example.org' name: 'Example' origin: 'https://example.com'.
	self should: [self register: self vectorEs256Reg] raise: WebAuthnError