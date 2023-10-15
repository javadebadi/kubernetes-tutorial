MATCH (n)
DETACH DELETE n;

// Commands
MERGE(kubectl_command:Command
{
    name: "kubectl"
}
)
MERGE(kubectl_get_command:Command
{
    name: "kubectl get",
    description: "list resources"
}
)
MERGE(kubectl_describe_command:Command
{
    name: "kubectl describe",
    description: "show detailed information about a resource"
}
)
MERGE(kubectl_logs_command:Command
{
    name: "kubectl logs",
    description: "print the logs from a container in a pod"
}
)
MERGE(kubectl_exec_command:Command
{
    name: "kubectl exec",
    description: "execute a command on a container in a pod"
}
)
MERGE(kubectl_get_pods_command:Command 
    {
        name: "kubectl get pods",
        description: "list pods in the cluster (default namespace)"
    }
)
MERGE(kubectl_describe_pods_command:Command 
    {
        name: "kubectl describe pods",
        description: "See details about the Pod’s container: IP address, the ports used and a list of events related to the lifecycle of the Pod."
    }
)
MERGE(kubectl_exec_command_how_to_execute_interactive_terminal_inside_a_pod:Command:HowTo
    {
        name: "kubectl exec -it $POD_NAME -- /bin/bash",
        description: "A command to have an interactive bash terminal inside a container of a pod assuming pod name is stored inside $POD_NAME."
    }
)
CREATE (kubectl_get_command)-[:IS_A_SUBCOMMAND_OF]->(kubectl_command)
CREATE (kubectl_get_pods_command)-[:IS_AN_EXAMPLE_OF]->(kubectl_get_command)
CREATE (kubectl_describe_command)-[:IS_A_SUBCOMMAND_OF]->(kubectl_command)
CREATE (kubectl_describe_pods_command)-[:IS_AN_EXAMPLE_OF]->(kubectl_describe_command)
CREATE (kubectl_logs_command)-[:IS_A_SUBCOMMAND_OF]->(kubectl_command)
CREATE (kubectl_exec_command)-[:IS_A_SUBCOMMAND_OF]->(kubectl_command)
CREATE (kubectl_exec_command_how_to_execute_interactive_terminal_inside_a_pod)-[:IS_AN_EXAMPLE_OF]->(kubectl_exec_command)


// Concepts
MERGE(container:Concept:SoftwareCategory {
    name: "Container",
    definitions: [
        "A container is a runtime environment with all the necessary components—like code, dependencies, and libraries—needed to run the application code without using host machine dependencies. "
    ]
}
)
MERGE(container_image:Concept:SoftwareCategory {
    name: "Container Image",
    definitions: [
        "A container image is a standalone, executable file used to create a container. "
    ]
}
)
MERGE(container_runtime:Concept:SoftwareCategory {
    name: "Container Runtime",
    definitions: [
        "A container runtime, also known as container engine, is a software component that can run containers on a host operating system."
    ]
}
)
MERGE(container_orchestration_tools:Concept:SoftwareCategory  {
    name: "Container Orchestration Tools",
    definitions: [
        "Tools to manage provisioning and manangin containerized applications"
    ]
    }
)

// k8 softwares and tools
MERGE(kubernetes: KubernetesTool:Software {
    name: "Kubernetes",
    definitions: [
        "Kubernetes coordinates a highly available cluster of computers that are connected to work as a single unit.",
        "Kubernetes automates the distribution and scheduling of application containers across a cluster in a more efficient way.",
        "Kubernetes is a production-grade, open-source platform that orchestrates the placement (scheduling) and execution of application containers within and across computer clusters"
    ],
    category: "core-software"
}
)
MERGE(containerd: KubernetesTool:Software {
    name: "containerd",
    category: "Container Runtime"
}
)
MERGE(cri_o: KubernetesTool:Software {
    name: "CRI-O",
    category: "Container Runtime"
}
)

