pipeline {
    agent any
    environment {
        VERSION = '1.0'
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/gtoro21/angular_dashboard_test.git', branch: 'main', credentialsId: '4dec74cea5403e4558072c23e301531e18e6e888'
            }
        }
        stage('Install Node.js and npm') {
            steps {
                sh 'curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -'
                sh 'sudo apt-get install -y nodejs'
            }
        }
        stage('Set PATH') {
            steps {
                sh 'echo "export PATH=$PATH:/usr/local/bin" >> ~/.bashrc'
                sh 'source ~/.bashrc'
            }
        }
        stage('Clean and Install') {
            steps {
                sh 'rm -rf node_modules'
                sh 'npm cache clean --force'
                sh 'npm install'
            }
        }
        stage('Build') {
            steps {
                sh 'ng build --prod'
            }
        }
    }
}