#!bin/sh -x

# Retrieve the input arguments/parameters.
FIREBASE_SERVICE_ACCOUNT=${1:-firebaseServiceAccount}
PROJECT_ID=${2:-projectId}
HUGO_PARAMS=${3:-hugoParams}

# Build the Hugo site.
hugo $HUGO_PARAMS

# Publish to Google Firebase.
echo -n $FIREBASE_SERVICE_ACCOUNT | base64 --decode > credentials.json
export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/credentials.json"
cat "$(pwd)/credentials.json"

firebase use $PROJECT_ID

firebase deploy -m "
  Successful Deployment: 
  Event: $GITHUB_EVENT_NAME,
  Commit SHA: $GITHUB_SHA,
  User: $GITHUB_ACTOR
" --non-interactive --only hosting

rm "$(pwd)/credentials.json"