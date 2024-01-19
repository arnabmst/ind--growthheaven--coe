cat ./.github/asciiart/ascii--deployment.txt

if [[ $BASE_BRANCH == "ind--growthheaven--coe" ]] 
then
echo "ORG__SECRET_URL=$COE_DEV_ORG_SECRET_URL" >> $GITHUB_ENV

elif [[ $BASE_BRANCH == "sourceBranch" ]]
then
echo "ORG__SECRET_URL=$COE_DEV_ORG_SECRET_URL" >> $GITHUB_ENV
fi