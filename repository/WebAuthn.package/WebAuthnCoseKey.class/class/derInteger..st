der
derInteger: anUnsignedBigEndianByteArray
	"DER INTEGER for an unsigned big-endian magnitude."

	| start bytes |
	start := 1.
	[start < anUnsignedBigEndianByteArray size and: [(anUnsignedBigEndianByteArray at: start) = 0]]
		whileTrue: [start := start + 1].
	bytes := anUnsignedBigEndianByteArray copyFrom: start to: anUnsignedBigEndianByteArray size.
	(bytes isEmpty or: [(bytes at: 1) >= 128])
		ifTrue: [bytes := (ByteArray with: 0) , bytes].
	^self der: 2 content: bytes