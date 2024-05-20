# matrix-authentication-service

![Version: 0.0.2](https://img.shields.io/badge/Version-0.0.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.9.0](https://img.shields.io/badge/AppVersion-0.9.0-informational?style=flat-square)

A Helm chart for deploying the matrix authentication service on Kubernetes

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| jessebot |  | <https://github.com/jessebot> |

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| oci://registry-1.docker.io/bitnamicharts | postgresql | 15.3.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `100` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| externalDatabase.database | string | `"mas"` | name of the database to try and connect to |
| externalDatabase.enabled | bool | `false` | enable using an external database *instead of* the Bitnami PostgreSQL sub-chart if externalDatabase.enabled is set to true, postgresql.enabled must be set to false |
| externalDatabase.existingSecret | string | `""` | Name of existing secret to use for PostgreSQL credentials |
| externalDatabase.hostname | string | `""` | hostname of db server. Can be left blank if using postgres subchart |
| externalDatabase.password | string | `"changeme"` | password of matrix-authentication-service postgres user - ignored using exsitingSecret |
| externalDatabase.port | int | `5432` | which port to use to connect to your database server |
| externalDatabase.secretKeys.adminPasswordKey | string | `"postgresPassword"` | key in existingSecret with the admin postgresql password |
| externalDatabase.secretKeys.database | string | `"database"` | key in existingSecret with name of the database |
| externalDatabase.secretKeys.databaseHostname | string | `"hostname"` | key in existingSecret with hostname of the database |
| externalDatabase.secretKeys.databaseUsername | string | `"username"` | key in existingSecret with username for matrix to connect to db |
| externalDatabase.secretKeys.userPasswordKey | string | `"password"` | key in existingSecret with password for matrix to connect to db |
| externalDatabase.sslcert | string | `""` | optional: tls/ssl cert for postgresql connections |
| externalDatabase.sslkey | string | `""` | optional: tls/ssl key for postgresql connections |
| externalDatabase.sslmode | string | `""` | sslmode to use, example: verify-full |
| externalDatabase.sslrootcert | string | `""` | optional: tls/ssl root cert for postgresql connections |
| externalDatabase.username | string | `"mas"` | username of matrix-authentication-service postgres user |
| fullnameOverride | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` | image pull policy. if image.tag is set to "latest", set to "Always" |
| image.repository | string | `"ghcr.io/matrix-org/matrix-authentication-service"` |  |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.tls | list | `[]` |  |
| livenessProbe.enabled | bool | `false` | enable a liveness probe on the deployment |
| livenessProbe.httpGet.path | string | `"/"` |  |
| livenessProbe.httpGet.port | string | `"http"` |  |
| mas.matrix.endpoint | string | `"https://localhost:8008"` | endpoint of your matrix home server (synapse or dendrite) with port if needed |
| mas.matrix.existingSecret | string | `""` | grab the above secret from an existing k8s secret. if set, ignores mas.matrix.secret |
| mas.matrix.homeserver | string | `"localhost:8008"` | name of your matrix home server (synapse or dendrite) with port if needed |
| mas.matrix.secret | string | `"test"` | i don't know what this is |
| mas.matrix.secretKey | string | `"secret"` | name of the key in existing secret to grab matrix.secret from |
| mas.policy.data.admin_clients | list | `[]` | Client IDs which are allowed to ask for admin access with a client_credentials grant |
| mas.policy.data.admin_users | list | `[]` | Users which are allowed to ask for admin access. If possible, use the can_request_admin flag on users instead. |
| mas.policy.data.client_registration.allow_host_mismatch | bool | `true` | don't require URIs to be on the same host. default: false |
| mas.policy.data.client_registration.allow_insecure_uris | bool | `true` | allow non-SSL and localhost URIs. default: false |
| mas.policy.data.passwords.min_length | int | `16` | minimum length of a password. default: 0 |
| mas.policy.data.passwords.require_lowercase | bool | `true` | require at least one lowercase character in a password. default: false |
| mas.policy.data.passwords.require_number | bool | `true` | require at least one number in a password. default: false |
| mas.policy.data.passwords.require_uppercase | bool | `true` | require at least one uppercase character in a password. default: false |
| mas.upstream_oauth2.existingSecret | string | `""` | use an existing k8s secret for upstream oauth2 client_id and client_secret |
| mas.upstream_oauth2.providers[0].authorization_endpoint | string | `"https://example.com/oauth2/authorize"` |  |
| mas.upstream_oauth2.providers[0].brand_name | string | `"zitadel"` |  |
| mas.upstream_oauth2.providers[0].claims_imports.displayname.template | string | `"{{ user.name }}"` |  |
| mas.upstream_oauth2.providers[0].claims_imports.email.set_email_verification | string | `"import"` |  |
| mas.upstream_oauth2.providers[0].claims_imports.email.template | string | `"{{ user.email }}"` |  |
| mas.upstream_oauth2.providers[0].claims_imports.localpart.template | string | `"{{ user.preferred_username }}"` |  |
| mas.upstream_oauth2.providers[0].claims_imports.subject.template | string | `"{{ user.sub }}"` |  |
| mas.upstream_oauth2.providers[0].client_id | string | `""` |  |
| mas.upstream_oauth2.providers[0].client_secret | string | `""` |  |
| mas.upstream_oauth2.providers[0].discovery_mode | string | `"oidc"` |  |
| mas.upstream_oauth2.providers[0].human_name | string | `"Example"` |  |
| mas.upstream_oauth2.providers[0].id | string | `""` |  |
| mas.upstream_oauth2.providers[0].issuer | string | `"https://example.com/"` |  |
| mas.upstream_oauth2.providers[0].jwks_uri | string | `"https://example.com/oauth2/keys"` |  |
| mas.upstream_oauth2.providers[0].pkce_method | string | `"auto"` |  |
| mas.upstream_oauth2.providers[0].scope | string | `"openid email profile"` |  |
| mas.upstream_oauth2.providers[0].token_endpoint | string | `"https://example.com/oauth2/token"` |  |
| mas.upstream_oauth2.providers[0].token_endpoint_auth_method | string | `"client_secret_post"` |  |
| mas.upstream_oauth2.secretKeys.client_id | string | `"client_id"` | secret key to use in existing k8s secret for oauth2 client_id |
| mas.upstream_oauth2.secretKeys.client_secret | string | `"client_secret"` | secret key to use in existing k8s secret for oauth2 client_secret |
| nameOverride | string | `""` |  |
| networkPolicies.enabled | bool | `true` |  |
| nodeSelector | object | `{}` |  |
| podAnnotations | object | `{}` |  |
| podLabels | object | `{}` |  |
| podSecurityContext | object | `{}` |  |
| postgresql.enabled | bool | `true` | Whether to deploy the Bitnami Postgresql sub chart If postgresql.enabled is set to true, externalDatabase.enabled must be set to false else if externalDatabase.enabled is set to true, postgresql.enabled must be set to false |
| postgresql.global.postgresql.auth.database | string | `"mas"` | name of the database |
| postgresql.global.postgresql.auth.existingSecret | string | `""` | Name of existing secret to use for PostgreSQL credentials |
| postgresql.global.postgresql.auth.password | string | `"changeme"` | password of matrix-authentication-service postgres user - ignored using exsitingSecret |
| postgresql.global.postgresql.auth.port | int | `5432` | which port to use to connect to your database server |
| postgresql.global.postgresql.auth.secretKeys.adminPasswordKey | string | `"postgresPassword"` | key in existingSecret with the admin postgresql password |
| postgresql.global.postgresql.auth.secretKeys.database | string | `"database"` | key in existingSecret with name of the database |
| postgresql.global.postgresql.auth.secretKeys.databaseHostname | string | `"hostname"` | key in existingSecret with hostname of the database |
| postgresql.global.postgresql.auth.secretKeys.databaseUsername | string | `"username"` | key in existingSecret with username for matrix-authentication-service to connect to db |
| postgresql.global.postgresql.auth.secretKeys.userPasswordKey | string | `"password"` | key in existingSecret with password for matrix-authentication-service to connect to db |
| postgresql.global.postgresql.auth.username | string | `"mas"` | username of matrix-authentication-service postgres user |
| postgresql.primary.initdb | object | `{"scriptsConfigMap":"{{ .Release.Name }}-postgresql-initdb"}` | run the scripts in templates/postgresql/initdb-configmap.yaml If using an external Postgres server, make sure to configure the database ref: https://github.com/matrix-org/synapse/blob/master/docs/postgres.md |
| postgresql.primary.podSecurityContext.enabled | bool | `true` |  |
| postgresql.primary.podSecurityContext.fsGroup | int | `1000` |  |
| postgresql.primary.podSecurityContext.runAsUser | int | `1000` |  |
| postgresql.tls.autoGenerated | bool | `false` | Generate automatically self-signed TLS certificates |
| postgresql.tls.certCAFilename | string | `""` | CA Certificate filename |
| postgresql.tls.certFilename | string | `""` | Certificate filename |
| postgresql.tls.certKeyFilename | string | `""` | Certificate key filename |
| postgresql.tls.certificatesSecret | string | `""` | Name of an existing secret that contains the certificates |
| postgresql.tls.crlFilename | string | `""` | File containing a Certificate Revocation List |
| postgresql.tls.enabled | bool | `false` | Enable TLS traffic support for postgresql, see [bitnami/charts/postgresql#securing-traffic-using-tls](https://github.com/bitnami/charts/tree/main/bitnami/postgresql#securing-traffic-using-tls) |
| postgresql.tls.preferServerCiphers | bool | `true` | Whether to use the server's TLS cipher preferences rather than the client's |
| postgresql.volumePermissions.enabled | bool | `true` | Enable init container that changes the owner and group of the PVC |
| readinessProbe.enabled | bool | `false` | enable a readiness probe on the deployment |
| readinessProbe.httpGet.path | string | `"/"` |  |
| readinessProbe.httpGet.port | string | `"http"` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext | object | `{}` |  |
| service.annotations | object | `{}` | annotations for your service |
| service.port | int | `80` | Port of service |
| service.targetPort | int | `8080` | targetPort of service. should be the same as port for bindaddr |
| service.type | string | `"ClusterIP"` | type of service |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.automount | bool | `true` | Automatically mount a ServiceAccount's API credentials? |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.13.1](https://github.com/norwoodj/helm-docs/releases/v1.13.1)
