Oprendszerek I. második ZH
=========

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
## A túloldalon folytatódik!
3. Mit ír ki az alábbi script?
        echo {1..5}
        echo {c..g}
        echo {06..10}
        echo {1..10..2}
4. Írj scriptet, hogy egy könyvtár összes fájljára lefusson a *command* parancs, úgy hogy
    1. az adott fájl a program első paramétere legyen!
    2. az első paramétere legyen és a második paraméter fixen "--force"!
    3. a parancs a fájlt az STDIN-járól olvassa be!
5. Hogy néznéd meg, hogy mennyit foglal egy könyvtár a teljes tartalmával?
    - Bónusz: Saját scripttel?
6. Idézet a *man grep*-ből alább. Milyen regkif.-fel válogatják szét a leveleket?

        Email bug reports to bug-gnu-utils@gnu.org. Be sure
        to include the word "grep" somewhere in the "Subject:" field.

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

# Jó munkát!
