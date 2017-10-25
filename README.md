# RHCWebsite

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

----

#### 4. Get approvals
Let others know that you have a `pull request` that needs review, so that they may check out your changes and `approve` them or request changes

To review other's pull requests, visit the `Pull requests` tab. After selecting a PR to review, visit the `Files changed` to see a list of the changes.

If the changes look good, click the `Review changes` button and select `Approve` and `Submit review`.
If the code needs some changes, or you want to start a discussion, you may `Request changes` or `Comment`.

----

#### 4. Merge Pull Request
Once your `pull request` receives a sufficient number of `approvals`, and the code passes any existing tests, it is ready to be `merged` back to the base branch (usually `master` but could be another branch).

After merging, you may `delete` the old branch.
