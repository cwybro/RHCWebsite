# RHCWebsite

### Environment Variables
To better hide our API keys (like Google), we will use Heroku `Environment variables`. These allow us to configure key-value pairs that will be used at runtime in our application. Due to this however, we must also use a `.env` file that contains these key-value pairs to test the app, since the `environment variables` on Heroku won't be used on a local server.

#### .env File
The `.env` file is a file that contains lines like the following: ```API_KEY=yourKey```. Using the command mentioned below, your local environment will use this file to configure your app in a similar manner to the cloud environment, assigning values to the places you've specified in the code.

To access the value of a key in the Rails app, you use: ```ENV['API_KEY']``` where ENV is the collection containing all of the `environment variables`.

Although the `.gitignore` already ignores the `.env` file, it should **never** be committed to the repo -- doing so would expose the `environment variables`. 

#### Run locally
Instead of using the usual ```rails server``` command, use: ```heroku local:run rails server``` to run the app locally (on `localhost`).

#### Resources
[Heroku - configure](https://devcenter.heroku.com/articles/config-vars)
[Heroku - run app locally](https://devcenter.heroku.com/articles/heroku-local)


### PR Workflow How-To
#### 1. Create branch
Any time you want to make a change to the code (add, update, remove, etc.), create a **new** branch from the `master` branch.

The name of this branch isn't super important, but it should be short and informative like the following:
```
add-event-view
create-location-filter
```
**Remember:** Never commit directly to `master` -- only make changes to your branch

----

#### 2. Make changes
Once you have a new branch, you may begin committing and pushing changes.

**Remember:** Make sure you are on the correct branch before committing any changes

----

#### 3. Create Pull Request
After you've completed work that you would like others to review, create a `pull request` (also a `PR`).

A `pull request` is a way of telling others that you have work you want them to check out.

Click on the `Pull requests` tab and select `New pull request`. Make sure the `base` branch is set to wherever you'd like to merge your changes into (usually `master`), and the `compare` branch is set to your branch.

**Remember:** Before a CI setup (automated testing server) is in place, make sure all tests pass locally before creating a pull request

----

#### 4. Get approvals
Let others know that you have a `pull request` that needs review, so that they may check out your changes and `approve` them or request changes

To review other's pull requests, visit the `Pull requests` tab. After selecting a PR to review, visit the `Files changed` to see a list of the changes.

If the changes look good, click the `Review changes` button and select `Approve` and `Submit review`
* Also add the `ok-1` label if you're the first to approve, or `ok-2` otherwise to help others see what's been reviewed

If the code needs some changes, or you want to start a discussion, you may `Request changes` or `Comment`
* If comments are made, add the `comments` label to help others easily see that comments remain unhandled

----

#### 4. Merge & Delete
Once your `pull request` receives a sufficient number of `approvals`, and the code passes any existing tests, it is ready to be `merged` back to the base branch (usually `master` but could be another branch).

After merging, you may `delete` the old branch.
