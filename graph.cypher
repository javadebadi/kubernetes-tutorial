MATCH (n)
DETACH DELETE n;
MERGE (tim: Topic {name: "install minikube", url:"", done: false, completed: false})
MERGE (tik: Topic {name: "install kubectl", url: "https://kubernetes.io/docs/tasks/tools/#kubectl", done: false, completed: false})
MERGE (thm: Topic {name: "hello minikube", url: "https://kubernetes.io/docs/tutorials/hello-minikube/", done:false, completed: false})
CREATE (tim)-[:IS_PREREQUISITE]->(thm)
CREATE (tik)-[:IS_PREREQUISITE]->(thm);
