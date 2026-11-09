utilities
bytes: aByteArray equals: anotherByteArray
	"Comparison in time independent of the position of the first difference."

	| diff |
	(aByteArray isKindOf: ByteArray) ifFalse: [^false].
	(anotherByteArray isKindOf: ByteArray) ifFalse: [^false].
	aByteArray size = anotherByteArray size ifFalse: [^false].
	diff := 0.
	1 to: aByteArray size do: [:i | diff := diff bitOr: ((aByteArray at: i) bitXor: (anotherByteArray at: i))].
	^diff = 0