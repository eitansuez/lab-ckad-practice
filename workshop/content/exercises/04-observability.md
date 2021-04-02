
## Under construction

1. Create a Pod named `myredis` with the image `redis`. Define a liveness probe and readiness probe with an initial delay of 5 seconds and the command `redis-cli PING`.

2. Create a Pod named `httptest` with image `kennethreitz/httpbin`. Define a readiness probe at path `/status/200` on port 80 of the container.

3. Create a Pod named `myenv` that runs the command `sh -c "printenv && sleep 1h"`. Use the image `bitnami/kubectl`.
Then: Save the logs of the pod to `myenv.log` file.
Then: Delete the pod.

4. A pod named tatooine has been created. It appears to be crashing. Fix it. The pod should be in running state. Recreate the pods if necessary.

5. A pod specification file is `coruscant.yaml`. We tried to create a pod using it, but it didn't work. Fix the spec file and create a pod using the spec file.

6. Find the name of the pod which is using most CPU across all namespaces. Enter the name of pod in the file `high-cpu.yaml`.
