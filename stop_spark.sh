export JAVA_HOME=/usr/local/jre1.8.0_181
export CLASSPATH=$JAVA_HOME/lib
export PATH=$PATH:.:$JAVA_HOME/bin

export SPARK_HOME=/usr/local/spark-3.0.3-bin-hadoop2.7
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HADOOP_HOME/lib/native
export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin

service ssh stop

if [ -n "${SPARK_HOST_SLAVES}" ]; then
   $SPARK_HOME/sbin/stop-master.sh
   $SPARK_HOME/sbin/stop-slaves.sh
fi