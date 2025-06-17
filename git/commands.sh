git init
git remote add origin <git-repository-url>
git status
git add *
git add .
git commit -m <"commit-message">
git push -u origin <branch-name> --force
git merge <feature-branch>

git stash
git stash apply

git branch -a
git branch <branch-name>
git checkout <branch-name>
git checkout -b <branch-name>
git branch -m <new-branch-name>
git branch -d <local-branch-name>
git push origin --delete <remote-branch-name>
git remote prune origin 

git rm <filename>
git rm --cached <filename>
git reset --hard HEAD~1

git remote remove origin

# count lines in repository
git ls-files | xargs wc -l

git config -l
git config credential.username <username>
git config --global user.name <username>
git config --global user.email <email>

git commit --amend --all

git log
git rebase -i <commit-id>~1
git commit --amend
git rebase --continue

# git commands for pre-commits
git commit -m <"commit message"> -n # skips all pre-commits checks
SKIP=ggshield git commit -m <"commit message"> # skips ggshield pre-commit checks
