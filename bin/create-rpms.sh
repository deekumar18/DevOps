# example usage: JOB_NAME=example-api BUILD_NUMBER=101 bash jenkins-build.sh
# ${env.BUILD_NUMBER}
# download and build nodejs application and 3rd party modules.

RPM_NAME=cmg-esb-stub

rm -fr "${WORKSPACE}/output"
mkdir -p "${WORKSPACE}/output"

# rm -fr "${WORKSPACE}/${JOB_NAME}"
# mkdir -p "${WORKSPACE}/${JOB_NAME}"
echo "job name: ${JOB_NAME}"
echo " workspace: ${WORKSPACE}"

npm rebuild
npm install -l
npm ci --production

version=`date +"%Y.%m.%d"`

/usr/local/bin/fpm \
  -s dir -t rpm \
  -p "${WORKSPACE}/output/" \
  --name "${RPM_NAME}" \
  --iteration "${BUILD_NUMBER}" \
  --version "$version" \
  --vendor "Department for Work and Pensions" \
  --before-install "DevOps/bin/before-install.sh" \
  --after-install "DevOps/bin/after-install.sh" \
  --rpm-user="njsadmin" --deb-user="njsadmin" \
  --rpm-group="njsadmin" --deb-group="njsadmin" \
  --directories "/opt/${RPM_NAME}" \
  --prefix=/opt/${RPM_NAME} \
  README.md app.js test json lib routes images locales middleware static views src node_modules tls \
  package.json cmg-esb-stub.service .env-sample \
  package-lock.json
