Feladatok
-----------

1. Képzeld bele magad a szituációba! Te mit írnál be? (több megoldás is elfogadott):

   ![Tar](http://imgs.xkcd.com/comics/tar.png)

    Megoldás(reg.kif formában):

        tar -[cx]v[zjJ]?f valami.(tar|tar.bz2|tar.gz|tar.xz|tbz2|tgz|txz) fájlok

2. A Linux egy multiuser, multitask operációs rendszer. Hogyan futtatnál két parancsot az alábbi feltételek együttes teljesülésével:
  - Egy gépen, egy oprendszeren belül, egyidejűleg
  - Két normál (nem root) felhasználó nevében
  - A gyakorlaton tanultak felhasználásával
  - Bónusz (függetlenül az előzőektől): Az egyiket alacsony a másikat magas prioritással

    Megoldás (vázlatosan, teljesség igénye nélkül. Részletek a diákban):
        - Kozolon belépünk (Ctrl+Alt+Fn)
        - Terminál multiplexer: *screen*/*byobu*
        - ssh-val belépünk két példányban
        - Ütemezett feladatok: *cron*, *at*, *anacron*
        - Háttérbe küldjük a folyamatot majd felhasználót váltunk:

                ./parancs.sh & ; su valakimas; ./parancs2.sh
        - Bónusz: *nice -n [-20-20] parancs* vagy *renice* hasonlóan

3. Hol keresnéd (könyvtár/fájl) a fájlrendszerben az alábbi információkat:
  1. Rendszernaplók
  1. Felhasználók adatai
  1. Futtatható állományok
  1. C könyvtár fejállományok (*header*), amiket *include*-olni akarunk a programba
  1. Indításkor felcsatolt kötetek
  1. Rendszerben elérhető merevlemezek nevei

  Megoldás:
    1. /var/log
    1. /etc/passwd
    1. /bin, /usr/bin, /sbin
    1. /usr/src (kernel), /usr/include (egyéb)
    1. /etc/fstab
    1. /dev/sd*

4. Milyen paranccsal keresnéd meg, hogy
  1. Milyen webszerver programok érhetőek el a telepíthető csomagok között?
  2. Milyen webszerver programok vannak telepítve az adott gépen?

  Megoldás (nem csak *apache* van a világon! Lásd a diákat!):
    1. *apt-cache search httpd*
    1. *dpkg -l | grep "httpd"*

5. Mit ír ki az alábbi parancs?

        rm *nemlétező_fájl* && echo "Törölve"; echo $?

    Megoldás: "nem törölhető... [újsor] 1" vagy "Törölve [újsor] 0"

6. Mi lesz az egyik, EGYIK, Másik, másik fájlok tartalma a parancsok végrehajtása után? (A fájlok kezdetben nem léteznek!)

        echo egyik > EGYIK; cp egyik Másik
        echo másik > egyik; cat Másik >> Egyik
        chmod 055 másik; echo EGYIK >> másik; cat MáSiK > EgyIk

 Megoldás:
       cat egyik
       másik
       cat EGYIK
       egyik
       cat Másik
       másik
       cat másik
       Engedély megtagadva
       chmod +r másik
       cat másik
       EGYIK

7. Milyen paranccsal keresnéd meg az rendszerben elérhető felhasználók között
    - a "B" betűvel kezdődőket?
    - a "student" csoportba tartozókat?

  Megoldás:
   - grep "^B" /etc/passwd
   - grep ":student:" /etc/passwd

8. Sorolj fel néhány *Signal*-t, amit *POSIX* rendszereken lehet küldeni!

  Megoldás (lásd a diákban): SIGKILL, SIGTERM, SIGHUP, SIGCONT, SIGSTOP

9. Nevezz meg egy parancssoros editort és néhány műveletét? Hogy hajtanád végre őket?

  Megoldás:
   - vi , vim, mcedit, nano, joe, emacs, stb.
   - Volt róluk szó: Mentés, megnyitás, keresés, stb.
   - Itt a cél az volt, hogy legalább egy editort ismerjen mindenki...

Operációs rendszerek I. első ZH *Megoldások*
-----------

- A rendelkezésre álló idő 30 perc.
- Feladatok megoldásához elektronikus eszköz és puska nem használható!
- A feladatokat a legegyszerűbben kell értelmezni! (A tanultak alapján.)
- Több helyes megoldás is létezik, többet is elfogadok.
- Különböző minőségű megoldások különböző pontozást érnek.
- A cél a problémához való hozzáállás vizsgálata, nem hogy papíron hiba mentesen programozzunk, vagy minden lexikális információt fejből tudjunk!

# Feladatok a túloldalon!
