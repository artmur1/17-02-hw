# Домашнее задание к занятию «Основы Terraform. Yandex Cloud» - `Мурчин Артем`

### Решение - выполненный код на проверку

locals.tf - https://github.com/artmur1/17-02-hw/blob/main/code/locals.tf

main.tf - https://github.com/artmur1/17-02-hw/blob/main/code/main.tf

outputs.tf - https://github.com/artmur1/17-02-hw/blob/main/code/outputs.tf

providers.tf - https://github.com/artmur1/17-02-hw/blob/main/code/providers.tf

variables.tf - https://github.com/artmur1/17-02-hw/blob/main/code/variables.tf

vms_platform.tf - https://github.com/artmur1/17-02-hw/blob/main/code/vms_platform.tf

### Цели задания

1. Создать свои ресурсы в облаке Yandex Cloud с помощью Terraform.
2. Освоить работу с переменными Terraform.


### Чек-лист готовности к домашнему заданию

1. Зарегистрирован аккаунт в Yandex Cloud. Использован промокод на грант.
2. Установлен инструмент Yandex CLI.
3. Исходный код для выполнения задания расположен в директории [**02/src**](https://github.com/netology-code/ter-homeworks/tree/main/02/src).


### Задание 0

1. Ознакомьтесь с [документацией к security-groups в Yandex Cloud](https://cloud.yandex.ru/docs/vpc/concepts/security-groups?from=int-console-help-center-or-nav). 
Этот функционал понадобится к следующей лекции.

------
### Внимание!! Обязательно предоставляем на проверку получившийся код в виде ссылки на ваш github-репозиторий!
------

### Задание 1
В качестве ответа всегда полностью прикладывайте ваш terraform-код в git.  Убедитесь что ваша версия **Terraform** =1.5.Х (версия 1.6.Х может вызывать проблемы с Яндекс провайдером) 

1. Изучите проект. В файле variables.tf объявлены переменные для Yandex provider.
2. Создайте сервисный аккаунт и ключ. [service_account_key_file](https://terraform-provider.yandexcloud.net).
4. Сгенерируйте новый или используйте свой текущий ssh-ключ. Запишите его открытую(public) часть в переменную **vms_ssh_public_root_key**.
5. Инициализируйте проект, выполните код. Исправьте намеренно допущенные синтаксические ошибки. Ищите внимательно, посимвольно. Ответьте, в чём заключается их суть.
6. Подключитесь к консоли ВМ через ssh и выполните команду ``` curl ifconfig.me```.
Примечание: К OS ubuntu "out of a box, те из коробки" необходимо подключаться под пользователем ubuntu: ```"ssh ubuntu@vm_ip_address"```. Предварительно убедитесь, что ваш ключ добавлен в ssh-агент: ```eval $(ssh-agent) && ssh-add``` Вы познакомитесь с тем как при создании ВМ создать своего пользователя в блоке metadata в следующей лекции.;
8. Ответьте, как в процессе обучения могут пригодиться параметры ```preemptible = true``` и ```core_fraction=5``` в параметрах ВМ.

В качестве решения приложите:

- скриншот ЛК Yandex Cloud с созданной ВМ, где видно внешний ip-адрес;
- скриншот консоли, curl должен отобразить тот же внешний ip-адрес;
- ответы на вопросы.

### Решение 1

В переменной variable "vpc_name" имя default = "develop" является неуникальным. Заменил на "network1".

platform_id = "standart-v4" - исправил на "standard-v3".

core_fraction = 5 - недопустимое значение. Поменял на 20 - гарантированная доля CPU.

cores         = 1 - недопустимое значение. Поменял на 2 - количество ядер.

preemptible = true - это значит, что виртуальная машина может быть принудительно остановлена в любой момент. Снижает стоимость виртуальной машины, что помогает сэкономить деньги.

core_fraction=5 - это гарантированная доля vCPU. Но такого значения в яндекс клауд нет - минимальное значение 20. Это значит, что гарантированно мы можем использовать 20 процентов процессорного времени. Снижает стоимость виртуальной машины, что помогает сэкономить деньги.

Выполнение команды  curl ifconfig.me

![alt text](https://github.com/artmur1/17-02-hw/blob/main/img/17-2-1-1.png)

ЛК Yandex Cloud с созданной ВМ.

![alt text](https://github.com/artmur1/17-02-hw/blob/main/img/17-2-1-2.png)

### Задание 2

1. Замените все хардкод-**значения** для ресурсов **yandex_compute_image** и **yandex_compute_instance** на **отдельные** переменные. К названиям переменных ВМ добавьте в начало префикс **vm_web_** .  Пример: **vm_web_name**.
2. Объявите нужные переменные в файле variables.tf, обязательно указывайте тип переменной. Заполните их **default** прежними значениями из main.tf. 
3. Проверьте terraform plan. Изменений быть не должно. 

### Решение 2

Изменения выполнены. Они отображены в файлах:

variables.tf - https://github.com/artmur1/17-02-hw/blob/main/code/variables.tf

main.tf - https://github.com/artmur1/17-02-hw/blob/main/code/main.tf

Результат выполнения команды terraform plan

![alt text](https://github.com/artmur1/17-02-hw/blob/main/img/17-2-2-1.png)

### Задание 3

1. Создайте в корне проекта файл 'vms_platform.tf' . Перенесите в него все переменные первой ВМ.
2. Скопируйте блок ресурса и создайте с его помощью вторую ВМ в файле main.tf: **"netology-develop-platform-db"** ,  ```cores  = 2, memory = 2, core_fraction = 20```. Объявите её переменные с префиксом **vm_db_** в том же файле ('vms_platform.tf').  ВМ должна работать в зоне "ru-central1-b"
3. Примените изменения.

### Решение 3

Изменения выполнены. Они отображены в файлах:

vms_platform.tf - https://github.com/artmur1/17-02-hw/blob/main/code/vms_platform.tf

main.tf - https://github.com/artmur1/17-02-hw/blob/main/code/main.tf

На скриншоте видно 2 вновь созданные ВМ. Машина "netology-develop-platform-db" находится в зоне "ru-central1-b" с RAM=2Гб.

![alt text](https://github.com/artmur1/17-02-hw/blob/main/img/17-2-3-1.png)

### Задание 4

1. Объявите в файле outputs.tf **один** output , содержащий: instance_name, external_ip, fqdn для каждой из ВМ в удобном лично для вас формате.(без хардкода!!!)
2. Примените изменения.

В качестве решения приложите вывод значений ip-адресов команды ```terraform output```.

### Решение 4

Изменения выполнены. Они отображены в файле outputs.tf - https://github.com/artmur1/17-02-hw/blob/main/code/outputs.tf

Результат выполнения команды ```terraform output```. Имя ВМ, внешний IP адрес, а также «полностью определённое доменное имя» отображаются корректно.

![alt text](https://github.com/artmur1/17-02-hw/blob/main/img/17-2-4-1.png)

### Задание 5

1. В файле locals.tf опишите в **одном** local-блоке имя каждой ВМ, используйте интерполяцию ${..} с НЕСКОЛЬКИМИ переменными по примеру из лекции.
2. Замените переменные внутри ресурса ВМ на созданные вами local-переменные.
3. Примените изменения.

### Решение 5

Изменения выполнены. Они отображены в файлах:

locals.tf - https://github.com/artmur1/17-02-hw/blob/main/code/locals.tf

main.tf - https://github.com/artmur1/17-02-hw/blob/main/code/main.tf

Описал в файле locals.tf имя каждой ВМ, используйте интерполяцию ${..}.

![alt text](https://github.com/artmur1/17-02-hw/blob/main/img/17-2-5-1.png)

Заменил значения для name в main.tf для каждой ВМ. Старый variable name закоментировал.

![alt text](https://github.com/artmur1/17-02-hw/blob/main/img/17-2-5-2.png)

### Задание 6

1. Вместо использования трёх переменных  ".._cores",".._memory",".._core_fraction" в блоке  resources {...}, объедините их в единую map-переменную **vms_resources** и  внутри неё конфиги обеих ВМ в виде вложенного map.  
   ```
   пример из terraform.tfvars:
   vms_resources = {
     web={
       cores=
       memory=
       core_fraction=
       ...
     },
     db= {
       cores=
       memory=
       core_fraction=
       ...
     }
   }
   ```
3. Создайте и используйте отдельную map переменную для блока metadata, она должна быть общая для всех ваших ВМ.
   ```
   пример из terraform.tfvars:
   metadata = {
     serial-port-enable = 1
     ssh-keys           = "ubuntu:ssh-ed25519 AAAAC..."
   }
   ```  
  
5. Найдите и закоментируйте все, более не используемые переменные проекта.
6. Проверьте terraform plan. Изменений быть не должно.

### Решение 6

Изменения выполнены. Они отображены в файлах:

variables.tf - https://github.com/artmur1/17-02-hw/blob/main/code/variables.tf

vms_platform.tf - https://github.com/artmur1/17-02-hw/blob/main/code/vms_platform.tf

main.tf - https://github.com/artmur1/17-02-hw/blob/main/code/main.tf

В единой map-переменной прописал ресурсы обеих ВМ.

![alt text](https://github.com/artmur1/17-02-hw/blob/main/img/17-2-6-1.png)

Прописал ссылки на ресусы ВМ в файле main.tf

![alt text](https://github.com/artmur1/17-02-hw/blob/main/img/17-2-6-2.png)

В единой map-переменной прописал блок metadata. Он общий для обеих ВМ.

![alt text](https://github.com/artmur1/17-02-hw/blob/main/img/17-2-6-3.png)

![alt text](https://github.com/artmur1/17-02-hw/blob/main/img/17-2-6-4.png)

------

## Дополнительное задание (со звёздочкой*)

**Настоятельно рекомендуем выполнять все задания со звёздочкой.**   
Они помогут глубже разобраться в материале. Задания со звёздочкой дополнительные, не обязательные к выполнению и никак не повлияют на получение вами зачёта по этому домашнему заданию. 


------
### Задание 7*

Изучите содержимое файла console.tf. Откройте terraform console, выполните следующие задания: 

1. Напишите, какой командой можно отобразить **второй** элемент списка test_list.
2. Найдите длину списка test_list с помощью функции length(<имя переменной>).
3. Напишите, какой командой можно отобразить значение ключа admin из map test_map.
4. Напишите interpolation-выражение, результатом которого будет: "John is admin for production server based on OS ubuntu-20-04 with X vcpu, Y ram and Z virtual disks", используйте данные из переменных test_list, test_map, servers и функцию length() для подстановки значений.

**Примечание**: если не догадаетесь как вычленить слово "admin", погуглите: "terraform get keys of map"

В качестве решения предоставьте необходимые команды и их вывод.

------

### Задание 8*
1. Напишите и проверьте переменную test и полное описание ее type в соответствии со значением из terraform.tfvars:
```
test = [
  {
    "dev1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117",
      "10.0.1.7",
    ]
  },
  {
    "dev2" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@84.252.140.88",
      "10.0.2.29",
    ]
  },
  {
    "prod1" = [
      "ssh -o 'StrictHostKeyChecking=no' ubuntu@51.250.2.101",
      "10.0.1.30",
    ]
  },
]
```
2. Напишите выражение в terraform console, которое позволит вычленить строку "ssh -o 'StrictHostKeyChecking=no' ubuntu@62.84.124.117"
------

------

### Задание 9*

Используя инструкцию https://cloud.yandex.ru/ru/docs/vpc/operations/create-nat-gateway#tf_1, настройте для ваших ВМ nat_gateway. Для проверки уберите внешний IP адрес (nat=false) у ваших ВМ и проверьте доступ в интернет с ВМ, подключившись к ней через serial console. Для подключения предварительно через ssh измените пароль пользователя: ```sudo passwd ubuntu```

### Правила приёма работыДля подключения предварительно через ssh измените пароль пользователя: sudo passwd ubuntu
В качестве результата прикрепите ссылку на MD файл с описанием выполненой работы в вашем репозитории. Так же в репозитории должен присутсвовать ваш финальный код проекта.

**Важно. Удалите все созданные ресурсы**.


### Критерии оценки

Зачёт ставится, если:

* выполнены все задания,
* ответы даны в развёрнутой форме,
* приложены соответствующие скриншоты и файлы проекта,
* в выполненных заданиях нет противоречий и нарушения логики.

На доработку работу отправят, если:

* задание выполнено частично или не выполнено вообще,
* в логике выполнения заданий есть противоречия и существенные недостатки. 

