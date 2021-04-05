
## Under construction

1. Create a pod named `vader` with image `alpine/nginx`. Mount a volume named `vader-vol` at `/var/www/html`, which should live as long as pod lives.

1. We created a persistent volume `maul-pv` and a persistent volume claim `maul-pvc`. But our PVC is not binding to the PV. Fix the issue. You may need to delete and recreate the PVC.

1. Create a persistent volume named `sidious-pv` of size `200Mi` at `/data/mysql` on host. Use manual storageClassName and ReadWriteOnce access mode.

    Then: Create a persistent volume claim `sidious-pvc` and consume the PV `sidious-pv`.

    Then: Create a pod `sidious` with image `alpine/mysql` and mount the PVC at `/var/lib/mysql` using volume name `sidious-vol`. Also, set the environment variable `MYSQL_ROOT_PASSWORD=my-secret-pw`.

1. Create a pod `dooku` with two containers using the images `alpine/redis` and `alpine/nginx`. Create a shared `hostPath` volume at `/data/dooku` named `dooku-logs` mounted at `/var/log/dooku` in both containers.
