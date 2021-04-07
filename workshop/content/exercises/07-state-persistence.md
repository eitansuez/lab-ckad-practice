
1. Create a pod named `vader` with image `bitnami/nginx`. Mount a volume named `vader-vol` at `/var/www/html`, which should live as long as pod lives.

    ```examiner:execute-test
    name: vol-pod-vader
    title: Pod vader with volume running?
    autostart: true
    cascade: true
    ```

1. We created a persistent volume `maul-pv` and a persistent volume claim `maul-pvc`. But our PVC is not binding to the PV. Fix the issue. You may need to delete and recreate the PVC.

    **Under construction**

1. Create a persistent volume named `sidious-pv` of size `200Mi` at `/data/mysql` on host. Use manual storageClassName and ReadWriteOnce access mode.

    Then: Create a persistent volume claim `sidious-pvc` and consume the PV `sidious-pv`.

    Then: Create a pod `sidious` with image `bitnami/mysql` and mount the PVC at `/var/lib/mysql` using volume name `sidious-vol`. Also, set the environment variable `MYSQL_ROOT_PASSWORD=my-secret-pw`.

    **Under construction**

1. Create a pod `dooku` with two containers using the images `bitnami/redis` and `bitnami/nginx`.
   Create an `emptyDir` scratch volume named `dooku-logs` mounted at `/var/log/dooku` in both containers.

    ```examiner:execute-test
    name: vol-pod-dooku
    title: Pod dooku running with two containers and a shared volume mount?
    cascade: true
    ```

    _Note_: Be sure to review the [`hostPath`](https://kubernetes.io/docs/concepts/storage/volumes/#hostpath) and other volume types as you prepare for the exam.

1. Create a ConfigMap named `my-data` with these two sets of key-value pairs: `city: Paris`, and `pastry: Baba au rhum`.  Create a Pod named `my-web-server` using the image `bitnami/nginx` that mounts the ConfigMap as a volume at `/etc/app-data` (the volume name is of your choosing).

    ```examiner:execute-test
    name: vol-pod-cm
    title: Pod my-web-server running with ConfigMap mounted at `/etc/app-data`
    cascade: true
    ```

## Check

Run the script `check-state-persistence` to verify your solutions.

```terminal:execute
command: check-state-persistence
```

## Cleanup

Before proceeding to the next section, please delete the resources you created in this section:

```terminal:execute
command: k delete deploy,pod,svc,cm --all
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
          name: vader
          labels:
            run: vader
        spec:
          containers:
          - name: vader
            image: bitnami/nginx
            volumeMounts:
            - name: vader-vol
              mountPath: /var/www/html
          volumes:
          - name: vader-vol
            emptyDir: {}
        ```

    1. Apply the yaml.

        ```bash
        k apply -f vader.yaml
        ```

1. Create a pod `dooku` with two containers using the images `bitnami/redis` and `bitnami/nginx`.
   Create an `emptyDir` scratch volume named `dooku-logs` mounted at `/var/log/dooku` in both containers.

    1. Begin with a pod yaml spec with a single container:

        ```bash
        k run dooku --image=bitnami/nginx $DR > dooku.yaml
        ```

    1. Add the spec for the second (redis) container (with env var REDIS_PASSWORD).

    1. To each container spec, add the `volumeMounts` section.

    1. Finally, on the pod spec, add the `volumes` section defining the `dooku-logs` volume of type `emptyDir`.

    1. The final yaml should resemble the following

        ```yaml
        ---
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            run: dooku
          name: dooku
        spec:
          containers:
          - name: nginx
            image: bitnami/nginx
            volumeMounts:
            - name: dooku-logs
              mountPath: /var/log/dooku
          - name: redis
            image: bitnami/redis
            env:
            - name: REDIS_PASSWORD
              value: x
            volumeMounts:
            - name: dooku-logs
              mountPath: /var/log/dooku
          volumes:
          - name: dooku-logs
            emptyDir: {}
        ```

    1. Apply the yaml.

        ```bash
        k apply -f dooku.yaml
        ```

1. Create a ConfigMap named `my-data` with these two sets of key-value pairs: `city: Paris`, and `pastry: Baba au rhum`.  Create a Pod named `my-web-server` using the image `bitnami/nginx` that mounts the ConfigMap as a volume at `/etc/app-data` (the volume name is of your choosing).

    1. Create the ConfigMap.

        ```bash
        k create cm my-data --from-literal=city=Paris --from-literal=pastry="Baba au rhum"
        ```

    1. Verify the ConfigMap was set properly.

        ```bash
        k get cm my-data -o jsonpath='{.data}'
        ```

    1. Create a base yaml file for the pod spec.

        ```bash
        k run my-web-server --image=bitnami/nginx $DR > my-web-server.yaml
        ```

    1. Edit the yaml file and add a volume for your ConfigMap and a volume mount for your container.  See [populate a volume with data stored in a ConfigMap](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#populate-a-volume-with-data-stored-in-a-configmap).

        The final spec should be similar to the following.

        ```yaml
        ---
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            run: my-web-server
          name: my-web-server
        spec:
          volumes:
          - name: my-data-volume
            configMap:
              name: my-data
          containers:
          - name: my-web-server
            image: bitnami/nginx
            volumeMounts:
            - name: my-data-volume
              mountPath: /etc/app-data
        ```

    1. Apply the yaml.

        ```bash
        k apply -f my-web-server.yaml 
        ```
