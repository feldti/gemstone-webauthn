helpers
replace: aString with: anotherString in: aJsonString
	| index |
	index := aJsonString indexOfSubCollection: aString startingAt: 1.
	self assert: index > 0.
	^(aJsonString copyFrom: 1 to: index - 1) , anotherString , (aJsonString copyFrom: index + aString size to: aJsonString size)