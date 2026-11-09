validating
consumeFor: aSymbol
	"Mark the ceremony as used. A challenge is valid for exactly one verification attempt."

	kind = aSymbol ifFalse: [^WebAuthnError signal: 'Ceremony is not a ' , aSymbol , ' ceremony'].
	self isUsed ifTrue: [^WebAuthnError signal: 'Challenge already used'].
	used := true.
	self isExpired ifTrue: [^WebAuthnError signal: 'Challenge expired']