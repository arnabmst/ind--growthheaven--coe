

TEST_CLASSES=$(cat ./testclass/testclass.txt)

# run tests on the source org during the time of validation
sfdx force:source:deploy -c -u $ORG__ALIAS -x package/package.xml -l RunSpecifiedTests -r $TEST_CLASSES --verbose | tee ./DEPLOY_ORG.txt


DEPLOY_EXIT_CODE=${PIPESTATUS[0]}
if [ $DEPLOY_EXIT_CODE != 0 ]
then
    exit $DEPLOY_EXIT_CODE;
fi
set -o pipefail
