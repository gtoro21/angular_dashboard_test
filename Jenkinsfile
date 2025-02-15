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
        stage('Build') {
            steps {
                nodejs(nodeJSInstallationName: 'Node 16.20'){
                    sh 'npm install'
                    sh 'ng build --prod'
                    sh 'podman build -t nombre_de_la_imagen:${VERSION}.${BUILD_NUMBER} .'
                }
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