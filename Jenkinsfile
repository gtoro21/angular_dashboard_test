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
                    bash 'bash'
                    bash 'source ~/.nvm/nvm.sh'
                    bash 'npm install'
                    bash 'ng build --prod'
                    bash 'podman build -t nombre_de_la_imagen:test .'
            }
        }
        stage('Deploy to Pod') {
            steps {
                bash 'podman generate kube nombre_de_la_imagen:test > kubernetes.yaml'
                bash 'kubectl apply -f kubernetes.yaml'
            }
        }

    }
}