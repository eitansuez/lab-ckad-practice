
## Under construction

1. Create a pod named `vader` with image `bitnami/nginx`. Mount a volume named `vader-vol` at `/var/www/html`, which should live as long as pod lives.

    ```examiner:execute-test
    name: vol-pod-vader
    title: Pod vader with volume running?
    autostart: true
    cascade: true
    ```

1. We created a persistent volume `maul-pv` and a persistent volume claim `maul-pvc`. But our PVC is not binding to the PV. Fix the issue. You may need to delete and recreate the PVC.

1. Create a persistent volume named `sidious-pv` of size `200Mi` at `/data/mysql` on host. Use manual storageClassName and ReadWriteOnce access mode.

    Then: Create a persistent volume claim `sidious-pvc` and consume the PV `sidious-pv`.

    Then: Create a pod `sidious` with image `alpine/mysql` and mount the PVC at `/var/lib/mysql` using volume name `sidious-vol`. Also, set the environment variable `MYSQL_ROOT_PASSWORD=my-secret-pw`.

1. Create a pod `dooku` with two containers using the images `alpine/redis` and `alpine/nginx`. Create a shared `hostPath` volume at `/data/dooku` named `dooku-logs` mounted at `/var/log/dooku` in both containers.

## Check

Run the script `check-state-persistence` to verify your solutions.

```terminal:execute
command: check-state-persistence
```

## Cleanup

Before proceeding to the next section, please delete the resources you created in this section:

```terminal:execute
command: k delete deploy,pod,svc --all
```

## Solutions

1. Create a pod named `vader` with image `bitnami/nginx`. Mount a volume named `vader-vol` at `/var/www/html`, which should live as long as pod lives.

    1. Begin by creating a pod spec from the command:

        ```bash
        k run vader --image=bitnami/nginx $DR > vader.yaml
        ```

    1. Read about [emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir), which is the type of volume you are asked to create.  The page also provides an example of how to define such a volume and how to mount it inside a container using the `mountPath` field.  Also, see [configuring a pod to use a volume for storage](https://kubernetes.io/docs/tasks/configure-pod-container/configure-volume-storage/).

    1. The final spec should resemble the following.

        ```yaml
        ---
        apiVersion: v1
        kind: Pod
        metadata:
        labels:
            run: vader
        name: vader
        spec:
        containers:
        - image: bitnami/nginx
            name: vader
            volumeMounts:
            - mountPath: /var/www/html
            name: vader-vol
        volumes:
        - name: vader-vol
            emptyDir: {}
        ```
