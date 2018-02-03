#!/bin/bash


echo "That the installation begins!!"

# Install Java 

if type -p java; then
    echo Found java executable in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
    echo found java executable in JAVA_HOME     
    _java="$JAVA_HOME/bin/java"
else
    echo "Install Java..."
    sudo apt-get update
    sudo apt-get -y install default-jre
    sudo apt-get -y install default-jdk
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    
    if [[ "$version" > "1.8.0_121" ]]; then
	clear
	echo "Java version $version is correclty installed"
    else         
        echo "Java should be at least of version 1.8.0_121 to continue the installation"
	echo "The actual version is $version"
        echo "Install Java..."
        sudo apt-get update
        sudo apt-get -y install default-jre
        sudo apt-get -y install default-jdk
    fi
fi


# Install sbt

PKG_OK=$(dpkg-query -W --showformat='${Status}\n' sbt |grep "install ok installed")
if [ "" == "$PKG_OK" ]; then
    echo "Install sbt..."
    echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
    sudo apt-get -y update
    sudo apt-get -y install sbt
    clear
else 
    echo "Sbt is already installed"
fi



PKG_OK=$(dpkg-query -W --showformat='${Status}\n' git |grep "install ok installed")
if [ "" == "$PKG_OK" ]; then
    echo "Install git..."
    sudo apt-get git
    clear
else
    echo "Git is already installed"
fi


echo "Here are all the example: https://playframework.com/download#examples"

PATH_SAMPLE="../scala-sample"
mkdir "$PATH_SAMPLE"

echo "Play Scala Anorm Example"
(cd "$PATH_SAMPLE" ;
    git clone https://github.com/playframework/play-scala-anorm-example.git
)

echo "Play Scala Chatroom using Websockets Example"
(cd "$PATH_SAMPLE" ;
    git clone https://github.com/playframework/play-scala-chatroom-example.git
)

echo Play Scala Compile Time Dependency Injection Example""
(cd "$PATH_SAMPLE" ;
    git clone 
)

echo "Play Scala File Upload Example"
(cd "$PATH_SAMPLE" ;
    git clone https://github.com/playframework/play-scala-fileupload-example.git
)

echo "Play Scala Forms Example"
(cd "$PATH_SAMPLE" ;
    git clone https://github.com/playframework/play-scala-forms-example.git
)

echo "Play Scala Integrated Slick Example"
(cd "$PATH_SAMPLE" ;
    git clone https://github.com/playframework/play-scala-slick-example.git
)

echo "Play Scala Isolated Slick Example"
(cd "$PATH_SAMPLE" ;
    git clone https://github.com/playframework/play-scala-isolated-slick-example.git
)

echo "Play Scala REST API Example"
(cd "$PATH_SAMPLE" ;
    git clone https://github.com/playframework/play-scala-rest-api-example.git
)

echo "Play Scala Secure Session Example"
(cd "$PATH_SAMPLE" ;
    git clone https://github.com/playframework/play-scala-secure-session-example.git
    sudo apt-get install -y libsodium-dev
)

echo "Play Scala Streaming Example"
(cd "$PATH_SAMPLE" ;
    git clone https://github.com/playframework/play-scala-streaming-example.git
)

echo "Play Scala Websocket Example"
(cd "$PATH_SAMPLE" ;
    git clone https://github.com/playframework/play-scala-websocket-example.git
)

echo "Play Secure HTTP (SSL/TLS) Example"
(cd "$PATH_SAMPLE" ;
    git clone https://github.com/playframework/play-scala-tls-example.git
)








