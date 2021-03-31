#!/usr/bin/env bash

set -euo pipefail

MEMORY_QUERY='sum by (label_app_kubernetes_io_component) (sum(container_memory_usage_bytes{namespace="openshift-cnv"}) by (pod) * on (pod) group_left(label_app_kubernetes_io_component) kube_pod_labels{namespace="openshift-cnv"}) / (1024* 1024)'
CPU_QUERY='sum by (label_app_kubernetes_io_component) (sum(pod:container_cpu_usage:sum{namespace="openshift-cnv"}) by (pod) * on (pod) group_left(label_app_kubernetes_io_component) kube_pod_labels{namespace="openshift-cnv"})'

JQ_FILTER='.data.result[] | .metric.label_app_kubernetes_io_component + ":" +  .value[1]'

function run_query() {
    local query="$1"
    oc exec -n openshift-monitoring prometheus-k8s-0 -c prometheus -- curl --silent \
      --data-urlencode "query=${query}" \
      http://127.0.0.1:9090/api/v1/query? | jq "$JQ_FILTER"
}

echo "----MEMORY_CONSUMPTION----"
run_query "$MEMORY_QUERY"
echo "----CPU_CONSUMPTION----"
run_query "$CPU_QUERY"