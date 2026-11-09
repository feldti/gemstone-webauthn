testing
isExpired
	timeoutMs ifNil: [^false].
	^(DateAndTime now - createdAt) asSeconds * 1000 > timeoutMs