
# Operációs rendszerek I.<br/> 4. gyakorlat

---

# Filozófia: "Toolbox philosophy"

"Think of free as in free speech, not as in free beer."

1. **Do one thing, and only one thing.** Everybody likes a flexible program. But I don’t like software that tries to do too much at once. For example, I resent music management software suites or photo management applications. I manage the photos. I manage the music. The application shows it, or plays it. Period. If you try to be all things at once to me, you will only disappoint.
1. **Do that one thing well.** A program needs focus — that goes without saying. If it achieves that goal and doesn’t muddle the final product, it is a winner. In other words, if you can’t do it right, don’t bother trying at all.
1. **Don’t drag my system down.** If you burden my installation with pointless libraries and dependencies that don’t add anything to your software, you fail. Some of the greatest software ever written has about two dependencies. Some of the worst drags in all of Gnome just to put an icon on the screen. That is inexcusable.
1. Finally, **points are awarded for style**. I can forgive and even adopt an ugly or cumbersome program if it achieves in the first three categories. But if you manage to capture all three and have a clever interface or a smooth look, then I embrace thee through the power of the Internets.

[Forrás](http://kmandla.wordpress.com/software/)

Megfontolandó tervezési szempont: <http://xkcd.com/1343/> [Messzire vezet...](http://www.catb.org/esr/writings/unix-koans/index.html)

---

# Hogyan kapunk segítséget?

![RTFM](http://gergo.erdi.hu/files/rtfm.jpg)

Read The Fine Manual!

---

# Hogyan kapunk segítséget?

- *man*: dokumentáció az egyes parancsokhoz
    - Például: *man bash*
    - Még a man-nak is van dokumentációja(!): *man man*, nincs **man woman**! :(
    - Jól szervezett, felépített dokumentáció (1971 óta!)
- *info*: bővebb leírása a parancsoknak
- *whatis*: rövid leírás
- *whereis*: file elérési útvonala
- *locate*: a fájlrendszerben elérhető fájlok amik neve tartalmazza a keresőszót
- *apropos*: a man bejegyzések(programok neve) és a rövid leírásokban keresi az attribútumként megadott szöveget
- A legtöbb parancsnak van *-h* vagy *--help* paramétere
- *wtf*: internetes szleng rövidítések feloldása
    - *wtf is RTFM*

---

# A shell főbb változói

- *$#*: az argumentumok száma
- *$\**: a parancssor minden argumentuma egybe zárójelezve ("$1 $2 $3")
- *$@*: a parancssor minden argumentuma külön zárójelezve ("$1" "$2" "$3")
- *$-*: a burok által adott opciók
- *$$*: a burok folyamatazonosítója
- *$!*: az utolsó, &-el indított folyamat azonosítója
- *$$*: a futó script folyamat azonosítója
- *$0*: a script neve (az első paraméter *$1*)
- *$?*: az utolsó folyamat hibakódja
- *$_*: a legutolsó parancs legutolsó argumentuma
- *$HOME*: a felhasználó saját könyvtára
- *$IFS*: a belső mezőelválasztó karakter (alapesetben fehér szóköz)
- *$PATH*, *$CDPATH*: a *cd* parancs itt keresi a megadott paramétert, illetve az adott parancs a szükséges fájlokat

---

# A változók behelyettesítése

- Okosan működik:

        !bash
        $ cat > abc.txt
        blabla CTRL-D
        $ file=abc.txt
        $ echo $file
        ??
        $ cat $file
        ??

- Múlt óráról kimaradt fontos billentyű kombináció: C-r
    - A historyban lehet keresni vele szó szerint

# Prompt

- *$PS1*: eltsődleges prompt (a $-ig)
- *$PS2*: másodlagos prompt (amikor többsoros input többi sorát várja alapesetben ">")
- *$PS3*: harmadlagos prompt *select* ciklusban használatos
- *$PS4*: negyedleges prompt debugoláshoz használatos, a kimeneti sorok elejét jelöli ("+")

---



# Még egy kis átirányítás

- *&>filename*: Mind az STDIN-ot és STDERR-t átirányítja
    - egyszerűbb mint: > file 2>&1 (ha a kettőt megcseréljük nem fog működni)
- *:>file*: törli a fájlt (egyszerűbb mint a /dev/null-ból átirányítani fájlba)
- *(egyik; masik) > fájl*: mindkét parancs kimenete átirányítódik a fájlba
- *parancs < fájl.txt*: A parancs STDIN-jára lehet irányítani a fájlt
    - Ekvivalens: *cat fájl | parancs*
- *./parancs*: Ha a parancs nincs a $PATH-ban és futtatni akarjuk
    - Kicselezhető: mkdir ~/bin; export PATH=$PATH:~/bin
- *[n]<> words.txt*: megnyitja írásra és olvasásra az n. fájlleírón a words.txt fájt
- *parancs |& parancs2*: implicit &2>1 és utána a pipe
- *! parancs*: a hibakód negálódik
- [Még](http://wiki.bash-hackers.org/howto/redirection_tutorial) [bővebben](http://wiki.shellium.org/w/Bash_Redirection)

---

# Haladó átirányítás

- Megnyitott fájlokba is lehet irányítani:
    - */dev/fd/fdesc*: Ahol fdesc egy létező egész számmal jelölt fájlleíró
    - */dev/stdin*: 0 számú fájlleíró
    - */dev/stdout*: 1 számú fájlleíró
    - */dev/stderr*: 2 számú fájlleíró
    - */dev/tcp/host/port*: létező host:port-ra nyit TCP kapcsolatot és oda irányít
    - */dev/udp/host/port*: létező host:port-ra nyit UDP kapcsolatot és oda irányít
- *[n]< file.txt*: az n. fájlleírón megnyitja a fájl.txt-t olvasásra
    - Példa: *5 < script.sh cat /dev/fd/5*
- *parancs << STOP*: parancsnak az STDIN-jára küldi a begépelt szöveget, amíg a csak STOP szót nem tartalmazó sor nem jön
    - A STOP szó tetszőlegesen cserélhető
- *parancs <<< word*: a word stringen az összes expanziót végrehajtja és úgy adja át az STDIN-ra

---

# Próbáljuk ki a parancsokat!

1. Nézzük meg a *man bash* parancsot!
1. Hasonlítsuk össze az *info* paranccsal!
1. Próbáljuk ki a *cat*-ot és *echo*-t tartalmazó példát
1. Próbáljuk ki a *cat* és az *echo* paranccsok *-h* és *--help* opcióit!
1. Próbáljuk ki a különféle átirányításokat!
1. Próbáljuk ki az alábbi kódot ([forrás](http://www.linuxtopia.org/online_books/advanced_bash_scripting_guide/devref1.html)):

        !bash
        exec 5<>/dev/tcp/www.index.hu/80
        echo -e "GET / HTTP/1.0\n" >&5
        cat <&5

---

# A rendszerhéj (shell) programozható

- Így gyorsan megoldhatóak bonyolult feladatok (script nyelv)
- A rendszer nagy része szöveges fájlból áll
    - Beállítás fájlok
    - Különféle scriptek, amik a rendszert működtetik
- Nagyon korán nagyon fejlett szövegfeldolgozási módszerek jelentek meg
- Operációs rendszer szinten támogatva vannak
    - Reguláris kifejezések, Különféle karakterkódolások
- Váltózók deklarálhatóak, lekérdezhetőek
    - Deklaráció: változó=1 (NINCS szóköz az egyenlőségjel után!)
    - Érték lekérdezése: $változó
- Macskakörmök speciális jelentéssel bírnak:
    - "szöveg" -\> változó behelyettesíthető pl.: "A változó értéke $változó"
    - 'szöveg' -\> literálisan értelmeződik
    - \`parancs\` -\> végrehajtódik egy subshellben (magyar billentyűzeten AltGr+7)

---

# Pár hasznos parancs

- *cal*, *ncal*: naptár kétféle formátumban
- *calendar*: emlékeztetőket lehet írni
- *hd*, *hexdump*: hexában kiírja a stringet (*od* oktálisan)
- *script*, *scriptreplay*: terminálba lehet jegyzetelni és visszajátszani
    - Felvétel: *script -t 2> timing* (Minden a *typescript* fájlban)
    - Lejátszás: *scriptreplay timing*
- *wall*: midnen terminálra üzenetet küld (pl shutdown -h now, minden terminálra kiírja, hogy leállás van)
- *vipe*: egy pipe-ba bele lehet írni szövegszerkesztővel középen
    - EDITOR változót be kell állítani mert nem respektálja az ubuntu *select-editor*-át
    - *export EDITOR=nano*
- *ifne*: csak akkor futtatja a megadott parancsot, ha a STDIN üres
- *isutf8*: kiírja, ha a STDIN nem helyes UTF-8 bájtokat tartalmaz
- És még sokan mások: [moreutils](https://joeyh.name/code/moreutils/)

---
# *tee* és *pee*

- *tee*: az angol T alakú elágazó csőről kapta a nevét ([szemléletesen](http://en.wikipedia.org/wiki/Tee_(command)))
    - az STDOUT-ra és a paraméterként adott fájlba **IS** írja az STDIN-ot
    - *\-a*: fájlt nem kezdi újra, hanem hozzáfűz mint a *>>* operátor (append)
- *pee*: két pipe ra továbbítja a bemenetet ([barátja a tpipe](http://linux.die.net/man/1/tpipe))
    - Példa: seq 5 -1 1 | pee >(sort -u > sorted) > (sort -R > unsorted)
    - Bash-ben szükségtelen: seq 5 -1 1 | tee >(sort -u > sorted) >(sort -R > unsorted)
    -[Forrás](http://serverfault.com/a/96260)
- Hasznos ha látni is és logolni is akarjuk, hogy mi történik az STDOUT-on

# Régi konzolos játékok nosztalgiázás céljából

- bsdgames
- bsdgames-nonfree
- Játékok listája: *dpkg -L bsdgames | grep "/usr/bin"*

---

# Hálózati interfészek beállítása

- *ifconfig*: hálózati interfészek beállítása (pl.: *up*, *down*)
    - MAC cím változtatás: *ifconfig wlan0 hw ether 00:00:00:00:00:00*
- *ifdata*: *ifconfig*-ból lehet kiszedni adatmezőket szenvedés nélkül
    - Példa: IPv4 cím kinyerése: *ifdata -pa eth0*

# Fájlok összehasonlítása

- *combine*: két fájl sorait kombinálja logikai művelet szerint
    - Példa: *combine névsor.txt not katalógus.txt > hiányzás.txt*
- *paste*: egymás mellé illeszti két fájl sorait megadott delimiterrel ([a *join* okosabb](http://www.techrepublic.com/article/lesser-known-linux-commands-join-paste-and-sort/))
    - Példa: *paste névsor.txt \`shuff osztályzatok_várt_eloszlasa.txt\` > eredmények.txt*
- *comm*: összehasonlítja két **rendezett** fájl sorait, a közös sorokat (common lines) kiírja
    - A *combine* parancs tudja ugyan ezt, de ez régebbi. [Alkalmazási lehetőség](http://hup.hu/node/128314)
- *diff*: összehasonlít két fájlt soronként, nagyon régi, jól testre szabható
    - Emberi kimenet: *diff -sy --suppress-common-lines*

---

# Gyakori számos műveletek (num-utils)

Magától értetődőek a nevek:

- *numaverage*
- *numbound*
- *numgrep*
- *numinterval*: hasonló mint a *seq* de okosabb
- *numnormalize*
- *numprocess*
- *numrandom*: hasonlít a *$RANDOM*-ra
- *numrange*
- *numround*
- *numsum*: olyan mint okos programozási nyelvekben a *reduce(+, lista)*
- [numutils](http://suso.suso.org/programs/num-utils/index.phtml)

---

# Tetszőleges pontosságú számológép

- *bc*: "Basic Calculator"
- STDIN-ről is fogad parancsokat
- Alapból egész pontosságú
- *scale*-lel állítható a pontosság
- Példa:

        !bash
        echo "scale=3; 10/3" | bc

- scale automatikus beállítása (100 tizedesjegyre) ([forrás](http://crunchbanglinux.org/forums/topic/15485/bc-cli-calculator-how-to-default-to-multiple-decimal-points/)):
    - export BC_ENV_ARGS=~/.bcrc
    - echo 'scale=100' > ~/.bcrc
    - echo 'export BC_ENV_ARGS=~/.bcrc' >> ~/.bashrc
- [Párja a Desk Calculator (DC) Lengyel Formában (reverse polish, postfix) tud számolni](http://wiki.bash-hackers.org/howto/calculate-dc)

---

# Próbáljuk ki a parancsokat!

1. Határozzuk meg mikor van idén az ortodox húsvét!
1. Írjuk ki hexában, hogy "árvíztűrőtükörúrógép"!
1. Küljünk üzenetet a *wall* paranccsal!
1. Próbáljuk ki a *tee* parancsot!
1. *seq* paranccsal generáljuk egy szekvenciát egy fájlba!
1. Illesszük mellé az eltolt párját!
1. Számoljuk ki a szekvencia átlagát!
1. Adjuk össze a számogat 1 től 100 ig!
1. Próbáljuk ki a *bc* és a *dc* programokat!


---

# Varázslatos parancsok

- *convert*: képeket konvertál és átalakít
    - Gyakorlatilag bármiről bármire (imagemagick)
- *rename*: átnevez fájlokat akár reg.kif alapján (batch módban is)
    - Perl van mögötte
- *avconv* vagy *ffmpeg*: audio és videó konvertálása átalakítása
    - A kettő gyakorlatilag egymás forkja
- *pdftk* és *psutils*: pdf és postscript-ek manipulálására
    - Különösen érdekes: *pdfbook* és *psbook*: füzetként nyomtathatóra varázsolja a pdf-et/ps-t
- *graphviz*: dot programozási nyelven gráfokat lehet benne definiálni
    - Minden formátumban generálni
- *gnuplot*: függvényrajzoló/plotter. Adatokat lehet vizualizálni vele könnyedén
    - Minden formátumba tud generálni

---

# Shell történelem

- sh : Bourne shell. Az eredeti "öreg" shell. Nincs parancssoros szerkesztés
- csh : C shell, Berkley-ben fejlesztve. Interaktív használatnál kompatibilis a Bourne shellel, de a programozásnál más interface-t használ (C stílus)
- tcsh : kibővített C shell (emacs stílus) ([FreeBSD alapértelmezett shell](https://www.freebsd.org/doc/en/articles/linux-users/shells.html))
- ksh : Korn shell. Unix rendszeren a legnépszerűbb. Az első ami a modernebb shell cuccokat integrálta a Bourne shellbe. Bourne shell kompatibilis (FreeBSD root shell!)
- bash : Bourne Again shell, leggyakrabban használt shell. Bourne shell kompatibilis
- zsh : Z shell. A legújabb. Bourne shell kompatibilis. Jó választás a kezdőknek

Ha ki akarja valaki próbálni: *chsh*

- De mielőtt cserélnénk, az adminisztrátornak installálni kell az újat és elérhetővé kell tennie a /etc/shellben
- *checkbashisms*: Megnézi, hogy mennyire kompatibilis a nem bash shellekkel az adott script ([Bash vs. Dash](http://princessleia.com/plug/2008-JP_bash_vs_dash.pdf))
- [Shebang (#!/bin/bash)](http://en.wikipedia.org/wiki/Shebang_(Unix)): [A */bin/sh*](http://hup.hu/cikkek/20141004/dash_mint_alapertelmezett_shell_a_fedora-ban) [nem bash!](https://lists.fedoraproject.org/pipermail/devel/2014-October/202876.html) [Be kell állítani a script első sorában!](https://wiki.ubuntu.com/DashAsBinSh)

- Olvasnivaló: [Bash vs. Dash](http://princessleia.com/plug/2008-JP_bash_vs_dash.pdf)

---

# Összehasonlítás: *[*, *test*

    !bash
    [ -z $alma ] && echo "true" || echo "false"
    test -z $alma && echo "true" || echo "false"

- \-s : igaz, ha a fájl létezik és nem üres
- \-f : igaz, ha a fájl létezik és reguláris állomány
- \-d : igaz, ha a fájl létezik és könyvtár
- \-x : igaz, ha a fájl létezik és végrehajtható
- \-w : igaz, ha a fájl létezik és írható
- \-r : igaz, ha a fájl létezik és olvasható
- \-z : igaz, ha a string hossza zéró
- \-n : igaz, ha a string hossza nem zéró
- stb.
- Tippek, trükkök:
    - Ilyet lehet írni: if grep ^root /etc/passwd; then
    - Ne felejtsük az idézőjeleket (a stringeknél): [ "$mystring" = testword ]

---

# Függelék: A visszaszámláló forrása

---

# *figlet*, *toilet*, *banner*

- Terminálra írnak ki, ASCII-art-tal
- [Figlet helyes telepítése](http://wiki.shellium.org/w/Figlet#Installing_on_Ubuntu)
    - Fontok: *showfigfonts*

[Bővebben](http://lgogua.blogspot.hu/2013/07/install-figlet-toilet-and-banner.html). A kód ([nyomokban emlékeztethet erre](http://www.unix.com/shell-programming-and-scripting/98889-display-runnning-countdown-bash-script.html)):


    !bash
    function countdown
    {
            local OLD_IFS="${IFS}"
            IFS=":"
            local ARR=( $1 )
            local SECONDS=$((  (ARR[0] * 60 * 60) + (ARR[1] * 60) + ARR[2]  ))
            local START=$(date +%s)
            local END=$((START + SECONDS))
            local CUR=$START

            while [[ $CUR -lt $END ]]
            do
                    CUR=$(date +%s)
                    LEFT=$((END-CUR))
                    clear
                    printf "%02d:%02d:%02d" \
                            $((LEFT/3600)) $(( (LEFT/60)%60)) $((LEFT%60)) | figlet -ct -f epic

                    sleep 1
            done
            IFS="${OLD_IFS}"
            echo "        "
    }

    if [ $# -eq 0 ]; then
        countdown "00:30:00"
    else
        countdown $1

    fi
