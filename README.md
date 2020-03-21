# Github Action (Hugo deployment to Firebase)

The following Github action will build and deploy your Hugo site and upload it to Google Firebase Hosting.

You will need a Firebase token in-order to run this.
Pre-requesites

- You will need a Firebase project. If you haven't already got one you can easily get one here: 


## Getting a Firebase Token

You will need firebase tools installed on your local machine to obtain a firebase token. If you haven't got it installed then you can install it by running `npm install -g firebase-tools`

* Firstly, run `firebase login` and follow the response flow to choose your account and login.
* Next we need to initalize a project. Within your project run `firebase init` and select `Hosting: Configure and deploy Firebase Hosting sites` and 
* To get your firebase token run `firebase login:ci`

## Using your Secret

Your Firebase token is sensitive so you will need to set it up as a secret within Github.

