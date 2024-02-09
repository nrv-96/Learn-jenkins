pipeline {
    agent { 
        node {
            label 'docker-agent-python'
            }
      }
    triggers {
        pollSCM '* * * * *'
    }
    stages {
        stage('Build') {
            steps {
                echo "Building.."
                sh '''
                cd myapp
                pip install -r requirements.txt
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Testing.."
                sh '''
                cd myapp
                python3 hello.py
                python3 hello.py --name=Brad
                '''
            }
        }
        stage('Deliver') {
            steps {
                echo 'Deliver....'
                sh '''
                echo "doing delivery stuff.."
                '''
            }
        }
        stage('Deploy') {
            environment {                
                ENVIRONMENT = sh(script: 'echo $BRANCH_NAME', returnStdout: true).trim()
            }
            steps {
                script {
                    if (ENVIRONMENT == 'dev') {
                        sh 'echo "Deploying to dev environment..."'
                    } else if (ENVIRONMENT == 'stage') {
                        sh 'echo "Deploying to stage environment..."'
                    } else if (ENVIRONMENT == 'prod') {
                        sh 'echo "Deploying to prod environment..."'
                    } else {
                        error "Unsupported environment: $ENVIRONMENT"
                    }
                }
            }
        }
    }
}
