gogetx: a patch of "go get" to support tag & branch
===================================================

gogetx is a patch of "go get" to support checking out repositories to
specified branches or tags. (upgraded to go1.8.1)

Quick Start
-----------

### Get "gogetx"

```bash
go get -u -d h12.me/gogetx
go generate h12.me/gogetx
go build h12.me/gogetx
```

### Write gogetx-config.yml

```yaml
-
    path: your_org/.*
    tags:
        - v1.2
        - develop
        - master
-
    path: .*
    tags:
        - master
```

* For your_org/abc with tag `v1.2` defined, it will be checked out to
tag `v1.2`.
* For your_org/def without tag v1.2 but with branch `develop`, it will be checked out
to branch `develop`.
* For your_org/xyz without tag v1.2 or branch `develop`, it will be checked out to
`master`.
* Any other repositories will be checked out to `master`.

### Run gogetx

Put `gogetx-config.yml` under the current directory and run:

```bash
gogetx your_repo
```
