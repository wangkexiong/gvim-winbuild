
git config --global user.name %GITHUB_USER%
git config --global user.email %GITHUB_EMAIL%
git clone https://%GITHUB_TOKEN%@github.com/%APPVEYOR_REPO_NAME%
FOR /F "TOKENS=2 DELIMS=/" %%x IN ("%APPVEYOR_REPO_NAME%") DO SET REPO_TO_OPERATE=%%x

PUSHD %REPO_TO_OPERATE%
bash -c "TIME=`date -R` && sed -i \"s/\*\*Last Build in:.*/\*\*Last Build in: $TIME\*\*/g\" README.md"
git add README.md
git commit --amend -m "Daily Regular Build..."
git push --force
POPD

