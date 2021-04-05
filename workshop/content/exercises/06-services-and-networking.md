
## Under construction

1. Create a pod named `ig-11` with image `alpine/nginx` and expose port 8080.

1. Create a Cluster IP service for pod `ig-11` named `greet`. Map service port 8080 to container port 8080.

1. Deployment `cara` is created. Expose port 80 of the deployment using NodePort on port 31888. Name the service `cara`.

1. Pod and Service `geonosis` is created for you. Create a network policy `geonosis-shield` which allows only pods with label `empire=true` to access the service. Use appropriate labels.
