## Matrix Authentication Service Helm chart
<a href="https://github.com/small-hack/matrix-authentication-service-chart/releases"><img src="https://img.shields.io/github/v/release/small-hack/matrix-authentication-service-chart?style=plastic&labelColor=blue&color=green&logo=GitHub&logoColor=white"></a>

A helm chart for deploying the [matrix-authentication-service](https://github.com/matrix-org/matrix-authentication-service) on Kubernetes.

## TLDR

Read through the [parameters](./charts/matrix-authentication-service-chart/README.md) and modify them locally before installing the chart:

```bash
# add the helm repo locally
helm repo add matrix-authentication-service https://small-hack.github.io/matrix-authentication-service-chart

# downloads the values.yaml locally
helm show values matrix-authentication-service/matrix-authentication-service > values.yaml

# install the chart
helm install my-release-name matrix-authentication-service/matrix-authentication-service --values values.yaml
```

## Notes
You can find the official docs for the Matrix Authentication Service at [matrix-org.github.io/matrix-authentication-service](https://matrix-org.github.io/matrix-authentication-service/index.html) for now, but this is expected to change to [element-hq.github.io/matrix-authentication-service](https://element-hq.github.io/matrix-authentication-service/index.html) in the near future.


### Database

By default, no database is enabled. To enable the built-in Bitnami hosted postgresql sub chart, use:

```yaml
postgresql:
  enabled: true
```

To enable using an external database instead of the built-in sub chart, use:

```yaml
externalDatabase:
  enabled: true
```

**NOTE**: You can only use `externalDatabase.enabled=True` *OR* `postgresql.enabled=True`. You cannot use both. You must pick one. If you're still using Bitnami postgresql, but not the one that is bundled as a subchart to this one, you want to use the `externalDatabase` section.

## Status
This chart was developed for use with the [small-hack/matrix-chart](https://github.com/small-hack/matrix-chart). We're still testing this chart. Feel free to open PRs and Issues if you see anything broken or want a feature.
