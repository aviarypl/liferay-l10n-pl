#!/usr/bin/perl -w

$ENV{'CATALINA_HOME'}='/home/liferay/portal';
$ENV{'CATALINA_OPTS'}='-Xms128m -Xmx512m';
print "SERVER SHUTDOWN...\n";
`cd \$CATALINA_HOME/bin;./shutdown.sh`;
print "COPY PROPERTIES...\n";
`cp Language_pl.properties \$CATALINA_HOME/webapps/ROOT/WEB-INF/classes/content/Language-ext_pl.properties`;
sleep 5;
print "SERVER STARTUP...\n";
`cd \$CATALINA_HOME/bin;./startup.sh`;
