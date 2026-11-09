accessing
requireUserVerification: aBoolean
	"When true, the UV flag is mandatory and userVerification is sent as 'required'."

	requireUserVerification := aBoolean.
	aBoolean ifTrue: [userVerification := 'required']