// k8 objects
MERGE(configmap:KubernetesObject {name: "ConfigMap"})
MERGE(pod:KubernetesObject
{
    name: "Pod",
    definitions: [
        "A Pod is a group of one or more application containers (such as Docker) and includes shared storage (volumes), IP address and information about how to run them."
    ],
    images: [
        "https://d33wubrfki0l68.cloudfront.net/fe03f68d8ede9815184852ca2a4fd30325e5d15a/98064/docs/tutorials/kubernetes-basics/public/images/module_03_pods.svg"
    ]
}
)
MERGE(cluster:KubernetesObject {name: "Cluster"})
MERGE(control_plane:KubernetesObject
    {
        name: "Control Plane",
        definitions: [
            "The Control Plane is responsible for managing the cluster.",
            "Control Planes manage the cluster and the nodes that are used to host the running applications."
        ]
    }
)
MERGE(node:KubernetesObject
    {
        name: "Node",
        definitions: [
            "A node is a VM or a physical computer that serves as a worker machine in a Kubernetes cluster.",
            "Nodes are the workers that run applications"
        ],
        images: [
            "https://d33wubrfki0l68.cloudfront.net/5cb72d407cbe2755e581b6de757e0d81760d5b86/a9df9/docs/tutorials/kubernetes-basics/public/images/module_03_nodes.svg"
        ]
    }
)
MERGE(kubelet:KubernetesObject
{
    name: "Kubelet",
    definitions: [
        "Kubelet is a agent for managing the node and communicating with control plane"
    ]
}
)
MERGE(deployment:KubernetesObject 
{
    name: "Deployment",
    definitions: [
        "A Deployment is responsible for creating and updating instances of your application"
    ]
}
)
MERGE(service:KubernetesObject
{
    name: "Service",
    definitions: [
        "Kubernetes Service is an abstraction layer which defines a logical set of Pods and enables external traffic exposure, load balancing and service discovery for those Pods"
    ]
}
)
MERGE(label:KubernetesObjectMetadata
{
    name: "Label",
    definitions: [
        "Lables are a way to tag Kubernets resources and can be used as selectors to select specific resources."
    ]
}
)

// k8 objects managements
MERGE(configmap_management:KubernetesObjectManagement {name:"ConfigMap Management"})
MERGE(cluster_management:KubernetesObjectManagement {name: "Cluster Managemet"})
MERGE(deployment_management_creation:KubernetesObjectManagement {name: "Create Deployment"})

// k8 objects interaction management
MERGE(configmap_in_pod:KubernetesObjectsInteraction {name:"ConfigMap in Pods"})


// k8 -> tutorials -> learn kubernetes basics
MERGE(learn_kubernetes_basics:Topic:TutorialChapter {name:"learn Kubernetes basics", url: "https://kubernetes.io/docs/tutorials/kubernetes-basics/", done: true, completed: true})
MERGE(learn_kubernetes_basics_create_cluster:Topic:TutorialSection {name: "create a cluster", url: "https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/", done: true, completed: true})
MERGE(learn_kubernetes_basics_create_cluster_cluster_intro:Topic:TutorialSubSection {
    name: "Using Minikube to Create a Cluster",
    url: "https://kubernetes.io/docs/tutorials/kubernetes-basics/create-cluster/cluster-intro/",
    done: true,
    completed: false
}
)
MERGE(
    learn_kubernetes_basics_deploy_an_app:Topic:TutorialSection {
        name: "Deploy an App",
        url: "https://kubernetes.io/docs/tutorials/kubernetes-basics/deploy-app/",
        done: true,
        completed: false
    }
)
MERGE (
    learn_kubernetes_basics_deploy_an_app_deploy_intro:TutorialSubSection {
        name: "Using kubectl to Create a Deployment",
        url: "https://kubernetes.io/docs/tutorials/kubernetes-basics/deploy-app/deploy-intro/",
        done: true,
        completed: false
    }
)
MERGE(
    learn_kubernetes_basics_explore_app:Topic:TutorialSection {
        name: "Explore Your App",
        url: "https://kubernetes.io/docs/tutorials/kubernetes-basics/explore/",
        done: true,
        completed: false
    }
)
MERGE (
    learn_kubernetes_basics_explore_app_explore_intro:TutorialSubSection {
        name: "Viewing Pods and Nodes",
        url: "https://kubernetes.io/docs/tutorials/kubernetes-basics/explore/explore-intro/",
        done: true,
        completed: false
    }
)
MERGE(
    learn_kubernetes_basics_expose:Topic:TutorialSection {
        name: "Expose Your App Publicly",
        url: "https://kubernetes.io/docs/tutorials/kubernetes-basics/expose/",
        done: true,
        completed: false
    }
)
MERGE(
    learn_kubernetes_basics_expose_intro:Topic:TutorialSubSection {
        name: "Using a Service to Expose Your App",
        url: "https://kubernetes.io/docs/tutorials/kubernetes-basics/expose/expose-intro/",
        done: false,
        completed: false
    }
)

