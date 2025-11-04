build:
	mkdir -p dist
	python -m pip install --upgrade pip
	python -m pip install pyinstaller
	pyinstaller --onefile 41_scan_stream_default.py --distpath dist
	mv dist/41_scan_stream_default dist/scan_stream.bin

sbom:
	syft dist/scan_stream.bin -o cyclonedx-json > dist/sbom.json

sign:
	cosign sign-blob dist/scan_stream.bin \
		--output-signature dist/scan_stream.bin.sig \
		--output-certificate dist/scan_stream.bin.pem \
		--yes

verify:
	grype sbom:dist/sbom.json

clean:
	rm -rf dist build *.spec
