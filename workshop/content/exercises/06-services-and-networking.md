
## Under construction

1. Create a pod named `ig-11` with image `bitnami/nginx` and specifying the container port 8080.

    ```examiner:execute-test
    name: make-pod-ig11
    title: Pod ig-11 running, specifies container port 8080?
    autostart: true
    cascade: true
    ```

1. Create a Cluster IP service for pod `ig-11` named `greet`. Map service port 8080 to container port 8080.

    ```examiner:execute-test
    name: make-clusterip-greet
    title: ClusterIP service exposes pod ig-11 on port 8080?
    cascade: true
    ```

1. Deployment `cara` is created. Expose port 80 of the deployment using NodePort on port 31888. Name the service `cara`.

1. Pod and Service `geonosis` is created for you. Create a network policy `geonosis-shield` which allows only pods with label `empire=true` to access the service. Use appropriate labels.

## Cleanup

Before proceeding to the next section, please delete the deployments servics you created in this section:

```terminal:execute
command: k delete deploy,svc --all
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

1. Pod and Service `geonosis` is created for you. Create a network policy `geonosis-shield` which allows only pods with label `empire=true` to access the service. Use appropriate labels.
