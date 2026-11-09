tests
testTamperedSignatureFails
	| json response sig |
	self register: self vectorEs256Reg.
	json := JsonParser parse: self vectorEs256Auth.
	response := json at: 'response'.
	sig := WebAuthnRelyingParty bytesFromBase64Url: (response at: 'signature').
	sig at: sig size put: ((sig at: sig size) bitXor: 1).
	response at: 'signature' put: (WebAuthnRelyingParty base64UrlFrom: sig).
	self should: [self authenticate: json] raise: WebAuthnError