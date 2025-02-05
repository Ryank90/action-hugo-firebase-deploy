#!bin/sh -x

# Retrieve the input arguments/parameters.
FIREBASE_PROJECT_NAME=$1
FIREBASE_DEPLOY_TOKEN=$2
ALIAS=${3:-alias}
HUGO_PARAMS=${4:-hugo-params}

# Build the Hugo site.
hugo $HUGO_PARAMS

# Publish to Google Firebase.
firebase use $FIREBASE_PROJECT_NAME
firebase use --token $FIREBASE_DEPLOY_TOKEN $ALIAS
firebase deploy -m "
  Successful Deployment: 
  Event: $GITHUB_EVENT_NAME,
  Commit SHA: $GITHUB_SHA,
  User: $GITHUB_ACTOR
" --non-interactive --token $FIREBASE_DEPLOY_TOKEN
