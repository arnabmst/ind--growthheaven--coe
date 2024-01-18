cat ./.github/asciiart/ascii--deployment.txt

if [[ $BASE_BRANCH == "ayush" ]] 
then
echo "ORG__SECRET_URL=$AYUSH_DEV_ORG_SECRET_URL" >> $GITHUB_ENV

elif [[ $BASE_BRANCH == "subham" ]]
then
echo "ORG__SECRET_URL=$SUBHAM_DEV_ORG_SECRET_URL" >> $GITHUB_ENV

elif [[ $BASE_BRANCH == "staging" ]]
then
echo "ORG__SECRET_URL=$STAGING_SECRET_URL" >> $GITHUB_ENV

elif [[ $BASE_BRANCH == "uat" ]]
then
echo "ORG__SECRET_URL=$UAT_SECRET_URL" >> $GITHUB_ENV

elif [[ $BASE_BRANCH == "preprod" ]]
then
echo "ORG__SECRET_URL=$PREPROD_SECRET_URL" >> $GITHUB_ENV

elif [[ $BASE_BRANCH == "production" ]]
then
echo "ORG__SECRET_URL=$PRODUCTION_SECRET_URL" >> $GITHUB_ENV
fi