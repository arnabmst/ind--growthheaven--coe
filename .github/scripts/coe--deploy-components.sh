# Deploys components from package.xml

TEST_CLASSES=$(cat ./testclass/testclass.txt)

# running tests from the specified test classes and performing validation
# and then deploying
sfdx force:source:deploy -u $ORG__ALIAS -x package/package.xml -l RunSpecifiedTests -r $TEST_CLASSES --verbose | tee ./DEPLOY_ORG.txt

DEPLOY_EXIT_CODE=${PIPESTATUS[0]}
if [ $DEPLOY_EXIT_CODE != 0 ]
then
    exit $DEPLOY_EXIT_CODE;
fi
set -o pipefail