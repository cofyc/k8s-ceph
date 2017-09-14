# k8s-ceph

## How to add job files

1, Add/modify files under `jobfiles/` directory.

2, Increase k8s job YAML file image spec's tag, for example `v1 -> v2`.

3, Git commit, and tag it.

```
git ci -m 'your commit message'
git tag -m 'v<n>' v<n>
git push
git push --tags
```

## How to run job

Create persistent volume first,

```
kubectl apply -f pvc.yml
```

Run a job:

```
kubectl apply -f fio-readwrite.yml
```

## How to retrieve fio outputs

```
kubectl logs -l app=k8s-fio --tail=10000
```

## How to clean

### Clean k8s job resources

```
kubectl delete jobs -l app=k8s-fio
```

### Clean k8s persistent volume claims

```
kubectl delete pvc -l app=k8s-fio
```

### Clean k8s persistent volumes

For ceph, please remove images from ceph cluster, then run these commands:

```
kubectl delete pv $(kubectl get pv -ocustom-columns=NAME:{.metadata.name},CLAIM:{.spec.claimRef.name} --no-headers | awk '$2 == "fio-readwrite-pvc" { print $1 }')
kubectl delete pv $(kubectl get pv -ocustom-columns=NAME:{.metadata.name},CLAIM:{.spec.claimRef.name} --no-headers | awk '$2 == "fio-readonly-pvc" { print $1 }')
```
