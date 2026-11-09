converting
publicKey
	"Answer a GsTlsPublicKey (OpenSSL) for this COSE key."

	publicKey ifNil: [
		publicKey := [GsTlsPublicKey newFromPemString: self asPemString]
			on: Error
			do: [:ex | ^WebAuthnError signal: 'Unusable public key: ' , ex messageText]].
	^publicKey