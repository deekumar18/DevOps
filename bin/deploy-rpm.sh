# ssh dt-options sudo bash << EOF
#   yum erase cmg-esb-stub -y
#   rm -rf /opt/cmg-esb-stub/*
#   yum clean all
#   yum install cmg-esb-stub -y
#   systemctl restart cmg-esb-stub
# EOF

#!/bin/sh
env=$1
version=`date +"%Y.%m.%d"`-${BUILD_NUMBER}

. ./DevOps/bin/install.sh

ansible-playbook ./DevOps/ansible/playbooks/${env}.yml

#echo 'Builds complete'
if [ $? -eq 0 ]
then
  echo "Deployment completed successfully "
else
  echo "Deployment failed" >&2
fi
