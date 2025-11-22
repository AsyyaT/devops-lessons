### Домашнє завдання 7: Розгортання Django на Kubernetes

### Опис

Це завдання демонструє:

1. Створення кластера Kubernetes через Terraform (AWS EKS).
2. Налаштування Elastic Container Registry (ECR) для зберігання Docker-образу Django.
3. Завантаження Docker-образу у ECR.
4. Створення Helm chart з:
   - Deployment (Django-поди)
   - Service (LoadBalancer)
   - ConfigMap (змінні середовища)
   - HPA (автоматичне масштабування)
5. Правильне підключення секретів для бази даних PostgreSQL.


## Команди

### 1. Перевірка доступних вузлів Kubernetes

```bash
kubectl get nodes
```


### 2. Створення секрету з даними бази даних

Рекомендовано зберігати чутливі дані у Kubernetes Secret, а не в ConfigMap.

kubectl create secret generic django-db-secret \
  --from-literal=POSTGRES_DB=db_name \
  --from-literal=POSTGRES_USER=db_user \
  --from-literal=POSTGRES_PASSWORD=db_pass \
  --from-literal=DB_HOST=db \
  --from-literal=DB_PORT=5432


Після цього у Deployment можна підключити секрет через envFrom.secretRef.


### Перевірка Helm chart перед деплоєм
```bash
helm lint charts/app-name/
helm template app-name charts/app-name/ --values charts/app-name/values.yaml
```