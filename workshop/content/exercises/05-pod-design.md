
1. Create a _Deployment_ named `hoth` with two (2) replicas of Pods with the image `bitnami/apache`. Be sure to use the version of this container image with the tag `2.4.46`.

    ```examiner:execute-test
    name: deploy-hoth
    title: hoth Deployment with 2 replicas of apache
    autostart: true
    cascade: true
    ```

1. Setup:

    1. Apply the deployment named `yavin`:

        ```terminal:execute
        command: k apply -f pod-design/yavin.yaml
        ```

    1. Wait for the rollout of the deployment to complete.

        ```terminal:execute
        command: k rollout status deploy yavin
        ```

    1. Rollout an update to your deployment:

        ```terminal:execute
        command: k apply -f pod-design/yavin-update.yaml
        ```

    1. Inspect the state of the new pods.

        ```terminal:execute
        command: k get pod -w
        ```

        There is a problem.

    _Your tasks_:

    - Rollback the Deployment `yavin` so that the Pods are working again.

    - Export `yavin` deployment spec in JSON to the file `yavin.json`.

    ```examiner:execute-test
    name: deploy-yavin-rollback
    title: Has the yavin deployment been rolled back?
    cascade: true
    ```

1. Setup:

    1. Apply the Deployment `naboo`:

        ```terminal:execute
        command: k apply -f pod-design/naboo.yaml
        ```

    _Your task_:

    Make sure the replicas autoscale with minimum 2 and maximum 5 when at 80% CPU.  Use `naboo` as the name of HPA resource.

    ```examiner:execute-test
    name: deploy-naboo-autoscale
    title: Has the naboo deployment been configured for autoscaling?
    cascade: true
    ```

1. Create a Cron job named `bespin` that runs the command `date` using the `bitnami/kubectl` image every 5 minutes (`*/5 * * * *`).

    ```examiner:execute-test
    name: deploy-bespin-cj
    title: bespin CronJob running date every 5 minutes
    cascade: true
    ```

## Check

Run the script `check-pod-design` to verify your solutions.

```terminal:execute
command: check-pod-design
```

## Cleanup

Before proceeding to the next section, please delete deployments and cronjobs you created in this section:

```terminal:execute
command: k delete deploy,cj --all
```

<h2 style="margin-top: 10em;">Solutions</h2>

1. Create a _Deployment_ named `hoth` with two (2) replicas of Pods with the image `bitnami/apache`. Be sure to use the version of this container image with the tag `2.4.46`.

    ```bash
    k create deploy hoth --image=bitnami/apache:2.4.46 --replicas=2
    ```

1. The Deployment `yavin` has been upgraded, but the new Pods are not getting created. Rollback the Deployment `yavin` so that the Pods are working again.

    ```bash
    k rollout undo deploy yavin
    ```

    Then: Export `yavin` deployment spec in JSON to the file `yavin.json`.

    ```bash
    k get deploy yavin -o json > yavin.json
    ```

1. The Deployment `naboo` has been created.  Make sure the replicas autoscale with minimum 2 and maximum 5 when at 80% CPU.  Use `naboo` as the name of HPA resource.

    ```bash
    k autoscale deploy naboo --name=naboo --min=2 --max=5 --cpu-percent=80
    ```

1. Create a Cron job named `bespin` that runs the command `date` using the `bitnami/kubectl` image every 5 minutes (`*/5 * * * *`).

    ```bash
    k create cj bespin --image=bitnami/kubectl --schedule="*/5 * * * *" -- date
    ```
