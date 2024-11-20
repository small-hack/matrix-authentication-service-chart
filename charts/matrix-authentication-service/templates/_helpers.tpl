{{/*
Expand the name of the chart.
*/}}
{{- define "matrix-authentication-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "matrix-authentication-service.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a fully qualified PostgreSQL name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "matrix-authentication-service.postgresql.fullname" -}}
{{- if .Values.postgresql.fullnameOverride }}
{{- .Values.postgresql.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "postgresql" .Values.postgresql.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a fully qualified PostgreSQL name, if run within a tpl function inside of the postgresql subchart.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "postgresql.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default "postgresql" .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "matrix-authentication-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "matrix-authentication-service.labels" -}}
helm.sh/chart: {{ include "matrix-authentication-service.chart" . }}
{{ include "matrix-authentication-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "matrix-authentication-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "matrix-authentication-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "matrix-authentication-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "matrix-authentication-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Helper function to get postgres instance name
*/}}
{{- define "matrix-authentication-service.postgresql.hostname" -}}
{{- if .Values.postgresql.enabled -}}
{{ template "postgresql.v1.primary.fullname" .Subcharts.postgresql }}
{{- else -}}
{{- .Values.externalDatabase.hostname -}}
{{- end }}
{{- end }}

{{/*
Helper function to get the postgres secret containing the database credentials
*/}}
{{- define "matrix-authentication-service.postgresql.secretName" -}}
{{- if and .Values.postgresql.enabled .Values.postgresql.global.postgresql.auth.existingSecret -}}
{{ .Values.postgresql.global.postgresql.auth.existingSecret }}
{{- else if and .Values.externalDatabase.enabled .Values.externalDatabase.existingSecret -}}
{{ .Values.externalDatabase.existingSecret }}
{{- else -}}
{{ template "matrix-authentication-service.fullname" . }}-db-secret
{{- end }}
{{- end }}

{{/*
Helper function to get postgres hostname secret key
*/}}
{{- define "matrix-authentication-service.postgresql.secretKeys.hostname" -}}
{{- if and .Values.postgresql.enabled .Values.postgresql.global.postgresql.auth.existingSecret -}}
{{- .Values.postgresql.global.postgresql.auth.secretKeys.databaseHostname -}}
{{- else if and .Values.externalDatabase.enabled .Values.externalDatabase.existingSecret -}}
{{- .Values.externalDatabase.secretKeys.databaseHostname -}}
{{- else -}}
{{- printf "hostname" }}
{{- end }}
{{- end }}

{{/*
Helper function to get postgres port secret key
*/}}
{{- define "matrix-authentication-service.postgresql.port" -}}
{{- if .Values.postgresql.enabled -}}
{{- .Values.postgresql.global.postgresql.auth.port -}}
{{- else if .Values.externalDatabase.enabled -}}
{{- .Values.externalDatabase.port -}}
{{- end }}
{{- end }}

{{/*
Helper function to get postgres database secret key
*/}}
{{- define "matrix-authentication-service.postgresql.secretKeys.database" -}}
{{- if and .Values.postgresql.enabled .Values.postgresql.global.postgresql.auth.existingSecret -}}
{{- .Values.postgresql.global.postgresql.auth.secretKeys.database -}}
{{- else if and .Values.externalDatabase.enabled .Values.externalDatabase.existingSecret -}}
{{- .Values.externalDatabase.secretKeys.database -}}
{{- else -}}
{{- printf "database" }}
{{- end }}
{{- end }}

{{/*
Helper function to get postgres user secret key
*/}}
{{- define "matrix-authentication-service.postgresql.secretKeys.user" -}}
{{- if and .Values.postgresql.enabled .Values.postgresql.global.postgresql.auth.existingSecret -}}
{{- .Values.postgresql.global.postgresql.auth.secretKeys.databaseUsername -}}
{{- else if and .Values.externalDatabase.enabled .Values.externalDatabase.existingSecret -}}
{{- .Values.externalDatabase.secretKeys.databaseUsername -}}
{{- else -}}
{{- printf "username" }}
{{- end }}
{{- end }}

{{/*
Helper function to get postgres password secret key
*/}}
{{- define "matrix-authentication-service.postgresql.secretKeys.password" -}}
{{- if and .Values.postgresql.enabled .Values.postgresql.global.postgresql.auth.existingSecret -}}
{{- .Values.postgresql.global.postgresql.auth.secretKeys.userPasswordKey -}}
{{- else if and .Values.externalDatabase.enabled .Values.externalDatabase.existingSecret -}}
{{- .Values.externalDatabase.secretKeys.userPasswordKey -}}
{{- else -}}
{{- printf "password" }}
{{- end }}
{{- end }}

{{/*
Helper function to get postgres ssl mode
*/}}
{{- define "matrix-authentication-service.postgresql.sslEnvVars" -}}
{{- if and .Values.externalDatabase.enabled .Values.externalDatabase.sslmode -}}
- name: PGSSLMODE
  value: {{ .Values.externalDatabase.sslmode }}
- name: PGSSLCERT
  value: {{ .Values.externalDatabase.sslcert }}
- name: PGSSLKEY
  value: {{ .Values.externalDatabase.sslkey }}
- name: PGSSLROOTCERT
  value: {{ .Values.externalDatabase.sslrootcert }}
{{- else -}}
- name: PGSSLMODE
  value: disable
{{- end }}
{{- end }}

{{/*
Helper function to get the matrix secret
*/}}
{{- define "matrix-authentication-service.matrix.secretName" -}}
{{- if .Values.mas.matrix.existingSecret -}}
{{ .Values.mas.matrix.existingSecret }}
{{- else -}}
{{ template "matrix-authentication-service.fullname" . }}-matrix-secret
{{- end }}
{{- end }}

{{- define "matrix-authentication-service.matrix.secretKey" -}}
{{- if .Values.mas.matrix.existingSecret -}}
{{ .Values.mas.matrix.secretKey }}
{{- else -}}
{{- printf "secret" }}
{{- end }}
{{- end }}
