instance creation
fromBytes: aByteArray
	"Decode a COSE_Key (RFC 9052) from CBOR bytes."

	| map |
	map := [Cbor decode: aByteArray]
		on: CborError
		do: [:ex | ^WebAuthnError signal: 'Invalid COSE key: ' , ex messageText].
	^self fromMap: map bytes: aByteArray