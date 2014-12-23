
# Operációs rendszerek I.<br/> 2. gyakorlat

---
# *ls -l* parancs kimenete

- típus (fájl, könyvtár, szimbolikus link, socket, stb.)
- jogok (3*rwx)
- könyvtár: hány "link van a könyvtárban", fájl: Hány link mutat rá
- tulajdonos és csoportja
- hány bájt a fájl (-h kapcsolóval érthetőbb lesz a méret)
- utolsó hozzáférés dátuma
- fájl neve

# *ln -s* parancs

- elérési út
- link neve
- A létrehozott soft link (hard linkhez: *link* parancs) a mienk, az amire mutat már nem feltétlenül

---

# Gyors ismétlés: *chmod*

- Egységes jogosultság kezelés (oktális)
- Három szint (User, Group, Other/World)
- Három mód: 1 (eXecute), 2 (Write), 4 (Read)
    - Könyvtáron az eXecute a listázás joga
- +/- jelekkel lehet a jogokat megadni és megvonni (pl.: *chmod +x script.sh*)
- *chmod u=rwx,g=rw,o= file.txt*: Egyenlőség jel csak azokat a jogokat adja meg, a többit elveszi, vessző felsorolás
- Az ls parancs nem tudja magától kiírni a számokat ([forrás](http://stackoverflow.com/a/1796009)):

        !bash
        ls -l | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/) *2^(8-i)); \
        if(k)printf("%0o ",k);print}'

