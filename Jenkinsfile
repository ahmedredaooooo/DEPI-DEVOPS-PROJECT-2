pipeline {
  agent any

  environment {
    AWS_REGION = "us-east-1"
    ECR_PUBLIC = "public.ecr.aws/t5z8k5y0"
    BACKEND_IMG = "backend-api"
    FRONTEND_IMG = "frontend-app"
  }

  stages {

    stage('Checkout') {
      steps {
        git 'https://github.com/ahmedredaooooo/DEPI-DEVOPS-PROJECT-2'
      }
    }

    stage('Login to ECR Public') {
    steps {
        withCredentials([
            string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
            string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
        ]) {
            sh '''
            aws ecr-public get-login-password --region $AWS_REGION \
            | docker login --username AWS --password-stdin $ECR_PUBLIC
            '''
        }
    }
}

    stage('Build Backend') {
      steps {
        sh '''
        docker build -t $ECR_PUBLIC/$BACKEND_IMG:latest Backend
        docker push $ECR_PUBLIC/$BACKEND_IMG:latest
        '''
      }
    }

    stage('Build Frontend') {
      steps {
        sh '''
        docker build -t $ECR_PUBLIC/$FRONTEND_IMG:latest Frontend
        docker push $ECR_PUBLIC/$FRONTEND_IMG:latest
        '''
      }
    }

    stage('Deploy to EKS') {
    steps {
        withCredentials([
            string(credentialsId: 'aws-access-key', variable: 'AWS_ACCESS_KEY_ID'),
            string(credentialsId: 'aws-secret-key', variable: 'AWS_SECRET_ACCESS_KEY')
        ]) {
            sh '''
        export AWS_DEFAULT_REGION=us-east-1
        aws eks update-kubeconfig --region $AWS_DEFAULT_REGION --name dev-eks
        export KUBECONFIG=/var/lib/jenkins/.kube/config
        kubectl get nodes
        kubectl rollout restart deployment backend-deployment
        kubectl rollout restart deployment frontend-deployment
      '''
        }
    }
}
  
}
}
