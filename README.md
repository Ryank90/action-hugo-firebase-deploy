# Github Action (Hugo Build & Deployment to Firebase)

The following Github Action will successfully build and deploy your Hugo static-site and upload it to Google Firebase Hosting.

**Pre-requisites**

- You will need a Firebase Project. If you haven't already got one you can easily get one here: [Firebase Console](https://console.firebase.google.com/)
- You will need a Google Service Account setup in-order for your site to be successfully deployed.

## Getting Started

You will need to generate a Google Service Account.

* Log in to Firebase (setup on your local machine) using `firebase login`, which opens a browser where you can select your account. Use `firebase logout` in case you are already logged in but to the wrong account.
* In the root of your Hugo project, initialize the Firebase project with the `firebase init` command. From here:
  * Choose Hosting in the feature question
  * Choose the project you just set up
  * Accept the default for your database rules file
  * Accept the default for the publish directory, which is public
  * Choose “No” in the question if you are deploying a single-page app
* You can generate a deploy token using `firebase login:ci`
* Your Firebase token is sensitive information so it will need to be setup as a [Github Secret](https://help.github.com/en/actions/configuring-and-managing-workflows/creating-and-storing-encrypted-secrets).
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
