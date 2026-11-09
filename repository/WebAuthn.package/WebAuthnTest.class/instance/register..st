helpers
register: aJsonString
	| ceremony |
	ceremony := rp registrationOptionsForUserHandle: self userHandle name: 'alice' displayName: 'Alice'.
	ceremony challenge: self registrationChallenge.
	^rp verifyRegistrationResponse: aJsonString ceremony: ceremony