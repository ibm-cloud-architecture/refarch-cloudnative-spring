# Run the Spring Stack on a Kubernetes Cluster

* [Run the Spring Stack on a Kubernetes Cluster](#run-the-spring-stack-on-a-kubernetes-cluster)
* [Introduction](#introduction)
* [Spring Stack Overview](#spring-stack-overview)
* [Project repositories](#project-repositories)
* [Deploy the Spring Stack](#deploy-the-spring-stack)
    * [Download required CLIs](#download-required-clis)
    * [Create a Kubernetes Cluster](#create-a-kubernetes-cluster)
    * [Deploy to Kubernetes Cluster](#deploy-to-kubernetes-cluster)
* [Validate the Spring Stack](#validate-the-deployment)
* [Delete the Spring Stack](#delete-the-deployment)
* [Optional Deployments](#optional-deployments)
    * [Deploy Spring Stack to IBM Bluemix Container Service using IBM Bluemix Services](#deploy-spring-stack-to-ibm-bluemix-container-service-using-ibm-bluemix-services)
    * [Deploy Spring Stack to IBM Cloud private using the App Center](#deploy-spring-stack-to-ibm-cloud-private-using-the-app-center)

## Introduction
Coming Soon...

## Spring Stack Overview
Coming Soon...

## Project repositories

This project organized itself like a microservice project, as such each component in the architecture has its own Git Repository and tutorial listed below.  

 - [refarch-cloudnative-spring](https://github.com/ibm-cloud-architecture/refarch-cloudnative-spring/tree/master) - The root repository (Current repository)
 - [refarch-cloudnative-netflix-eureka](https://github.com/ibm-cloud-architecture/refarch-cloudnative-netflix-eureka/tree/master) - This repository contains a basic Netflix Eureka application.
 - [refarch-cloudnative-netflix-zuul](https://github.com/ibm-cloud-architecture/refarch-cloudnative-netflix-zuul/tree/master) - This repository contains a basic Netflix Zuul proxy application.
 - [refarch-cloudnative-spring-config](https://github.com/ibm-cloud-architecture/refarch-cloudnative-spring-config/tree/master) - This repository contains a packaged Spring Config config server for use in a Netflix OSS-based microservices architecture.
 - [refarch-cloudnative-netflix-hystrix](https://github.com/ibm-cloud-architecture/refarch-cloudnative-netflix-hystrix/tree/master) - This repository contains a basic Netflix Hystrix Dashboard application, configured to use messaging for inter-component communication.
 - [refarch-cloudnative-netflix-turbine](https://github.com/ibm-cloud-architecture/refarch-cloudnative-netflix-turbine/tree/master) - This repository contains a basic Netflix Turbine Server application, configured to use messaging for inter-component communication.
 - [refarch-cloudnative-zipkin](https://github.com/ibm-cloud-architecture/refarch-cloudnative-zipkin/tree/master) - This repository contains Zipkin, a distributed tracing system.

## Deploy the Sprint Stack

To run the Spring Stack you will need to configure your environment for the Kubernetes and Microservices
runtimes.

### Download required CLIs

To deploy the Sprint Stack, you require the following tools:

- [kubectl](https://kubernetes.io/docs/user-guide/kubectl-overview/) (Kubernetes CLI) - Follow the instructions [here](https://kubernetes.io/docs/tasks/tools/install-kubectl/) to install it on your platform.
- [helm](https://github.com/kubernetes/helm) (Kubernetes package manager) - Follow the instructions [here](https://github.com/kubernetes/helm/blob/master/docs/install.md) to install it on your platform.


### Create a Kubernetes Cluster

The following clusters have been tested with this sample application:

- [minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) - Create a single node virtual cluster on your workstation
- [IBM Bluemix Container Service](https://www.ibm.com/cloud-computing/bluemix/containers) - Create a Kubernetes cluster in IBM Cloud.  The application runs in the Lite cluster, which is free of charge.  Follow the instructions [here](https://console.bluemix.net/docs/containers/container_index.html).
- [IBM Cloud private](https://www.ibm.com/cloud-computing/products/ibm-cloud-private/) - Create a Kubernetes cluster in an on-premise datacenter.  The community edition (IBM Cloud private-ce) is free of charge.  Follow the instructions [here](https://www.ibm.com/support/knowledgecenter/en/SSBS6K_1.2.0/installing/install_containers_CE.html) to install IBM Cloud private-ce.

### Deploy to Kubernetes Cluster

We have packaged all the application components as Kubernetes [Charts](https://github.com/kubernetes/charts). To deploy the Spring Stack, follow the instructions configure `kubectl` for access to the Kubernetes cluster.

1. Initialize `helm` in your cluster.
   
   ```
   $ helm init
   ```
   
   This initializes the `helm` client as well as the server side component called `tiller`.
   
2. Add the `helm` package repository containing the reference application:

   ```
   $ helm repo add ibmcase https://raw.githubusercontent.com/ibm-cloud-architecture/refarch-cloudnative-spring/master/docs/charts/
   ```
   
3. Install the reference application:

   ```
   $ helm install --name spring-stack ibmcase/spring-stack
   ```
   
   After a minute or so, the containers will be deployed to the cluster.  The output of the installation contains instructions on how to access the application once it has finished deploying.

## Validate the Spring Stack

Coming soon

## Delete the Spring Stack

To delete the Spring Stack from your cluster, run the following:

```
$ helm delete --purge spring-stack
```


## Optional Deployments

### Deploy Spring Stack to IBM Bluemix Container Service using IBM Bluemix Services

**IGNORE FOR NOW**

We have also prepared a chart that uses managed database services from the IBM Bluemix catalog instead of local docker containers, to be used when deploying the application on a cluster in the IBM Bluemix Container Service.  Please be aware that this will incur a cost in your IBM Bluemix account.  The following services are instantiated by the helm chart:

- [Compose for Elasticsearch](https://www.compose.com/databases/elasticsearch) (one instance for the Catalog microservice is created)
- [IBM Cloudant](https://www.ibm.com/analytics/us/en/technology/cloud-data-services/cloudant/) (a free Lite instance is created for the Customer Microservice)
- [Compose for MySQL](https://www.compose.com/databases/mysql) (two instances, one for Orders microservice and one for Inventory microservice)
- [IBM Message Hub](http://www-03.ibm.com/software/products/en/ibm-message-hub) - (for asynchronous communication between Orders and Inventory microservices; a topic named `orders` is created)

To install, use the following command to install the chart:

```
$ helm install --name spring-stack ibmcase/spring-stack \
    --set global.bluemix.target.endpoint=<Bluemix API endpoint> \
    --set global.bluemix.target.org=<Bluemix Org> \
    --set global.bluemix.target.space=<Bluemix Space> \
    --set global.bluemix.clusterName=<Name of cluster> \
    --set global.bluemix.apiKey=<Bluemix API key for user account>
```

Where,

- `<Bluemix API endpoint>` specifies an API endpoint (e.g. `api.ng.bluemix.net`).  This controls which region the Bluemix services are created.
- `<Bluemix Org>` and `<Bluemix Space>` specifies a space where the Bluemix Services are created.
- `<Name of cluster>` specifies the name of the cluster as created in the IBM Bluemix Container Service
- `<Bluemix API key for user account>` is an API key used to authenticate against Bluemix.  To create an API key, follow [these instructions](https://console.bluemix.net/docs/iam/apikeys.html#creating-an-api-key).

When deleting the application, note that the services are not automatically removed from Bluemix with the chart.

### Deploy Spring Stack to IBM Cloud private using the App Center

**IGNORE FOR NOW**

IBM Cloud private contains integration with Helm that allows you to install the application without the need to go to a command line.  This can be done as an administrator using the following steps:

1. Click on the three bars in the top left corner, and go to *System*.
2. Click on the *Repositories* tab
3. Click on *Add Repository*.  Use the following values:

   - Repository Name: *ibmcase*
   - URL: *https://raw.githubusercontent.com/ibm-cloud-architecture/refarch-cloudnative-spring/master/docs/charts/*
   
   Click *Add* to add the repository.
4. Click on the three bars in the top left corner again, and go to *App Center*.
5. Under *Packages*, locate `ibmcase/spring-stack`, and click *Install Package*.
6. Click *Review and Install*, then *Install* to install the application.
