#!/bin/bash

ISO_IMAGE_URL="https://cdn.intra.42.fr/isos/SnowCrash.iso"
ISO_IMAGE_NAME="OS_guest.iso"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    WORK_FOLDER=$HOME
    mkdir -p $WORK_FOLDER/vb_mdulcie
    MEMORY=512
    CPUS=1
    HD_SIZE=10000
elif [[ "$OSTYPE" == "darwin"* ]]; then
    WORK_FOLDER="/Users/mdulcie/goinfre"
    MEMORY=4096
    CPUS=6
    HD_SIZE=20000
else
    echo Oopps
    exit
fi

# доступные ОС для установки на машине хосте.
# VBoxManage list ostypes

#  создать виртуальную машину и зарегистрировать в списке виртуальных машин
echo -e "\033[32m Virtual machine: Create and register \033[0m"
VBoxManage createvm                                     \
                    --name vb_mdulcie                   \
                    --register                          \
                    --basefolder $WORK_FOLDER           
                    # --basefolder /home/user

# NETWORK=$(VBoxManage hostonlyif create | grep vboxnet[[:digit:]] -E -o)
# NETWORK_NB=$(echo $NETWORK | grep [[:digit:]] -E -o)

# настроить виртуальную машину
# if VBoxManage list hostonlyifs | grep vboxnet0; then
#     NETWORK=vboxnet0
#     NETWORK_NB=0
# else
#     NETWORK=$(VBoxManage hostonlyif create | grep vboxnet[[:digit:]] -E -o)
#     NETWORK_NB=$(echo $NETWORK | grep [[:digit:]] -E -o)
# fi

echo -e "\033[32m Virtual machine: setup \033[0m"
VBoxManage modifyvm        vb_mdulcie                   \
                    --vram 64                           \
                    --pae on                            \
                    --longmode on                       \
                    --apic on                           \
                    --x2apic on                         \
                    --nestedpaging on                   \
                    --nested-hw-virt on                 \
                    --rtcuseutc on                      \
                    --cpus $CPUS                        \
                    --memory $MEMORY                    \
                    # --cpus 1                            \
                    # --memory 1024                       \
                    # --clipboard   bidirectional         \
                    # --draganddrop bidirectional         \
                    # --graphicscontroller vmsvga

##########
# Создать диски
# контроллер
echo -e "\033[32m Virtual machine: create controller \033[0m"
VBoxManage storagectl      vb_mdulcie                   \
                    --name "IDE Controller"             \
                    --add ide

# жесткий диск
echo -e "\033[32m Virtual machine: create hard disk \033[0m"
VBoxManage createmedium                                  \
                    --filename $WORK_FOLDER/vb_mdulcie/vb_mdulcie.vhd \
                    --size $HD_SIZE                      \
                    --variant Fixed                      \
                    # --filename /home/user/vb_mdulcie/vb_mdulcie.vhd \
                    # --size 10000                         \
                    
# Присоединить жесткий диск к контроллеру
echo -e "\033[32m Virtual machine: attach hard disk to controller \033[0m"
VBoxManage storageattach   vb_mdulcie                   \
                    --storagectl "IDE Controller"       \
                    --port 0                            \
                    --device 0                          \
                    --type hdd                          \
                    --medium $WORK_FOLDER/vb_mdulcie/vb_mdulcie.vhd
                    # --medium /home/user/vb_mdulcie/vb_mdulcie.vhd

# скачать установочный образ системы гостевой машины
echo -e "\033[32m Virtual machine: download the installation \n                  \
image of the guest machine system \033[0m"

# curl -o /home/user/OS_guest.iso https://cdn.intra.42.fr/isos/SnowCrash.iso
if test -f $WORK_FOLDER/$ISO_IMAGE_NAME ; then
    echo present
else
    curl -o $WORK_FOLDER/$ISO_IMAGE_NAME $ISO_IMAGE_URL
fi

# присоединить установочный образ системы гостевой машины
echo -e "\033[32m Virtual machine: attach   the installation \n                  \
image of the guest machine system \033[0m"
VBoxManage storageattach   vb_mdulcie                   \
                    --storagectl "IDE Controller"       \
                    --port 1                            \
                    --device 0                          \
                    --type dvddrive                     \
                    --medium $WORK_FOLDER/$ISO_IMAGE_NAME
                    # --medium /home/user/OS_guest.iso

# запустить машину с установочного диска
echo -e "\033[32m Virtual machine: run with the installation \n                  \
image of the guest machine system \033[0m"
VBoxManage modifyvm        vb_mdulcie --boot1 dvd
VBoxManage startvm         vb_mdulcie --type gui

# rm -r $WORK_FOLDER