 Oprendszerek I. második ZH Megoldás
-----------

- A rendelkezésre álló idő 30 perc.
- Feladatok megoldásához elektronikus eszköz és puska nem használható!
- A feladatokat a legegyszerűbben kell értelmezni! (A tanultak alapján.)
- Több helyes megoldás is létezik, többet is elfogadok.
- Különböző minőségű megoldások különböző pontozást érnek.
- A cél a problémához való hozzáállás vizsgálata, nem hogy papíron hiba mentesen programozzunk, vagy minden lexikális információt fejből tudjunk!

Feladatok
-----------

1. Toplista készítő program
    - Bemenet(STDIN): "elemek" szóközzel és néha újsorral elválasztva
    - Kimenet(STDOUT): TOP 10 leggyakoribb elem (az azonosan gyakori elemek fordított ábécé sorrend szerint legyenek rendezve!)
    - Példa (bemenet):
           Az alma nem esett messze a fájától !
           A körte viszont a fától messze esett .
    - Példa (kimenet):
            2 messze
            2 esett
            2 a
            1 viszont
            1 nem
            1 körte
            ...
  Megoldás: *tr " " "\n" | sort | uniq -c | sort -r*
   - Sorok tördelése: *tr " " "\n"* vagy *sed 's/ /\n/g'*
   - Rendezés, számolás, rendezés: *sort | uniq -c | sort -r*

2. Az 1. feladat kiegészítése:
    1. Külön gyűjtsük a nagybetűvel és külön a kisbetűvel kezdődő elemeket! (Eredmény: két toplista)
    2. Az elemek maguk is több részből állnak, ezek a részek # karakterrel vannak elválasztva. A **második** rész alapján történjen a számolás (csak az szerepeljen a toplistában)!
        Példa:
           Az#az#[DET] alma#alma#[FN][NOM] nem#nem#[HAT] esett#esik#[IGE][MULT]
           a#a#[DET] fájától#fa#[FN][GEN][EX]
    3. Az összes szó legyen nagybetűsítve és úgy legyen számolva!
    4. Kapcsolókkal lehessen változtatni a program viselkedésén!
        Példa:
            prog -1 -> 2/1 feladat
            prog -2 -> 2/2 feladat
            prog -3 -> 2/3 feladat
            prog -> 1. feladat
    5. Függvények használatával készüljön a program!

  Megoldás:
    1. Több megoldás lehetséges:
     - Vagy fájlba mentjük az inputot és úgy dolgozzuk fel:

             cat - > fájl.txt vagy tr " " "\n" > fájl.txt
             cat fájl.txt | grep "^[:upper:]" | sort | uniq -c | sort -r
             cat fájl.txt | grep "^[:lower:]" | sort | uniq -c | sort -r

     - Vagy kettészedjük az inputot:

             tr " " "\n" | tee >(grep "^[:upper:]" | sort | uniq -c | sort -r) \
                               >(grep "^[:lower:]" | sort | uniq -c | sort -r)

    1. Az előzőek felhasználásával, az eltérés:

           tr " " "\n" | cut -d"#" -f2 | sort | uniq -c | sort -
           # vagy
           tr " " "\n" | sed 's/^[^#]*#\([^#]*\)#[^#]*$/\1/g' | sort | uniq -c | sort -

    1. Az előzőek felhasználásával, az eltérés:

           tr " " "\n" | tr '[:lower:]' '[:upper:]' | sort | uniq -c | sort -

    1. Az eddigi megdoldásokat fogjuk meghívni (sok if-et is lehet használni, kevesebb pontért):

           if [ $# -eq 1 ]; then
             case $1 in
              -1) ... ;;
              -2) ... ;;
              -3) ... ;;
               *) ... ;; # Default: például az első
             esac
            else
             ... # Első, paramétere nélküli meghívás
            fi

    1. Az eddigi megdoldásokat fogjuk meghívni (az esetszltválasztásba beilleszthető, csak az elsőt írom le):

           function elso() {
            # itt az STDIN ugyanúgy jelen van
            tr " " "\n" | sort | uniq -c | sort -r
           }

3. Mit ír ki az alábbi script?
        echo {1..5}
        echo {c..g}
        echo {06..10}
        echo {1..10..2}

  Megoldás:

       1 2 3 4 5
       c d e f g
       06 07 08 09 10
       1 3 5 7 9

4. Írj scriptet, hogy egy könyvtár összes fájljára lefusson a *command* parancs, úgy hogy
    1. az adott fájl a program első paramétere legyen!
    2. az első paramétere legyen és a második paraméter fixen "--force"!
    3. a parancs a fájlt az STDIN-járól olvassa be!

  Megoldás (Useless use of *ls \**):
    1. command \*
    1. command \* --force
    1. for f in *; do cat $f | command; done # Itt nem úszható meg a for ciklus

5. Hogy néznéd meg, hogy mennyit foglal egy könyvtár a teljes tartalmával?
    - Bónusz: Saját scripttel?

  Megoldás:

       du -c
       # Bónusz: Rekurzív részletes listázás, többszörös szóközök leszedése
       # Fájlok kiválogatása (hogy csak azpk szerepeljenek)
       # Kivágjuk a méretet és összegezzük!
       ls -Rl . | sed -r 's/ +/ /g' | grep "^-" | cut -d" " -f5 | numsum

6. Idézet a *man grep*-ből alább. Milyen regkif.-fel válogatják szét a leveleket?

        Email bug reports to bug-gnu-utils@gnu.org. Be sure
        to include the word "grep" somewhere in the "Subject:" field.

  Megoldás: A tárgyra greppelnek: a "grep" regkiffel

7. Bónusz: Implementálj minél több halmazműveletet az alábbi reprezentáció szerint:
    - Minden halmaz egy fájl. Minden elem egy sor egy fájlban.
    - Műveletek:
            Elem tartalmazása
            Egyenlőség (két halmaz esetén)
            Elemszáma a halmaznak
            Részhalmaz tulajdonság
            Unió
            Metszet
            Komplementer (egy bizonyos halmaz Ábécé felett)
            Szimmetrikus differencia
            Hatványhalmaz (minden részhalmaz halmaza)
            Keresztszorzat (minden elem minden elemmel párban)
            Két halmaz diszjunktságának tesztelése
            Üres halmaz tulajdonság tesztelése
            Minimális elem
            Maximális elem

  Megoldás: Innen vettem az ötletet (Típushiba volt, hogy a halmaz elemei egyediek kell, hogy legyenek! = sort -u a végén!): <http://www.catonmat.net/blog/set-operations-in-unix-shell/>

