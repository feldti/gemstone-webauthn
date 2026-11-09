private
parseResponse: aJsonStringOrDictionary
	| result |
	(aJsonStringOrDictionary isKindOf: AbstractDictionary) ifTrue: [^aJsonStringOrDictionary].
	result := [JsonParser parse: aJsonStringOrDictionary]
		on: Error
		do: [:ex | ^WebAuthnError signal: 'Response is not valid JSON'].
	(result isKindOf: AbstractDictionary) ifFalse: [^WebAuthnError signal: 'Response is not a JSON object'].
	^result