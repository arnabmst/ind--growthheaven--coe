# Authenticates Salesforce Orgs

echo ${ORG__SECRET_URL} > ./CI_SFDX_URL.txt && 
sfdx force:auth:sfdxurl:store -f ./CI_SFDX_URL.txt -a ${ORG__ALIAS} -d

