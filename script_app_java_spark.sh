#!/bin/sh

sudo wget https://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i s/\$releasever/6/g /etc/yum.repos.d/epel-apache-maven.repo
sudo yum install -y apache-maven
sudo yum install -y java-1.8.0-devel

mvn archetype:generate -DgroupId=com.escuela.maven.webapp \
-DartifactId=com.escuela.maven.webapp   \
-DarchetypeArtifactId=maven-archetype-quickstart \
-DarchetypeVersion=1.4 \
-DinteractiveMode=false

echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>

<project xmlns=\"http://maven.apache.org/POM/4.0.0\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
  xsi:schemaLocation=\"http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd\">
  <modelVersion>4.0.0</modelVersion>

  <groupId>com.escuela.maven.webapp</groupId>
  <artifactId>com.escuela.maven.webapp</artifactId>
  <version>1.0-SNAPSHOT</version>

  <name>com.escuela.maven.webapp</name>
  <!-- FIXME change it to the project's website -->
  <url>http://www.example.com</url>

  <properties>
    <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
    <maven.compiler.source>8</maven.compiler.source>
    <maven.compiler.target>8</maven.compiler.target>
  </properties>

  <dependencies>
    <dependency>
      <groupId>junit</groupId>
      <artifactId>junit</artifactId>
      <version>4.11</version>
      <scope>test</scope>
    </dependency>
  <!-- https://mvnrepository.com/artifact/org.slf4j/slf4j-api -->
		<dependency>
            <groupId>org.slf4j</groupId>
            <artifactId>slf4j-api</artifactId>
            <version>1.7.32</version>
        </dependency>
   <!-- https://mvnrepository.com/artifact/org.slf4j/slf4j-simple -->
        <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>slf4j-simple</artifactId>
        <version>1.7.32</version>
        </dependency>

		<dependency>
            <groupId>com.sparkjava</groupId>
            <artifactId>spark-core</artifactId>
            <version>2.9.2</version>
            <type>jar</type>
        </dependency>
      </dependencies>

  <build>
    <pluginManagement><!-- lock down plugins versions to avoid using Maven defaults (may be moved to parent pom) -->
      <plugins>
        <!-- clean lifecycle, see https://maven.apache.org/ref/current/maven-core/lifecycles.html#clean_Lifecycle -->
        <plugin>
          <artifactId>maven-clean-plugin</artifactId>
          <version>3.1.0</version>
        </plugin>
        <!-- default lifecycle, jar packaging: see https://maven.apache.org/ref/current/maven-core/default-bindings.html#Plugin_bindings_for_jar_packaging -->
        <plugin>
          <artifactId>maven-resources-plugin</artifactId>
          <version>3.0.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-war-plugin</artifactId>
          <version>3.2.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-compiler-plugin</artifactId>
          <version>3.8.0</version>
        </plugin>
        <plugin>
          <artifactId>maven-surefire-plugin</artifactId>
          <version>2.22.1</version>
        </plugin>
        <plugin>
          <artifactId>maven-install-plugin</artifactId>
          <version>2.5.2</version>
        </plugin>
        <plugin>
          <artifactId>maven-deploy-plugin</artifactId>
          <version>2.8.2</version>
        </plugin>
        <plugin>
               <groupId>org.apache.maven.plugins</groupId>
               <artifactId>maven-dependency-plugin</artifactId>
               <version>3.0.1</version>
               <executions>
                    <execution>
                    <id>copy-dependencies</id>
                    <phase>package</phase>
                    <goals><goal>copy-dependencies</goal></goals>
                    </execution>
  </executions>
         </plugin>
		 
		 </plugins>
    </pluginManagement>
  </build>
</project>" > /home/ec2-user/com.escuela.maven.webapp/pom.xml

echo "package com.escuela.maven.webapp;
import spark.Request;
import spark.Response;
import static spark.Spark.*;

/**
 * Hello world!
 *
 */
public class App
{
        public static void main(String... args){
        port(4568);
        get(\"hello\", (req,res) -> \"Hello Deploy CDK AWS!\");
                                        }
}" >  /home/ec2-user/com.escuela.maven.webapp/src/main/java/com/escuela/maven/webapp/App.java

cd /home/ec2-user/com.escuela.maven.webapp
mvn install dependency:copy-dependencies

java -cp "target/classes:target/dependency/*" com.escuela.maven.webapp.App