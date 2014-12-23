
# Operációs rendszerek I.<br/> 7. gyakorlat

---

# Szöveges fájlok olvasása a terminálban

- *more*: képernyő méretű darabokra bontja a hosszú fájlt ([pager](https://wiki.archlinux.org/index.php/List_of_applications#Terminal_pagers)) és lehet előre léptetni (util-linux)
- *less*: a *more* okosabb testvére (less csomag)
    - Előre is lehet lépkedni benne
    - Nagy fájlokon is működik
    - Keresni lehet benne
    - [Régi, sok funkciója van,](http://www.greenwoodsoftware.com/less/faq.html) [túl sok is néha...](http://garrett.damore.org/2014/09/modernizing-less.html) ([magyarul](http://hup.hu/node/135071))

# Coreutils (Textutils)

- A Bash beépített parancsain kívül számos program segíti a szövegfeldolgozást
    - Olyan alapvető programok, amiknek a kombinációjával erős szövegfeldolgozási képességekre tehetünk szert
- Textutils: Az alap szövegfeldolgozó programok ([lista](http://www.delorie.com/gnu/docs/textutils/))
    - *sed*, *grep* külön volt már akkor is
    - 2003 óta: Fileutils, Shellutils & Textutils → Coreutils [forrás](http://www.gnu.org/software/textutils/textutils.html)

---

# Coreutils (Textutils)

- *head*: egy fájl első 10 sorát írja csak ki
    - \-n X: első X sorát
    - \-n +X: első X sorát (ugyan az mint + nélkül)
    - \-n -X: mindent kivéve az utolsó X sorát (levágja az utolsó X sort)
    - \-c X: bájtokkal a fentiek
- *tail*: egy fájl utolsó 10 sorát írja csak ki
    - \-n X: utolsó X sorát
    - \-n +X: mindent kivéve az első X sorát (X. sortól)
    - \-n -X: utolsó X sorát (ugyan az mint - nélkül)
    - \-f: *Follow* (kevésbé ismert): egy növekvő (pl. log) fájlt követ és kiírja az új sorait
- *tac*: fordított sorrendben írja ki egy fájl sorait (*cat* szó megfordítva)
- *fold*: sortöréseket csinál (line wrapping) a megadott hosszban (alapból 80)
- *printf*: a C ből ismert printf (PRINT and Format)

---

# Coreutils (Textutils)

- *tr*: *TRanslate and Replace* cseréli a felsorolt bájt (!) párokat illetve -d kapcsolóval törli őket
    - Példa: *tr -d '\r'* # "kocsi-vissza" karakter törlése
    - Példa: *tr -s '\n'* # Több egymás utáni újsor karakterből csinál egyet
    - Példa: *tr a-z A-Z* # kisbetűket nagybetűkre cseréli (csak az angol Ábécé szerint)
    - **Nem ismeri az Unicode-ot!** Csak a [Heirloom verzió](http://heirloom.sourceforge.net/)!
    - Jobb elkerülni, számtalan más programmal megoldható ugyanez a feladat... (*sed*, *awk*, *dos2unix*, stb.)
- *uniq*: az egymás utáni ismétlődő sorok közül csak egyet ír ki
    - \-c kiírja az ismétlődések számát is
    - \-d csak a többször előforduló sorokat írja ki
    - \-u csak az egyszer előforduló sorokat írja ki
-c lista ezeket a karakterpozíciókat
- *tsort*: [topológiai rendezést végez](http://en.wikipedia.org/wiki/Tsort)
- *timeout*: Időlimittel futtat egy programot (lelövi, ha nem végzett időre)

---

# Coreutils (Textutils)

- *cut*: kivágja az STDIN-on érkező sorokat szétvágja
    - \-d x: A mezőelválasztó karaktert lehet megadni
    - \-f n: Hányadik mezőt írja ki (lehet intervallumot és listát is megadni)
    - \-c n: Hányadik karaktert írja ki (lehet intervallumot és listát is megadni)
    - \-b n: Hányadik bájtot írja ki (lehet intervallumot és listát is megadni)
- Példa: az *ls -l* parancsból a fájlok tulajdonosát és csoportját szeretnénk csak látni: <br/>
`ls -l | cut -d" " -f3-4`

# Néhány parancs a *Coreutils*-ból
- *csplit*: minták (regkif.) alapján tudja szétvágni a fájlokat [példa](http://www.sanfoundry.com/5-practical-csplit-command-usage-examples-in-linux/)
- *unexpand*: szóközöket tabulátorrá cserél (a tabulátor mérete megadható)
- *truncate*: egy megadott méretre zsugorítja/növeszti a paraméterként kapott fájlt
- *numfmt*: különböző számformátumok között konvertál [példa](http://www.pixelbeat.org/docs/numfmt.html)
- *mktemp*: ideiglenes fájlokat és könyvtárakat lehet vele létrehozni véletlen névvel

---

# Néhány parancs a *Coreutils*-ból

- *sync*: Kiüríti a fájlrendszer puffereit (flush)
- *uname*: Rendszer információkat ír ki
    - \-s: kernel neve
    - \-m: operációs rendszer architektúra (nem a hardveré) (az *arch* parancs ugyan ezt tudja)
    - \-n: gépnév
- *date*: Dátumot különféle formátumokban ki tudja írni
- *true*: semmit nem csinál, de azt 0-és hibakóddal (a ":" parancs szinonimája)
- *false*: semmit nem csinál, de azt 1-és hibakóddal
- *yes*: végtelenségig ismétel egy stringet (alapból a "y"), amíg meg nem ölik
- *shred*: felülír egy fájlt, hogy ne lehessen később visszaállítani, aztán opcionálisan törli
- *split*: szétvág egy nagyobb fájlt a megadott méret szerint több darabra (illetve visszaállítja)
- *touch*: létrehoz egy üres fájlt, vagy a módosítás dátumát megváltoztatja

---

# Néhány parancs a *Coreutils*-ból

- *pathchk*: megnézi, hogy egy fájlnév helyes és hordozható-e
- *readlink*: feloldja az a symlinkeket és kiírja az igazi elérési utat
- *printenv*: kiírja az összes élő környezeti változót
- *sleep x*: vár minimum x másodpercet

# Találós kérdés: Álláshirdetés

A pozícióra az alábbi fejtörő megoldásával jelentkezhetsz:

# A fejlesztőink számának, az aktív előfizetőink számának, a rendszerünk fejlesztése során eddig felvett user storyk számának és a fejlesztési vezető életkorának szorzata 49433665. Hány éves a fejlesztési vezető? Önéletrajzod az {N}@minicrm.hu címre várjuk. Az {N} helyére a fejlesztési vezető életkorát írd!

---

# Megoldás

A feladat megoldása: a jó öreg *factor* parancs

[Forrás](http://hup.hu/node/135227)

# Komplexebb parancsok

- *lex*, *flex*: standard lexikális elemző generátor. Az utóbbi teljesen szabad szoftver nem része a GNU projectnek
- *yacc*, *bison*: szintaktikus elemző generátor. Az előbbi a Berkely az utóbbi a GNU család tagja
- *m4*: Makrónyelv előfeldolgozást lehet végezni fájlokon vele. [Példák](http://www.linuxjournal.com/article/5594)
- spell, hunspell: helyesírás ellenőrző. Az előbbi szabványos régi [nem használatos](http://en.wikipedia.org/wiki/Spell_(Unix)), az utóbbi széleskörben használt, nem csak magyar nyelvre
- *expect*, *Tcl/Tk*: az előbbivel automatizálni lehet a parancssoros interaktív programokat, az utóbbi az eredeti célon túlnőve önálló programozási nyelv lett
    - [Példák és *Autoexpect*](http://www.admin-magazine.com/Articles/Automating-with-Expect-Scripts)

---

# Még egy EDitor

Potenciális ZH kérdés (nem ebből a tárgyból): A backreference reguláris nyelvcsalád része? Ha nem miért nem?

# Ed az editor

- Már volt róla szó (1971-ben írta Ken Thompson)
- Ken Thompson találta fel a
    - A Unixot
    - A reguláris kifejezéseket és Thompson automatát
    - A B és C programozási nyelveket (a C-t főleg inspirálta)
    - Az UTF-8-at
    - Egy sakkozó programot
    - A GO nyelvet (inkább csak közösen tervezte másokkal)
- Tehát sejthető az ED nevű editort főleg Reguláris kifejezésekkel kell vezérelni
- Akkoriban lassú volt a terminál, kicsi a memória és a programozó "vakon" szerkesztette a szöveges fájlt

---

# Még egy EDitor

- A főbb meghívási módok: *echo 'parancsok' | ed fájl* és *ed fájl <<< 'parancsok'*
- Főbb módjai: parancs (command), megtekintő(view) és szöveg mód (text)
- A parancs mód a legérdekesebb (a másik kettő a VIM-nek is van)
- A fájl címezhető soronként: "1,$" (az elsőtől az utolsó sorig) röviden: ","
- Ki tudja írni az eredményt: p vagy w paranccsal: előbbi a képernyőre, utóbbi a lemezre
- Csere minden sorban: *ed -s test.txt <<< $',s/alma/körte/g\nw'* # Ha egy sorban nem tud cserélni, az hibát eredményez!
- Öt sorral a "gyümölcsök" után cserél csak:  *ed -s test.txt <<< $'/gyümölcsök/+5s/apple/banana/g\nw'*
- Kitörli a másodiktól az ötödik sorig a sorokat: *ed -s test.txt <<< $'2,5d\nw'*
- A *grep* parancs szimulálható: *ed -s file <<< 'g/REgkif/p'* # Innen jön a parancs neve: 'g/RE/p'
- A *wc -l* parancs is: *ed -s file <<< '='* # Kiírja az utolsó sor számát
- A *cat* parancs: *ed -s file <<< $',p'*
- [Forrás](http://wiki.bash-hackers.org/howto/edit-ed)

---

# Miért is fontos ez: *sed*

- **Stream EDitor**: hasonló mint az *ed* (1974-ben írták)
- Saját programozási nyelvén szöveget transzformál
- Fontosabb opciói:
    - \-i (*Inplace*): felülírja a fájlt
    - \-r: kiterjesztett reguláris kifejezéseket használ
    - \-e: további scripteket lehet megadni a programnak, hogy egymás után hajtódjanak végre
- Legfontosabb felhasználási esete a *csere*
- Szintaxisa: sed -ri 's/mit/mire/opciók' fájl
- Fontosabb opciók:
    - g: globális csere, különben az első csere után csak kiírja a maradékot
    - i: kisbetű-nagybetűkre nem lesz érzékeny
- Csoportosításnál a zárójeleket le kell védeni!

---

# Miért is fontos ez: *sed*

- Feladat: Egy fájlban alakítsuk a szóközöket újsorrá az újsorokat dupla újsorrá!
    - Megoldás (tr): *tr ' ' '\n'*
    - Megodlás (sed): *sed 's/ /\n/g'*
- Feladat: Visszafelé, az újsorokat szóközzé?
- Megoldás (tr): *tr '\n' ' '*
- Megodlás 1 (sed): *sed 's/\n/ /g'* # Nem csinál semmit, mert sororientált a feldolgozás
- Megodlás 2 (sed): sed ':a;N;$!ba;s/\n/ /g' # Nem olyan egyszerű... [Magyarázat](http://stackoverflow.com/a/1252191)
- Kevésbé ismert tulajdonsága:
    - Az elválasztó tetszőlegesen cserélhető: sed 's#/#//#g'
    - Cserénél & karakter a teljes mintát helyettesíti: sed 's/alma/gyümölcs: &/g'
- Alkalmazási lehetőség: a *tree* parancs szimulációja ([forrás](http://systembash.com/content/one-line-linux-command-to-print-out-directory-tree-listing/))

        !bash
        ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /'\
        -e 's/-/|/'

---

# AWK: egy teljes programozási nyelv

- A fő koncepció: A bemeneti fájl rekordokból és mezőkből áll, hatékonyan feldolgozható szabályokkal. [A shellscriptekkel együtt jól alkalmazható](https://www.gnu.org/software/gawk/manual/html_node/Using-Shell-Variables.html)
- *awk 'minta { tevékenység }'*
- minta (pattern):  alapértelmezett viselkedés: mindenre illeszkedik (tehát a { } blokk minden sorra lefut)
- tevékenység (action): alapértelmezett viselkedés: a sort kiírja
- Főbb opciói:
    - \-F: mezőelválasztó karakter átdefiniálása
    - \-f: programkód fájlból olvasása
- Változók gyengén típusosak. Előre definiált változók:
    - $0 (egész sor), $1,$2, ..., $n (mezők)
    - NF (Numberof Fields, szavak száma), NR (Number of Records, akt. sor száma)
    - FS (Field Separator), RS (Record Separator), OFS (Output Field Separator)
    - FILENAME: aktuális fájl neve (STDIN-re "-")
    - Asszociatív tömbök: tömb[kulcs]

---

# AWK: egy teljes programozási nyelv

- Alapvetően egy sor egy rekord, egy mező egy szó, [de el lehet térni](http://systembash.com/content/one-line-batch-rename-files-using-csv-input-file-and-awk/)
- /regkif/ pl.: /a+/
- *BEGIN { parancsok }*: feldolgozás előtt
- *END { parancsok }*: feldolgozás után
- *print*, *printf*: az előbbi kiírja az utána jövő felsorolást vagy összerakja a mezőket a rekordban (amin változtathattunk is!), az utóbbi úgy működik mint C-ben
- C++ -ban látott programkonstrukciók + *for (var in array) statement*
- C++ -ban látott aritmetikai, logikai műveletek + *$1 ~/k$/* (Mintaillesztés)
- Néhány példa ([bővebb információ, példák](http://www.grymoire.com/Unix/Awk.html)):

        !bash
        awk '{ print $1 }'
        awk '{ print NR, $1 }'
        awk '{ print NR * $1 }' - aritmetika
        awk 'BEGIN {
            p = "fájl.txt";
            while((getline < p)>0) { # Fájl megnyitása, soronkénti olvasása
            print $0
            }
            close(p);
            }'

---

# Próbáljuk ki a parancsokat!

1. Szimuláljuk AWK-val a *wc -l* parancsot!
1. Szimuláljuk AWK-val a *grep* parancsot!
1. Szimuláljuk AWK-val a *cat* parancsot!
1. Írjunk számolós ciklust 1-10 ig!
1. Keressük meg az r betűvel kezdődő felhasználókat a rendszerben!
1. Vegyük csak azokat közűlük, akiknek az UID-je nagyobb mint 1000!
1. Az egészet csináljuk úgy, hogy mindent a BEGIN blokkba írunk!
1. Írassuk ki az /etc/passwd-t fejléccel és lábléccel szóközökkel elválasztva a mezőket!
1. Nehéz: Írjunk egy egyszerű lexikális elemzőt AWK-ban!

---

# Néhány okos fogás

- CD lemezkép készítés: *dd if=/dev/cdrom of=file.iso*
- CD írás parancssorból: *cdrecord*, ISO készítés fájlból: *mkisofs*
- ssh parancs szűrőként is viselkedhet!
    - Példa: *ssh szerver -c "cat alma.txt" > alma_helyi.txt*
    - Példa: *cat alma.txt | ssh szerver -c "tar - -cz alma.tgz"*
- Kombinálhatók:
    - Letöltött ISO-t egyből kiírni: *curl www.server.com/image.iso | cdrecord*
    - Fájlokat közvetlenül lemezre írni: *mkisofs fájlok | cdrecord*
    - Fájlokat kiírni a távoli gépen lévő CD íróval: *mkisofs fájlok | ssh szerver -c "cdrecord"*
- *watch*: beállított időnként lefuttatja az adott parancsot és mutatja a kimenetét (alapesetben 2 másodpercenként)
    - Például a szerkesztett fájl folyamatos tesztelésére használható

---

# Web és a parancssor

- Konzolos felületű, szöveg alapú böngészők: *lynx*, *links*, *w3m*
- Oldal/fájl letöltés, webes interakció: *curl*, *wget*, [stb.](http://www.mynitor.com/2010/09/30/command-line-alternatives-to-wget-and-so-much-better/)
- [Külső IP cím kiderítése:](http://systembash.com/content/one-liner-to-get-external-ip-address/) *curl icanhazip.com*
- [Google bejelentkezés](http://wiki.shellium.org/w/Login_to_google_by_script)

# Egyéb

- [Minden tömörítést kicsomagoló script](http://wiki.shellium.org/w/Trick:_The_Simplest_Program_to_Extract_Archives)
- [Néhány szó a vicces nevű könyvtárakról és fájlokról](http://wiki.shellium.org/w/Changing_Directories)
- [Bash szövegszerkesztési billentyűkombinációk](http://wiki.shellium.org/w/Trick:_Change_the_command_line_editing_interface_in_bash)
- [Shell-fu](http://www.shell-fu.org/) és [Commandline-fu](http://www.commandlinefu.com/)
- [Példák](http://www.examplenow.com/)
- [Lokalizáció](http://tldp.org/LDP/abs/html/localization.html) [és a bajok amik belőle származnak](http://www.gnu.org/software/gettext/manual/html_node/bash.html)

# [Minden](http://mywiki.wooledge.org/BashSheet) [lexikális](http://wiki.shellium.org/w/Index:MAN) [és](http://wiki.shellium.org/w/Learning_the_shell) [kevésbé](https://help.ubuntu.com/community/UsingTheTerminal) [lexikális](http://wiki.bash-hackers.org/scripting/posparams) [információ](http://freeengineer.org/learnUNIXin10minutes.html) [ami](http://ryanstutorials.net/linuxtutorial/) [elhangzot](http://kingcomputerservices.com/unixtuto.htm) [már](http://mywiki.wooledge.org/) [korábban](http://www.shelldorado.com/)
