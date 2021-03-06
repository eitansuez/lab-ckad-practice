
1. Create a pod `mp-hello` with three containers, each with image `bitnami/nginx`, `bitnami/kubectl` and `bitnami/consul`, respectively. Name the container running the kubectl image `shell`.  Make the shell container run the shell command `sleep infinity`.

    ```examiner:execute-test
    name: mc-pod
    title: Pod runs three containers?
    autostart: true
    ```

## Check

Run the script `check-multi-container-pods` to verify your solutions.

```terminal:execute
command: check-multi-container-pods
```

## Cleanup

Before proceeding to the next section, delete the config maps, secrets, pods, and service accounts you created in this section:

```terminal:execute
command: k delete pod --all
```

<div style="margin-top: 5em;"></div>

```section:begin
title: Solutions
```

1. Create a pod `mp-hello` with three containers, each with image `bitnami/nginx`, `bitnami/kubectl` and `bitnami/consul`, respectively. Name the container running the kubectl image `shell`.  Make the _shell_ container run the shell command `sleep infinity`.

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
            command: ["/bin/sh"]
            args: ["-c", "sleep infinity"]
          - name: consul
            image: bitnami/consul
        ```

    1. Finally, apply the yaml.

        ```bash
        k apply -f mp-hello.yaml
        ```

    See [running a command in a shell](https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#run-a-command-in-a-shell).

```section:end
```
