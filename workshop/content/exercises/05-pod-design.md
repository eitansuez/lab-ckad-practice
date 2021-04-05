
## Under construction

1. Create a _Deployment_ named `hoth` that deploys four (4) replicas of Pods with the image `bitnami/apache`. Be sure to use the version of this container image with the tag `2.4.46`.

    ```examiner:execute-test
    name: hoth-deploy
    title: hoth Deployment with 4 replicas of apache
    autostart: true
    cascade: true
    ```

1. The Deployment `yavin` has been upgraded, but the new Pods are not getting created. Rollback the Deployment `yavin` so that the Pods are working again.

    Then: Export `yavin` deployment spec in JSON to the file `yavin.json`.

1. The Deployment `naboo` has been created.  Make sure the replicas autoscale with minimum 2 and maximum 5 when at 80% CPU.  Use `naboo` as the name of HPA resource.

1. Create a Cron job named `bespin` that runs the command `date` using the `bitnami/kubectl` image every 5 minutes (`*/5 * * * *`).

    ```examiner:execute-test
    name: bespin-cj
    title: bespin CronJob running date every 5 minutes
    autostart: true
    ```

## Cleanup

Before proceeding to the next section, please delete deployments and cronjobs you created in this section:

```terminal:execute
command: k delete deploy,cj --all
```

## Solutions

1. Create a _Deployment_ named `hoth` that deploys four (4) replicas of Pods with the image `bitnami/apache`. Be sure to use the version of this container image with the tag `2.4.46`.

    ```bash
    k create deploy hoth --image=bitnami/apache:2.4.46 --replicas=4 
    ```

1. The Deployment `yavin` has been upgraded, but the new Pods are not getting created. Rollback the Deployment `yavin` so that the Pods are working again.

    Then: Export `yavin` deployment spec in JSON to the file `yavin.json`.

1. The Deployment `naboo` has been created.  Make sure the replicas autoscale with minimum 2 and maximum 5 when at 80% CPU.  Use `naboo` as the name of HPA resource.

1. Create a Cron job named `bespin` that runs the command `date` using the `bitnami/kubectl` image every 5 minutes (`*/5 * * * *`).

    ```bash
    k create cj bespin --image=bitnami/kubectl --schedule="*/5 * * * *" -- date
    ```
