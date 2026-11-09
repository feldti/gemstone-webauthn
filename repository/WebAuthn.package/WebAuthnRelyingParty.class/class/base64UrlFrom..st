utilities
base64UrlFrom: aByteArray
	"base64url without padding."

	| s |
	s := aByteArray asBase64UrlString.
	[s notEmpty and: [s last = $=]] whileTrue: [s := s copyFrom: 1 to: s size - 1].
	^s