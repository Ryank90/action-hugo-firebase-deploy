# Github Action (Hugo Build & Deployment to Firebase)

The following Github Action will successfully build and deploy your Hugo static-site and upload it to Google Firebase Hosting.

**Pre-requisites**

- You will need a Firebase Project. If you haven't already got one you can easily get one here: [Firebase Console](https://console.firebase.google.com/)
- You will need a Firebase Token in-order for this to run.

## Getting Started


You will need firebase tools installed on your local machine to obtain a firebase token. If you haven't got it installed then you can install it by running `npm install -g firebase-tools`.

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

Within your repo select the `Actions` tab. Create a new workflow and paste the following:

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
        firebase-token: ${{ secrets.firebase_token }}
        alias: ${{ alias }} // Optional
```

Save and you are ready to push code to your repo and have it deployed.
