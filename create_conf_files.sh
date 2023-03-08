# core-site.xml (HADOOP e SPARK)
# =============
echo '<configuration>' >$SPARK_HOME/conf/core-site.xml
echo '  <property>' >>$SPARK_HOME/conf/core-site.xml
echo '    <name>fs.default.name</name>' >>$SPARK_HOME/conf/core-site.xml
echo '    <value>hdfs://'${HADOOP_HOSTNAME}':9000</value>' >>$SPARK_HOME/conf/core-site.xml
echo '  </property>' >>$SPARK_HOME/conf/core-site.xml
echo '</configuration>' >>$SPARK_HOME/conf/core-site.xml

# hdfs-site.xml (HADOOP e SPARK)
# =============
echo '<configuration>' >$SPARK_HOME/conf/hdfs-site.xml

echo '  <property>' >>$SPARK_HOME/conf/hdfs-site.xml
echo '    <name>dfs.replication</name>' >>$SPARK_HOME/conf/hdfs-site.xml
echo '    <value>1</value>' >>$SPARK_HOME/conf/hdfs-site.xml
echo '  </property>' >>$SPARK_HOME/conf/hdfs-site.xml

echo '  <property>' >>$SPARK_HOME/conf/hdfs-site.xml
echo '    <name>dfs.name.dir</name>' >>$SPARK_HOME/conf/hdfs-site.xml
echo '    <value>file:///data/hadoop/hdfs/namenode</value>' >>$SPARK_HOME/conf/hdfs-site.xml
echo '  </property>' >>$SPARK_HOME/conf/hdfs-site.xml

echo '  <property>' >>$SPARK_HOME/conf/hdfs-site.xml
echo '    <name>dfs.data.dir</name>' >>$SPARK_HOME/conf/hdfs-site.xml
echo '    <value>file:///data/hadoop/hdfs/datanode</value>' >>$SPARK_HOME/conf/hdfs-site.xml
echo '  </property>' >>$SPARK_HOME/conf/hdfs-site.xml

echo '</configuration>' >>$SPARK_HOME/conf/hdfs-site.xml

# hive-site.xml (SPARK)
# =============
echo '<configuration>' >$SPARK_HOME/conf/hive-site.xml
echo '  <property>' >>$SPARK_HOME/conf/hive-site.xml
echo '    <name>hive.metastore.warehouse.dir</name>' >>$SPARK_HOME/conf/hive-site.xml
echo '    <value>/user/hive/warehouse</value>' >>$SPARK_HOME/conf/hive-site.xml
echo '  </property>' >>$SPARK_HOME/conf/hive-site.xml
echo '</configuration>' >>$SPARK_HOME/conf/hive-site.xml

# spark-env.sh (SPARK)
# ============
echo 'export JAVA_HOME=/usr/local/jre1.8.0_181' >$SPARK_HOME/conf/spark-env.sh
chmod +x $SPARK_HOME/conf/spark-env.sh

# spark-defaults.conf (SPARK)
# ===================
echo 'spark.driver.memory  1024m' >$SPARK_HOME/conf/spark-defaults.conf
echo 'spark.yarn.am.memory 1024m' >>$SPARK_HOME/conf/spark-defaults.conf
echo 'spark.executor.memory  1536m' >>$SPARK_HOME/conf/spark-defaults.conf
