
# Operációs rendszerek I.<br/> 3. gyakorlat

---

# Breaking news: "Shell shock" bug

---

# Távolról is kihasználható hiba a *bash*-ben

- [Leírás](http://www.csoonline.com/article/2687265/application-security/remote-exploit-in-bash-cve-2014-6271.html) [CVE-2014-6271](http://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2014-6271)
- Lényeg:
    - *bash*-ben lehet függvényeket is átadni a környezetnek, nem csak változókat
    - De ha egy függvényt adunk át, a *bash* értelmezi függvény utáni kódrészletet is (injection)
    - Tetszőleges CGI, PHP, stb script, ami root joggal fut és bash-t hív felhasználható
- [Debianon nem javították még alapból](http://hup.hu/node/135477#comment-1784060)
- A nagyobb Linux platformokon már megérkezett a frissítés
- A támogatatlan Android telefonok tipikus támadási célpontok lesznek a jövőben
- [A hiba kihasználására néhány ötlet](http://seclists.org/oss-sec/2014/q3/650) (Metasploit-ban már benne van)
-  Példa:

        !bash
        $ env x='() { :;}; echo vulnerable' bash -c "echo this is a test"
        vulnerable
        this is a test
        env FORK_BOMB='() { :;}; :(){ :|:& };:' ssh some_user@some_system

---

# Régimódi tömörítés: Tar Géza és Tar Béla

- Régen szalagos meghajtók voltak a legnagyobb kapacitású adattárolók (ma is)
    - Lassúak
    - Nem hibatűrőek
    - Használatkor "egyberagasztják" a fájlokat kazettánként, a gyorsabb másolás miatt
    - Megőrzi a fájlrendszer tulajdonságait (dátumok, jogok, stb.)
- Most az ehhez kialakult örökséget visszük tovább: TAR (Tape ARchive)
    - Gyakorlatilag csak "össze ragasztja a fájlokat", a könnyebb kezelés végett egy "kátránylabdába" (tarball)
- Ezt a "kátránylabdát" még egy lépésben tömöríti a tömörítő: több lehetőség
    - compress: hagyományos Unix út, kihalt (LZW algoritmust használ)
    - GnuZIP: GNU implementációja a ZIP-nek
    - bzip2: Csak egy fájl tömöríthető vele (Burrows–Wheeler algoritmus), jól párhuzamosítható (lásd pbzip2)
    - xz: csak egy fájl, divatos, kisebb picivel a többinél (LZMA algoritmus, 7-zip használja)

---

# Modern felhasználás

- A tar programnak is több implementációja van:
    - GNU tar (GPL) legelterjedtebb
    - BSD tar (BSDL) BSD licencű, hagyományosabb
    - star (CDDL) gyors (volt régen, gyakorlatilag kihalt)
- Ezek már egybe vannak építve a tömörítő szűrővel, van párhuzamos implementáció ([pbzip2](http://compression.ca/pbzip2/))
- Szöveget is tudunk közvetlenül kitömöríteni és dolgozni vele anélkül, hogy fájlba írnánk
    - zcat, bzcat és xzcat
    - zless, bzless és xzless
    - zgrep, bzgrep és xzgrep
    - zdiff, bzdiff és xzdiff
    - [Forrás](http://www.thegeekstuff.com/2009/05/zcat-zless-zgrep-zdiff-zcmp-zmore-gzip-file-operations-on-the-compressed-files/)
- [C++-ban is megtalálhatóak ezek a funkciók](http://www.boost.org/doc/libs/1_40_0/libs/iostreams/doc/classes/zlib.html)

---

# Praktikus tar parancsok

- *tar -xvf [fájl]*: kicsomagol bármit
- *tar -cvf cél.tar [fájlok]*: tar-t csinál
- *tar -cvzf cél.tar.gz|cél.tgz [fájlok]*: Tar Gézát csomagol
- *tar -cvjf cél.tar.bz2|cél.tbz|cél.tb2 [fájlok]*: Tar Bélát csomagol
- *tar -tvf  [fájl]*: listázza minden típusú archívum fájljait
- Magyarázat: ([Még több parancs](http://www.tecmint.com/18-tar-command-examples-in-linux/))
    - x: eXtract
    - c: Compress
    - t: Table of contents
    - v: Verbose
    - f: File
    - z: gZip
    - j: bzip2
    - J: xz

---

# Próbáljuk ki a parancsokat!

1. Vegyünk egy szöveges fájlt, tömörítsük be
    - tar-ba
    - tar.gz-be
    - tar.bz2-be
    - tar.xz-be
    - Nézzük meg, melyik mekkora lett! Tömörítsük ki az egyiket!
1. Próbáljuk ki a párhuzamos bzip2 tömörítést!
    - *sudo apt-get install pbzip2*
    - *tar -I pbzip2 -cvf fájl.tar.bz2 fájl*
1. Tömörítsünk csak bzip2-vel egy fájlt tar nélkül!
    - *bzip2 alma.txt* (ilyenkor törli az alma.txt-t)
    - Visszafelé: *bunzip2 alma.txt.bz2*
1. Keressünk a fájlban *grep*-pel kitömörítés nélkül!

---

# *cpio*

- "CoPy In, copy Out"
- *ls | cpio -ov > archivum.cpio*: becsomagol
- *cpio -idv < object.cpio*: kicsomagol
- *ls | cpio -ov -H tar -F sample.tar*: tar-t csinál
- *cpio -idv -F sample.tar*: kicsomagolja a tar-t
- *cpio -it -F sample.tar*: tartalmazott fájlokat mutatja meg
- [Forrás](http://www.thegeekstuff.com/2010/08/cpio-utility/)

# PAX (Posix ARchiver)

- Megpróbálja kibékíteni a *tar* és a *cpio* fanatikusokat (ahogy a neve is utal rá)
- Nemigen használják
- [Forrás](http://wiki.bash-hackers.org/howto/pax)


---
# Csomagkezelő: Ubuntu

- *dpkg*: deb csomagokat lehet vele kezelni
    - \-l kapcsoló: listázza a telepített csomagokat
    - \-r kapcsoló: töröl egy csomagot
    - \-i kapcsoló: telepít egy csomagot
- *apt*: szoftverforrásokat lehet vele kezelni (ráépül a dpkg-ra)
    - *apt-get install*: telepít
    - *apt-get remove*: töröl
    - *apt-get update*: szoftverlistákat frissít
    - *apt-get upgrade*: csomagokat frissít
    - *apt-get dist-upgrade*: rendszert frissít
- *aptitude*: Metacsomagokat lehet vele kezelni, disztribúció frissítésre is jó
    - curses GUI
- *synaptic*: igazi grafikus felület, funkcionalitásában megegyezik az aptitude-dal

---

# Csomagkezelő: *apt*

- *apt-show-versions*: csomag aktuális verziója és forrása
- *apt-cache search*: lehet keresni az adatbázisban (csomagleírásokra is!)
- *apt-get install -f*: amikor valami telepítés megszakadt
- *apt-add-repository*: PPA-t lehet hozzáadni
- *ppa-purge*: PPA-t lehet törölni downgrade-eléssel
- \-V kapcsoló: mutatja a verziókat (vagy [a konfigban beállítható](http://hup.hu/node/122458))
- véd a hülyeségektől:

        !bash
        sudo apt-get remove bash

- [A szoftverforrások kérdése igen bonyolult is tud lenni](https://sites.google.com/site/mydebiansourceslist/) ([frissítési előzmények](http://hup.hu/treyblog/20140929/ubuntu_frissitesi_elozmenyek))
- */etc/apt/sources.list*: Itt vannak a források tárolva
- Trükk (Biztosan jól lefutott?): *dpkg --get-selections > installed-software; echo $?*

---

# Terminál multiplexelés: screen és byobu

- Alapvető probléma régóta, hogy távolról elérve a gépet csak egy terminálunk van
    - Nincs grafikus felület, amin több ablakban lapozgatható terminálunk van
    - Az F1-6 billentyűk sem működnek
    - Nehézkes az élet a háttérbe nyomott feladatok váltogatásával (*bg*, *fg*, később)
    - Nem beszélve a megszakadt kapcsolat után a munkamenet visszaállításának nehézségeiről
- Régen létezik erre megoldás: *screen*
    - Elindítva olyan, mintha nem is történt volna semmi
    - A C-a c billentyűkombinációra új "ablak" jön létre (C-a = Ctrl-a)
    - C-a a: vissza lehet lépni az előző ablakba
    - C-a n: a sorban következőre lehet lépni
    - C-a p: a sorban előzőre lehet lépni
    - C-a d: lecsatolja a screen munkamenetet és akár ki is jelentkezhetünk, a munkamenet megmarad
    - screen -r: futó munkamenetre csatlakozás
    - screen -x: ha megszakadt a kapcsolat és nem csatoltuk le a munkamenetet
    - stb.
- A az újraindítást nem élik túl a munkamenetek!

---

# Terminál multiplexelés: screen és byobu

Az Ubuntu-féle változat: byobu

- Alapból csatlakozik a nyitva lévő bármilyen munkamenetre
- "egyszerűbben" konfigurálható állapotmezők vannak
- Az F\* billentyűkkel is lehet váltogatni az ablakok között
- Kétféle backendje van:
    - screen
    - tmux
- Bonyolítottak az egyszerű és régóta jól működő rendszeren (nem egyszerűbb beállítani)
- F billentyűk nehezen letilthatók [bugreport](https://bugs.launchpad.net/byobu/+bug/389129/) (Ubuntu 12.04-ben a mai napig javítatlan)
    - Megoldás: *byobu-select-backend* és itt 1 *screen*
    - Illetve: [a beállítások között kell matatni](http://zipizap.wordpress.com/2013/04/03/byobu-screen-disabling-the-function-keys-aka-f-keys/)
- A *screen*-hez vannak okos toolok, amik segítik a produktivitást: [Link](http://skoneka.github.io/screen-session/)

---
# Jó ha tudja az ember

Bár 14.04-ben már jól működik, 12.04-nél jól jöhet: *byobu* túlélés

- *byobu-select-backend*: és itt *screen*
- [Konfigfájl matatás az F-billentyűkért](http://zipizap.wordpress.com/2013/04/03/byobu-screen-disabling-the-function-keys-aka-f-keys/)

*putty* túlélés:

- Window -> Translation -> Characterset Translation: UTF-8 (Ékezetes karakterek működnek)
- Terminal -> Keyboard -> Function keys and keypad: Xterm R6 (F1-4 működik)
- Terminal -> Features -> Disable application keypad mode: Pipa (Num lock működik)
- Connection -> Seconds between keepalives: 10 (Nem szakad meg ha nem csinálsz semmit, sokáig)

[Forrás](http://vim.wikia.com/wiki/PuTTY_numeric_keypad_mappings), [Másik](http://serverfault.com/a/585426)

---

# Vágólap

- Réges-régen még az X10-es időkben (1985) három vágólap volt
    - PRIMARY
    - SECONDARY
    - CLIPBOARD
- A SECONDARY már kihalt, a PRIMARY csak kihalófélben van
- A PRIMARY működése: Kijelöléssel automatikusan vágólapra kerül, középső egérgombbal beilleszt
    - Inkább a parancssoros dolgok használják
- A CLIPBOARD működése: Windows stílusú, ez a jövő útja
    - Inkább a GUI programok használják
- A programok birtokolják a memóriát, ha bezárul a program a vágólap törlődik
- Vannak vágólap managerek, [nem is egy](https://wiki.archlinux.org/index.php/clipboard)...

---

# Folyamatkezelés

- *fg*: előtérbe hozza a legutolsó háttérben futó folyamatot
- *bg*: háttérbe küldi az éppen futó folyamatot (mint a parancs végére rakott "&")
    - *cp bigfile other &*
- *ps*: kilistázza a rendszeren futó folyamatokat
    - a "-aux" paraméterrel lehet az összes felhasználó folyamatait kilistázni
    - vannak interaktív eszközök is erre: *top*, *htop* [Forrás](http://www.cyberciti.biz/tips/top-linux-monitoring-tools.html)
- *kill*: egy SIGNAL-t küld az adott folyamatnak (általában arra vonatkozik, hogy fejezze be a futást)
    - *killall*: PID helyett a folyamat nevét kell megadni (minden egyező folyamatra végrehajtódik az utasítás)
- *jobs*: megmutatja a háttérben futó job-okat
- Barátaik: *skill*, *pkill*, *pgrep*, *snice*

---

# SIGNAL-ok

- SIGHUP (1): ha a folyamat alatt bezáródik a terminál, rendszerint ilyenkor kilép.
    - Egyes programok a beállításaikat újraolvassák a hatására (pl.: init)
- SIGINT (2): a folyamatot megszakítása kéri fel (ha tud, le is áll)
- SIGTERM (15): a folyamatot leállásra kéri fel, például a *kill* alapból (ha tud, le is áll)
- SIGKILL (9): a folyamatot kilövi azonnali hatállyal
- SIGTSTP (20): a folyamatot időlegesen megállítja (pl.: háttérbe küldés céljából)
- SIGQUIT (3): a folyamatot kilépésre utasítja és core dump készül
- Még többen is vannak, de az már más tészta
- A C-ben ugyanígy működnek
- Lehet Trap-eket írni, és elkapkodni a signalokat (Bash-ben is)

---

# Bash példa a Signal-ok kezelésére

SIGHUP:

    !bash
    function echo01 {
        echo "Received signal 1 (SIGHUP)"
        echo "Now I would close files if I had any open."
        exit
    }

    trap echo01 1

    while true
    do
        sleep 5
        echo "Awake"
    done

Futtatás:

- Mentsük waiter.sh fájlba
- *chmod a+x waiter.sh*
- *./waiter.sh &*
- *kill -1 AZ ELŐBB KIÍRT PID*

[Forrás](http://kingcomputerservices.com/unix_101/sending_signals.htm)

---

# Billentyűkombinációk (SIGNAL-ok)

- Ctrl-C: SIGINT-et küld a folyamatnak (abortálás)
- Ctrl-Z: SIGTSTP-et küld a folyamatnak (felfüggesztés)
- Ctrl-\: SIGQUIT-et küld a folyamatnak
- Ctrl-T (nem minden "\*Nix" rendszer támogatja) SIGINFO-et küld a folyamatnak

# Egyéb billentyűkombinációk

- Backspace billentyűvel lehet egyesével törölni a begépelt szöveget
- Ctrl-U: törli a kurzor előtti összes szöveget
- Ctrl-S: megállítja a terminál kimenetét (scroll lock)
- Ctrl-Q: kilép ebből a "fagyasztásból" (C-A-Fn terminálon működik!)
- A fenti kettő már nem lényeges, mert a terminál ablakot lehet görgetni
- *stty -a*: aktuális hozzárendelések
- A Ctrl-t a billentyű előtti ^ jelzi (^H jelöli a backspace-t)


---

# Nice a programok prioritása

- *uptime*: megmondja mióta fut a rendszer, hányan vannak bejelentkezve és mennyi a *load*
    - *load*: 1.0 = 100% per processzor mag kell érteni (8 magos gép: 8.0 = 100%)
    - Három szám egymás után, 1, 5 és 15 perces terhelési átlag (processzek száma)
    - A Linux a szálakat külön számolja
- *nice*: prioritást lehet vele adni  a programoknak (root tudja változtatni) [További információ](http://systembash.com/content/using-nice-to-control-cpu-usage-and-process-priority/)
    - \-20 (legnagyobb)- 20(legkisebb) között
    - Értéke a szülőtől öröklődik, alapból 0
    - *renice*: processz futása közben változtatható a prioritása
- *nohup*: úgy lehet programot futtatni, hogy imunis lesz a terminál bezáródására (alapból nem az)
- Folyamatok ideiglenes megállítása (pause) újraindítása (resume) ([Forrás](http://tombuntu.com/index.php/2007/11/23/how-to-pause-a-linux-process/))
    - *kill -STOP PID* és *kill -CONT PID*
- Hasonló parancsok: *snice*, *pgrep*, *skill*

---

# Felhasználó kezelés (röviden)

- *w*, *who*, *whois*, *finger*: Információ a bejelentkezett felhasználókról
    - *chfn*: felhasználó (finger) adatait lehet változtatni
    - Többségében egy régi kor maradványai, *finger*, *whois* Ubntu-n alapból nincs fent
- *whoami*: (*id -un*) felhasználó teljes neve
- *adduser* vs. *useradd*: useradd alacsonyabb szintű kezelés, másik kifinomultabb
- *deluser*: törlés különböző módozatai
- *usermod*: felhasználónév deaktiválása, jelszó lejáratának változtatása stb.
- *chown*: A fájl birtokosát meg lehet változtatni vele
- *chgrp*: A fájl birtokosának csoportját meg lehet változtatni vele
- *groups*: A felhasználó mely csoportokban van benne

---

# Runlevel ("futási szint")

Elvileg véges sok szolgáltatáskombináció létezhet

- A 0-ás runlevel a rendszerleállítást "szokta" jelenteni
- Az 1-es a single user módot
- Az 5-ös "szokta" jelenteni a legmagasabb szintet (X)
- A 6-os az újraindít́ást
- A többit elvileg szabadon definiálhatjuk
- [Systemd vs. SysVinit cheatseet](http://hup.hu/node/135072) [eredetileg](http://linoxide.com/linux-command/systemd-vs-sysvinit-cheatsheet/)

A Systemd szakít a több évtizedes hagyománnyal (nem is szeretik pl: [Uselessd](http://uselessd.darknedgy.net/))


---

# Ütemezett feladatok: Cron

- *crontab -e*: megnyit egy szerkesztőt és ide kell írni a következő formátumot:
    - Perc (0-59)
    - Óra (0-23)
    - Nap (1-31)
    - Hónap (1-12)
    - Hét napja (0-7): vasárnappal kezdődik
    - Parancs
    - Szóközzel elválasztva
    - \*: minden előfordulása a mezőnek (minden nap, minden perc, stb.)
    - Vesszővel felsorolhatóak elemek
    - */x: egész osztás (x=10 -> 00,10,20,30,40...)
    - \-: intervallum felsorolása
- Ha sima felhasználóként csináljuk, akkor sima joggal fut, rendszergazdaként root joggal

---

# Ütemezett feladatok: Cron

- PATH-t nem állítja be! Nem árt naplózni és tesztelni, mielőtt élesíti az ember a scriptet! (*set env*)
- Speciális időpontok:
    - @reboot
    - @midnight
    - @yearly
    - stb.
- GUI programok futtatása: env DISPLAY=:0 gui_program
- Webről: *curl http://your-site.org/lib/cron.php*

Más lehetőségek:

- anacron: root joggal fut a *run-parts* segítségével
    - /etc/cron.(hourly|daily|weekly|monthly)/
    - *run-parts --test /etc/cron.hourly/*: tesztelni lehet
    - Sorrend megadható: szám prefixum a fájlnevében (99alma, 55körte)

---

# Ütemezett feladatok: *at*

- Régi maradvány, mégis van ami használja még...
- *at*: egyszer futtatunk valamit a jövőben
    - *echo "cc -o foo foo.c" | at 1145 jan 31*
    - *atq*: kilistázza a parancsokat
- systemd timers: a systemd erre is képes
- [El tud bonyolodni](http://stackoverflow.com/questions/134906/how-do-i-list-all-cron-jobs-for-all-users/137173#137173)
- *flock -n lockfile parancs*: lehet zárolni [és még sok lehetőség van erre](http://wiki.bash-hackers.org/howto/mutex)
- *chronic parancs*: csak akkor ír ki bármit is, ha a hibakód nem 0

---

# Próbáljuk ki a parancsokat!

1. Keressünk rá csomagokra a leírásuk alapján!
1. Számoljuk meg hány csomag van telepítve a rendszerre!
1. *screen* vagy *byoubu* alatt indítsunk el két külön programot, lépjünk ki, nézzük meg őket *top*-pal és *ps*-sel!
1. Indítsunk el egy folyamatot tegyük háttérbe hozzuk vissza!
1. Indítsunk el egy folyamatot és öljük meg *kill*-el!
1. Próbáljuk ki a bash példát a szignálok elkapására, írjunk egy saját *trap*-et!
1. Próbáljuk ki hogy csökkentjük illetve növeljük a folyamatok prioritását!
1. Írjunk egy *cron* parancsot amit 3 perc múlva fog lefutni!
1. Próbáljuk ki a *run-parts*-ot!
1. Csináljunk egy *at* időzítést 3 perc múlvára!
1. Írjunk egy scriptet, ami nem futtatható két példányban!

---

# Rendszergazdaság: sudo és su -

- *root* felhasználó mindent írhat olvashat megváltoztathat
    - Alapesetben távolról nem lehet bejelentkezni a nevében
    - Egy rendszergazdára lett kitalálva régen
- A *su* paranccsal egy subshellt indít a root nevében
    - A \- kapcsoló a környezeti változókat is átállítja, különben marad érintetlen minden
    - *root* jelszó kell hozzá
- A *su felhasználó* paranccsal "meg lehet személyesíteni" egy felhasználót
    - A sima felhasználóktól elkéri az aktuális felhasználó jelszavát
    - A *root*-nak ehhez nem kell jelszót megadni
- Mi van ha a *root* jelszava elveszik?
    - Meg lehet hackelni a rendszert (később)
    - Rosszabb, ha diktátorrá válik a *root*!

---

# *sudo*: "Super User DO"

- Komplex jogosultság kezelő rendszer:
    - [Ahogy az egyszerű felhasználó látja...](http://xkcd.com/149/)
    - [Hogyan találták ki](https://www.youtube.com/watch?v=LaAwl3HN5ds)
    - [Története](http://www.gratisoft.us/sudo/history.html)
    - [Majdnem kihalt mielőtt még megszületett volna](http://hup.hu/cikkek/20130716/emlekezes_a_nore_aki_megmentette_a_sudo-t)
    - [A Microsoft szabadalmaztatta, de mégsem...](http://www.maximumpc.com/article/news/microsoft_has_patented_sudo_yes_command)
    - A meghatalmazottaknak (wheel csoport) lehet *root* joggal parancsokat futtatni [RMS véleménye a wheel-ről](http://administratosphere.wordpress.com/2007/07/19/the-wheel-group/)
    - Több felhasználó is adminisztrálhat egy gépet: demokratikusabb
    - Pontosabban lehet konfigurálni a jogokat
- Lehet subshellt kérni: *sudo -s*
    - Ez megegyezik a *su -* paranccsal
    - Ha a felhasználónak van joga erre

---

# *sudoers* formátum

- */etc/sudoers*
    - $EDITOR beállítása után *visudo* paranccsal szerkeszthető
    - Ha hibásan mentjük akkor elszáll a sudo!!!
    - Beállíthatóak makrók, naplózás, e-mail értesítés, stb.
- felhasználó neve vagy %csoport neve
- host, amire érvényes (ALL= minden hostra)
- =
- Zárójelben felhasználó:csoport, akinek a nevében fut a program (nem csak root lehet)
- Opciók: például NOPASSWD
- kettőspont után vesszővel felsorolva a parancsok nevei, amit futtatni lehet
- Példák:

        !bash
        %wheel      ALL=(ALL) ALL
        USER_NAME   ALL=(ALL) ALL
        USER_NAME   ALL=(user:group) ALL
        USER_NAME   ALL= NOPASSWD: /usr/bin/apt-get, /usr/bin/dpkg

---

# Az "ős-editor": vi

- A **legősibb "editor"** az *ed* [maga Ken Thompson írta](http://en.wikipedia.org/wiki/Ed_(text_editor))
    - Már gyakorlatilag nem használják (kivéve *sed*, később)
- Az *vi* első verzió 1976-ban született
- Azóta a számítógépek kimagasló százalékán megtalálható, de facto standard, [legnépszerűbb](http://www.linuxjournal.com/article/10451)
- *emacs*: RMS írta személyesen Lispben 1976-ban, kiterjeszthető, testre szabható, stb.
    - Azóta is népszerű kiterjesztésekkel már majdnem az egész az operációs rendszer feladatait is át tudja venni egyedül (később)
    - C-x y z típusú billentyűkombinációkat használnak benne. [Erről született egy vicc is](http://xkcd.com/378/)
- *vim*: VI iMproved 1991-ben jelent meg először, Gépíróknak optimalizálták
    - Cél volt, hogy minél kevesebb billentyűnyomással minél hatékonyabban lehessen szerkeszteni a szöveget ([Neovim](http://hup.hu/cikkek/20140223/neovim))
    - [Vim parancsok gyüjteménye](http://hup.hu/node/97489), [Tanulást segítő játék](http://vim-adventures.com/), [Verseny a billentyűtésekért](http://www.vimgolf.com/)
- Közös jellemzőjük, hogy nagy fájlokkal is boldogulnak mert pufferekkel dolgoznak
- Filozófiai viták középpontjában állnak, hogy melyik a jobb...

---

# Halandóknak: nano, joe, mcedit, stb.

- A Washingtoni egyetem 1989-ben írt egy könnyen kezelhető konzolos e-mail klienst (pine)
    - Program for Internet News and E-mail
- Ennek része volt a *pico*
    - PIne's message COmposition editor, ami külön is használható volt
    - A *pine*-t nem fejlesztették tovább, illetve nem volt nyílt forrású
    - Ezért 1999-ben megszületett a TIP (This Isn't Pine), de a név konfliktus miatt átnevezték *nano*-ra
    - A *pine*-nak kiadták a forráskódját és azóta
- 2007-ben megszületett az *alpine* (apache licenc alatt), ALternatively Licensed PINE
    - Így napjainkban mind az "editor" mind a e-mail kliens használható tovább
- A *joe* (Joe's Own Editor) 1991-ben született, fő cél volt a könnyű használat
    - A turbo C-re hasonlítanak a billentyűkombinációk, beépített súgót tartalmaz
- Az *mcedit* 1994-ben indult az Midnight Commander részeként
    - Az 1986-os Norton Commander klónjanként

---

# GUI-s: gedit, kate, geany, gvim, stb.

- *gedit*: 1999-ben jelent meg a GNOME részeként
    - Elég fapados, mégis népszerű
- *kate*: 2001-től a KDE része
- *geany*: 2005-től létezik, inkább IDE (nagyon okos, kicsi, gyors)
- *gvim*: A vim GUI-s kiterjesztése
    - Megjegyzés: *evim*: "VIM easy mode" WYSIWYG jellegű (lehet váltani a módok között)
- Terminál emulátorban a kedvencek...
- Sok más
- [Fun: Types of Editors](http://xkcd.com/1341/)
- [Editor választáshoz](http://www.viemu.com/a-why-vi-vim.html)
- Nem érnek semmit, ha nincs GUI a rendszerben, pl szerver esetén...

---

# A varázslatos SysRq gomb

Ha már minden elveszett és lefagyott a gép Alt+SysRq+

- un**R**aw (take control of keyboard back from X)
- t**E**rminate (send SIGTERM to all processes, allowing them to terminate gracefully)
- k**I**ll (send SIGKILL to all processes, forcing them to terminate immediately)
- **S**ync (flush data to disk)
- **U**nmount (remount all filesystems read-only)
- re**B**oot

Könnyebb megjegyzéshez:

- "**R**aising **E**lephants **I**s **S**o **U**tterly **B**oring"
- "**R**eboot **E**ven **I**f **S**ystem **U**tterly **B**roken"
