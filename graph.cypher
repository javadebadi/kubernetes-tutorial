MATCH (n)
DETACH DELETE n;

// Concepts
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
MERGE(pod:KubernetesObject {name: "Pod"})
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

// k8 objects managements
MERGE(configmap_management:KubernetesObjectManagement {name:"ConfigMap Management"})
MERGE(cluster_management:KubernetesObjectManagement {name: "Cluster Managemet"})

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

// tutorials chapters and sections relationhisp
CREATE (learn_kubernetes_basics)-[:INCLUDES]->(learn_kubernetes_basics_create_cluster)
CREATE (learn_kubernetes_basics)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_create_cluster)
CREATE (learn_kubernetes_basics_create_cluster)-[:INCLUDES]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (learn_kubernetes_basics_create_cluster)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (learn_kubernetes_basics)-[:INCLUDES]->(learn_kubernetes_basics_deploy_an_app)
CREATE (learn_kubernetes_basics)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_deploy_an_app)
CREATE (learn_kubernetes_basics_deploy_an_app)-[:INCLUDES]->(learn_kubernetes_basics_deploy_an_app_deploy_intro)
CREATE (learn_kubernetes_basics_deploy_an_app)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_deploy_an_app_deploy_intro)
CREATE (learn_kubernetes_basics_create_cluster_cluster_intro)-[:IS_PREREQUISITE_OF]->(learn_kubernetes_basics_deploy_an_app_deploy_intro)

// k8 softwares relationships
CREATE (kubernetes)-[:IS_EXPLAINED_IN {depth: 50}]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (kubernetes)-[:IS_AN_IMPLEMENTATION_OF]->(container_orchestration_tools)
CREATE (containerd)-[:IS_AN_IMPLEMENTATION_OF]->(container_runtime)
CREATE (cri_o)-[:IS_AN_IMPLEMENTATION_OF]->(container_runtime)

// k8 objects relationship to tuorials
CREATE (cluster)-[:IS_EXPLAINED_IN {depth: 50}]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (control_plane)-[:IS_EXPLAINED_IN {depth: 10}]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (node)-[:IS_EXPLAINED_IN {depth: 10}]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (kubelet)-[:IS_EXPLAINED_IN {depth: 10}]->(learn_kubernetes_basics_create_cluster_cluster_intro)
CREATE (deployment)-[:IS_EXPLAINED_IN {depth: 10}]->(learn_kubernetes_basics_deploy_an_app_deploy_intro)

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
CREATE (deployment)-[:LIVES_IN]->(control_plane)
CREATE (control_plane)-[:USES {for: "scheduling containerized applications in worker nodes"}]->(deployment)

//  k8 objects management relationships
CREATE (cluster_management)-[:IS_EXPLAINED_IN {depth: 50}]->(learn_kubernetes_basics_create_cluster_cluster_intro)
;
