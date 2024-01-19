# Evaluates the difference from the 2 branches and generates the package.xml
git config --global --add safe.directory /__w/ind--growthheaven--coe/ind--growthheaven--coe
git fetch origin "+refs/heads/*:refs/remotes/origin/*"

# checking if there is any change in force-app folder and update the environment variable in order to avoid the exit command
# if [ -z "$(git diff HEAD origin/$BASE_BRANCH --name-only force-app/main/default)" ]; then
#     echo "Package data unchanged"
#     export SKIP_VALIDATION=false
# else
#     echo "Package data changed"
#     export SKIP_VALIDATION=true
#     env
# fi 
# This is a Feature Enhancement Commented for now.

# updating the HOME to point to root as HOME is pointing to GIT and the extension is loaded at root directory

export HOME=/root

git config --global --add safe.directory /__w/ind--growthheaven--coe/ind--growthheaven--coe

sfdx sgd:source:delta -a 58 --from "origin/$BASE_BRANCH" --output . -i manifest/mdapi/.sgdignore

echo "--- package.xml generated with added and modified metadata since $LAST_DEPLOYED_COMMIT in $BASE_BRANCH ---"
cat package/package.xml
echo
echo "--- destructiveChanges.xml generated with deleted metadata since $LAST_DEPLOYED_COMMIT in $BASE_BRANCH ---"
cat destructiveChanges/destructiveChanges.xml
echo