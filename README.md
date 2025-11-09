## ДЗ5 – Terraform Infrastructure on AWS

## Опис модулів

### S3 + DynamoDB (modules/s3-backend)
- Створює S3-бакет для зберігання Terraform state
- Створює DynamoDB таблицю для блокування state


### VPC (modules/vpc)
- Створює VPC з CIDR блоком
- 3 публічні та 3 приватні підмережі
- Internet Gateway для публічних підмереж
- NAT Gateway для приватних підмереж
- Маршрутизація через Route Tables


### ECR (modules/ecr)
- Створює ECR репозиторій для Docker образів
- Включає автоматичне сканування образів


## Команди

```bash
terraform init
terraform plan
terraform apply
terraform destroy
