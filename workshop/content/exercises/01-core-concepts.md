
1. Create a Pod named `nginx`. Use `nginx` image.

    ```examiner:execute-test
    name: make-pod
    title: Pod nginx exists.
    ```

1. Create a pod named `hello` with image `busybox` and command `echo "Hello World"`. Make sure the pod does not restart automatically.

    ```examiner:execute-test
    name: hello-world-pod
    title: Pod emits greeting.
    ```

1. Generate a pod manifest file `mypodx.yaml` (in your current working directory). Pod name should be `mypodx` with image `redis`. Make sure you only generate the pod manifest file, you do not have to create the pod.

    ```examiner:execute-test
    name: redis-pod-manifest
    title: Pod emits greeting.
    ```
