sudo apt update
sudo apt install -y maven
mvn -v

# Build java applications
mvn clean package -DskipTests          # generates target/<filename.jar>
mvn clean install                      # generates target/<filename.jar> and installs it in ~/.m2/repository for other services

# Run java applications
java -Djava.security.egd=file:/dev/./urandom \
    -Dserver.port=<port> \
    -Duser.timezone=Asia/Kolkata \
    -jar <filename.jar> \

jps -l # List Java processes

# Install sdk for java version
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 14.0.2-open
java -version

sdk list java
sdk current java
sdk default java <version/identifier>
