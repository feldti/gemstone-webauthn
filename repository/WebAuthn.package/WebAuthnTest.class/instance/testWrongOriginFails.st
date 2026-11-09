tests
testWrongOriginFails
	rp := WebAuthnRelyingParty rpId: 'example.com' name: 'Example' origin: 'https://evil.example'.
	self should: [self register: self vectorEs256Reg] raise: WebAuthnError