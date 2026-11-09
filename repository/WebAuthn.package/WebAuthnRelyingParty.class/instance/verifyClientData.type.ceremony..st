private
verifyClientData: clientData type: aType ceremony: aCeremony
	clientData type = aType ifFalse: [^WebAuthnError signal: 'clientData type is not ' , aType].
	(self class bytes: clientData challenge equals: aCeremony challenge)
		ifFalse: [^WebAuthnError signal: 'Challenge mismatch'].
	(origins includes: clientData origin)
		ifFalse: [^WebAuthnError signal: 'Origin not allowed: ' , clientData origin printString].
	(clientData isCrossOrigin and: [allowCrossOrigin not])
		ifTrue: [^WebAuthnError signal: 'Cross-origin request not allowed']