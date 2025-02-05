#!bin/sh -x

# Retrieve the input arguments/parameters.
FIREBASE_DEPLOY_TOKEN=${1:-firebase-token}
ALIAS=${2:-alias}
HUGO_PARAMS=${3:-hugo-params}

# Build the Hugo site.
echo "Building the Hugo site..."
hugo $HUGO_PARAMS

# Publish to Google Firebase.
firebase use --token $FIREBASE_DEPLOY_TOKEN $ALIAS
firebase deploy -m "
  Successful Deployment: 
  Event: $GITHUB_EVENT_NAME,
  Commit SHA: $GITHUB_SHA,
  User: $GITHUB_ACTOR
" --non-interactive --token $FIREBASE_DEPLOY_TOKEN
