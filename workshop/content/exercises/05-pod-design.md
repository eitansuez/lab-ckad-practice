
## Under construction

1. Create a deployment named `hoth` with image `httpd`. Scale the deployment to 4 replicas. Update the deployment to use `httpd:2.4.46` image.

1. Deployment `yavin` is deployed but after an upgrade, new pods are not getting created. Rollback the deployment `yavin` so the pods are working again.

    Then: Export `yavin` deployment spec in JSON to the file `yavin.json`.

1. Deployment `naboo` is created. Make sure the replicas autoscale with minimum 2 and maximum 5 when at 80% CPU. Use `naboo` as the name of HPA resource.

1. Create a Cron job `bespin` that runs every 5 minutes (`*/5 * * * *`) and runs the command `date`. Use the alpine image.
