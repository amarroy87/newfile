pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Checkout the code from the repository
                git branch: 'main', url: 'https://github.com/ApasoftTraining/pipeline-maven-java.git'
            }
        }
        stage('Build') {
            steps {
                echo 'Building...'
                // Compile the code using Maven
                sh 'mvn clean compile'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                // Run tests using Maven
                sh 'mvn test'
            }
        }
        stage('Package') {
            steps {
                echo 'Packaging...'
                // Package the application using Maven
                sh 'mvn package'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying...'
                // Run the Java program with an example argument
                sh 'java -cp target/your-app-1.0-SNAPSHOT.jar com.apasoft.ToUpper "example test"'
            }
        }
    }
}
