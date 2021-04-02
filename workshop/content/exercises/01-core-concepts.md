
1. Create a Pod named `nginx`, with container using the image `bitnami/nginx`.

    ```examiner:execute-test
    name: make-pod
    title: Pod nginx exists
    cascade: true
    autostart: true
    ```

1. Create a pod named `hello` with image `bitnami/kubectl` and command `echo "Hello World"`. Make sure the pod does not restart automatically.

    ```examiner:execute-test
    name: hello-world-pod
    title: Pod emits greeting
    cascade: true
    ```

1. Generate a pod manifest file `mypodx.yaml` (in your current working directory). Pod name should be `mypodx` with image `redis`. Make sure you only generate the pod manifest file, you do not have to create the pod.

    ```examiner:execute-test
    name: redis-pod-manifest
    title: Pod yaml has correct name and image
    cascade: true
    ```

Run the script `check-core-concepts` to verify your solutions.

```terminal:execute
command: check-core-concepts
```

## Cleanup

Before proceeding to the next section, delete the pods you created in this section:

```terminal:execute
command: k delete pod --all
```

## Solutions

1. Create a Pod named `nginx`, with container using the image `bitnami/nginx`.

    ```bash
    k run nginx --image=bitnami/nginx
    ```

1. Create a pod named `hello` with image `bitnami/kubectl` and command `echo "Hello World"`. Make sure the pod does not restart automatically.

    ```bash
    k run hello --image=bitnami/kubectl --restart=Never --command -- echo "Hello World"
    ```

1. Generate a pod manifest file `mypodx.yaml` (in your current working directory). Pod name should be `mypodx` with image `redis`. Make sure you only generate the pod manifest file, you do not have to create the pod.

    ```bash
    k run mypodx --image=redis --dry-run=client -oyaml > mypodx.yaml
    ```
