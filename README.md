# k8s-ceph

## how to add fio job files, etc

1, Add/modify files under `jobfiles/` directory.

2, Increase k8s job YAML file image spec's tag, for example `v1 -> v2`.

3, Git commit, and tag it.

```
git ci -m 'your commit message'
git tag -m 'v<n>' v<n>
git push
git push --tags
```

4, Wait for `https://hub.docker.com/r/cofyc/k8s-fio/` to build `v<n>` image.

## how to run

```
kubectl apply -f fio-job.yml
```

## how to retrieve fio outputs

```
kubectl logs -l app=k8s-fio
```

## how to clean

```
kubectl delete -f fio-job.yml
kubectl delete pv -l app=k8s-fio
```
