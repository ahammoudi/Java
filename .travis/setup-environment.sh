#!/bin/bash

echo "setup environment"
curl -LOH "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u40-b26/jdk-8u40-linux-x64.tar.gz

tar -zxf jdk-8u40-linux-x64.tar.gz
jdk1.8.0_40/bin/java -version

ls -al
