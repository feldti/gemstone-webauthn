tests
testExcludeAndAllowCredentials
	| credential json |
	credential := self register: self vectorEs256Reg.
	json := JsonParser parse: (rp registrationOptionsForUserHandle: self userHandle name: 'alice' displayName: 'Alice') optionsJson.
	self assert: ((json at: 'excludeCredentials') first at: 'id') equals: credential credentialIdString.
	json := JsonParser parse: (rp authenticationOptionsForUserHandle: self userHandle) optionsJson.
	self assert: ((json at: 'allowCredentials') first at: 'id') equals: credential credentialIdString.
	self assert: (json at: 'rpId') equals: 'example.com'.
	json := JsonParser parse: rp authenticationOptions optionsJson.
	self assert: (json at: 'allowCredentials') isEmpty