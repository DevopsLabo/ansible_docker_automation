
## Qué hace este proyecto?
La idea es realizar el aprovisionamiento de un entorno Docker en VMs, utilizando las características de IaC ofrecidas por [Ansible](https://docs.ansible.com/).

## Qué se incluye?
Se incluyen archivos:
- **Vagrantfile**: Archivo descriptivo de infraestructura con la definición de 3 VMs
- **provision-general.sh** y **provision-ansible.sh**: Archivos que ejecutan scripts de aprovisionamiento de paquetes
- **hosts**: Archivo con definición de hosts y direcciones IP para funciones de networking
- **passwd_file**: Archivo con contraseña de usuario root para ejecución de comandos ssh
- **myhosts**: Definición de grupos de hosts Ansible
- **playbook-docker.yml**: Libro de tareas de Ansible para desplegar operaciones en hosts

## Prerequisitos
- Práctica realizada en el proyecto [vagrant_vm_provisioning](https://github.com/DevopsLabo/vagrant_vm_provisioning) donde se explica la provisión de VMs mediante Vagrant.

## Paso a paso
1. Clonar el repositorio en un directorio local
```
git clone https://github.com/DevopsLabo/ansible_docker_automation.git
```

2. Ejecutar el aprovisionamiento, desde el directorio del proyecto
```
cd ./ansible_docker_automation && vagrant up
```

4. Controlar las VMs creadas verficando mediante comandos `ping` (por ejemplo a ansible-ctrl)
```
ping 192.168.56.10
```

5. Desde la VM 'ansible-ctrl' utilizar Ansible para instalar Docker en las VMs restantes
```
vagrant ssh ansible-ctrl
```
```
cd /vagrant/ansible && ansible-playbook -i myhosts -K playbook-docker.yml
```
Al ejecutar el Playbook deberá proporcionar la contraseña de root ("vagrant").

6. Verificar la instalación de Docker y Docker Compose en los nodos, mediante comandos Ad-hoc de Ansible
```
ansible nodes -i myhosts -m command -a 'docker version'
```
ó ingresar a la vm y comprobarlo con línea de comandos
```
ssh vm1
```
```
docker version
docker-compose version
```

7. Jugar con las VMs mediante los comandos disponibles en Ansible
- [Guía útil de comandos de Ansible](https://docs.ansible.com/ansible/latest/index.html)

8. Para dar de baja las VMs en forma definitiva ejecutar, en el directorio local
```
vagrant destroy
```
