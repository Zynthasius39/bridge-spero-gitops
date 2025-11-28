{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "brsp.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "brsp.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "brsp.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/* Ingress service name */}}
{{- define "brsp.service.name" -}}
{{ .root.Release.Name }}-{{ .path.service.app }}{{ if .path.service.environment}}-{{ .path.service.environment }}{{ end }}
{{- end -}}

{{/* Environment */}}
{{- define "brsp.environment" -}}
{{ if eq . "dev" }}dev{{ else }}bluegreen{{ end }}
{{- end -}}


{{/* Redis */}}

{{- define "redis.statefulSet.name" -}}
{{- if .Values.redis.statefulSet -}}
{{ .Values.redis.statefulSet.name | default "redis-node" }}
{{- else -}}
redis-node
{{- end -}}
{{- end -}}

{{- define "redis.port" -}}
{{ .Values.redis.port | default "6379" }}
{{- end -}}

{{- define "redis.sentinelPort" -}}
{{ .Values.redis.sentinelPort | default "26379" }}
{{- end -}}

{{- define "redis.service.name" -}}
{{ ((.Values.redis).service).name | default "redis" }}
{{- end -}}

{{- define "redis.serviceHeadless.name" -}}
{{ ((.Values.redis).serviceHeadless).name | default "redis-headless" }}
{{- end -}}

{{- define "redis.startupProbe.timeoutSeconds" -}}
{{ ((.Values.redis).startupProbe).timeoutSeconds | default ((.Values.redis).livenessProbe).timeoutSeconds | default "5" }}
{{- end -}}

{{- define "redis.livenessProbe.timeoutSeconds" -}}
{{ ((.Values.redis).livenessProbe).timeoutSeconds | default "5" }}
{{- end -}}

{{- define "redis.readinessProbe.timeoutSeconds" -}}
{{ ((.Values.redis).readinessProbe).timeoutSeconds | default "1" }}
{{- end -}}


{{/* Postgres */}}

{{- define "postgres.storage.storageClass" -}}
{{- if ((.Values.postgres).storage).storageClass -}}
{{ ((.Values.postgres).storage).storageClass }}
{{- else if (.Values.global).storageClass -}}
{{ (.Values.global).storageClass }}
{{- end -}}
{{- end -}}
