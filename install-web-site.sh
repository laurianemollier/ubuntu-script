#!/bin/bash


echo "That the installation begins!!"

# Install Java 

sudo apt-get update
sudo apt-get -y install default-jre
sudo apt-get -y install default-jdk

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



#PKG_OK=$(dpkg-query -W --showformat='${Status}\n' git |grep "install ok installed")
#if [ "" == "$PKG_OK" ]; then
#    echo "Install git..."
#    sudo apt-get git
#    clear
#else
#    echo "Git is already installed"
#fi

git clone https://github.com/laurianemollier/software-factory-website.git


sudo apt-get update
# heroku
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

#postgresql
sudo apt-get update
sudo apt-get install -y postgresql postgresql-contrib
sudo -i -u postgres createdb software_factory
sudo apt-get update

sudo -u postgres psql -c "ALTER USER postgres PASSWORD '123123';"
sudo -i -u postgres createdb software-factory --host=localhost --port=5432 --username=postgres


PATH_SAMPLE="software-factory-website"
mkdir "$PATH_SAMPLE"

clear
echo "Compile and run the website..."
(cd "$PATH_SAMPLE" ;
    sbt compile
    sbt run
)

