- Mit lehet tenni ha kiadjuk a *chmod -x chmod* parancsot?
    - [Előadás](https://www.youtube.com/watch?v=DTWZqh64RcQ)
    - [Magyar hozzászólások](http://hup.hu/node/134301)

---

# Néhány szó a fájlok törléséről: *rm*

- Könyvtárat nem töröl (rmdir)
- \-f kapcsoló: **Force** veszélyes, de hasznos
- \-r kapcsoló: **Recursive** még veszélyesebb, de még hasznosabb
- Beépített vételem alapból
- Fájlok felsorolhatóak, vigyázni kell vele:

        !bash
        rm -rf / könyvtár

- [Lomtár Unix módra](http://freedesktop.org/wiki/Specifications/trash-spec/)
    - [Megvalósítás](https://github.com/andreafrancia/trash-cli)

---

# Próbáljuk ki a parancsokat!

1. Hány bájtot foglal egy könyvtár?
1. Hány link van alapból egy könyvtárban?
1. Írjuk be egy fájlba, hogy 'árvíztűrő tükörfúrógép' hány bájtos a fájl?
1. Milyen csoport birtokolja a /dev/sr0-t?
1. Kiknek és milyen jogai vannak az a /dev/shm-hoz?
1. Hozzunk létre egy linket a /dev/shm-re a home könyvtárunkból!
1. Honnan látjuk az ls kimenetén, hogy link?
1. Hozzunk létre egy fájlt, vegyük el az írásjogot próbáljuk törölni!
1. Hozzunk létre egy fájlt, vegyük el az olvasásjogot próbáljunk bele írni!
1. Hozzunk létre egy könyvtárat, vegyük el a listázás jogát!
1. Az előző könyvtárba hozzunk létre egy fájlt valamilyen szöveggel!
1. Olvassuk ki az előző fájl tartalmát!
1. Töröljük az előző fájlt! Miért jelent biztonsági rést, ha csak a listázási jogot vesszük el?

---

# A fontosabb főkönyvtárak: /etc

Könyvtárváltás: *cd könyvtár neve*

- /etc/passwd: a felhasználók adatai (Nézzük meg az users-en!)
    - Felhasználónév
    - Jelszó (hagyományból, mindenhol x)
    - User ID (1000 fölött az igazi felhasználók, alatta daemonok, 0 a root)
    - Group ID (1000 fölött az igazi csoportok, alatta daemonok, 0 a root)
    - Teljes név
    - Home könyvtár
    - shell
- /etc/group: a felhasználói csoportok (Nézzük meg az users-en!)
    - Csoport neve
    - Jelszó
    - Group ID
    - tagok felsorolása

---

# A fontosabb főkönyvtárak: /etc

- /etc/cron.*: az ütemezett feladatok (később)
- /etc/(g)?shadow: a valódi tárolt jelszavak
- /etc/sudoers: a sudo parancs beállításai (később)
- /etc/hostname: a gép neve
- /etc/hosts: dns cache (régi maradvány)
- /etc/X11: grafikus felülettel kapcsolatos beállítások
- /etc/aliases: belső levelezéshez szükséges aliasok
- /etc/fstab: csatolási beállítások
- /etc/init.d: indítási beállítások
- /etc/inittab: terminál indulási beállítások (Ubuntun nincs ilyen, lassan már máshol sem)
- /etc/motd: Message of the Day [lehet fokozni](http://systembash.com/content/adding-random-quotes-to-the-bash-login-screen/)
- /etc/shells: a választható shellek
- /etc/alternatives: a standard parancsok aktuális implementációi

---

# A fontosabb főkönyvtárak: /proc

- /proc/PID/cmdline: parancssori paraméterek
- /proc/PID/cpu: az aktuális és az előző cpu amin futott a program
- /proc/PID/fd: a nyitva levő fájlleírók
- /proc/PID/status: emberi formában az összes információ
- Ezeket olvasgatják a sokkal emberközelibb programok
    - top
    - htop
    - stb.

---

# A fontosabb főkönyvtárak: /usr

- /usr/bin: futtatható bináris fájlok
- /usr/include: header fájlok
- /usr/share: minden 'független' fájl (ikonok, fontok, dokumentációk stb.)
- /usr/src: a Linux headerek
- /usr/local: forrásból telepített programok
- /usr/lib: az osztott függvénykönyvtárak helye (dll-ek)
- Van még tovább is, de a szabványban próbálják egyszerűsíteni a felépítését


---

# A fontosabb főkönyvtárak: /var

- /var/log: a rendszernaplók gyűjtőhelye
    - dmesg: alacsony szintű kernel üzenetek
    - boot.log: indulási napló
    - dpkg.log: csomagkezelő naplója
    - kern.log: kernel üzenetek
    - syslog: egyéb rendszer üzenetek
    - Xorg.0.log: X napló
- /var/lock: lock fájlok
- /var/www: http root
- /var/spool: levelek, nyomtatási sor, stb.
- /var/cache: cache fájlok

---

# A parancssor: Parancsok futtatása

- Ha csak visszakapjuk a promptot minden egyéb nélkül -\> Sikeresen végrehajtva
- Ha a rendszernek közölnivalója van, kiírja, ha nincs akkor nem ír semmit
- A szöveges fájlok és hibaüzenetek végén [általában megköveteli a rendszer az új sort](https://bugs.launchpad.net/ubuntu/+source/cron/+bug/118168)
- Sor orientált feldolgozás az operációs rendszer részéről
- Parancsok összeláncolhatóak logikai jelekkel vagy "pipe"-pal (|) (Ctrl+W magyar bill.en)
    - *parancs1 && pararncs2*: Ha az első parancs hibakódja 0, akkor lefut a másik
    - *parancs1 || parancs2*: Ha az első parancs hibakódja 0, akkor NEM fut le a másik
    - *parancs1 | parancs2*: Az első parancs, kimenetét átirányítja a második bemenetére
    - *rm myfile && echo "File is removed successfully" || echo "File is not removed"*
- Egy parancsnak mindig van hibakódja, ami sikeres futás esetén 0, különben \>0
- Egy parancs alapesetben...
    - A standard bemenetről olvas (STDIN)
    - A standard kimenetre ír (STDOUT), a standard hibakimenetre (STDERR) írja a hibát

---

# Alap parancsok: *echo* és *cat*

- *echo*: kiír egy szövegeket az STDOUT-ra
    - \-n kapcsoló: nem tesz új sort a végére
    - \-e kapcsoló: a speciális karaktereket értelmezi(pl.: \n, \t, stb.)
- *cat*: egy fájlt kiír at STDOUT-ra
    - \-a kapcsoló: minden láthatatlan karakter jelöl
    - \-s kapcsoló: a több egymást követő üres sort törli
    - \-n kapcsoló: sorszámokat ír

A "-" jel jelöli több program esetében az STDIN-ot (ctrl+D az EOF szimbólum)

Fájl elejére beszúrás:

    !bash
    echo $title | cat - $file >$file.new

[Forrás](http://tldp.org/LDP/abs/html/assortedtips.html)

---

# A be- és kimenetek átirányíthatók

- *echo "alma" >  alma.txt*: újrakezdi a fájlt (truncate)
- *echo "alma" >>  alma.txt*: hozzáírja az eredeti tartalomhoz az újat
- STDIN alapesetben a billentyűzet
- STDOUT, STDERR alapesetben a képernyőre kerül
- Sor orientált a feldolgozás(!), kivéve az STDERR (ott karakter orientált!)
    - Többsoros parancs is bevihető, ilyenkor a prompt ">" jellé változik
    - Sortörés kérhető sorvégi "\\" jellel. Ekkor folytatható a parancs az új sorban

A hibakód lekérdezhető:

- *$?* változó tartalmazza
- Az *echo $?* parancs visszaadja az előző parancs hibakódját
- Ha kétszer adjuk ki, akkor a második 0-lesz, mivel az echo 0-val tér vissza...

---

# Próbáljuk ki a parancsokat!

1. Hozzunk létre egy fájlt legalább egy sornyi szöveggel
    - *cat*-tal
    - *echo*-val
1. Írassuk ki a képernyőre
1. Hozzunk létre egy másik fájlt legalább egy sornyi szöveggel
1. Írassuk ki őket egymás után a képernyőre
1. Az első fájlhoz írjunk hozzá még egy sort
1. Írassuk ki a képernyőre
1. A második fájl tartalmát írjuk felül egy új egysoros szöveggel
1. Írassuk ki ezt is a képernyőre
1. Másoljuk az egyik fájl tartalmát a másikba
1. Írassuk ki ezt is a képernyőre

---
# Próbáljuk ki a parancsokat!

1. Írassuk ki a két fájlt egymás után a képernyőre sorszámokkal, köztük írjunk be valamit
    - \- kapcsoló a *cat*-on
1. Írassuk ki a két fájlt egymás után úgy, hogy csak az első van sorszámozva
1. Írassunk ki egy szöveget ami fehér szóközöket tartalmaz, úgy hogy látszódjanak
1. Az előző feladat eredményét írassuk vissza ugyan abba a fájlba!
    - Mi történt?
    - *sponge*: megjegyzi a kimenetet és visszaírja a kimeneti fájlba ha vége
1. Próbáljunk beszúrni egy fájl elejére egy szöveget!

---

# Alap parancsok

- echo: változók is kiírhatók:
    - *echo "A PATH változó értéke: $PATH"*
    - *echo 'A PATH változó értéke: $PATH'*
- *grep [reguláris kifejezés]*: Azokat a sorokat írja csak ki, amik illeszkednek a reg.kif-re
    - \-v kapcsoló: amik nem illeszkednek
    - \-i kapcsoló: kis-nagy betű nem számít
- *mv*, *cp*: "MoVe", "CoPy"
- *sort*: Soronként rendezi a standard bemenetet
    - \-r kapcsoló: **Reverse** fordítva
    - \-n kapcsoló: **Numerical** számok értéke szerint
    - \-u kapcsoló: **Unique** minden elemből csak egyet vesz számba
    - \-R kapcsoló: **Random** véletlen sorrendbe rendez
    - \-k kapcsoló: i[,j] i. mezőtől a j. mezőig veszi figyelembe
    - \-t kapcsoló: mezőelválasztó karakter alapból: fehér szóköz
    - Hasonlót tud a *shuf* (shuffle) parancs

---

# Próbáljuk ki a parancsokat!

1. Írassuk ki a /etc/passwd fájl tartalmát és keressünk benne d kezdőbetűjű felhasználókat!
1. Rendezzük őket Ábécé sorrendbe!
1. Fordítva!
1. Rendezzük véletlenszerű sorrendbe!
    - *sort*-tal
    - *shuf*-fal
1. Hozzunk létre egy fájlt, másoljuk le, helyezzük át!
1. Könyvtárral ugyan ezt!
1. Keresünk a /dev/ könyvtárban csoport által írható fájlokat
1. Hozzunk létre egy több soros fájlt, minden sorban 10 és 100 közötti számokból egy véletlen sorrendben
    - Rendezzük sima *sort*-tal
    - Rendezzük numerikus *sort*-tal
