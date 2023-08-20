{{/*
SPDX-License-Identifier: MIT
*/}}

{{/*
Return the proper node-local-dns image name
*/}}
{{- define "node-local-dns.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.image "global" .Values.global) }}

{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "node-local-dns.imagePullSecrets" -}}
{{- include "common.images.pullSecrets" (dict "images" (list .Values.image) "global" .Values.global) -}}
{{- end -}}

{{/*
Returns the proper service account name depending if an explicit service account name is set
in the values file. If the name is not set it will default to either common.names.fullname if serviceAccount.create
is true or default otherwise.
*/}}
{{- define "node-local-dns.serviceAccountName" -}}
    {{- if .Values.serviceAccount.create -}}
        {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
    {{- else -}}
        {{ default "default" .Values.serviceAccount.name }}
    {{- end -}}
{{- end -}}

{{/*
Provisioning job labels (exclude matchLabels from standard labels)
*/}}
{{- define "node-local-dns.labels.provisioning" -}}
{{- $provisioningLabels := (include "common.labels.standard" . | fromYaml ) -}}
{{- range (include "common.labels.matchLabels" . | fromYaml | keys ) -}}
{{- $_ := unset $provisioningLabels . -}}
{{- end -}}
{{- print ($provisioningLabels | toYaml) -}}
{{- end -}}

