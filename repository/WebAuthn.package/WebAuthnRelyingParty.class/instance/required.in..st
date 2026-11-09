private
required: aKey in: aDictionary
	^aDictionary at: aKey ifAbsent: [WebAuthnError signal: 'Missing field: ' , aKey printString]