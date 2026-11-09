baseline
baseline: spec
	<baseline>
	spec for: #'common' do: [
		spec
			baseline: 'Cbor'
			with: [
				spec
					repository: 'github://feldti/gemstone-cbor:main/repository';
					loads: #('Core')].
		spec package: 'WebAuthn' with: [spec requires: #('Cbor')].
		spec
			group: 'default' with: #('WebAuthn');
			group: 'Core' with: #('WebAuthn')]