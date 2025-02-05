#!bin/sh -x

# Retrieve the input arguments/parameters.
FIREBASE_DEPLOY_TOKEN=${1:-firebaseToken}
FIREBASE_SERVICE_ACCOUNT=${2:-firebaseServiceAccount}
PROJECT_ID=${3:-projectId}
HUGO_PARAMS=${4:-hugoParams}

# Build the Hugo site.
hugo $HUGO_PARAMS

# Publish to Google Firebase.

echo $FIREBASE_SERVICE_ACCOUNT > credentials.json
GOOGLE_APPLICATION_CREDENTIALS=credentials.json

# firebase use --token $FIREBASE_DEPLOY_TOKEN $PROJECT_ID
firebase deploy -m "
  Successful Deployment: 
  Event: $GITHUB_EVENT_NAME,
  Commit SHA: $GITHUB_SHA,
  User: $GITHUB_ACTOR
" --non-interactive --token $FIREBASE_DEPLOY_TOKEN
