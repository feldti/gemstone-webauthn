initialization
initialize
	origins := Set new.
	credentialStore := WebAuthnCredentialStore new.
	timeoutMs := 300000.
	challengeSize := 32.
	userVerification := 'preferred'.
	residentKey := 'required'.
	attestation := 'none'.
	supportedAlgorithms := #(-7 -8 -257 -37).
	requireUserVerification := false.
	checkSignCount := true.
	allowCrossOrigin := false