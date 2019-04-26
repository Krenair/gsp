> This repository (gsp-terraform-ignition) will eventually become the main repository for the GDS Supported Platform. It will be renamed to something more sensible (e.g. gds-supported-platform, gsp, to de decided) however at the moment there are dependencies on this so it has to keep the same name.

# What is the GDS Supported Platform?

## Overview

The GDS Supported Platform is the strategic container platform for hosting services developed for the [Government Digital Service](https://www.gov.uk/government/organisations/government-digital-service).

The platform manages the infrastructure that your application runs on and provides tooling for teams to build, deploy and manage their applications on that infrastructure.


The platform is operated by [GDS Reliability Engineering](https://reliability-engineering.cloudapps.digital/) according to the [Technology & Operations Shared Responsibility Model](https://reliability-engineering.cloudapps.digital/documentation/strategy-and-principles/techops-shared-responsibility-model.html)

## Who is the platform for?

The platform is for teams working in the [Government Digital Service](https://www.gov.uk/government/organisations/government-digital-service) that need to run software applications.

## Features

- A declarative continuous delivery workflow - merging to master triggers deployment to production
- A container platform based on industry standard [Docker](https://docs.docker.com/) and [Kubernetes](https://kubernetes.io)
- Build tooling with [ConcourseCI](https://concourse-ci.org/)
- A private container registry with [Docker Registry](https://docs.docker.com/registry/)
- Signing of docker image integrity with [Docker Notary](https://docs.docker.com/notary/)
- Scanning of docker images for security vulnerabilities with [clair](https://github.com/coreos/clair)
- Application deployment with [Flux](https://github.com/weaveworks/flux)
- Monitoring and alerting with [Prometheus](https://prometheus.io/), [Alertmanager](https://prometheus.io/docs/alerting/alertmanager/) and [Grafana](https://grafana.com/)
- Secure git-based secrets configuration with [sealed-secrets](https://github.com/bitnami-labs/sealed-secrets)
- Ingress management with [nginx ingress controller](https://kubernetes.github.io/ingress-nginx/)
- Protective monitoring provided by GDS TechOps CyberSecurity with [Splunk](https://www.splunk.com/)
- Cloud infrastructure hosted on [AWS](https://aws.amazom.com) in three availability zones in the London region managed with [Terraform](https://www.terraform.io/)
- Kubernetes control plane with [AWS EKS](https://aws.amazon.com/eks/)

## Running locally

It is possible to run a GSP cluster locally using [kind](https://kind.sigs.k8s.io/). You will probably want to give your Docker daemon more RAM than the default (anecdotally 8GB works).

To create a cluster run:

```
./scripts/gsp-local.sh create
```

You can then play with some of the services:

```
export KUBECONFIG="$(kind get kubeconfig-path --name="gsp-local")"

kubectl port-forward service/gsp-concourse-web -n gsp-system 8080:8080
# curl http://127.0.0.1:8080

kubectl port-forward service/gsp-prometheus-operator-prometheus -n gsp-system 9090:9090
# curl http://127.0.0.1:9090
```

When you're finished you should destroy it:

```
./scripts/gsp-local.sh destroy
```

## Help and support
For help or support:
- read our [documentation](/docs)
- raise an [issue](https://github.com/alphagov/gsp-terraform-ignition/issues)
- message the team on the Reliability [Engineering Slack channel](https://gds.slack.com/messages/CAD6NP598) [#reliability-eng](https://gds.slack.com/messages/CAD6NP598)
