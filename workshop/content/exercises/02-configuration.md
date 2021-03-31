
```examiner:execute-test
name: config-init
autostart: true
```

1. Create a config map with the name `my-config` and value `confa=exvalue`.

    ```examiner:execute-test
    name: config-map
    title: ConfigMap my-config exists
    ```

1. A config map named `al-conf` has been created. Expose the value of `al-user` to a pod named `al-pod` as the environment variable name `AL_USER`. Use redis image for the pod.

    ```examiner:execute-test
    name: config-map-as-env
    title: Pod has environment variable with value from config map entry
    ```

1. Create a Pod named `secure-pod`. Use the `redis` image. Run pod as user 1000 and group 2000.

    ```examiner:execute-test
    name: secure-pod
    title: Pod runs as user 1000 and group 2000
    ```

1. Create a pod manifest file `limited-pod.yaml` with name `limited-pod` and `busybox` image. Set memory request at `100Mi` and limit at `200Mi`. You do not need to create the pod.

    ```examiner:execute-test
    name: limited-pod
    title: Pod yaml has specified resource memory requests and limits
    ```

1. Create a secret `db-secret` with value `MYSQL_ROOT_PASSWORD=YoYoSecret` and `MYSQL_PASSWORD=XoXoPassword`.

    Then: Create a configmap named `db-config` with value `MYSQL_USER=k8s` and `MYSQL_DATABASE=newdb`.

    Then: Create a pod named `mydb` with image `mysql:5.7` and expose all values of `db-secret` and `db-config` as environment variables to the pod.

1. Create a service account named `namaste`.

    Then: Use the service account to create a `yo-namaste` pod with nginx `image`.

Run the script `check-configuration` to verify your solutions.
