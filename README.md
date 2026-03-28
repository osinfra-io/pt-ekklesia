# <img align="left" width="45" height="45" src="https://github.com/user-attachments/assets/2b9ec893-58ff-4bf3-94c9-fc321d3a173c"> Backstage

[![Dependabot](https://img.shields.io/github/actions/workflow/status/osinfra-io/pt-ekklesia/dependabot.yml?style=for-the-badge&logo=github&color=2088FF&label=Dependabot)](https://github.com/osinfra-io/pt-ekklesia/actions/workflows/dependabot.yml)
[![Datadog Security Enabled](https://img.shields.io/badge/Datadog%20Security-Enabled-632CA6?style=for-the-badge&logo=datadog)](https://app.datadoghq.com/security/code-security/repositories?repository_id=pt-ekklesia)

## 📄 Repository Description

This repository manages Backstage resources. It provides a centralized repository for managing all Backstage configurations, plugins, and customizations. It runs on Google Kubernetes Engine (GKE) and leverages various Google Cloud Platform (GCP) services for scalability and reliability. It depends on [google-kubernetes-engine](https://github.com/osinfra-io/google-kubernetes-engine) for cluster provisioning and onboarding of namespaces.

The continuous delivery workflows are implemented using GitHub Actions, ensuring testing, building, and deployment of Backstage components.

### 🛠️ Tools

- [pre-commit](https://github.com/pre-commit/pre-commit)
- [osinfra-pre-commit-hooks](https://github.com/osinfra-io/pt-techne-pre-commit-hooks)

### 📋 Skills and Knowledge

Links to documentation and other resources required to develop and iterate in this repository successfully.

- [backstage](https://backstage.io/docs)
- [cloud dns](https://cloud.google.com/dns/docs)
- [cloud sql](https://cloud.google.com/sql/docs)
- [datadog synthetics](https://docs.datadoghq.com/synthetics/)
- [google cloud platform iam](https://cloud.google.com/iam/docs/overview)
- [google cloud platform projects](https://cloud.google.com/resource-manager/docs/creating-managing-projects)
- [helm](https://helm.sh/docs/)
- [kubernetes](https://kubernetes.io/docs/home/)

### 🔍 Tests

A local instance of Backstage can be used to test some of the changes made to the repository. You can go to the application
directory and start the app using the `yarn dev` command. The `yarn dev` command will run both the frontend and backend as separate
processes (named `[0]` and `[1]`) in the same window.

```none
cd app
```

```none
yarn dev
```