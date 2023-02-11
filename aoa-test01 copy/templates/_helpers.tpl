{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "argocd.xxx-yyy.enabled" -}}
{{- index .Values "global" "argocd" "xxx-yyy" "enabled" -}}
{{- end -}}





{{- define "argocd.application" }}
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: {{ .Values.global.env }}-fluent
  namespace: argocd
  finalizers:
    - resources-finalizer.argocd.argoproj.io
  annotations:
    argocd.argoproj.io/sync-wave: "1"
spec:
  destination:
    server: {{ .Values.global.argocd.destination.server }}
    namespace: {{ .Values.global.argocd.fluent.namespace }}
  project: {{ .Values.global.argocd.project }}
  source:
    repoURL: {{ .Values.global.argocd.fluent.git.repo }}
    targetRevision: {{ .Values.global.argocd.fluent.git.branch }}
    path: {{ .Values.global.argocd.fluent.git.path }}
    helm:
      releaseName: {{ .Values.global.argocd.fluent.releaseName }}
{{- end }}