MERGE (install_minikube:Topic:Task{name: "install minikube", url:"", done: false , completed: false })
MERGE (install_kubectl:Topic:Task {name: "install kubectl", url: "https: //kubernetes.io/docs/tasks/tools/#kubectl", done: false, completed: false})
MERGE (hello_minikube:Topic:TutorialChapter {name: "hello minikube", url: "https: //kubernetes.io/docs/tutorials/hello-minikube/", done:true, completed: false})
MERGE (tcpc:Topic:Task {name: "Configure a Pod to Use a ConfigMap", url: "https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/", done:true, completed: false})
MERGE (ttccruc:Topic:TutorialSection {name: "configure redis using configmap", url: "https: //kubernetes.io/docs/tutorials/configuration/configure-redis-using-configmap/", done:false, completed: false})
CREATE (install_minikube)-[:IS_PREREQUISITE_OF]->(hello_minikube)
CREATE (install_kubectl)-[:IS_PREREQUISITE_OF]->(hello_minikube)
CREATE (hello_minikube)-[:IS_PREREQUISITE_OF]->(ttccruc)
CREATE (tcpc)-[:IS_PREREQUISITE_OF]->(ttccruc)

// configmap (management and its usage in pods)
CREATE (configmap)-[:IS_EXPLAINED_IN {depth: 100}]->(tcpc)
CREATE (tcpc) -[:ASSUMES_FAMILIARITY_ABOUT]-> (pod)
CREATE (configmap_management)-[:IS_EXPLAINED_IN {depth: 100}]->(tcpc)
CREATE (configmap_in_pod)-[:IS_EXPLAINED_IN {depth: 100}]->(tcpc)

// management 
// management of deployment
CREATE (deployment_management_creation)-[:IS_FOR_MANAGEMENT_OF {depth: 10, how: "create deployment"}]->(deployment)

// tutorials chapters and sections relationhisp
CREATE (learn_kubernetes_basics)-[:INCLUDES]->(learn_kubernetes_basics_create_cluster)
CREATE (learn_kubernetes_basics)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_create_cluster)
CREATE (learn_kubernetes_basics_create_cluster)-[:INCLUDES]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (learn_kubernetes_basics_create_cluster)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (learn_kubernetes_basics)-[:INCLUDES]->(learn_kubernetes_basics_deploy_an_app)
CREATE (learn_kubernetes_basics)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_deploy_an_app)
CREATE (learn_kubernetes_basics_deploy_an_app)-[:INCLUDES]->(learn_kubernetes_basics_deploy_an_app_deploy_intro)
CREATE (learn_kubernetes_basics_deploy_an_app)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_deploy_an_app_deploy_intro)
CREATE (learn_kubernetes_basics)-[:INCLUDES]->(learn_kubernetes_basics_explore_app)
CREATE (learn_kubernetes_basics)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_explore_app)
CREATE (learn_kubernetes_basics_explore_app)-[:INCLUDES]->(learn_kubernetes_basics_explore_app_explore_intro)
CREATE (learn_kubernetes_basics_explore_app)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_explore_app_explore_intro)
CREATE (learn_kubernetes_basics)-[:INCLUDES]->(learn_kubernetes_basics_expose)
CREATE (learn_kubernetes_basics)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_expose)
CREATE (learn_kubernetes_basics_expose)-[:INCLUDES]->(learn_kubernetes_basics_expose_intro)
CREATE (learn_kubernetes_basics_expose)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_expose_intro)


