verifying
verifySignature: signatureBytes of: dataBytes
	"Answer true if signatureBytes is a valid signature over dataBytes, false otherwise."

	| alg key |
	alg := self alg.
	key := self publicKey.
	^[
		(alg = -7 or: [alg = -8])
			ifTrue: [dataBytes verifyWithEcPublicKey: key signature: signatureBytes]
			ifFalse: [
				alg = -257
					ifTrue: [dataBytes verifyWithSha256AndRsaPublicKey: key signature: signatureBytes]
					ifFalse: [
						alg = -37
							ifTrue: [dataBytes verifyWithSha256AndRsaPssPublicKey: key signature: signatureBytes]
							ifFalse: [false]]]]
		on: CryptoError
		do: [:ex | ex return: false]