keep="sudo -u hdfs hadoop fs  -mv  $1/*  $2"
$keep
creating="sudo -u hdfs hadoop fs -touchz $2/finish.done"
$creating
