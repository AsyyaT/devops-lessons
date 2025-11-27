
# DevOps Lessons - Terraform + Jenkins + Argo CD

## 1. Застосування Terraform

1. Ініціалізація Terraform:
```bash
terraform init
````

2. Планування змін:

```bash
terraform plan
```

3. Застосування змін:

```bash
terraform apply
```

> Після `apply` Jenkins і всі необхідні ресурси будуть створені або оновлені у Kubernetes.

---

## 2. Перевірка Jenkins job

1. Отримати пароль адміністратора Jenkins:

```bash
kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
```

2. Отримати URL Jenkins:

```bash
kubectl get svc -n jenkins jenkins
```

3. Увійти в Jenkins через браузер, використовуючи `admin` і отриманий пароль.

4. Перевірити seed-job:

   * Відкрити `seed-job` в Jenkins.
   * Переконатися, що job створює pipeline для проекту Django.
   * Pipeline має підключатися до GitHub і будувати образ у ECR.

---

## 3. Перегляд результату в Argo CD

1. Відкрити Argo CD UI (через LoadBalancer або порт-форвардинг):

```bash
kubectl port-forward svc/argo-cd-server -n argocd 8080:443
```

* Далі відкрити [https://localhost:8080](https://localhost:8080) в браузері.

2. Залогінитися:

   * Ім’я користувача: `admin`
   * Пароль: взяти з секрету Argo CD:

```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

3. Синхронізація додатку:

   * В Argo CD обрати додаток, який відповідає твоєму Django-проєкту.
   * Натиснути **Sync** з такими опціями:

     * `Revision`: lesson-8-9
     * `Prune`: ✅
     * `Apply Out of Sync Only`: ✅
     * `Server-Side Apply`: ✅
     * `Prune Propagation Policy`: `foreground`
   * Натиснути **Synchronize / Apply**.

4. Перевірити стан:

   * Статус додатку має бути **Synced** та **Healthy**.
   * Можна перевірити всі ресурси (Deployment, Service, ConfigMap, HPA) у UI.

---

### 1️⃣ Назва модуля та короткий опис

```markdown
# Terraform RDS Module

Універсальний модуль для створення бази даних AWS:
- Підтримка Aurora та звичайної RDS (`use_aurora`).
- Створює DB Subnet Group, Security Group, Parameter Group.
- Підтримує налаштування engine, версії, класу інстансу, multi-AZ.
```

---

### 2️⃣ Приклад використання

```hcl
module "rds" {
  source      = "./modules/rds"
  
  use_aurora       = false       # true для Aurora, false для RDS
  engine           = "postgres"
  engine_version   = "17.2"
  instance_class   = "db.t3.medium"
  multi_az         = true
  db_name          = "myapp"
  password         = "secure_password"
  subnet_ids       = ["subnet-aaa", "subnet-bbb", "subnet-ccc"]
  vpc_id           = "vpc-xxxx"
  tags             = {
    Environment = "dev"
    Project     = "myapp"
  }
}
```

---

### 3️⃣ Опис змінних

| Змінна           | Тип    | Значення за замовчуванням | Опис                                    |
| ---------------- | ------ | ------------------------- | --------------------------------------- |
| `use_aurora`     | bool   | false                     | Використовувати Aurora або звичайну RDS |
| `engine`         | string | "postgres"                | Тип БД (postgres, mysql тощо)           |
| `engine_version` | string | "17.2"                    | Версія БД                               |
| `instance_class` | string | "db.t3.medium"            | Клас інстансу (для RDS)                 |
| `multi_az`       | bool   | true                      | Multi-AZ розгортання                    |
| `db_name`        | string | "myapp"                   | Ім'я бази даних                         |
| `password`       | string | -                         | Пароль користувача postgres             |
| `subnet_ids`     | list   | []                        | Список підмереж для DB Subnet Group     |
| `vpc_id`         | string | -                         | ID VPC                                  |
| `tags`           | map    | {}                        | Теги для ресурсів                       |

---

### 4️⃣ Як змінити конфігурацію

* **Тип БД та engine:** змінюємо `use_aurora` і `engine`.
* **Версія engine:** `engine_version`.
* **Клас інстансу:** `instance_class`.
* **Multi-AZ:** `multi_az = true/false`.
* **Subnet group та VPC:** передаємо `subnet_ids` і `vpc_id`.

---

