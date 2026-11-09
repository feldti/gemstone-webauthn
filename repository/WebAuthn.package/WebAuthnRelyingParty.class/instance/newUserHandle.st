options
newUserHandle
	"A fresh random user handle (WebAuthn user.id). It must not contain personal data."

	^self class randomBytes: 32