private
verifyAuthenticatorData: authData
	(self class bytes: authData rpIdHash equals: self rpIdHash)
		ifFalse: [^WebAuthnError signal: 'rpIdHash mismatch'].
	authData isUserPresent ifFalse: [^WebAuthnError signal: 'User not present'].
	(requireUserVerification and: [authData isUserVerified not])
		ifTrue: [^WebAuthnError signal: 'User not verified']