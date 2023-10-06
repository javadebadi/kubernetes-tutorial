MATCH (n)
DETACH DELETE n;

MERGE (tim: Topic { name: "install minikube", url:"", done: false , completed: false })
MERGE (tik: Topic {name: "install kubectl", url: "https: //kubernetes.io/docs/tasks/tools/#kubectl", done: false, completed: false})
MERGE (thm: Topic {name: "hello minikube", url: "https: //kubernetes.io/docs/tutorials/hello-minikube/", done:true, completed: false})
MERGE (ttccruc: Topic {name: "configure redis using configmap", url: "https: //kubernetes.io/docs/tutorials/configuration/configure-redis-using-configmap/", done:false, completed: false})
CREATE (tim)-[:IS_PREREQUISITE]->(thm)
CREATE (tik)-[:IS_PREREQUISITE]->(thm)
CREATE (thm)-[:IS_PREREQUISITE]->(ttccruc);
