
# Operációs rendszerek I.<br/> 5. gyakorlat

---

# Bash Változók

- Kétféle  változó van:
    - Rendszer változók (az operációs rendszer kezeli őket): Nagybetűkkel írandók hagyományosan
    - Felhasználó változói (a felhasználó kezeli őket): Kisbetűvel írandók hagyományosan
- A változónevek alfanumerikus betűkből vagy undescore karakterből (_) kell álljon
- Például:
    - HOME
    - SYSTEM_VERSION
- Nem szabad az értékadás egyik oldalára sem szóközt rakni!
- Rosszak lesznek a következő értékadások:
    - $ no =10  # "no" parancs, "=10" argumentummal
    - $ no= 10  # "10" parancs, "no" környezeti változóval, ami "" re van állítva
    - $ no = 10 # "no" parancs, két argumentum: "=" és "10"
    - $ no=1 2 3# "no=1" érétkadás, "2" parancs "3" argumentummal-> Error!
    - Vagy védjük a szóközt (\) vagy idézőjellel körbevesszük a stringet

---

# Bash Változók

- A változók kis- és nagybetűkre érzékenyek!
- Az alábbi négy változó egymástól független:
    - $ no=10
    - $ No=11
    - $ NO=20
    - $ nO=2
- A változó értéke lehet üres string (nem ekvivalens azzal ha nincs értéke a változónak)
    - Nem deklarált változónak mindig üres string az értéke (kivéve aritmetikai parancsban, mert akkor 0)
    - $ nem_deklaralt+=5; echo $nem_deklaralt # 5
    - *unset $változó*: változót törli. Mi lesz az értéke ezután?
