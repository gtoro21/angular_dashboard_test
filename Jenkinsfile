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

        stage('Example') {
            steps {
                script {
                    // Cambiar a otro usuario usando credenciales
                    withCredentials([usernamePassword( usernameVariable: 'gabriel', passwordVariable: 'gatg1221')]) {
                        // Aquí puedes ejecutar comandos como el usuario especificado
                        sh '''
                        echo "Ejecutando como $USERNAME"
                        # Comandos que requieren permisos del nuevo usuario
                        '''
                    }
                }
            }
        }
        
        stage('Build') {
            steps {
                    // sh 'npm install'
                    // sh 'ng build --prod'
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