#!/bin/bash
# Check if kubecontext should be configured
if [ "$CI_KUBERNETES_ACTIVE" = "true" ] || [ ! -z ${GL_K8S_AGENT_ID+x} ] || [ ! -z ${GL_K8S_PROXY_URL+x} ] ; then
  if [ "$CI_SERVER_HOST" == "gitlab.com" ]; then
      GL_K8S_AGENT_HOST_DEFAULT="kas.gitlab.com/k8s-proxy"
  else
      GL_K8S_AGENT_HOST_DEFAULT="$CI_SERVER_HOST/-/kubernetes-agent/k8s-proxy/"
  fi
  echo "Using ${GL_K8S_PROXY_URL:-https://$GL_K8S_AGENT_HOST_DEFAULT} as k8s proxy server"
  kubectl config set-credentials agent:$GL_K8S_AGENT_ID --token="ci:${GL_K8S_AGENT_ID}:${CI_JOB_TOKEN}"
  kubectl config set-cluster gitlab --server="${GL_K8S_PROXY_URL:-https://$GL_K8S_AGENT_HOST_DEFAULT}"
  kubectl config set-context "$GL_K8S_CONTEXT" --cluster=gitlab --user="agent:${GL_K8S_AGENT_ID}"
  kubectl config use-context "$GL_K8S_CONTEXT"
  kubectl config set-context --current --namespace=default
  export KUBE_CONFIG_PATH=$KUBECONFIG
  mkdir -p ~/.kube
  if [ ! -z "$KUBECONFIG" ] && [ -f "$KUBECONFIG" ]; then
    cp $KUBECONFIG ~/.kube/config
  fi
fi