- Nem szabad ?,* stb. karaktereket használni a változónévben!
- Értékadásnál a nevükkel hivatkozunk rájuk, hivatkozásnál kell eléjük egy dollárjel ($)
[Bővebben](http://www.tldp.org/LDP/abs/html/varsubn.html)

---

# Bash Változók

Mindig van előttük dollárjel ($), **kivéve**:

- Deklarációkor
- Értékadáskor
- Törléskor (unset)
- Exportáláskor (export)
- Aritmetikus kifejezésben a duplazárójeleken belül ( "((...))" )
- amikor szignált reprezentál (*trap* paramétereként) [példa](http://tldp.org/LDP/abs/html/debugging.html#EX76)
- *read* utasításnál
- A ciklus fejében (*for i in 1 2 3*)
- Az idézőjel (") nem interferál a változó behelyettesítéssel (half quoting, weak quoting)
- Aposztróffal (') közrefogva nincs változó behelyettesítés (full quoting, strong quoting)

---

# Bash string változó manipulálás

- *${#string}*: a string hossza
- *${string:pozíció}*: substring a pozíciótól (0-tól van indexelve)
- *${string:pozíció:hossz}*: substring a pozíciótól (0-tól van indexelve) hossz hosszban
- *${string#substring}*: a legrövidebb substring egyezést kiszedi a stringből
- *${string##substring}*: a leghosszabb substring egyezést kiszedi a stringből
- *${string%substring}*: a legrövidebb substring egyezést kiszedi a stringből hátulról
- *${string%%substring}*: a leghosszabb substring egyezést kiszedi a stringből hátulról
- *${string/substring/replacement}*: az első egyezést cseréli
- *${string//substring/replacement}*: minden egyezést cseréli
- *${string/#substring/replacement}*: a string első végétől kezdve egyező első találatot cserél
- *${string/%substring/replacement}*: a string hátsó végétől kezdve egyező első találatot cserél

---

# Bash string változó manipulálás

- *${string^}*, *${string^^}*: Az első, illetve az összes karaktert nagybetűsíti
- *${string,}*, *${string,,}*: Az első, illetve az összes karaktert kisbetűsíti
- *${string~}*, *${string~~}*: Az ellentétére (reverse case) cseréli az első, illetve az összes betűt
- [Bővebben](http://wiki.bash-hackers.org/syntax/pe)
- Bash string változó helyettesítés ([Forrás](http://tldp.org/LDP/abs/html/parameter-substitution.html))
    - *$var*, *${var}*: Változó értéke, néha érdemes lehet kapcsos zárójellel védeni
    - *${var:-dolog}*: var értéke, ha definiálva van, egyébként a dolog értéke (var nem kap értéket)
    - *${var:=dolog}*: var értéke, ha definiálva van, egyébként a dolog értéke (var értéke a dolog lesz)
    - *${var:+dolog}*: dolog, ha var definiálva van, egyébként üres string
    - *${var:?üzenet}*: ha var definiálva van, akkor var értéke. Ha nem, akkor kiírja az üzenetet és a shell kilép. Ha az üzenet üres, akkor saját hibaüzenetet ír ki

---

# Kiértékelés

- *((alma=2+2))*: aritmetikus kiértékelés
    - ekvivalens a *let alma=2+2* kifejezéssel
    - POSIX változat: *alma=$((2+2))*
- [[ 2>2 ]]: feltételes kiértékelés [Bővebb infó](http://serverfault.com/a/52050)
    - Szimpla: Beépített parancs, Dupla: Kulcsszó (Nem kompatibilis a régi shellekkel)
    - A beépített parancsnál nem kell a védés (mert nem téveszti össze a shell más funkcióival), a másiknál kell!
- *expr 2 + 2*: aritmetikus kiértékelés
    - Le kell védeni egy csomó mindent, és szóközöket kell rakni!
- *echo $((43#a))*: A konstansok megadhatók különböző számrendszerekben is (<64 alappal)
    - pl.: 43#a -> 10, 43#A -> 36
- Az aritmetikában a 0 a hamis és az 1 az igaz, a hibakódoknál fordítva! [Bővebben](http://wiki.bash-hackers.org/syntax/arith_expr)
- A *:* parancs: a Bourne shellből maradt, mai megfelelője a *true* parancs ([Bővebb infó](http://stackoverflow.com/a/3224910))
- Példa: *test 5 > 2* -> nem jó mert átirányítást ért a 2-es fájlra. Helyesen: test 5 -gt 2

---

# Próbáljuk ki a parancsokat!

1. Próbáljuk ki, hogy hozzáadunk egy számot egy nem deklarált változóhoz!
1. Próbáljuk ki, hogy deklarálunk egy változót, majd töröljük!
1. Mi lesz az értéke ezután?
1. Próbáljuk ki a string manipulációkat!
1. Próbáljuk ki az aritmetikai kiértékeléseket!
1. Próbáljuk ki a szögletes zárójeles logikai kiértékeléseket!
1. Hol az eredmény?
1. Mi következik ebből?

---

#Bash függvények

Kódblokkok:
    - ( parancs ) subshell
    - { parancs } ebben a shellben hajtódik végre

Igazi függvények:

    !bash
    function függvény_név(){
    parancs
    }
    echo "A függvényt végrehajtjuk:"
    függvény_név

- *function* kulcsszó és az üres zárójelek is elhagyhatók (de egyszerre csak egy!)
- A nevével lehet hivatkozni rá
- A definíciónak(!) meg kell előznie a hívást, nem lehet deklarálni!
- A függvény nem lehet üres!
    - Minimum egy parancs: (*:* parancs nem csinál semmit)
- Egymásba ágyazhatóak
- Mindenhol lehet definiálni függvényt, ahol parancsnak kéne lennie
- Felüldefiniálhatóak (még a rendszer parancsok is, bár nem célszerű!)

---

# Bash függvények

- Az átadott változók stringként értelmeződnek
    - Indirekt referenciákkal, lehet változó referenciát átadni ([bővebben](http://www.tldp.org/LDP/abs/html/ivr.html))

            !bash
            echo_var ()
            {
            echo "$1"
            }

            message=Hello
            Hello=Goodbye

            echo_var "$message"        # Hello
            # És most indirekt refereniát adunk át
            echo_var "${!message}"     # Goodbye

    - Dereferenciát is lehet csinálni:

            !bash
            y=\$"$alma"   # Ez a változó neve nem az értéke lesz!
            echo $y       # $alma

            x=`eval "expr \"$y\" "`
            echo $1=$x
            eval "$1=\"Some Different Text \""  # Új értéket rendelünk hozzá

---

# Bash függvények

- STDIN redirect: *{ ... } < file*
- *shift* a paramétereket balra tolja ($2->$1, $n+1 ->$n) [Bővebben](http://wiki.bash-hackers.org/scripting/posparams)
- Lokális változók fordítva(!) működnek mint C-ben, csak akkor lokálisak, ha explicit akarjuk! (*local* kulcsszó)
- Előbb van a kiértékelés, mint az értékadás mindig!

# A rekurzió egy érdekes és néha hasznos formája az ön-referenciának:
 - Herbert Mayer a következőképpen definiálja: "Egy algoritmus kifejezése ugyanazon algoritmus egy egyszerűbb változatának segítségével..."
 - Egy definíció, ami sajátmagával van meghatározva (redundancia)
 - Egy kifejezés, ami implicit saját magára nézve (tautológia)
 - Egy saját farkába harapó kígyó (metafóra)
 - Egy függvény amit saját magát hívja meg (rekurzív függvény)

[Forrás](http://tldp.org/LDP/abs/html/localvar.html), [rekurzió érdekes megvalósításai](http://tldp.org/LDP/abs/html/recurnolocvar.html)

---

# Bash függvények

- *export*: elérhetővé tesz egy változót a subproceszek számára
- *unset*: a változót törli (ettől még az értéke üres string és 0 lesz, lásd korábban)
- *printf*: "PRINT and Format", formázottan lehet kiírni az STDOUT-ra (Mint C-ben)
- *eval*: Az utána következő stringet kiértékeli (manapság nem használják)
    - Mostanság arra használják, hogy a futás közben létrejött változó nevét megadja
    - Erre van bash-ben a ${!varprefix*}, ${!varprefix@}
- *exit n*: Kilép a programból n visszatérési értékkel, *atexit*, *on_exit* [Érdekes alkalmazás](http://pl.atyp.us/wordpress/index.php/2012/11/stackable-exit-hooks-for-bash/)
    - A leghordozhatóbb (EXIT_SUCCESS, EXIT_FAILURE) mert a 0,1, stb. a VMS-en például másképp működik
    - A BSD megpróbálta standardizálni a hibakódokat, lásd: sysexits.h
- *return*: ellentétben az *exit*-tel ez nem hagyja el a futtató shellt
    - [Nagyon jó leírás, hogy kell értéket viszatéríteni függvényből](http://www.linuxjournal.com/content/return-values-bash-functions)
- *getopts*: Paramétereket lehet kezelni okosan, standard módon, nem úgy mint a (getopt, s nélkül!) [leírás](http://wiki.bash-hackers.org/howto/getopts_tutorial)

---

# Függvények/parancsok visszatérési értéke

- Minden programnak/függvénynek van ilyen, alapból: 0
- Fel lehet használni arra, hogy
    - Kiírjuk
    - Reagáljunk rá
    - Megváltoztassuk a script futási folyamatát vele
- Max 255 (egy bájt) [bővebben](http://tldp.org/LDP/abs/html/complexfunct.html)
    - A 0-125 ig tartó intervallum szabadon használható (0 a szabályos, >0 a nem szabályos leállás)
    - A 126-255 ig tartó intervallum le van foglalva speciális célokra (pl.: SIGNAL általi befejeződés jelzése)
- Speciális értékek jelentései:
    - 126: A kért parancs/fájl nem futtatható (de létezik)
    - 127: A kért parancs/fájl nem létezik
    - 128, 255: Az exit parancs nem szabályos argumentumot kapott (?)
    - 128 + N: Az N. számú SIGNAL-al lett leállítva a program

---

# Néhány parancs

- *basename*: elérési útból kiszedi a fájlnevet
- *dirname*: elérési útból kiszedi a könyvtárnevet
- *wc*: megszámolja az összes sorát (-l) szavát (-w) és bájtját (-c) a bemenetnek (*wc -m*: unicore karaktert számol)
- *nl*: csak a nem üres sorokat számolja (*nl -ba*: már minden sort számol)
- *history*: a legutóbb beírt parancsokat írja ki
- *du*: egy adott könyvtár hány bájtot foglal elemenként
- *df*: a felcsatolt köteteken mennyi szabad hely van

# Hogyan adunk meg "-" al kezdődő paramétert a parancsnak?
- Azt akarjuk, hogy a program fejezze be az módosítók (-v és --valami) beolvasását és a "-15.txt" -t fogadjuk el paraméterként
    - *rm -15.txt*, *cp -15.txt minusz_15.txt*
- Meg kell adni egy "--" -t magában, ezzel jelezve hogy vége a módosítóknak, fájlok jönnek [forrás](http://unix.stackexchange.com/questions/1519/how-do-i-delete-a-file-whose-name-begins-with-hyphen-a-k-a-dash-or-minus)

---

# Shell programkonstrukciók: elágazások

    !bash
    if feltétel; then
      igaz-ág;
    elif beágyazott-feltétel; then
      beágyazott-igaz-ág;
    else hamis ág;
    fi

    #--------------------------------------------

    case word in
        marha) parancsok ;;& # itt a következő feltételt is megvizsgálja
        csirke) parancsok ;& # itt folytatja a lejjebb levő ágakkal mint a switch C-ben
        alma | körte | banán | stb.) parancsok ;; # itt megy az esac-ra
        *) default-ág;;
    esac

    #--------------------------------------------

    select fname in *;
    do
        echo you picked $fname \($REPLY\)
        break;
    done

- A *select*-tel már-már interaktív programokat is lehet írni ([bővebben](http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_09_06.html))

---

# Shell programkonstrukciók: ciklusok

- A szokásos konstrukciók elérhetők:
    - `until feltétel; do ciklusmag; done`
    - `while feltétel; do ciklusmag; done`
    - `for (( expr1 ; expr2 ; expr3 )); do ciklusmag; done`
- És még egy extra is: `for name in lista; do ciklusmag; done`
- A feltétel vizsgálat számtalan módjáról már volt szó.
- *break [n]*: n-edik ciklusból lép ki
- *continue [n]*: n-edik ciklusból folytatja az iterációt
- *do* után nem szabad pontosvesszőt (;) rakni!
- Egy sorban is írható, de külön is szedhető
- A feltételek és a kifejezések tetszőleges módon felírhatók
    - Sok lehetőséget ad

---

# *read* és a *seq* parancs

- *read*: beolvas egy sort a standard inputról alapesetben a *$REPLY* változóba
    - *-a $tömb*: minden "szó" a tömbbe kerül (0-tól indexelve)
    - *-d delim*: mezőelválasztó átállítása
    - *-e*: a *Readline* (1989 óta létezik) programot használja
    - *-n n*: max. n darab karaktert olvas be soronként
    - *-r*: a backslasht (\\) nem értelmezi (=literálisan értelmeződik)
    - *-s*: nem mutatja a karaktereket (mint a jelszó bekérésnél)
    - *-t x*: ha x másodperc alatt nincs egy egész sor, akkor timeoutol
- *seq*: számsorozatot generál: kezdet növelés vég
    - A kezdet kihagyható (alapból: 0)
    - A növelés kihagyható (alapból 1)
    - *-w*: egyenlő hosszúra rendezi a számokat (padding)
    - *-f*: *printf* stílusban formázható a kimenet
    - *-s*: szeparátor megadható (alapesetben: \n)

---

# STDIN olvasása rekordonként és mezőnként

- Újsor karakterrel és szóközökkel elválasztva

            !bash
            #!/bin/bash
            while read; do
             echo "sor: $REPLY"
             for i in $REPLY; do
              echo "mező: $i"
             done
            done

- Ugyanez ha megváltoztatjuk az elválasztó karaktereket és fájlból olvasunk:
    - *read -d DELIM* (alapesetben: újsor karakter)
    - és *IFS=DELIM* (alapesetben: fehérszóköz)

            !bash
            #!/bin/bash
            IFS="|"
            while read -d ";" ; do
             echo "sor: $REPLY"
             for i in $REPLY; do
              echo "mező: $i"
             done
            done < file.txt

---

# Még néhány parancs

- *alias*: át lehet definiálni vele parancsokat
    - pl.: *alias rm="rm -f"*
    - [Csomó hasznos alkalmazás](http://wiki.shellium.org/w/Bash_Aliases) [és még egy](http://systembash.com/content/prompt-to-confirm-copy-even-with-cp-f/)
- *readonly*: konstans változó deklarálható
- *declare*: asszociatív tömböket csak így lehet deklarálni ([tömbök](http://tldp.org/LDP/abs/html/arrays.html))
 - pl.: *declare -A tömb* [forrás](http://www.gnu.org/software/bash/manual/html_node/Arrays.html#Arrays), [bővebben](http://wiki.bash-hackers.org/syntax/arrays)
 - Hivatkozás: ${gyümölcs[alma]}
 - Minden elem felsorolása: *${name[@]}* és *${name[@]}*
- *tree*: Ki lehet iratni a könyvtár tartalmát szépen fa struktúrában
- *xargs*: a STDIN-on kapott sort cseréli az következő parancs argumentumára
    - pl.: pgrep "program" | xargs killall -9
    - Bonyolult dolgokat is meg lehet vele oldani!
    - pl.: cat lista.txt | xargs -I % cp % /dest/dir/

---

# Próbáljuk ki a parancsokat!

1. Próbáljuk ki a kódblokkokat! A kívül deifinált változók elérhetők?
1. Definiáljunk egy függvényt!
1. Definiáljunk felül egy függvénnyel egy már létező parancsot!
1. Írjunk egy elágazást, feltétel vizsgálattal!
1. Írjunk egy elágazást, feltétel vizsgálat nélkül!
1. Írjunk ciklust, ami 1-től 10-ig számol! (Mind a négy változatban!)
1. Próbáljuk meg *shift*-tel elfogyasztani a paramétereket!
1. Definiáljunk lokális változót!
1. Mi történik, ha két ugyan olyan nevű változó van: az egyik a függvényen kívül van definiálva, a másik belül lokálisan?
1. Próbáljunk 255-nél nagyobb hibakódot visszaadni! Mi történik? Mit tehetünk?
1. Számoljuk meg egy fájl sorait karaktereit és adjuk meg a méretét!
1. Ciklussal fogyasszuk el a STDIN-re írt szöveget!
1. Definiáljunk egy parancsot, ami az *ls -l*-t hajtja végre!
