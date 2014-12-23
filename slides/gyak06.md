
# Operációs rendszerek I.<br/> 6. gyakorlat

---

# Még egy kis infó a ShellShockról

- [A Shellshock margójára](http://hup.hu/node/135564)
- [Shellshock összefoglaló](http://www.dwheeler.com/essays/shellshock.html) (Hasonló hiba: [Apple goto fail](http://www.dwheeler.com/essays/apple-goto-fail.html))
- [A Windows-t is érintheti](http://threatpost.com/shellshock-like-weakness-may-affect-windows/108696) [egy Shellshock-szerű probléma](http://thesecurityfactory.be/command-injection-windows.html)

# Kapcsolódó

- [A windows parancssor visszatér](http://wpdev.uservoice.com/forums/266908-command-prompt)
- [37 éves bugot javítottak az OpenBSD-ben](http://hup.hu/cikkek/20141010/37_eves_bugot_javitottak_az_openbsd-ben_egy_22_eves_patchcsel) [egy 22 éves patchcsel](http://cvsweb.openbsd.org/cgi-bin/cvsweb/src/usr.bin/head/head.c?rev=1.18&content-type=text%2Fx-cvsweb-markup)
- [Miért nem Windows 9 a következő Windows?](http://hup.hu/node/135681)
- [FUN: /dev/null as a service](http://devnull-as-a-service.com/)
- [Bash csomagkezelő készítés](http://hup.hu/node/132326)

---

# *Grep* parancs

- Reguláris kifejezések segítségével egy fájlon/STDIN-on érkező szövegben keres, ha a sor (legalább egy részére) illeszkedik a reguláris kifejezés, akkor kiírja a sort, különben nem.
- Fontosabb opciói:
    - *-E*: kiterjesztett reguláris kifejezéseket is lehet használni (az *egrep* parancs gyakorlatilag "symlink")
    - *-P*: perl-féle reguláris kifejezéseket használ (*pcregrep* hasonló)
    - *-A n*: az egyező sor utáni n sort is kiírja
    - *-B n*: az egyező sor előtti n sort is kiírja
    - *--color*: kiszínezi az illeszkedő szöveget a sorban
    - *-c*: megszámolja az egyező sorokat (nem kell *wc -l*)
    - *-e PATTERN*: a "-"-el kezdődő mintákat védi
    - *-F*: fix stringek regkif helyett (újsorral elválasztva)
    - *-f FILE*: a mintákat a megadott fájlból veszi (minden minta egy sor)

---

# *Grep* parancs

- További fontosabb opciók:
    - *-H*: kiírja a fájlnevet is az egyező sorok elé
    - *-i*: kisbetű-nagybetű érzéketlen vizsgálat
    - *-v*: inverz illeszkedés (az a sor íródik ki, amelyik nem illeszkedik a mintára)
    - *-m n*: csak az első n darab illeszkedést végzi el. Nem olvassa tovább a bemenetet, így a következő folyamat folytathatja a bemenet olvasását.
    - *-n*: a sorszámot (a bemeneti sorok számát tekintve) beszúrja a sor elejére
    - *-R*, *-r*: Minden fájlt rekurzívan feldolgoz a könyvtáron belül
- locale-t figyelembe veszi! pl.: *echo "kutya" | grep "[s-u]"*
- [Magyar vonatkozásai is vannak](http://tdk.bme.hu/VIK/Szoftver/POSIX-regularis-kifejezesek1)
- Példa a használatra: [Több fájlban egy mintát kicserélni egy paranccsal](http://systembash.com/content/easy-search-and-replace-in-multiple-files-on-linux-command-line/)
- [FUN: Regex Golf](http://xkcd.com/1313/)

---

# *Grep* parancs, amit még tudni érdemes

- [Vita a BSD grep körül](http://hup.hu/cikkek/20100815/vita_a_bsd_grep_korul+)
- [Ígéretes patch a BSD grep-hez](http://hup.hu/cikkek/20100817/igeretes_patch_a_bsd_grep-hez)
- ["Miért gyors a GNU grep"](http://hup.hu/cikkek/20100822/miert_gyors_a_gnu_grep)
- [Ismét a GNU grep az alapértelmezett a FreeBSD HEAD-ben](http://hup.hu/cikkek/20100823/ismet_a_gnu_grep_az_alapertelmezett_a_freebsd_head-ben)
- [Akár 7-10-szeres gyorsulást ígér a grep új kiadása](http://hup.hu/cikkek/20140218/akar_7-10-szeres_gyorsulast_iger_a_grep_uj_kiadasa)
- [Még gyorsabb az új grep 2.21](http://www.phoronix.com/scan.php?page=news_item&px=MTg0NjI)
- [*grep* nagy fájlokon](http://hup.hu/node/115377)
- [CUDA grep - hardveresen gyorsított regex illesztő](http://hup.hu/cikkek/20130604/cuda_grep_hardveresen_gyorsitott_regex_illeszto)
- [*ack* forráskódokra optimalizált grep Perlben](http://beyondgrep.com/)

# Kapcsolódó

[A *grep* és az *iconv* magyar vonatkozásai: Kövesdán Gábor](https://www.aut.bme.hu/en/Staff/gabor.kovesdan)

---

# A kiterjesztések sorrendje

Az elsőtől az utolsó felé haladva: [Bővebb infó](http://wiki.bash-hackers.org/syntax/expansion/intro)

- Kapcsos zárójel kiterjesztés (brace expansion)
- Tilde (~) kiterjesztés
- A következő kiterjesztések egyszerre balról-jobbra haladva történnek
    - Paraméter kiterjesztés (változók)
    - Aritmetikus kifejezések kiértékelése ( ((alma=2+2)), [ $alma -gt 2 ] )
    - Parancsok kiértékelése ( $( COMMAND ), \` COMMAND \` )
    - A alfolyamatok (process substitution) kiértékelése (< fájl és > fájl)
- Szavakra bontás (az $IFS alapján)
- Elérési utak kiterjesztése (globbing)
- Az egyszerre végrehajtódó lépések miatt (paraméter, aritmetika, parancsok, alfolyamatok) az eredmény az alábbi esetben 1 1 2 és nem 1 1 1 lesz:

        i=1
        echo $i $((i++)) $i

---

# Kapcsos zárójel (brace) kiterjesztés

- Egyfajta minta adaható meg vele (minden kombinációt legyárt)
- *{string1,string2,...,stringN}*: Egymás után rakja a felsorolás elemeit (a prefixet és suffixet másolja)
    - pl.: doc/{alma,korte}.txt -> doc/alma.txt doc/korte.txt
- *{<START>..<END>}*: A kezdet és a vég számokhoz szekvenciát gyárt
    - Tud padding-et is ilyenkor a megfelelő számú nullát kell a kezdet elé írni
    - Tud tetszőleges növekményt is: *{<START\>..<END\>..<INCR\>}*
    - Példák: [Még több vicces felhasználás](http://wiki.bash-hackers.org/syntax/expansion/brace)

            !bash
            echo {1..5} -> 1 2 3 4 5
            echo {c..g} -> c d e f g
            echo {06..10} -> 06 07 08 09 10
            echo {1..10..2} -> 1 3 5 7 9
            # A változó behelyettesítés később van, ezért kell subshellben futtatni!
            for i in $(eval echo {$a..$b})
            # Itt a zárójelek és a kiértékelés sajátossága miatt működik!
            declare -a 'pics=(img{'"$a..$b"'}.png)'; mv "${pics[@]}" ../imgs
            # Nem alkalmazza a locale-t
            echo {{A..Z},{a..z}} -> Összes nagy és kisbetű az Ábécében
            somecommand -v{,,,,} -> somecommand -v -v -v -v -v

---

# Tilde (~) kiterjesztés

- A tilde kiterjesztése csak akkor hajtódik vére, ha
    - Az egyik szó elején van egy tilde-t tartalmazó konstrukció
    - Vagy önmaga egy külön szót alkot
    - Minden változó hozzárendeléskor
    - az első egyenlőségjel (=) után pl.: PATH=~jozsi/share
    - és minden kettőspontnál (:) pl.: PATH=file:~jozsi/share
- Ha valami hiba van, vagy nem kiterjeszthető akkor nem történik semmi
- Ha a konstrukció szóközöket tartalmaz, akkor a tilde után kell idézni: <br/> pl.: *~/"szóközös könyvtár"*
- A kifejezés a következő specifikus elérési utakra terjesztődhet ki
    - *~*, *~jozsi* home könyvtár ($HOME)
    - *~+*:  az aktuális munkakönyvtár ($PWD)
    - *~-*: az előző munkakönyvtár ($OLDPWD)
- [Bővebb információ](http://wiki.bash-hackers.org/syntax/expansion/tilde)

---

# Mintaillesztés a shellben (Glob patterns)

- *: Minden stringre illeszkedik (az üresre is (!), kivéve a / és beállítástól függően a pont)
- ?: Egy darab karakterre illeszkedik
- [...]: A felsorolt karakterekre illeszkedik (intervallumok is jók mint a reg.kif-eknél)
- Különféle opciók a shellben történő ki-be kapcsolásával a viselkedésük testre szabható
- A *shopt -s extglob* a kiterjesztett globok is elérhetők (list= minták |-val elválasztva)
- ?(list): a megadott minták valamelyikének egy vagy zéró előfordulására illeszkedik
- *(list): a megadott minták valamelyikének zéró vagy több előfordulására illeszkedik
- +(list): a megadott minták valamelyikének egy vagy több előfordulására illeszkedik
- @(list): a megadott minták pontosan egyikére illeszkedik
- !(list): a megadott minták egyikére sem illeszkedik
- [Bővebb](http://wiki.bash-hackers.org/syntax/pattern)
  [információt](http://wiki.bash-hackers.org/syntax/expansion/globs)
  [lehet](http://mywiki.wooledge.org/BashGuide/Patterns)
  [találni](http://mywiki.wooledge.org/glob)
  [az interneten](http://tldp.org/LDP/abs/html/globbingref.html)

        !bash
        ls \*.txt*, *ls b\*
        cat test{0..11}/result.txt
        cp \*.[ch] somewhere/

---

# Kerülendők (Obsolete & Depracated)

- *&>FILE and >&FILE*
    - Helyette: *>FILE 2>&1*
    - Oka: Régi, többértelműségre ad okot, elemzéskor
- *COMMAND |& COMMAND*
    - Helyette: *COMMAND 2>&1 | COMMAND*
    - Oka: Zsh-ból jön, fölösleges, összeakad a többi shellel
- *$[EXPRESSION]*
    - Helyette: *$((EXPRESSION))*
    - Oka: Régi és már rég lecserélte a POSIX megfelelőre minden
- *function NAME() parancsok*
    - Helyette: *NAME() parancsok vagy function NAME { parancsok; }*
    - Oka: Ez egy olyan kombináció, ami nem is létezhetne (nem fogadja el minden)
- *for x; { …;}*
    - Helyette: *do, done, in, stb.* (Régen így működött (Korn shell) már van rá kulcsszó)

---

# Kerülendők (Obsolete & Depracated)

- *\`COMMANDS\`*
    - Helyette: *$(COMMANDS)*
    - Oka: Mindkettő POSIX, de a másodikat ajánlják
- *printf $((  500 *  RANDOM  / 32767   ))*
    - Helyette: *random=$(awk 'BEGIN { srand(); printf ("%d\n", int(rand()*499)+1); }')*
    - Oka: Elkerülendő a RANDOM, helyette AWK-féle random() kell!
- *((echo X);(echo Y))*
    - Helyette: *( (echo X); (echo Y) )*
    - Oka: Az egymásba ágyazott subshell ne keveredjen az aritmetikai operátorral!
- *(( MATH ))*
    - Helyette: *: $(( MATH ))*
    - Oka: Nem minden shell ismeri, kerülő megoldás
- *export VAR=VALUE*
    - Helyette: VAR=VALUE; export VAR (Előbb van az export utána a kiértékelés)

---

# Hordozhatóság

- *declare keyword*  # Ksh, stb.
    - Helyette: *typeset keyword* # Bash only
    - Oka: El kell dönteni, mire fejlesztünk...
- *function NAME() COMPOUND-CMD*  # Ksh. stb.
    - Helyette: *NAME() COMPOUND-CMD*
    - Vagy: *function NAME { CMDS; }* # Bash only
    - Oka: Lásd az előző.
- *[[ EXPRESSION ]]* # Bash only
    - Helyette: [ EXPRESSION ] vagy test EXPRESSION # POSIX
    - Oka: Majdnem mindenhol támogatott a Bash verzió, de nem POSIX ([példa](http://tldp.org/LDP/abs/html/testsandcomparisons.html))
    - Megj: A test kulcsszó sem mindenhol támogatott csak a klasszikus *[test](http://wiki.bash-hackers.org/commands/classictest)*

[Régi szintaxis](http://wiki.bash-hackers.org/scripting/obsolete) [Hordozhatóság](http://wiki.bash-hackers.org/scripting/nonportable) [Kompatibilitás](http://linuxshellaccount.blogspot.hu/2008/07/basic-io-redirection-differences-in.html)

---

# Hordozhatóság

- *command <<< WORD* # Bash only (here-string) (Input kézi megadása extremális elemig)
- Helyette:

        !bash
        command <<MARKER
        WORD
        MARKER

- *source FILE* # Bash only (Forrás fájl beillesztése: include)
    - Helyette: . FILE # POSIX

- Ha szeretnénk megbizonyosodni, hogy egy parancs elérhető a rendszeren:

        !bash
        # Vagy hash
        if hash ls >/dev/null 2>&1; then
            echo "ls is available"
        fi
        # Vagy command parancs
        if command -v sed >/dev/null 2>&1; then
            echo "sed is available"
        fi

---

# Sebesség optimalizálás

- Használnjunk beépített parancsokat ahol lehet
- A Pipe-okat minimalizáljuk
- Unicode kikapcsolása: export LC_ALL=C
- Sebesség (növekvő sorrendben): expr < let < $(( ))
- Sebesség (növekvő) if [] és idézőjelek < if [], és -eq < if [] idézőjelek nélkül < case
- Asszociatív tömbök sima tömbök helyett, ahol lehet!
- A kritikus részek újraírása gyorsabb scriptben vagy C-ben... :)
- File I/O minimalizálása esetleg (Perl vagy AWK segítségével)

# Security

- Titkos adat ne kerüljön környezeti változóba!
- Külső parancsnak ne adjuk argumentumként csak Pipe-pal vagy átirányítással!
- Ne bízzunk meg a kapott $PATH-ban. Állítsuk be körültekintően mi magunk!
- Az Oprendszer összes változójával legyünk bizalmatlanok!

[Bővebb infó](http://tldp.org/LDP/abs/html/optimizations.html) [és itt is](http://tldp.org/LDP/abs/html/securityissues.html)

---

# Useless ** award

- "The Useless Use of Cat Award": A *cat* célja, hogy több fájl összefűzzünk, egy fájlra pazarlás

        !bash
        cat fájl | parancs és az argumentumok
        # Átirányítással
        <fájl parancs és az argumentumok
        # Argumentumként
        parancs és az argumentumok fájl
        # Kivétel:
        { foo; bar; cat mumble; baz } | whatever

- "Useless Use of Kill -9 : Nincs esélye a programnak
    - A socketeket lezárni
    - Az ideiglenes fájlokat törölni
    - A gyerekeit értesíteni, hogy meg fog halni
    - Visszaállítani a terminál beállításait
    - stb.

---

#  Useless ** award

- Helyes sorrend:
    - kill -15 # SIGTERM
    - utána várni 2 másodpercet
    - utána kill -2 # SIGINT
    - utána kill -1 # SIGHUP
    - "Ha ezután sem halt meg, akkor törölni kell a programot, mert nem jól viselkedett!"
- "Useless Use of ls *"

        !bash
        # Az ls fölösleges subshell subprocessel
        for f in \`ls *\`; do
            command "$f"   # newbies will often forget the quotes, too
        done

        # Az echo és a \` is fölslegesa globbing miatt...
        for f in \`echo *\`; do

        # Még a for is fölösleges
        for f in *; do

        # Helyesen
        command *

---

#  Useless ** award

- Useless Use of Wc -l
    - parancs | grep '.' | wc -l
    - Helyesen: parancs | grep -c .
    - Hasonlóan ha csak az érdekel minket hogy talált-e valamit: something | grep . >/dev/null && ...
    - Vagy ha a grep támogatja: parancs | grep -q . && ...
    - A legjobb ha ilyenkor a "parancs" maga beállítja a hibakódját és nem kell greppelni...
- Useless Use of grep | awk and grep | sed
    - ps -l | grep -v '[g]rep' | awk '{print $2}'
    - Az *awk* tud "greppelni: ps -l | awk '!/[a]wk/{print $2}'

---

#  Useless ** award

- Useless Use of Backticks
    - Veszélyes (!): for f in \`cat file\`; do ...; done
    - A sor lehet, hogy hosszabb mint, amit az oprendszer kezelni tud (ARG_MAX) [Variációk a problémára](http://mywiki.wooledge.org/DontReadLinesWithFor)
    - Helyesen: while read f; do ...; done <file
    - Vagy: parancs ami a fordított aposztrófban volt | while read f; do ...; done <file
    - Hasonlóan: command \`másik parancs\`
    - Helyesen: másik parancs | xargs egyik parancs
- Useless Use of Test
    - parancs; if [ $? -ne 0 ] ; then utasítás
    - Helyett: if parancs ; then : ; else
- Még pár érdekes dolog

[Forrás és bővebb infó](http://www.smallo.ruhr.de/award.html)

---

# Próbáljuk ki a parancsokat!

1. Keressünk B-vel keződő sorokat egy fájlban!
1. Számoljuk meg az ilyen sorokat!
1. Próbáljuk ki a "kutyás" példát!
1. Próbáljuk ki az "Useless use of *ls*"-beli példákat!
1. Mérjük li a futásidőket!
1. Próbáljuk ki a "kapcsos zárójel kiterjesztéseket"!

---

# Hogy kell csendben folyamatot ölni?

    !bash
    #!/bin/bash

    # example background process
    sleep 300 &

    # get the PID
    BG_PID=$!

    ### HERE, YOU TELL THE SHELL TO NOT CARE ANY MORE ###
    disown $BG_PID
    ###


    # kill it, hard and mercyless, now without a trace
    kill -9 $BG_PID

    echo "Yes, we killed it"

[Forrás](http://wiki.bash-hackers.org/snipplets/kill_bg_job_without_message)

# C-v beillesztésként való használata ([forrás](http://wiki.bash-hackers.org/snipplets/xclip))

    !bash
    if [ -n "$DISPLAY" ] && [ -x /usr/bin/xclip ] ; then
        # Work around a bash bug: \C-@ does not work in a key binding
        bind '"\C-x\C-m": set-mark'
        # The '#' characters ensure that kill commands have text to work on; if
        # not, this binding would malfunction at the start or end of a line.
        bind 'Control-v: "#\C-b\C-k#\C-x\C-?\"$(xclip -o -selection c)\"\e\C-e\C-x\C-m\C-a\C-y\C-?\C-e\C-y\ey\C-x\C-x\C-d"'
    fi

---

# Konfig fájlok

- Egyszerű konfigok készíthetők scriptekhez a *soruce* használatával
    - POSIX verzió: *. config.cfg*
    - Bash only verzió: *source config.cfg*
    - Gyakorlatilag "include", nem futtatja a scriptet
- Rendszer szintű és felhasználó szintű konfigok elválaszthatók felülírhatók
- Gonosz kódot is tartalmazhat, nem csak értékadásokat! Meg kell tisztítani ([forrás](http://wiki.bash-hackers.org/howto/conffile)):

        !bash
        #!/bin/bash
        configfile='/etc/cool.cfg'
        configfile_secured='/tmp/cool.cfg'

        # check if the file contains something we don't want
        if egrep -q -v '^#|^[^ ]*=[^;]*' "$configfile"; then
          echo "Config file is unclean, cleaning it..." >&2
          # filter the original to a new file
          egrep '^#|^[^ ]*=[^;&]*'  "$configfile" > "$configfile_secured"
          configfile="$configfile_secured"
        fi

        # now source it, either the original or the filtered variant
        source "$configfile"

---

# Párhuzamosítási lehetőségek

- *parallel* kulcsszó
    - Parallel lehet futtatni parancsokat
    - Nem igen használják
- *coproc* kulcsszó
    - Ez is egy fajtája a háttérfolyamatok gyártásának
- *wait* parancs
    - Például a *coproc* által létrehozott feladatokra lehet várni
    - PID megadásával megvárja a script, amíg a folyamat befejeződik

[Bővebb](http://wiki.bash-hackers.org/syntax/keywords/coproc) [infó](http://wiki.bash-hackers.org/commands/builtin/wait)

# Kommentek

- Sima komment # karaktertől sor végéig tart, blokk kommentekre hack:

        !bash
        : <<"SOMEWORD"
        A blokk komment ide jön
        SOMEWORD

---

# Hasznos infók

- Debugolás:
    - Vigyázzunk a név ütközésekre! A *syntax highlighting* sok bajtól megkímél!
    - Hosszan futó scriptet érdemes [logolni pl. a syslogba](http://unixhelp.ed.ac.uk/CGI/man-cgi?logger+1)
    - *echo* és a *printf* %q opciója
    - Verbose és Xtrace:  #!/bin/bash -vx
    - Xtrace okosítás: *export PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'*
    - [És még sokan mások](http://wiki.bash-hackers.org/scripting/debuggingtips)
- [Javasolt kódolási stílus](http://wiki.bash-hackers.org/scripting/style) ([és a nem javasolt](http://tldp.org/LDP/abs/html/gotchas.html))
- [Terminál kódolás mélységei](http://wiki.bash-hackers.org/scripting/terminalcodes)
- Vannak OOP keretrendszerek, amiket lehet használni bashben [nem](http://sourceforge.net/projects/oobash/) [is](https://github.com/hornos/shf3) [egy](https://github.com/chilicuil/learn/blob/master/sh/lib)
- Ha "zárt forrású" scriptet akarunk írni: Shell script compiler (*shc*) [kód obfuszkálásra való](http://www.datsi.fi.upm.es/~frosal/sources/shc.html)
    - Feltörhető, de nem lehet egyből belenézni a kódba
- [Online is lehet játszani](http://www.compileonline.com/execute_bash_online.php)

---

# Néhány eszköz ami a GUI-felé visz

- [gdialog](http://snipplr.com/view/39570/yesno-gui-dialog-on-linux-using-gdialog/)
    - Ahány grafikus toolkit, annyi változat
- [xmessage](http://linux.byexamples.com/archives/87/using-gui-dialog-box/)
    - Használati eset: [Pislogás emlékeztető](http://hup.hu/node/135663#comment-1786429)
- [zenity](http://www.howtogeek.com/107537/how-to-make-simple-graphical-shell-scripts-with-zenity-on-linux/)
- [GTKDialog](http://xpt.sourceforge.net/techdocs/language/gtkdialog/gtkde02-GtkdialogExamples/)
    - Itt azt használjuk ki, hogy tulajdonképp XML-ben írjuk le a GUI-t és azt adjuk át
- [Példák és infók](http://tldp.org/LDP/abs/html/assortedtips.html)

# További hasznos eszköz a tanuláshoz

[Explain shell](http://explainshell.com/)

---

# Néhány feladat egysoros megoldása

- [Hogyan csatoljunk e-mailhez fájlt parancssorból?](http://systembash.com/content/linux-command-line-attach-files-email/)
    - *uuencode filename1 filename2 | mail user@domain.name*
- [Hogyan töröljünk régi könyvtárakat?](http://systembash.com/content/another-bash-one-liner-to-delete-old-directories/)
    - *find /home/backup/ -maxdepth 1 -type d -mtime +7 -exec echo "Removing Directory => {}" \; -exec rm -rf "{}" \;*
- [Hogyan kapcsoljuk ki a monitort távolról, parancssorból?](http://systembash.com/content/how-to-turn-off-your-monitor-via-command-line-in-ubuntu/)
    - *DISPLAY=:0 xset dpms force off*
- [Hogyan mérjük meg "fapadosan" a merevlemez sebességét?](http://systembash.com/content/simple-disk-benchmarking-in-linux-using-dd/)
    - *dd bs=1M count=512 if=/dev/zero of=test conv=fdatasync*
    - Hasonlóan: [Random fájl generálása tetszőleges méretben...](http://systembash.com/content/linux-command-line-generating-a-random-file/)
- [Hogyan szinkronizáljunk (fájlattribútumokkal együtt) ssh-en keresztül?](http://systembash.com/content/using-rsync-on-an-alternate-ssh-port-or-with-openssh-keys/)
    - *rsync -avz -e "ssh -i /path/to/private/key -p $port" username@ip:/path/to/files/ /local/files/\**
    - [Lehet tovább is fokozni, automatizálással...](http://systembash.com/content/bash-script-to-interface-with-rsync-command/)
