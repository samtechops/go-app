pipeline {
    agent { node { label 'jenkins-slave' } }

    parameters {
        booleanParam(defaultValue: false, name: 'CREATE_AWS_ECR', description: 'If true, the pipeline will create an ECR Repository')

    }

    environment {
        AWS_DEFAULT_REGION = 'eu-west-1'
        AWS_ACCESS_KEY_ID     = credentials('jenkins-aws-secret-key-id')
        AWS_SECRET_ACCESS_KEY = credentials('jenkins-aws-secret-access-key')
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Create ECR') {
            when {
                expression { 
                   return params.CREATE_AWS_ECR == true
                }
            }
            steps {
                echo "Terraform Apply"
                
                dir('ecr') {
                    echo "Terraform Apply Base"
                    sh "terraform init -reconfigure -backend-config=\"bucket=$TF_S3_STATE_BUCKET\" -backend-config=\"region=$AWS_DEFAULT_REGION\" -no-color"
                    sh "terraform apply -auto-approve -no-color"
                }
            }
        }
        stage('Build') {

            steps {
                echo "Building Go Application"

                sh "aws ecr get-login-password --region eu-west-1 | docker login --username AWS --password-stdin 009215683468.dkr.ecr.eu-west-1.amazonaws.com"
                sh "docker build -t go-web-api ."
                sh "docker tag go-web-api:latest 009215683468.dkr.ecr.eu-west-1.amazonaws.com/go-web-api:${GIT_COMMIT}"
                sh "docker push 009215683468.dkr.ecr.eu-west-1.amazonaws.com/go-web-api:${GIT_COMMIT}"
                echo "DEPLOYMENT_IMAGE=009215683468.dkr.ecr.eu-west-1.amazonaws.com/go-web-api:${GIT_COMMIT}"
            }
        }

        
    }

}