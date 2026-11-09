tests
testAlgorithmRestriction
	rp supportedAlgorithms: #(-7).
	self should: [self register: self vectorRs256Reg] raise: WebAuthnError.
	self assert: (self register: self vectorEs256Reg) publicKey alg equals: -7