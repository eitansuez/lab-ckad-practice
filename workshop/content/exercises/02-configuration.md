
```examiner:execute-test
name: config-setup
title: Initialize
autostart: true
cascade: true
```

1. Create a config map with the name `my-config` and value `confa=exvalue`.

    ```examiner:execute-test
    name: config-map
    title: ConfigMap my-config exists
    cascade: true
    ```

1. A config map named `al-conf` has been created.

    ```terminal:execute
    command: k get cm
    title: Verify that the config map exists
    ```

    Expose the value of `al-user` to a pod named `al-pod` as the environment variable name `AL_USER`. Use `bitnami/redis` as the image for the pod.

    Note: To function, the `bitnami/redis` [requires setting the environment variable named REDIS_PASSWORD](https://github.com/bitnami/bitnami-docker-redis#setting-the-server-password-on-first-run)

    ```examiner:execute-test
    name: config-map-as-env
    title: Pod has environment variable with value from config map entry
    cascade: true
    ```

1. Create a Pod named `secure-pod`. Use the `bitnami/redis` image. Run pod as user 1000 and group 2000.

    ```examiner:execute-test
    name: secure-pod
    title: Pod runs as user 1000 and group 2000
    cascade: true
    ```

1. Create a pod manifest file `limited-pod.yaml` with name `limited-pod` and `bitnami/kubectl` image. Set memory request at `100Mi` and limit at `200Mi`. You do not need to create the pod.

    ```examiner:execute-test
    name: limited-pod
    title: Pod yaml has specified resource memory requests and limits
    cascade: true
    ```

1. Create a secret `db-secret` with value `MYSQL_ROOT_PASSWORD=YoYoSecret` and `MYSQL_PASSWORD=XoXoPassword`.

    Then: Create a configmap named `db-config` with value `MYSQL_USER=k8s` and `MYSQL_DATABASE=newdb`.

    Then: Create a pod named `mydb` with image `bitnami/mysql` and expose all values of `db-secret` and `db-config` as environment variables to the pod.

    ```examiner:execute-test
    name: conf-db-pod
    title: Mysql Pod configured with environment variables from config map and secrets
    cascade: true
    ```

1. Create a service account named `namaste`.

    Then: Use the service account to create a `yo-namaste` pod with `bitnami/nginx` image.

    ```examiner:execute-test
    name: conf-pod-sa
    title: Pod configured with service account
    ```

Run the script `check-configuration` to verify your solutions.

```terminal:execute
command: check-configuration
```

## Cleanup

Before proceeding to the next section, delete the config maps, secrets, pods, and service accounts you created in this section:

```terminal:execute
command: k delete cm,pod,secret,sa --all
```

## Solutions

1. Create a config map with the name `my-config` and value `confa=exvalue`.

    ```bash
    k create cm my-config --from-literal=confa=exvalue
    ```

1. A config map named `al-conf` has been created. Expose the value of `al-user` to a pod named `al-pod` as the environment variable name `AL_USER`. Use `redis` as the image for the pod.

    1. Create starting point pod yaml with:

    ```bash
    k run al-pod --image=bitnami/redis --dry-run=client -o yaml > al-pod.yaml
    ```

    1. Edit `al-pod.yaml` and add an `env` section (to the container specification) to configure the environment variable, as follows:

        ```yaml
        env:
        - name: REDIS_PASSWORD
          value: howdy
        - name: AL_USER
          valueFrom:
            configMapKeyRef:
              name: al-conf
              key: al-user
        ```

        See [Use ConfigMap-defined environment variables in Pod commands](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#use-configmap-defined-environment-variables-in-pod-commands).

1. Create a Pod named `secure-pod`. Use the `bitnami/redis` image. Run pod as user 1000 and group 2000.

    1. Create starting point pod yaml with:

        ```bash
        k run secure-pod --image=bitnami/redis --dry-run=client -o yaml > secure-pod.yaml
        ```

    1. Edit `secure-pod.yaml` and add to the Pod spec a securityContext section as follows:

        ```yaml
        securityContext:
          runAsUser: 1000
          runAsGroup: 2000
        ```

    1. Don't forget to add the environment variable required for the bitnami redis image:

        ```yaml
        env:
        - name: REDIS_PASSWORD
          value: hello-again
        ```

    See [Set the security context for a Pod](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/#set-the-security-context-for-a-pod).

1. Create a pod manifest file `limited-pod.yaml` with name `limited-pod` and `bitnami/kubectl` image. Set memory request at `100Mi` and limit at `200Mi`. You do not need to create the pod.

    ```bash
    k run limited-pod --image=bitnami/kubectl \
      --requests=memory=100Mi \
      --limits=memory=200Mi \
      --dry-run=client -o yaml > limited-pod.yaml
    ```

    Alternatively..

    1. Create base pod manifest:

        ```bash
        k run limited-pod --image=bitnami/kubectl --dry-run=client -o yaml > limited-pod.yaml
        ```

    1. Edit manifest and add resources section to container specification:

        ```yaml
        resources:
          requests:
            memory: "100Mi"
          limits:
            memory: "200Mi"
        ```

    See [Managing Resources for Containers](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-memory).

1. Create a secret `db-secret` with value `MYSQL_ROOT_PASSWORD=YoYoSecret` and `MYSQL_PASSWORD=XoXoPassword`.

    ```bash
    k create secret generic db-secret --from-literal=MYSQL_ROOT_PASSWORD=YoYoSecret --from-literal=MYSQL_PASSWORD=XoXoPassword
    ```

    Then: Create a configmap named `db-config` with value `MYSQL_USER=k8s` and `MYSQL_DATABASE=newdb`.

    ```bash
    k create cm db-config --from-literal=MYSQL_USER=k8s --from-literal=MYSQL_DATABASE=newdb
    ```

    Then: Create a pod named `mydb` with image `bitnami/mysql` and expose all values of `db-secret` and `db-config` as environment variables to the pod.

    1. Create base pod manifest:

        ```bash
        k run mydb --image=bitnami/mysql --dry-run=client -o yaml > mydb.yaml
        ```

    1. Edit `mydb.yaml` and add an `envFrom` section (to the container specification) to configure the environment variables, as follows:

        ```yaml
        envFrom:
        - configMapRef:
            name: db-config
        - secretRef:
            name: db-secret
        ```

    See [configure all key value pairs in a config map as container environment variables](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#configure-all-key-value-pairs-in-a-configmap-as-container-environment-variables) and [Secrets use case: as container environment variables](https://kubernetes.io/docs/concepts/configuration/secret/#use-cases).

1. Create a service account named `namaste`.

    ```bash
    k create serviceaccount namaste
    ```

    Then: Use the service account to create a `yo-namaste` pod with `bitnami/nginx` image.

    ```bash
    k run yo-namaste --image=bitnami/nginx --serviceaccount=namaste
    ```

    Alternatively generate the base pod yaml and set the `serviceAccountName` field in the pod spec.

    Try this:

    ```terminal:execute
    command: k explain pod.spec.serviceAccountName
    ```
