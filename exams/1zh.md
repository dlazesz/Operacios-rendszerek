Feladatok
-----------

1. Képzeld bele magad a szituációba! Te mit írnál be? (több megoldás is elfogadott):

   ![Tar](http://imgs.xkcd.com/comics/tar.png)

2. A Linux egy multiuser, multitask operációs rendszer. Hogyan futtatnál két parancsot az alábbi feltételek együttes teljesülésével:
  - Egy gépen, egy oprendszeren belül, egyidejűleg
  - Két normál (nem root) felhasználó nevében
  - A gyakorlaton tanultak felhasználásával
  - Bónusz (függetlenül az előzőektől): Az egyiket alacsony a másikat magas prioritással

3. Hol keresnéd (könyvtár/fájl) a fájlrendszerben az alábbi információkat:
  1. Rendszernaplók
  1. Felhasználók adatai
  1. Futtatható állományok
  1. C könyvtár fejállományok (*header*), amiket *include*-olni akarunk a programba
  1. Indításkor felcsatolt kötetek
  1. Rendszerben elérhető merevlemezek nevei

4. Milyen paranccsal keresnéd meg, hogy
  1. Milyen webszerver programok érhetőek el a telepíthető csomagok között?
  2. Milyen webszerver programok vannak telepítve az adott gépen?

5. Mit ír ki az alábbi parancs?

        rm *nemlétező_fájl* && echo "Törölve"; echo $?

6. Mi lesz az egyik, EGYIK, Másik, másik fájlok tartalma a parancsok végrehajtása után? (A fájlok kezdetben nem léteznek!)

        echo egyik > EGYIK; cp egyik Másik
        echo másik > egyik; cat Másik >> Egyik
        chmod 055 másik; echo EGYIK >> másik; cat MáSiK > EgyIk

7. Milyen paranccsal keresnéd meg az rendszerben elérhető felhasználók között
    - a "B" betűvel kezdődőket?
    - a "student" csoportba tartozókat?

8. Sorolj fel néhány *Signal*-t, amit *POSIX* rendszereken lehet küldeni!
9. Nevezz meg egy parancssoros editort és néhány műveletét? Hogy hajtanád végre őket?

Operációs rendszerek I. első ZH
=========

- A rendelkezésre álló idő 30 perc.
- Feladatok megoldásához elektronikus eszköz és puska nem használható!
- A feladatokat a legegyszerűbben kell értelmezni! (A tanultak alapján.)
- Több helyes megoldás is létezik, többet is elfogadok.
- Különböző minőségű megoldások különböző pontozást érnek.
- A cél a problémához való hozzáállás vizsgálata, nem hogy papíron hiba mentesen programozzunk, vagy minden lexikális információt fejből tudjunk!

# Feladatok a túloldalon!
