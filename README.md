# NgNet

NgNET is a boilerplate application featuring Docker, Angular 15 frontend with hot reload, Bootstrap 5, .NET 7.0 WebApi backend, automatic PostgreSQL database migration, and PgAdmin.

## Features
- Single command **docker-compose up** to run the whole full-stack application
- Angular 15, Bootstrap 5 in the frontend
- Hot reload enabled, so changes in Angular project will be reflected in the browser automatically
- ASP.NET 7.0 WEBAPI in the backend
- CORS policy enabled
- Automatic Database migration with dummy data
- Swagger is enabled for APIs
## Angular Application
![NgNET](https://i.imgur.com/8BxL1Wm.png)
## WebAPI
![NgNET](https://i.imgur.com/2AXvZe5.png)
## Swagger
![NgNET](https://i.imgur.com/UA9jnpK.png)
## PgAdmin
![NgNET](https://i.imgur.com/xNiYRRx.png)
## Getting Started

## Project Architecture
![WhatsApp Image 2025-12-18 at 6 12 24 PM](https://github.com/user-attachments/assets/f0ddf898-793a-4221-b705-8d011da98331)

## To run from your pc build frontend and backend using docker then apply your deployments 
<img width="1497" height="692" alt="image-frontend" src="https://github.com/user-attachments/assets/bd298422-7bd4-40ac-9650-2f09a5e239ac" />
<img width="1463" height="651" alt="image-backend" src="https://github.com/user-attachments/assets/154a26a0-357d-476d-a23b-a4ec394c3e9a" />

## using these commands 
minikube image load backend

minikube image load frontend

kubectl apply -f postgres-deployment.yaml

kubectl apply -f backend-deployment.yaml

kubectl apply -f frontend-deployment.yaml

minikube service frontend

## To run from AWS follow these steps 
create i am user and give it permissions 

create access key 

download aws cli 
run aws configure (enter the access key and region)

create bucket to create terraform locks inside it 

aws s3 mb s3://dev-ops-terraform-state --region us-east-1
aws dynamodb create-table --table-name terraform-locks --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5 --region us-east-1

## inside terraform folder run these commands 
terraform init

terraform apply 

Build images then push images into ECR
docker tag backend:latest public.ecr.aws/t5z8k5y0/backend-api:latest

docker push public.ecr.aws/t5z8k5y0/backend-api:latest

docker tag frontend:latest public.ecr.aws/t5z8k5y0/frontend-app:latest

docker push public.ecr.aws/t5z8k5y0/frontend-app:latest

<img width="1887" height="881" alt="Screenshot 2025-12-18 21014466" src="https://github.com/user-attachments/assets/863bb273-680d-433c-b464-c57a4ed43af9" />

## Use Jenkins to automate the process
<img width="1865" height="952" alt="Screenshot 2025-12-18 204749" src="https://github.com/user-attachments/assets/9c3f814a-290e-446f-b107-682126a546fb" />

<img width="1085" height="307" alt="frontend-push" src="https://github.com/user-attachments/assets/7e5ac883-7b42-4d4a-963f-dbd74ff4f117" />
<img width="1335" height="280" alt="backend_push" src="https://github.com/user-attachments/assets/a3cb7aef-298b-47e6-81bd-021131fa635e" />
<img width="1752" height="956" alt="jen" src="https://github.com/user-attachments/assets/8a9b0138-5e28-47a5-80f1-d3a52cc8ba89" />

## Output will be like that
<img width="1747" height="960" alt="output" src="https://github.com/user-attachments/assets/a1faedef-babf-4511-8fa5-f10fd52cf55e" />
