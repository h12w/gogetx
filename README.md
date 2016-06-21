gogetx: a fork of "go get" that supports tag & branch
=====================================================

gogetx is a fork of "go get" that supports checking out repositories to
specified branches or tags.

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

Examples:

* For your_org/abc with tag `v1.2` defined, it will be checkout to
tag `v1.2`.
* For your_org/xyz without tag v1.2 but with branch `develop`, it will be checkout
to branch `develop`.

### Run gogetx

Put `gogetx-config.yml` under the current directory and run:

```bash
gogetx your_repo
```
