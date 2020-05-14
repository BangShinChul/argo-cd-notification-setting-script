#!/bin/bash

# 현재 쿠버네티스의 네임스페이스가 argocd인 app의 이름을 모두 가져오는 명령어
# Command to get all names of apps with namespace argocd in kubernetes cluster
APPS=`kubectl get app --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}' -n argocd`

# APPS의 결과를 loop 하면서 kubectl patch app 명령어 실행
# Execute kubectl patch app command while looping the result of variable APPS
for app in $APPS
do
    echo "Argo Notification Setting Processing $app ..."
    kubectl patch app $app -n argocd -p '{"metadata":{"annotations":{"recipients.argocd-notifications.argoproj.io":"slack:<your-slack-channel-name>"}}}' --type merge
done

echo "All Processing is Done!"
