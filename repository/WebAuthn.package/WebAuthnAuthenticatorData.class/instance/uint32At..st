private
uint32At: anIndex
	^((((bytes at: anIndex) bitShift: 24) + ((bytes at: anIndex + 1) bitShift: 16))
		+ ((bytes at: anIndex + 2) bitShift: 8)) + (bytes at: anIndex + 3)