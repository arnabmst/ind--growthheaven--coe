# Migrates data from one Salesforce org to another

cd .sfdmu/
# run sfdmu from source to target org
sfdx sfdmu:run --sourceusername ${ORG__SRC_ALIAS} --targetusername ${ORG__DEST_ALIAS}
MIGRATE_EXIT_CODE=${PIPESTATUS[0]}
if [ $MIGRATE_EXIT_CODE != 0 ]
then
    exit $MIGRATE_EXIT_CODE;
fi
cd -