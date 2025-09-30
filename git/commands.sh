git remote set-url origin git@github.com-work:org/repo.git

git init
git remote add origin <git-repository-url>
git status
git add *
git add .
git commit -m <"commit-message">
git push -u origin <branch-name> --force

git checkout <base-branch>
git pull origin <base-branch>       # make sure your base branch is up to date
git fetch origin
git merge origin/<compare-branch>     # merge latest compare-branch into base-branch

git stash
git stash apply

git log --all --oneline -l          # check latest commit

git branch -a
git branch <branch-name>
git checkout <branch-name>
git checkout -b <branch-name>
git branch -m <new-branch-name>
git branch -d <local-branch-name>
git push origin --delete <remote-branch-name>
git remote prune origin 

# Clone repository
# <--depth=1> for cloning only latest commit
# -b <branch-name> for cloning specific branch
# <$GITHUB_PAT> for cloning private repository
git clone --depth=1 -b <branch-name> https://$GITHUB_PAT@github.com/<user/org-name>/<repo-name>.git

git restore --staged <path>
git rm <filename>
git rm --cached <filename>
git reset --hard HEAD~1

git remote show origin
git remote remove origin

# count lines in repository
git ls-files | xargs wc -l

git config -l
git config credential.username <username>
git config --global user.name <username>
git config --global user.email <email>
git config --global core.autocrlf input    # This tells Git to keep LF in repo

git commit --amend --all

git log
git rebase -i <commit-id>~1
git commit --amend
git rebase --continue

# git commands for pre-commits
git commit -m <"commit message"> -n # skips all pre-commits checks
SKIP=ggshield git commit -m <"commit message"> # skips ggshield pre-commit checks
