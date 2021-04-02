
## Under construction

1. Create a Pod named `myredis` with the image `bitnami/redis`. Define a liveness probe and readiness probe with an initial delay of 5 seconds and the command `redis-cli PING`.

    ```examiner:execute-test
    name: readiness-liveness-pod
    title: Is Pod configured with readiness and liveness probes?
    autostart: true
    cascade: true
    ```

1. Create a Pod named `httptest` with image [`mccutchen/go-httpbin`](https://github.com/mccutchen/go-httpbin) and a readiness probe that checks the http endpoint of the container at path `/status/200` on port `8080`.

    ```examiner:execute-test
    name: httpbin-readiness-probe
    title: Is Pod ready?
    cascade: true
    ```

1. Create a Pod named `myenv` that runs the command `sh -c "printenv && sleep 1h"`. Use the image `bitnami/kubectl`.
Then: Save the logs of the pod to `myenv.log` file.
Then: Delete the pod.

1. A pod named tatooine has been created. It appears to be crashing. Fix it. The pod should be in running state. Recreate the pods if necessary.

1. A pod specification file is `coruscant.yaml`. We tried to create a pod using it, but it didn't work. Fix the spec file and create a pod using the spec file.

## Solution

1. Create a Pod named `myredis` with the image `redis`. Define a liveness probe and readiness probe with an initial delay of 5 seconds and the command `redis-cli PING`.

    1. Create a base pod manifest:

        ```bash
        k run myredis --image=bitnami/redis --env="REDIS_PASSWORD=test" $DR > myredis.yaml
        ```

    1. Visit [configuring liveness, readiness](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/) and grab a livenessProbe stanza to copy in as a starting point.

    1. The `readinessProbe` stanza is identify with the exception of the base field name.

    1. Your resulting pod yaml specification should resemble this:

        ```yaml
        ---
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            run: myredis
          name: myredis
        spec:
          containers:
          - name: myredis
            image: bitnami/redis
            env:
            - name: REDIS_PASSWORD
              value: test
            livenessProbe:
              exec:
                command:
                - redis-cli
                - PING
              initialDelaySeconds: 5
            readinessProbe:
              exec:
                command:
                - redis-cli
                - PING
              initialDelaySeconds: 5
        ```

1. Create a Pod named `httptest` with image [`mccutchen/go-httpbin`](https://github.com/mccutchen/go-httpbin) and a readiness probe that checks the http endpoint of the container at path `/status/200` on port `8080`.

    1. Begin by creating the pod yaml:

        ```bash
        k run httptest --image=mccutchen/go-httpbin $DR > httpbin.yml
        ```

    1. Edit the yaml to add the [readiness http probe](https://kubernetes.io/docs/tasks/configure-pod-container/configure-liveness-readiness-startup-probes/#http-probes), optionally adding an initial delay of a few seconds.

    1. The final yaml should resemble the following:

        ```yaml
        ---
        apiVersion: v1
        kind: Pod
        metadata:
          labels:
            run: httptest
          name: httptest
        spec:
          containers:
          - name: httptest
            image: mccutchen/go-httpbin
            readinessProbe:
              httpGet:
                path: /status/200
                port: 8080
              initialDelaySeconds: 5
        ```
