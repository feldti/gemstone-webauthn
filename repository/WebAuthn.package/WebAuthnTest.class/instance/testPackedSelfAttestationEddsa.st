tests
testPackedSelfAttestationEddsa
	| credential |
	credential := self register: self vectorEddsaRegPacked.
	self assert: credential attestationFormat equals: 'packed'.
	self assert: (self authenticate: self vectorEddsaAuth userHandle: self userHandle) == credential