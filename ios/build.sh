#!/bin/sh

# Script builds an unsigned ipa file from project (For distribution with AltStore and self-signed applications stuff, or for enterprise distribution)
WORKSPACE="Runner.xcworkspace"
SCHEME="Runner"
OUTPUT="../build/app/outputs/ipa/app.ipa"

# Remove files that are created during this script, just in case they fuck the whole thing up
rm -r "temp.xcarchive"
rm -r "Payload" # Especially this one will cause it to be incorrectly formatted!
rm $OUTPUT

# Generate the archive
xcodebuild -scheme $SCHEME -workspace $WORKSPACE -configuration Release clean archive -archivePath "temp.xcarchive" CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGNING_ALLOWED=NO

# Copy the built application to the Payload to ipa
cp -r "temp.xcarchive/Products/Applications" "Payload"
zip -r $OUTPUT "Payload"

# Remove garbage stuff
rm -r "temp.xcarchive"
rm -r "Payload"
