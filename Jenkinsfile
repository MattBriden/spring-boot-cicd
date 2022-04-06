pipeline {
    agent any
    tools {
        maven 'Maven 3.3.9'
        jdk 'jdk8'
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Clone repository') {
            steps {
                script{
                    checkout scm
                }
            }
        }
        stage('Build Artifact') {
            steps {
                sh 'mvn clean install'
            }
        }
        stage('Build') {
            steps {
                script{
                    app = docker.build("springboot-cicd-api:latest")
                }
            }
        }
        stage('Upload Image') {
            steps {
                script {
                    docker.withRegistry('https://891709250373.dkr.ecr.us-east-1.amazonaws.com', 'ecr:us-east-1:aws-credentials') {
                        app.push("${env.BUILD_NUMBER}")
                        app.push("latest")
                    }
                }
            }
        }
        stage('Deploy'){
            steps {
                 sh 'kubectl apply -f api.yml'
            }
        }
    }
}