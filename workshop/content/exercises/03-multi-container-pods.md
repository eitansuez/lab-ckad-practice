
1. Create a pod `mp-hello` with three containers, each with image `bitnami/nginx`, `bitnami/kubectl` and `bitnami/consul`, respectively. Use the command `sleep infinity` for the alpine container.

    ```examiner:execute-test
    name: mc-pod
    title: Initialize
    autostart: true
    ```

## Cleanup

Before proceeding to the next section, delete the config maps, secrets, pods, and service accounts you created in this section:

```terminal:execute
command: k delete pod --all
```

## Solution

1. Create a pod `mp-hello` with three containers, each with image `bitnami/nginx`, `bitnami/kubectl` and `bitnami/consul`, respectively. Use the command `sleep infinity` for the alpine container.

    1. Consider first producing the Pod yaml for a single container:

        ```bash
        k run mp-hello --image=bitnami/nginx $DR > mp-hello.yaml
        ```

    1. Next, edit the yaml file and append the remaining two container specifications.

        ```yaml
        ---
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            run: mp-hello
          name: mp-hello
        spec:
          containers:
          - name: nginx
            image: bitnami/nginx
          - name: shell
            image: bitnami/kubectl
            args:
            - sleep
            - infinity
          - name: consul
            image: bitnami/consul
        ```
