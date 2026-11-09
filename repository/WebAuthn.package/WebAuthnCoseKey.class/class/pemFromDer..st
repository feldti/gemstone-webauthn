der
pemFromDer: aByteArray
	| b64 stream |
	b64 := aByteArray asBase64String.
	stream := WriteStream on: String new.
	stream nextPutAll: '-----BEGIN PUBLIC KEY-----'; nextPut: Character lf.
	1 to: b64 size by: 64 do: [:i |
		stream
			nextPutAll: (b64 copyFrom: i to: (i + 63 min: b64 size));
			nextPut: Character lf].
	stream nextPutAll: '-----END PUBLIC KEY-----'; nextPut: Character lf.
	^stream contents