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

### create persistent volume to test

```
kubectl 
```

### run jobs

```
kubectl apply -f fio-readwrite.yml
```

## how to retrieve fio outputs

```
kubectl logs -l app=k8s-fio --tail=10000
```

## how to clean

### clean jobs

```
kubectl delete jobs -l app=k8s-fio
```

### clean persistent volumes

```
kubectl delete pvc -l app=k8s-fio
kubectl delete pv $(kubectl get pv -ocustom-columns=NAME:{.metadata.name},CLAIM:{.spec.claimRef.name} --no-headers | awk '$2 == "fio-readwrite-pvc" { print $1 }')
kubectl delete pv $(kubectl get pv -ocustom-columns=NAME:{.metadata.name},CLAIM:{.spec.claimRef.name} --no-headers | awk '$2 == "fio-readonly-pvc" { print $1 }')
```
