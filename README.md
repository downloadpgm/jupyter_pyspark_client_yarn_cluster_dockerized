# Jupyter client running into YARN cluster in Docker

Apache Spark is an open-source, distributed processing system used for big data workloads.

In this demo, a Spark container uses a Hadoop YARN cluster as a resource management and job scheduling technology to perform distributed data processing.

This Docker image contains Spark binaries prebuilt and uploaded in Docker Hub.

## Build Spark image
```shell
$ wget https://archive.apache.org/dist/spark/spark-3.0.3/spark-3.0.3-bin-hadoop2.7.tgz
$ docker image build -t mkenjis/ubspypkcli_yarn_img .
$ docker login   # provide user and password
$ docker image push mkenjis/ubpyspkcli_yarn_img
```

## Shell Scripts Inside 

> run_spark.sh

Sets up the environment for Spark client by executing the following steps :
- sets environment variables for JAVA and SPARK
- starts the SSH service for passwordless SSHfiles on start-up

> create_conf_files.sh

Creates the following Hadoop files on $SPARK_HOME/conf directory :
- core-site.xml
- hdfs-site.xml
- hive-site.xml
- spark-env.sh
- spark-defaults.conf

## Start Swarm cluster

1. start swarm mode in node1
```shell
$ docker swarm init --advertise-addr <IP node1>
$ docker swarm join-token worker  # issue a token to add a node as worker to swarm
```

2. add 3 more workers in swarm cluster (node2, node3, node4)
```shell
$ docker swarm join --token <token> <IP nodeN>:2377
```

3. label each node to anchor each container in swarm cluster
```shell
docker node update --label-add hostlabel=hdpmst node1
docker node update --label-add hostlabel=hdp1 node2
docker node update --label-add hostlabel=hdp2 node3
docker node update --label-add hostlabel=hdp3 node4
```

4. create an external "overlay" network in swarm to link the 2 stacks (hdp and spk)
```shell
docker network create --driver overlay mynet
```

5. start the Hadoop cluster (with HDFS and YARN)
```shell
$ docker stack deploy -c docker-compose-hdp.yml hdp
$ docker stack ps hdp
jeti90luyqrb   hdp_hdp1.1     mkenjis/ubhdpclu_vol_img:latest   node2     Running         Preparing 39 seconds ago             
tosjcz96hnj9   hdp_hdp2.1     mkenjis/ubhdpclu_vol_img:latest   node3     Running         Preparing 38 seconds ago             
t2ooig7fbt9y   hdp_hdp3.1     mkenjis/ubhdpclu_vol_img:latest   node4     Running         Preparing 39 seconds ago             
wym7psnwca4n   hdp_hdpmst.1   mkenjis/ubhdpclu_vol_img:latest   node1     Running         Preparing 39 seconds ago
```

4. start spark client
```shell
$ docker stack deploy -c docker-compose.yml spk
$ docker service ls
ID             NAME          MODE         REPLICAS   IMAGE                                 PORTS
xf8qop5183mj   spk_spk_cli   replicated   0/1        mkenjis/ubpyspkcli_yarn_img:latest
```

## Set up Spark client

1. access spark client node and setup jupyter notebook
```shell
$ docker container exec -it <spk_cli ID> bash
```

2. run jupyter notebook --generate-config
```shell
$ jupyter notebook --generate-config
```

3. edit /root/.jupyter/jupyter_notebook_config.py
```shell
$ vi /root/.jupyter/jupyter_notebook_config.py
c.NotebookApp.ip = '*'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 8082
```

4. setup a jupyter password
```shell
$ jupyter notebook password
Enter password:  *********
Verify password: *********
```

5. run pyspark
```shell
PYSPARK_DRIVER_PYTHON_OPTS="notebook --no-browser --allow-root --port=8082" pyspark --master yarn
```

6. in the browser, issue the address https://host:8082 to access the Jupyter Notebook.

Provide the credentials previously created

![JUPYTER home](docs/jupyter-login.png)

Click on New button to start a new notebook. Choose Python3 as interpreter

![JUPYTER home](docs/jupyter-python-notebook.png)

Issue Spark commands

![JUPYTER home](docs/jupyter-python-spark.png)
![JUPYTER home](docs/jupyter-python-spark_1.png)