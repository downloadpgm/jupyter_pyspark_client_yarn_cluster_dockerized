
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
