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
                sh '''
                    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # Esto carga nvm
                    [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # Esto carga la autocompletación de nvm
                    source ~/.bashrc
                    nvm --version
                '''
            }
        }
        stage('Node Setup') {
            steps {
                sh '''
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # Carga nvm
                    nvm install 16.17.0  # Instala la última versión de 16.17.0.js
                    nvm use 16.17.0      # Usa la versión instalada
                    node -v           # Verifica que Node.js esté instalado
                    npm -v            # Verifica que npm esté instalado
                '''
            }
        }
        stage('Build') {
            steps {
                sh '''
                    export NVM_DIR="$HOME/.nvm"
                    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # Carga nvm
                    npm install
                    ng build --prod
                    podman build -t nombre_de_la_imagen:${VERSION}.${BUILD_NUMBER} .
                '''
            }
        }
        stage('Deploy to Pod') {
            steps {
                sh '''
                    podman generate kube nombre_de_la_imagen:${VERSION}.${BUILD_NUMBER} > kubernetes.yaml
                    kubectl apply -f kubernetes.yaml
                '''
            }
        }
    }
}