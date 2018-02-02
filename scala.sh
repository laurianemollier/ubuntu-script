#!/bin/bash

echo "That the installation begins!!"

#sudo apt-get update

#sudo apt-get -y install default-jre
sudo apt-get -y install default-jdk

#clear

if type -p java; then
    echo Found java executable in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo found java executable in JAVA_HOME     
    _java="$JAVA_HOME/bin/java"
else
    echo "Java was not installed"
    exit 1
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    
    if [[ "$version" > "1.8.0_121" ]]; then
	clear
	echo "Java version $version is correclty installed"
    else         
        echo "Java should be at least of version 1.8.0_121 to continue the installation"
	echo "The actual version is $version"
	exit 1
    fi
fi

#echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
#sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
#sudo apt-get -y update
#sudo apt-get -y install sbt

#sudo apt-get git
#git clone https://github.com/playframework/play-scala-secure-session-example.git

#sudo apt-get install -y libsodium-dev
#cd play-scala-secure-session-example





