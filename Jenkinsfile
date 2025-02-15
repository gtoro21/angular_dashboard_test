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
        stage('Install NVM') {
            steps {
                sh 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash'
                sh '''
                  export NVM_DIR="$HOME/.nvm"
                  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
                  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
                  source ~/.bashrc
                  nvm --version
                '''
            }
        }
        stage('Node Setup') {
            steps {
                sh 'nvm install v16.17.0' // Installs the latest version of v16.17.0.js
                sh 'nvm use v16.17.0'     // Use the installed version
                sh 'node -v'          // Verify node is installed
                sh 'npm -v'           // Verify npm is installed
            }
        }
        stage('Build') {
            steps {
                    sh 'nvm ls'
                    sh 'npm install'
                    sh 'ng build --prod'
                    sh 'podman build -t nombre_de_la_imagen:${VERSION}.${BUILD_NUMBER} .'
            }
        }
        stage('Deploy to Pod') {
            steps {
                sh 'podman generate kube nombre_de_la_imagen:${VERSION}.${BUILD_NUMBER} > kubernetes.yaml'
                sh 'kubectl apply -f kubernetes.yaml'
            }
        }

    }
}