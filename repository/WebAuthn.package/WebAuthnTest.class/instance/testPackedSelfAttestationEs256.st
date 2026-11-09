tests
testPackedSelfAttestationEs256
	| credential |
	credential := self register: self vectorEs256RegPacked.
	self assert: credential attestationFormat equals: 'packed'.
	self assert: (self authenticate: self vectorEs256Auth userHandle: self userHandle) == credential