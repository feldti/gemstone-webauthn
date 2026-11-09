tests
testTamperedAuthenticatorDataFails
	| json response data |
	self register: self vectorRs256Reg.
	json := JsonParser parse: self vectorRs256Auth.
	response := json at: 'response'.
	data := WebAuthnRelyingParty bytesFromBase64Url: (response at: 'authenticatorData').
	data at: 37 put: 8.
	response at: 'authenticatorData' put: (WebAuthnRelyingParty base64UrlFrom: data).
	self should: [self authenticate: json] raise: WebAuthnError