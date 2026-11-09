helpers
authenticate: aJsonString userHandle: aUserHandle
	| ceremony |
	ceremony := rp authenticationOptionsForUserHandle: aUserHandle.
	ceremony challenge: self authenticationChallenge.
	^rp verifyAuthenticationResponse: aJsonString ceremony: ceremony