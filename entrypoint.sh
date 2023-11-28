GITHUB_REPOSITORY=$INPUT_REPO
RELEASE_NAME=$INPUT_RELEASE
RELEASE_FILE=$INPUT_ARTIFACT
RELEASE_FILE_MIMETYPE=$INPUT_ARTIFACT_MIME_TYPE
GITHUB_ACCESS_TOKEN=$INPUT_GH_TOKEN

upload_url=$(curl -s -H "Authorization: Bearer $GITHUB_ACCESS_TOKEN" \
			"https://api.github.com/repos/${GITHUB_REPOSITORY}/releases/tags/${RELEASE_NAME}" \
			| jq -r '.upload_url')

upload_url="${upload_url%\{*}"
          
echo "Uploading release artifact to $upload_url"
          
curl -X POST -H "Authorization: Bearer $GITHUB_ACCESS_TOKEN" \
	-H "Content-Type: $RELEASE_FILE_MIMETYPE" \
	--data-binary "@$RELEASE_FILE" \
	"$upload_url?name=$RELEASE_FILE"