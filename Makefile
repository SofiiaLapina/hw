build:
	mkdir -p dist
	zip -j dist/scan_stream.zip 41_scan_stream_default.py README.md requirements.txt

sbom:
	syft dist/scan_stream.zip -o cyclonedx-json > dist/sbom.json

sign:
	cosign sign-blob dist/scan_stream.zip \
		--output-signature dist/scan_stream.zip.sig \
		--output-certificate dist/scan_stream.zip.pem

verify:
	grype sbom:dist/sbom.json

clean:
	rm -rf dist

