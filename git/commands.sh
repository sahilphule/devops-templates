git status
git add *
git add .
git commit -m <commit-message>
git push -u origin <branch-name> --force
git rm <filename>
git rm --cached <filename>
git reset --hard HEAD~1

# delete branch locally
git branch -d <local-branch-name>

# delete branch remotely
git push origin --delete <remote-branch-name>

git init
git remote add origin <git-repository-url>
git remote remove origin

git branch <branch-name>
git checkout <branch-name>
git checkout -b <branch-name>

git config -l
git config credential.username <username>
git config --global user.name <username>
git config --global user.email <email>

git commit --amend --all

git log
git rebase -i <commit-id>~1
git commit --amend
git rebase --continue