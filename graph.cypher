MATCH (n)
DETACH DELETE n;

Merge(configmap:KubernetesObject {name:"ConfigMap"})
Merge(pod:KubernetesObject {name:"Pod"})
Merge(configmap_management:KubernetesObjectManagement {name:"ConfigMap Management"})
Merge(configmap_in_pod:KubernetesObjectsInteraction {name:"ConfigMap in Pods"}) 
MERGE (tim:Topic:Task{name: "install minikube", url:"", done: false , completed: false })
MERGE (tik:Topic:Task {name: "install kubectl", url: "https: //kubernetes.io/docs/tasks/tools/#kubectl", done: false, completed: false})
MERGE (thm:Topic:Tutorial {name: "hello minikube", url: "https: //kubernetes.io/docs/tutorials/hello-minikube/", done:true, completed: false})
MERGE (tcpc:Topic:Task {name: "Configure a Pod to Use a ConfigMap", url: "https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/", done:true, completed: false})
MERGE (ttccruc:Topic:Tutorial {name: "configure redis using configmap", url: "https: //kubernetes.io/docs/tutorials/configuration/configure-redis-using-configmap/", done:false, completed: false})
CREATE (tim)-[:IS_PREREQUISITE_OF]->(thm)
CREATE (tik)-[:IS_PREREQUISITE_OF]->(thm)
CREATE (thm)-[:IS_PREREQUISITE_OF]->(ttccruc)
CREATE (tcpc)-[:IS_PREREQUISITE_OF]->(ttccruc)

// configmap (management and its usage in pods)
CREATE (configmap)-[:IS_EXPLAINED_IN {depth: 100}]->(tcpc)
CREATE (tcpc) -[:ASSUMES_FAMILIARITY_ABOUT]-> (pod)
CREATE (configmap_management)-[:IS_EXPLAINED_IN {depth: 100}]->(tcpc)
CREATE (configmap_in_pod)-[:IS_EXPLAINED_IN {depth: 100}]->(tcpc);
