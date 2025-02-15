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
        stage('Run Bash Commands') {
            steps {
                // Ejecutar comandos de Bash
                sh '''
                bash
                source ~/.nvm/nvm.sh
                ng version
                ls -la
                '''
            }
        }
        stage('Build') {
            steps {
                    sh '. ~/.nvm/nvm.sh'
                    sh 'node -v'
                    sh 'npm -v'
                    sh 'npm install'
                    sh 'ng build --prod'
                    sh 'podman build -t nombre_de_la_imagen:test .'
            }
        }
        stage('Deploy to Pod') {
            steps {
                sh 'podman generate kube nombre_de_la_imagen:test > kubernetes.yaml'
                sh 'kubectl apply -f kubernetes.yaml'
            }
        }

    }
}