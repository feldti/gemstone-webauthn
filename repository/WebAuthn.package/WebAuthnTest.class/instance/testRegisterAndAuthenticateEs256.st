tests
testRegisterAndAuthenticateEs256
	| credential |
	credential := self register: self vectorEs256Reg.
	self assert: rp credentialStore size equals: 1.
	self assert: credential userHandle equals: self userHandle.
	self assert: credential signCount equals: 0.
	self assert: credential backupEligible.
	self assert: credential attestationFormat equals: 'none'.
	self assert: (credential transports includes: 'internal').
	self assert: (self authenticate: self vectorEs256Auth) == credential.
	self assert: credential signCount equals: 7.
	self assert: credential lastUsedAt notNil