CREATE (learn_kubernetes_basics_create_cluster_cluster_intro)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_deploy_an_app_deploy_intro)
CREATE (hello_minikube)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_deploy_an_app_deploy_intro)
CREATE(learn_kubernetes_basics_deploy_an_app_deploy_intro)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_explore_app_explore_intro)
CREATE (learn_kubernetes_basics_explore_app_explore_intro)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_expose_intro)

// k8 softwares relationships
CREATE (kubernetes)-[:IS_EXPLAINED_IN {depth: 50}]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (kubernetes)-[:IS_AN_IMPLEMENTATION_OF]->(container_orchestration_tools)
CREATE (containerd)-[:IS_AN_IMPLEMENTATION_OF]->(container_runtime)
CREATE (cri_o)-[:IS_AN_IMPLEMENTATION_OF]->(container_runtime)
CREATE (containerd)-[:RUNS]->(container)
CREATE (container_image)-[:USED_TO_CREATE]->(container)

// k8 objects relationship to tuorials
CREATE (cluster)-[:IS_EXPLAINED_IN {depth: 50}]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (control_plane)-[:IS_EXPLAINED_IN {depth: 10}]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (node)-[:IS_EXPLAINED_IN {depth: 10}]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (node)-[:IS_EXPLAINED_IN {depth: 20}]->(learn_kubernetes_basics_explore_app_explore_intro)
CREATE (kubelet)-[:IS_EXPLAINED_IN {depth: 10}]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (deployment)-[:IS_EXPLAINED_IN {depth: 10}]->(learn_kubernetes_basics_deploy_an_app_deploy_intro)
CREATE (pod)-[:IS_EXPLAINED_IN {depth: 50}]->(learn_kubernetes_basics_explore_app_explore_intro)
CREATE (service)-[:IS_EXPLAINED_IN {depth: 20}]->(learn_kubernetes_basics_expose_intro)
CREATE (label)-[:IS_EXPLAINED_IN {depth: 20}]->(learn_kubernetes_basics_expose_intro)

// k8 objects relationships to each other
CREATE (control_plane)-[:IS_PART_OF]->(cluster)
CREATE (node)-[:IS_PART_OF]->(cluster)
CREATE (kubelet)-[:IS_PART_OF]->(node)
CREATE (control_plane)-[:MANAGES {depth: 10}]->(cluster)
CREATE (control_plane)-[:MANAGES {depth: 10}]->(node)
CREATE (kubelet)-[:MANAGES {depth: 10}]->(node)
CREATE (kubelet)-[:COMMUNICATES_TO {depth: 10}]->(control_plane)


// k8 objects relationships to other things
CREATE (node)-[:USES {for:"container operations"}]->(container_runtime)
CREATE (node)-[:RUNS {for: "container operations including pulling container images from a registry, unpacking the container, and running the application."}]->(container_runtime)
CREATE (node)-[:RUNS {for: "communicating with control-plane and the Node, management of pods and containers running in the Node" }]->(kubelet)
CREATE (deployment)-[:LIVES_IN]->(control_plane)
CREATE (pod)-[:LIVES_IN]->(node)
CREATE (node)-[:CAN_RUN_MANY]->(pods)
CREATE (pod)-[:RUNS {details:"Note that many containers can be run in a single pod. Containers should only be scheduled together in a single Pod if they are tightly coupled and need to share resources such as disk."}]->(container)
CREATE (control_plane)-[:USES {for: "scheduling containerized applications in worker nodes"}]->(deployment)
CREATE (container_image)-[:IS_REQUIRED_TO_CREATE]->(deployment)

//  k8 objects management relationships
CREATE (cluster_management)-[:IS_EXPLAINED_IN {depth: 50}]->(learn_kubernetes_basics_create_cluster_cluster_intro)
;
