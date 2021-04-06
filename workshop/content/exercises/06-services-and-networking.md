
## Under construction

1. Create a pod named `ig-11` with image `bitnami/nginx` and specifying the container port 8080.

    ```examiner:execute-test
    name: svc-pod-ig11
    title: Pod ig-11 running, specifies container port 8080?
    autostart: true
    cascade: true
    ```

1. Create a Cluster IP service for pod `ig-11` named `greet`. Map service port 8080 to container port 8080.

    ```examiner:execute-test
    name: svc-clusterip-greet
    title: ClusterIP service exposes pod ig-11 on port 8080?
    cascade: true
    ```

1. Setup:

    Apply the deployment named `cara`:

    ```terminal:execute
    command: k deploy -f services-and-networking/cara.yaml
    ```

    _Your Task_:

    Expose the deployment (which is running on port 8080) using a NodePort type service named `cara` using the service port 31888.

    ```examiner:execute-test
    name: svc-cara-nodeport
    title: Is deployment exposed via NodePort on port 31888?
    cascade: true
    ```

1. Setup:

    Apply the pod `geonosis` and accompanying ClusterIP service:

    ```terminal:execute
    command: k apply -f services-and-networking/geonosis-*.yaml
    ```

    _Your Task_:

    Create a network policy `geonosis-shield` which allows only pods with the label `empire=true` to access the service. Use appropriate labels.

    ```examiner:execute-test
    name: svc-geonosis-netpol
    title: Is network policy in place for the geonosis service?
    cascade: true
    ```

## Check

Run the script `check-services-and-networking` to verify your solutions.

```terminal:execute
command: check-services-and-networking
```

## Cleanup

Before proceeding to the next section, please delete the deployments, pods, services you created in this section:

```terminal:execute
command: k delete deploy,pod,svc --all
```

## Solutions

1. Create a pod named `ig-11` with image `bitnami/nginx` and expose port 8080.

    ```bash
    k run ig-11 --image=bitnami/nginx --port=8080
    ```

1. Create a Cluster IP service for pod `ig-11` named `greet`. Map service port 8080 to container port 8080.

    ```bash
    k expose pod ig-11 --port=8080 --target-port=8080 --name=greet
    ```

1. Deployment `cara` is created. Expose port 80 of the deployment using NodePort on port 31888. Name the service `cara`.

1. Pod and Service `geonosis` are created for you. Create a network policy `geonosis-shield` which allows only pods with the label `empire=true` to access the service. Use appropriate labels.

    1. Review the documentation on the subject of [Network Policies](https://kubernetes.io/docs/concepts/services-networking/network-policies/);

    1. Draft a network policy spec (in a file named, say, `netpol.yaml`), as follows:

        ```yaml
        ---
        apiVersion: networking.k8s.io/v1
        kind: NetworkPolicy
        metadata:
          name: geonosis-shield
        spec:
          podSelector:
            matchLabels:
              sector: arkanis
        ingress:
        - from:
          - podSelector:
              matchLabels:
                empire: "true"
        ```

    1. Apply the network policy (`k apply -f netpol.yaml`)
