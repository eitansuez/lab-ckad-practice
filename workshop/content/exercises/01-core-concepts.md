
1. Execute a dry-run command to create, in yaml format, the resource definition for a namespace named `frontend`.  Write the yaml output to the file `my-namespace.yaml`.

    ```examiner:execute-test
    name: core-ns-spec
    title: Manifest for namespace created
    cascade: true
    autostart: true
    ```

1. Create a Pod named `nginx` in the namespace `{{session_namespace}}-apps`, using the image `bitnami/nginx`.

    ```examiner:execute-test
    name: core-make-pod
    title: Pod nginx exists
    cascade: true
    ```

1. Create a pod named `hello` with image `bitnami/kubectl` and command `echo "Hello World"`. Make sure the pod does not restart automatically.

    ```examiner:execute-test
    name: core-hello-world-pod
    title: Pod emits greeting
    cascade: true
    ```

1. Generate a pod manifest file `mypodx.yaml` (in your current working directory). Pod name should be `mypodx` with image `redis`. Make sure you only generate the pod manifest file, you do not have to create the pod.

    ```examiner:execute-test
    name: core-redis-pod-manifest
    title: Pod yaml has correct name and image
    cascade: true
    ```

## Check

Run the script `check-core-concepts` to verify your solutions.

```terminal:execute
command: check-core-concepts
```

## Cleanup

Before proceeding to the next section, delete the pods you created in this section:

```terminal:execute
command: k delete pod --all
```

..and the one created in the separate namespace:

```terminal:execute
command: k delete pod --all --namespace {{session_namespace}}-apps
```

<div style="margin-top: 5em;"></div>

```section:begin
title: Solutions
```

1. Execute a dry-run command to create, in yaml format, the resource definition for a namespace named `frontend`.  Write the yaml output to the file `my-namespace.yaml`.

    ```bash
    k create ns frontend --dry-run=client -o yaml > my-namespace.yaml
    ```

    Alternatively, use the `DR` environment variable as a shorthand:

    ```bash
    k create ns frontend $DR > my-namespace.yaml
    ```

1. Create a Pod named `nginx` in the namespace `{{session_namespace}}-apps`, using the image `bitnami/nginx`.

    ```bash
    k run nginx --image=bitnami/nginx -n {{session_namespace}}-apps
    ```

    Hint:  Use the `-w` flag to see the pod status progress to running state:

    ```bash
    k get pod -n {{session_namespace}}-apps -w
    ```

1. Create a pod named `hello` with image `bitnami/kubectl` and command `echo "Hello World"`. Make sure the pod does not restart automatically.

    ```bash
    k run hello --image=bitnami/kubectl --restart=Never --command -- echo "Hello World"
    ```

1. Generate a pod manifest file `mypodx.yaml` (in your current working directory). Pod name should be `mypodx` with image `redis`. Make sure you only generate the pod manifest file, you do not have to create the pod.

    ```bash
    k run mypodx --image=redis --dry-run=client -oyaml > mypodx.yaml
    ```

```section:end
```
