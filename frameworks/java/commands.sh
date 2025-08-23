sudo apt update
sudo apt install -y maven
mvn -v

# Build java applications
mvn clean package # generates target/<filename.jar>

# Run java applications
java -Dserver.port=<port> -jar <filename.jar>
