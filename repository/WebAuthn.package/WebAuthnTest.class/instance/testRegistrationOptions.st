tests
testRegistrationOptions
	| ceremony json |
	ceremony := rp registrationOptionsForUserHandle: self userHandle name: 'alice' displayName: 'Alice'.
	json := JsonParser parse: ceremony optionsJson.
	self assert: ((json at: 'rp') at: 'id') equals: 'example.com'.
	self assert: (WebAuthnRelyingParty bytesFromBase64Url: ((json at: 'user') at: 'id')) equals: self userHandle.
	self assert: (WebAuthnRelyingParty bytesFromBase64Url: (json at: 'challenge')) equals: ceremony challenge.
	self assert: ceremony challenge size equals: 32.
	self assert: ((json at: 'pubKeyCredParams') collect: [:each | each at: 'alg']) asArray equals: #(-7 -8 -257 -37).
	self assert: ((json at: 'authenticatorSelection') at: 'residentKey') equals: 'required'.
	self assert: (json at: 'excludeCredentials') isEmpty