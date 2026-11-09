converting
optionsJson
	"JSON string to hand to the browser (PublicKeyCredential.parseCreationOptionsFromJSON /
	 parseRequestOptionsFromJSON, or manual base64url decoding)."

	| stream |
	stream := WriteStream on: String new.
	options printJsonOn: stream.
	^stream contents