argocd login 127.0.0.1:31777 --username admin --password admin123456 --insecure
argocd app create -f aoa-01-trigger.yaml --upsert
sleep 2
while true
do
    echo "*********************************"
    echo "*********************************"
    echo "*********************************"
    argocd app wait -l app.kubernetes.io/instance=app-of-apps01-trigger-prod --health --timeout 1
    if [ $? -ne 0 ]
    then
        echo "yesyesyesyesyesyesyesyesyesyesyesyesyesyesyesyes"
        echo "yesyesyesyesyesyesyesyesyesyesyesyesyesyesyesyes"
        echo "yesyesyesyesyesyesyesyesyesyesyesyesyesyesyesyes"
    else
        echo "nononononononononononononononononononononononono"
        echo "nononononononononononononononononononononononono"
        echo "nononononononononononononononononononononononono"
        exit 0
    fi
    echo "*********************************"
    echo "*********************************"
    echo "*********************************"
done


argocd app wait -l app.kubernetes.io/instance=app-of-apps01-trigger-prod --sync



