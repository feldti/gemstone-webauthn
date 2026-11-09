tests
testUserVerificationRequired
	| json data |
	rp requireUserVerification: true.
	self register: self vectorEs256Reg.
	json := JsonParser parse: self vectorEs256Auth.
	data := WebAuthnAuthenticatorData fromBytes: (WebAuthnRelyingParty bytesFromBase64Url: ((json at: 'response') at: 'authenticatorData')).
	self assert: data isUserVerified.
	self assert: (self authenticate: json) signCount equals: 7