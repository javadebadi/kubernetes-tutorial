MATCH (n)
DETACH DELETE n;

MERGE (tim:Topic:Task { name: "install minikube", url:"", done: false , completed: false })
MERGE (tik:Topic:Task {name: "install kubectl", url: "https: //kubernetes.io/docs/tasks/tools/#kubectl", done: false, completed: false})
MERGE (thm:Topic:Tutorial {name: "hello minikube", url: "https: //kubernetes.io/docs/tutorials/hello-minikube/", done:true, completed: false})
MERGE (tcpc:Topic:Task {name: "Configure a Pod to Use a ConfigMap", url: "https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/", done:true, completed: false})
MERGE (ttccruc:Topic:Tutorial {name: "configure redis using configmap", url: "https: //kubernetes.io/docs/tutorials/configuration/configure-redis-using-configmap/", done:false, completed: false})
CREATE (tim)-[:IS_PREREQUISITE]->(thm)
CREATE (tik)-[:IS_PREREQUISITE]->(thm)
CREATE (thm)-[:IS_PREREQUISITE]->(ttccruc)
CREATE (tcpc)-[:IS_PREREQUISITE]->(ttccruc);
