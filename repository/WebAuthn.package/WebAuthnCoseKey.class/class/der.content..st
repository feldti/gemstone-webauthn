der
der: tagByte content: aByteArray
	^(ByteArray with: tagByte) , (self derLength: aByteArray size) , aByteArray