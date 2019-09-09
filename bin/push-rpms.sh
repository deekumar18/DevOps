INIT_PATH=${WORKSPACE}
mkdir -p $INIT_PATH/sync
cd $INIT_PATH/sync
aws s3 sync s3://cmg-code-promotion-dev/RPMS/cmg-online-revive $INIT_PATH/sync

echo "Return code from s3 => jenkins sync = $?"

cp  $INIT_PATH/output/* $INIT_PATH/sync/.
createrepo -d $INIT_PATH/sync
aws s3 sync $INIT_PATH/sync s3://cmg-code-promotion-dev/RPMS/cmg-online-revive --sse AES256 --delete

echo "Return code from jenkins => s3 sync = $?"
