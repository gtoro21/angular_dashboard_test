pipeline {
    agent any
    environment {
        VERSION = '1.0'
    }
    stages {
        stage('Checkout') {
            steps {
                git url: 'URL_DEL_REPOSITORIO_GIT', branch: 'master', credentialsId: 'ID_DE_LAS_CREDENCIALES'
            }
        }
        stage('Build') {
            steps {
                sh 'npm install'
                sh 'ng build --prod'
                sh 'podman --socket /var/run/podman/podman.sock build -t nombre_de_la_imagen:${VERSION}.${BUILD_NUMBER} .'
            }
        }
        stage('Deploy to Pod') {
            steps {
                sh 'podman --socket /var/run/podman/podman.sock generate kube nombre_de_la_imagen:${VERSION}.${BUILD_NUMBER} > kubernetes.yaml'
                sh 'kubectl apply -f kubernetes.yaml'
            }
        }
    }
}