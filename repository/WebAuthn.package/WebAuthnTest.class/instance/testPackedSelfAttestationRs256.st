tests
testPackedSelfAttestationRs256
	| credential |
	credential := self register: self vectorRs256RegPacked.
	self assert: credential attestationFormat equals: 'packed'.
	self assert: (self authenticate: self vectorRs256Auth userHandle: self userHandle) == credential