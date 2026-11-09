private
param: anInteger
	| value |
	value := map at: anInteger ifAbsent: [^WebAuthnError signal: 'COSE key parameter missing: ' , anInteger printString].
	(value isKindOf: ByteArray) ifFalse: [^WebAuthnError signal: 'COSE key parameter is not a byte string: ' , anInteger printString].
	^value