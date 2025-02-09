pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                script {
                if (env.BRANCH_NAME == 'prod') {
            sh '''
            cd code/
            docker build -t farrasyakila/laravel-9:$BUILD_NUMBER-prod .
            '''
                }
                else {
                    sh 'echo Nothing to Build'
                }
            }
        }
    }
    stage('push') {
        steps {
            script {
             if (env.BRANCH_NAME == 'prod') {
            sh 
            'docker push farrasyakila/laravel-9:$BUILD_NUMBER-prod' 
                }
                else {
                    sh 'echo Nothing to Build'
                }
            }
          }
        } 
        stage('deploy') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'prod') {
                    sh '''
                        cd k8s-deployment/
                        # Replace image tag with the current BUILD_NUMBER
                        sed -i "s|farrasyakila/laravel-9:prod|farrasyakila/laravel:${BUILD_NUMBER}-prod|" laravel-deployment.yaml
                    
                        cat laravel-deployment.yaml | grep image:

                        # Apply Kubernetes configurations
                        kubectl apply -f laravel-namespace.yaml
                        kubectl apply -f laravel-deployment.yaml
                        kubectl apply -f laravel-service.yaml
                        kubectl apply -f laravel-secret.yaml
                        kubectl apply -f laravel-ingress.yaml
                        kubectl apply -f laravel-hpa.yaml
                        kubectl apply -f mysql-namespace.yaml
                        kubectl apply -f mysql-deployment.yaml
                        kubectl apply -f mysql-service.yaml
                        kubectl apply -f mysql-secret.yaml
                        kubectl apply -f mysql-pv.yaml
                        kubectl apply -f mysql-pvc.yaml
                    '''
                }
                    else {
                    sh 'echo Nothing to Build'
                    }
                }
            }
        }
    }
}