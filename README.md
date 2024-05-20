## Matrix Authentication Service Helm chart
<a href="https://github.com/small-hack/matrix-authentication-service-chart/releases"><img src="https://img.shields.io/github/v/release/small-hack/matrix-authentication-service-chart?style=plastic&labelColor=blue&color=green&logo=GitHub&logoColor=white"></a>

A helm chart for deploying the [matrix-authentication-service](https://github.com/matrix-org/matrix-authentication-service) on Kubernetes.

## TLDR

Read through the parameters and modify them locally before installing the chart:

```bash
# add the helm repo locally
helm repo add matrix-authentication-service https://small-hack.github.io/matrix-authentication-service-chart

# downloads the values.yaml locally
helm show values matrix-authentication-service/matrix-authentication-service > values.yaml

# install the chart
helm install my-release-name matrix-authentication-service/matrix-authentication-service --values values.yaml
```


## Notes

Docs are currently here: https://matrix-org.github.io/matrix-authentication-service/setup/general.html

We're currently testing with [`0.9.0`](https://github.com/matrix-org/matrix-authentication-service/releases/tag/v0.9.0) however I want to note that this will be sourced from the element-hq in the future, as matrix-org will no longer be maintaining it.

I generated this config using:

```bash
docker run ghcr.io/matrix-org/matrix-authentication-service:main config generate > config.yaml
```
