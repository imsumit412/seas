{{- /*
Chart specific config file for SCH (Shared Configurable Helpers)
_sch-chart-config.tpl is a config file for the chart to specify additional
values and/or override values defined in the sch/_config.tpl file.

*/ -}}

{{- /*
"sch.chart.config.values" contains the chart specific values used to override or provide
additional configuration values used by the Shared Configurable Helpers.
*/ -}}
{{- define "ibm-seas.sch.chart.config.values" -}}
sch:
  chart:
    appName: "ibm-seas"
    metering:
     {{- if eq (toString .Values.licenseType | lower) "non-prod"  }}
      productName: "IBM Sterling External Authentication Server Premium Ed Certified Container"
      productID: "1eb57e71e4ca4500bf22604fc7452a6f"
    {{- else }}
      productName: "IBM Sterling External Authentication Server Premium Ed Certified Container"
      productID: "1eb57e71e4ca4500bf22604fc7452a6f"
    {{- end }}
      productVersion: "6.1.1"
      productMetric: "VIRTUAL_PROCESSOR_CORE"
      productChargedContainers: ""
    podSecurityContext:
      runAsNonRoot: true
      supplementalGroups:
{{- if .Values.storageSecurity.supplementalGroups }}
{{ toYaml .Values.storageSecurity.supplementalGroups | indent 8 }}
{{- else }}
      - 65534
{{- end }}	 
      fsGroup: {{ .Values.storageSecurity.fsGroup | default 65534 }}
      runAsGroup: 0
      runAsUser: 1000
      seccompProfile:
        type: "RuntimeDefault"	  
    initContainerSecurityContext:
      privileged: false
	  {{- if .Values.storageSecurity.rootSquash.enabled }}
      runAsUser: {{ .Values.storageSecurity.rootSquash.runAsUser | default 65534 }} 
	  {{- else }}
      runAsUser: 1000
      {{- end }}
      readOnlyRootFilesystem: false
      allowPrivilegeEscalation: false
      capabilities:
        drop: [ "ALL" ]
    containerSecurityContext:
      privileged: false
      runAsUser: 1000
      readOnlyRootFilesystem: false
      allowPrivilegeEscalation: false
      capabilities:
        drop: [ "ALL" ]
{{- end -}}
