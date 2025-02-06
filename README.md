# Github Action (Hugo Build & Deployment to Firebase)

The following Github Action will successfully build and deploy your Hugo static-site and upload it to Google Firebase Hosting.

**Pre-requisites**

- You will need a Firebase Project. If you haven't already got one you can easily get one here: [Firebase Console](https://console.firebase.google.com/)
- You will need a Google Service Account setup in-order for your site to be successfully deployed. See below on how to set one up.

## Manually configure the service account

### 1. Create a service account that the action will use to deploy to Hosting

1. Visit the [GCP Service Accounts page](https://console.cloud.google.com/iam-admin/serviceaccounts) and make sure the correct project (same name as your Firebase project) is selected in the top blue bar
1. Click the "+ CREATE SERVICE ACCOUNT" button
1. Give the service account a name, id, description. I recommend something like `github-action-<my repository name>`
1. At the "Grant this service account access to project" step, choose the following [roles](https://firebase.google.com/docs/projects/iam/roles-predefined-product) that the service account will need to deploy on your behalf:
   - **Firebase Authentication Admin** (Required to add preview URLs to Auth authorized domains)
     - `roles/firebaseauth.admin`
   - **Firebase Hosting Admin** (Required to deploy preview channels)
     - `roles/firebasehosting.admin`
   - **Cloud Run Viewer** (Required for projects that [use Hosting rewrites to Cloud Run or Cloud Functions](https://firebase.google.com/docs/hosting/serverless-overview))
     - `roles/run.viewer`
   - **API Keys Viewer** (Required for CLI deploys)
     - `roles/serviceusage.apiKeysViewer`
1. Finish the service account creation flow

### 2. Get that service account's key and add it to your repository as a secret

1. [Create and download](https://cloud.google.com/iam/docs/creating-managing-service-account-keys#creating_service_account_keys) the new service account's JSON key
1. Add that JSON key [as a secret in your GitHub repository](https://docs.github.com/en/free-pro-team@latest/actions/reference/encrypted-secrets#creating-encrypted-secrets-for-a-repository). I recommend a name like `FIREBASE_SERVICE_ACCOUNT` but ensure it has been base64 encoded before saving. You can do this on MacOS by running `cat {file_name}.json | base64` in Terminal and copying the output into Github.

## Getting Started

* Ensure you've followed the above steps to setup your service account.
* Log in to Firebase (setup on your local machine) using `firebase login`, which opens a browser where you can select your account. Use `firebase logout` in case you are already logged in but to the wrong account.
* In the root of your Hugo project, initialize the Firebase project with the `firebase init` command. From here:
  * Choose Hosting in the feature question
  * Choose the project you just set up
  * Accept the default for your database rules file
  * Accept the default for the publish directory, which is public
  * Choose “No” in the question if you are deploying a single-page app
* You will now have everything setup within your repo to deploy successfully to Firebase.
* Once completed you are ready to setup your action.

## Setting up Actions

Within your repo select the `Actions` tab. Create a new workflow and paste the following code:

```
on: [push]
name: Deploy Hugo to Firebase
jobs:
  build:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v1
      with:
        submodules: true
    - uses: ryank90/action-hugo-firebase-deploy@master
      with:
        firebaseServiceAccount: ${{ secrets.firebase_service_account }}
        projectId: ${{ secrets.firebase_project_name }}
        hugoParams: -D
```

Save and you are ready to push code to your repo and have it automatically deployed.

## Options

`firebaseServiceAccount` _{string}_ required
This is a Google service account JSON key that has been base64 encoded. Once you have got your JSON key configured and downloaded you can run `` on your mac to base64 encode it ready for uploading into Github.

It's important to ensure you set this up as an encrypted secret within Github. You can do that here: https://github.com/USERNAME/REPOSITORY/settings/secrets.

`projectId` _{string}_
This is your Firebase project ID that can be found from within the Firebase console.

`hugoParams` _{string}_
These are your hugo parameters that you would like to pass. It defaults to `-D` which will built your site ready for deployment although you can pass further parameters. See Hugo documentation for more information on what is available here.
