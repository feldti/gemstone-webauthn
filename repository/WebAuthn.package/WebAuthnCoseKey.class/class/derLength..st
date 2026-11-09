der
derLength: anInteger
	| bytes n |
	anInteger < 128 ifTrue: [^ByteArray with: anInteger].
	bytes := ByteArray new.
	n := anInteger.
	[n > 0] whileTrue: [
		bytes := (ByteArray with: (n bitAnd: 255)) , bytes.
		n := n bitShift: -8].
	^(ByteArray with: 128 + bytes size) , bytes