FROM picoded/ubuntu-openjdk-8-jdk
MAINTAINER Eugene Cheah <eugene@picoded.com>

# This is in accordance to : https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-get-on-ubuntu-16-04
RUN apt-get update && \
	apt-get install -y maven && \
	apt-get install -y tomcat7 && \
	apt-get install -y git && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /var/cache/oracle-jdk8-installer;

# Setup Larax

WORKDIR /home/

RUN git clone https://github.com/chreul/LAREX.git
RUN ls
RUN mvn clean install -f LAREX/Larex/pom.xml
RUN ln -s $PWD/LAREX/Larex/target/Larex.war /var/lib/tomcat7/webapps/Larex.war
RUN systemctl enable tomcat7

EXPOSE 80

CMD ["systemctl start tomcat7"]
