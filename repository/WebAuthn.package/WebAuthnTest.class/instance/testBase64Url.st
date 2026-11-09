tests
testBase64Url
	| bytes |
	bytes := #[251 255 0 1 2].
	self assert: (WebAuthnRelyingParty base64UrlFrom: bytes) equals: '-_8AAQI'.
	self assert: (WebAuthnRelyingParty bytesFromBase64Url: '-_8AAQI') equals: bytes