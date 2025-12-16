pipeline {
  agent any

  environment {
    AWS_REGION = "us-east-1"
    ECR_PUBLIC = "public.ecr.aws/t5z8k5y0"
    BACKEND_IMG = "backend"
    FRONTEND_IMG = "frontend"
  }

  stages {

    stage('Checkout') {
      steps {
        git 'https://github.com/ahmedredaooooo/DEPI-DEVOPS-PROJECT-2'
      }
    }

    stage('Login to ECR Public') {
      steps {
        sh '''
        aws ecr-public get-login-password --region us-east-1 \
        | docker login --username AWS --password-stdin public.ecr.aws
        '''
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
        sh '''
        aws eks update-kubeconfig --region us-east-1 --name dev-eks-cluster
        kubectl rollout restart deployment backend-deployment
        kubectl rollout restart deployment frontend-deployment
        '''
      }
    }
  }
}
