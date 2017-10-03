{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
*/}}
{{- define "fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "configServerBootstrap" }}
{{- if .Values.global.useConfigServerBootstrap }}
        configMap:
          name: {{ .Release.Name }}-spring-config-server-bootstrap
{{- else }}
        configMap:
          name: {{ .Release.Name }}-{{ .Chart.Name }}
{{ end }}
{{ end -}}
