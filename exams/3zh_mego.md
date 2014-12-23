Oprendszerek I. harmadik ZH
=========

- A rendelkezésre álló idő 30 perc.
- Feladatok megoldásához elektronikus eszköz és puska nem használható!
- A feladatokat a legegyszerűbben kell értelmezni! (A tanultak alapján.)
- Karikázd be (húzd alá, jelöld) egyértelműen (!) a jónak vélt választ!
- Egy feladat tartalmazhat több jó választ (ilyenkor mindegyiket jelölni kell), a rossz válaszok jelölése pontlevonással jár!

Feladatok
-----------

1. Elégséges egy felhasználó kitiltásához az, hogy a felhasználó shelljét átírjuk valamire, ami azonnal kilép, ahelyett hogy ténylegesen kitiltanánk?
    - a) Igen, például */bin/true*-ra.
    - b) Igen, valami nemlétező vagy nem futtatható fájlra.
    - c) Nem, mert így is hozzáfér a fájlrendszerhez privát kulcsos azonosítással.
    - d) Nem, mert így is tud portot továbbítani privát kulccsal bejelentkezve.

  Megoldás: (d) A diákban szerepel, hogy a */bin/true* nem elég, mert shell nélkül is bejut az ember kulcsos azonosítással ssh-n, ami minden hasonló trükkre igaz.

1. Ha elfelejtettük a *root* felhasználó jelszavát akkor...
    - a) Még mindig ott van a *sudo* parancs.
    - b) Várni kell egy biztonsági hibára és annak segítségével feltörni a rendszert.
    - c) Fizikai hozzáférés esetén át lehet írni az *init*-et és megváltoztatni a *root* jelszót.
    - d) Újra kell telepíteni a rendszert, nem tudjuk megúszni egyszerűbben.

  Megoldás: (c) A diákban szerepel és órán mutattam, az *init*-en keresztüli belépést. A többi válasz komolytalan és ezt gyakorlaton is mondtam.

1. Az *init* PID-je...
    - a) Mindig 1.
    - b) Biztonsági megfontolásból random választódik minden rendszerindításkor.
    - c) Biztonsági megfontolásból a rendszer futása közben többször megváltozik.
    - d) Telepítésenként eltérő állandó szám. (random generálódik telepítéskor)

  Megoldás: (a) Többször visszatérő téma volt az *init*, gyakorlaton kifejtettem bőven.

1. Az *init* folyamat a rendszer indítása után...
    - a) Átadja a vezérlést és leáll.
    - b) Fut a rendszer leállításáig.
    - c) Leáll, de a rendszer leállításakor újra meghívódik a leállítási paraméterekkel.
    - d) Leáll, de időnként elindul és ellenőrzi, hogy a démonok rendesen futnak-e.

  Megoldás: (b) Az *init* lényege, hogy ő az összes folyamat szülője, ha meghal, a rendszer meghal.

1. A *chroot* rendszerhívás eredeti funkciója szerint arra való, hogy...
    - a) Virtualizáljunk rendszereket a segítségével.
    - b) Börtönbe zárja (a FreeBSD *jail* hívásához hasonlóan) azokat a programokat, amik túl sok erőforrást fogyasztanak.
    - c) Tiszta, független futtatókörnyezetet hozzunk létre vele.
    - d) Szeparáljuk azokat a programokat, amik amúgy "összevesznének" az erőforrásokon.

  Megoldás: (c) A virtualizálás, mint fogalom kb a *Java VM* feltalálásval egyidős. Addig nem is álmodoztak róla.

1. A *chroot* program a mai környezetekben...
    - a) Egyáltalán nincs használva, mert nem biztonságos.
    - b) Csak végszükség esetén használják, amikor már minden mindegy. (Disaster Recovery)
    - c) Csak olyan feladatokra, használják, ahol a biztonság nem elsődleges.
    - d) Feladatát átvette mára a virtualizáció, így szükségtelenné vált. Használata marginális.

  Megoldás: (c) És a mai környezetekben sem elsődlegesen virtualizálásra, hanem szeparációra.

1. A *chroot* lehetővé teszi...
    - a) Az összes erőforrás szeparációját, alacsony erőforrás költségen (overhead).
    - b) A fájlrendszer különböző részeinek szeparációját.
    - c) A memória különböző részeinek szeparációját.
    - d) A processzor kapacitásainak finomhangolt elosztását a processek között.

  Megoldás: (b) A fájlrendszert szeparálja csak. A *dev*, *sys* és *proc* fájlrendszerre szüksége van és ez biztonsági kockázatot jelent. Gyakorlaton bemutattam, ahogy a *chroot*-ból lövöm ki a *chroot*-on kívüli terminált.

1. A *chroot* egy mappába telepített...
    - a) Egyedüli programot képes csak futtatni.
    - b) Egész operációs rendszert képes futtatni a másikon belül párhuzamosan.
    - c) Egész operációs rendszert képes futtatni, ilyenkor a külső rendszer nem tud mást csinálni.
    - d) Processzor architektúrától függetlenül bármilyen operációs rendszert képes futtatni. (Ezért is máig életképes virtualizációs megoldás.)

  Megoldás: (b) Gyakorlaton telepítettünk is ketőtt. (*Ubuntut*, *Arch*-ot)

1. A *debootstrap* program...
    - a) Egy mappába képes egy egész operációs rendszert telepíteni.
    - b) Használható fizikai vason futó rendszer telepítésekor is.
    - c) Bármilyen *Linux* disztribúció telepítésére képes.
    - d) Bármilyen architektúrájú operációs rendszert tud telepíteni a fizikai paraméterektől függetlenül.

  Megoldás:
      - (a) Minden disztribúciónak megvan a saját hasonló eszköze, mivel a telepítő CD is ezt csinálja a háttérben
      - (b) Arch-linuxot hasonló módon telepítettünk. (Azt a programot *pacbootstrap*-nek hívták.)
      - (d) Volt róla szó, hogy csak kicsomagolja a fájlokat és esetleg futat néhány scriptet. Binárist nem futtat, így bármilyen architektúrát lehet vele telepíteni. Használni, már nehezebb...

1. A *debootstrap* program a telepítés után...
    - a) Indítható rendszert eredményez, nincs szükség további konfigurálásra.
    - b) Automatikusan felismeri azokat a beállításokat, amiket lehet (földrajzi elhelyezkedés, billentyűzet kiosztás, stb.).
    - c) Jelzi, hogy a gazda rendszert újra kell indítani a továbblépéshez.
    - d) Azonnal elindítja a rendszert és visszaadja a promptját, hogy elvégezhessük a további konfigurációt.

  Megoldás: Nincs helyes megoldás!
      - Szükséges például a hostnév beállítása, felhasználók, jelszavak stb. beállítása
      - Ezt önmagában nem teszi meg, mivel nem a feladata. A begyüjtött/felismert adatokat egy külső telepítő adja át, ha a hivatalos telepítőt használjuk.
      - Nem kell semmit újraindítani a folyamat közben.
      - Nem a feladata visszaadni a promptot, ezért nem teszi. Erre van a *chroot* parancs.

1. A *chroot* programra igazak-e az alábbi állítások?
    - a) GUI programot nem tudunk benne futtatni.
    - b) Rendszerindításkor automatikusan elindulnak a benne levő démonok.
    - c) Csak megfelelő hardvertámogatás jelenlétében működik értékelhető sebességgel.
    - d) Segítségével kikapcsolt állapotban levő rendszerekre is rá lehet csatlakozni kívülről és úgy futtatni programokat bennük.

  Megoldás: (d) A *grub* helyreállítása vagy a root jelszó megváltoztatása *chroot*-on keresztül egy ilyen művelet.

1. Az *ifconfig* parancs...
    - a) Elavult, ezért sem *Arch Linuxon* sem *FreeBSD*-n nem az alaptelepítés része.
    - b) Arra szolgál, hogy a hálózati interfészek állapotát tudjuk lekérdezni és beállítani.
    - c) Helyettesíti az elavult *ip link show* és *netstat -i* parancsokat.
    - d) Segítségével csak lekérdezni tudjuk a hálózati interfészek állapotát, beállítani konfigfájlok szerkesztésével lehet csak őket.

  Megoldás: (b) *Arch Linuxon* elavult, *FreeBSD*-n nem.

1. Az *Arch Linux* telepítése közben a particionálásra...
    - a) Rendelkezésre áll a *Gparted* program.
    - b) Csak a *cfdisk* program használható.
    - c) Több, konzolos program rendelkezésre áll.
    - d) Rendelkezésre álló programok egyikét használnunk kell, ezt a lépést nem lehet kihagyni akkor sem, ha már előzőleg particionálva vannak a lemezek.

  Megoldás: (c) A Gparted-hez GUI felület kellene, helyette van *parted*, *cfdisk*, *fdisk* és mi az egyiket használtuk.

1. Az *Arch Linux* telepítésénél...
    - a) A particionálás és a formázás egy lépésben megoldható.
    - b) Mindenképpen szükségünk van swap partíció létrehozására.
    - c) Be tudjuk állítani a rendszert úgy, hogy csak olvasható gyökér-fájlrendszerrel induljon.
    - d) A rendszer felismeri automatikusan a földrajzi helyünket és megjeleníti az ajánlott beállításokat.

  Megoldás: (c) Ezeket mutattam gyakorlaton. Megfelelő particionálás esetén lehetséges.

1. Az *Arch Linux* telepítése élesen eltér a többi *Linux* telepítésétől abban, hogy...
    - a) A nekünk vélhetően megfelelő beállításokra a nyelv kiválasztása után nem tesz ajánlatot, szemben az *Ubuntu* telepítőjével.
    - b) Nincs meghatározott, csak ajánlott sorrendje a telepítési lépéseknek, így magunkra vagyunk utalva a rendszer testreszabásakor.
    - c) Itt *chroot*-ba kell telepítenünk a rendszert, míg az *Ubuntu* erre egy radikálisan más módot alkalmaz.
    - d) Teljesen más kérdéseket kell megválaszolnunk a telítés során, mint azt az *Ubuntu* telepítésekor tettük.

  Megoldás:
      - (a) Szabadon választhatjuk és szabhatjuk testre a beállításokat. Minimális keretek vannak csak megadba.
      - (b) Ebbe beleértendő a telepítőlépések sorrendje...

1. Az *Arch Linux*-ra igazak-e az alábbi állítások?
    - a) Ellentétben az *Ubuntu* fix időközönkénti kiadásaival, "akkor adják ki, amikor elkészül".
    - b) Mivel gördülő kiadás van, ezért tulajdonképpen nincsenek nagy váltások a rendszerben, ha rendszeresen frissítjük! Ellentétben az *Ubuntu*-val ahol egy kiadás váltás után a nagyobb átállás miatt sok minden elromolhat.
    - c) Csak a legfrissebb verziójú csomagok érhetőek el mindig! Nincs semmilyen lehetőség a csomagok visszafejlesztésére (downgrade).
    - d) Van benne az *Ubuntuhoz* hasonlító "nem hivatalos" bináris csomag telepítő rendszer (PPA).

  Megoldás: (b) Az "akkor adják ki, amikor elkészül" a *Debian* filozófiája. Nem ugyan az, mint a "ha egy csomag elkészül, beleteszik a rendszerbe".

1. Az *Arch Linux* a *FreeBSD*-vel szemben...
    - a) Nem alkalmaz forrás alapú terjesztést, a nem hivatalos csomagok esetén.
    - b) Tartalmaz bináris csomag telepítési lehetőséget.
    - c) Nem saját, házon belül fejlesztett kernelre épül.
    - d) Nem tartalmaz egyszerű csomagkészítő és telepítő eszközöket.

  Megoldás: (c) Az *Arch Linux* a függetlenül fejlesztett, mindenki által használt *Linux kernelt* tartalmazza. Míg *FreeBSD* kernel csak *FreeBSD*-ben és a leszármazottaiban van.

1. A *systemD*...
    - a) Hátrányai közé tartozik, hogy túlnő a feladatain.
    - b) Előnye, hogy kompatibilis a régi *init* rendszerekkel.
    - c) A modern *Linux* disztribúciók mindegyikében már alapértelmezett.
    - d) Vitatott fogadtatása miatt, még egy disztribúció sem használja élesben.

  Megoldás: (a) Nem kompatibilis, túlnő a feladatain, ezért a jelenleg stabil kiadásokban nem szerepel, csak a jövőbeliekben. Az *Arch Linux* használja már régen élesben.

1. A célszoftvert futtató *köztesréteg*...
    - a) Lehet maga az Operációs rendszer, hiszen ez a célja.
    - b) Az operációs rendszer hardverabsztrakciója fölé épülő szoftver például valamilyen virtuális gép.
    - c) Képes operációs rendszer nélkül futni.
    - d) Célja hogy az operációs rendszer hívásain túlnyúló absztrakciót hajtson végre, egyszerűsítve a célszoftver architektúráját. Ezért túlnyúlik az operációs rendszer feladatain. (például böngésző)

  Megoldás:
      - (b) Az Operációs rendszer célja nem az, hogy köztes réteg legyen. (Különben kompatibilis lenne minden oprendszer.)
      - (d) A Operációs rendzer célja például a hardvert absztrahálni a használhatóságig. Onnan jön a köztesréteg.

1. A *FreeBSD*...
    - a) Nem eredeti Unix kódokra épül, szemben a *Linuxszal*.
    - b) Licence szigorúbb mint a *Linuxé*, ezért nem terjedt el jobban.
    - c) Nem tartalmaz egy csomó új funkciót, ami a *Linuxban* régóta alap, de ettől még kicsi és gyors rendszer.
    - d) Nincs jól dokumentálva, a gyors változások nem követhetők benne az átlag felhasználó számára.

  Megoldás: (c) Hagyomány követő rendszer. Nem szeretnek "kísérletezni", több "azonos funkciójú programot az alaprendszerben látni"...

1. A *FreeBSD* szemben a *Linux* disztribúciók filozófiájával...
    - a) Nem helyez hangsúlyt, több azonos feladatot ellátó alapszolgáltatás a rendszerben tartására, így biztosítva a különféle disztribúciók készítését.
    - b) A hagyományos Unix utat követi, ami kimondja, hogy kifejezett előny, ha több eszköz ugyan azt a feladatot el tudja látni.
    - c) Már csak a licence okán is, megtűri a kernelben a nem nyílt forrású összetevőket.
    - d) Erősen elválasztja a kernelt, a *Userspace*-től.

  Megoldás: SZEMBEN!
      - (a) A *FreeBSD* erősen centrális modellre épít, a *Linux* erősen elosztott modellre.
      - (c) A *FreeBSD* próbálja az alaprendszerből (nem ekvivalens a kernellel) száműzni (a Ports fába), ami csak nem tetszik nekik, akár licence alapon is. A *Linuxban* hasonló törekvések vannak.

1. A *FreeBSD* alaptelepítésben...
    - a) Nem található fordítóprogram.
    - b) Alapból nincs semmilyen csomagkezelési lehetőség.
    - c) Vannak a GNU projekt által implementált eszközök.
    - d) A konzol Unicode támogatása és a lokalizáció még nem megoldott.

  Megoldás:
      - (c) Vannak GNU Licencű eszközök, bár csökken a számuk. Például a fordítóprogram helyettesítésre került.
      - (d) Gyakorlaton mondtam, hogy a következő verziók valamelyikében érkezhet a támogatás.

1. A *FreeBSD*-ben...
    - a) Van X11, hogy egyből lehessen GUI-s programokat futtatni.
    - b) A GUI-s programok futtatása rendszerszinten még nem megoldott.
    - c) Van *Linux* kompatibilitási réteg, amivel *Linux* binárisokat lehet módosítás nélkül futtatni.
    - d) A legtöbb frissítés a *CVS* verziókezelőn keresztül történik.

  Megoldás:
      - (a) Van X11, Wayland és Mir nincs.
      - (c) Ez az egyik érdekes feature-re a *FreeBSD*-nek. *SVN*-nel dolgoznak. *CVS* az *OpenBSD*-ben van.

1. A *FreeBSD*-re igazak-e az alábbi állítások?
    - a) A *FreeBSD*-ben lehet könyvtárat *cat*-olni.
    - b) A *FreeBSD*-ben az eszközök nevei megegyeznek a *Linuxos* megfelelőikkel, mivel ezt a POSIX szabvány előírja.
    - c) A Ports fát manuálisan kell letöltenünk és frissen tartanunk. Nincs semmilyen eszköz, ami segítené a munkánkat.
    - d) A Ports fa előre lefordított csomagokat tartalmaz.

  Megoldás: (a) Ki is próbáltuk gyakorlaton. Még ha semmi értelme sincs. A Ports fa egy kiválóan támogatott, forrásalapú terjesztési platform.

1. Ha a *FreeBSD*-vel kapcsolatban segítségre szorulunk...
    - a) Nem áll rendelkezésre a *man*, mert az egy újabb *Linuxos* találmány, amit a *FreeBSD* még nem integrált.
    - b) Rendelkezésre áll a *FreeBSD Handbook*, ahol minden információt megtalálunk.
    - c) A programok többségének, nincs meg a szokásos *-h* vagy *--help* kapcsolója, mert akit érdekel, hogy hogy működik a program megnézi úgyis a forrását.
    - d) Az egyes Port-ok mellett a rövid működésre vonatkozó leírás megtalálható, ezért nem kell telepíteni őket, hogy megtudjuk mit csinálnak.

  Megoldás:
      - (b) A *man* mellett (ami 100 éves Unixos találmány) bőven rendelkezésre áll minden információ a központosított szerkesztésű *Handbook*-ból.
      - (d) Minden normális csomagkezelő része a csomag leírása, illetve a programokban POSIX szabvány által előírt *-h* vagy *--help* kapcsoló.

## Bónusz feladatok:

1. A modern fájlrendszerek...
    - a) Támogatják a naplózást ezért nem is kell őket továbbfejleszteni.
    - b) Az új szemlélet szerint támogatják a dinamikus átméretezést, a logikai lemezkezelést és a RAID szinteket (ami eddig a kernel feladata volt).
    - c) Mint a *BTRFS* és a *ZFS* nem támogatják még a pillanatfelvételek készítését, de folyik a funkció fejlesztése.
    - d) Mint a *BTRFS* és a *ZFS* azért nem terjedtek el, mert még a fejlesztőik sem tartják őket elég stabilnak.

  Megoldás: (b) A legtöbb operációs rendszer kernele nem tekinti közvetlen feladatának a logikai lemezkezelés kérdését, ezért fájlrendszer szintre van utalva.

1. A *Linux* kernelre igazak-e az alábbi állítások?
    - a) A rendszer elindulása után a memóriában marad ezért, nem lehet futás közben frissíteni (patchelni).
    - b) Fájlokra hasonlító interfészeket biztosít a vele való kommunikációhoz.
    - c) Nem képes elrejteni a különböző hardverek különbségeit, amiket ezek után a felhasználóknak kell kezelniük.
    - d) Kevesebb drivert tartalmaz, mint a FreeBSD, ennek ellenére mégis népszerűbb.

  Megoldás: (b) Mindegyikről volt szó a gyakorlatokon.

1. A *Bash*...
    - a) A legfejlettebb shell, ezért megtalálható a főbb BSD rendszerek alaptelepítésében is.
    - b) Egy interaktív shell, ezért lassabb nem interaktív használatkor mint az erre tervezett *Dash*.
    - c) Kizárólag a POSIX szabvány ajánlásait implementálja, hogy kompatibilis maradjon a régi shellekkel.
    - d) Segítségével célszerű megvalósítani minden algoritmust, mert így átláthatóbb lesz a kód, mintha külső parancsokat hívogatnánk.

  Megoldás: (b) Volt szó a Bash és a Dash különbségéről, hogy rendszerindításkor nem kell interaktívnak lenni, de jó ha gyorsabb a shell.

1. Az alábbi állítások közül melyik **hamis**?
    - a) Az /usr könyvtár semmi olyat nem tartalmaz, aminek futás közben változnia kéne.
    - b) A /var fájlrendszert célszerű *ramdisk*-re tenni, mert így gyorsabban írható olvasható a tartalma.
    - c) A /tmp könyvtárban elhelyezett futtatható fájl biztonsági kockázatot jelent.
    - d) A /dev könyvtárban van olyan fájl vagy könyvtár, ami alapesetben az átlag felhasználó számára írható.

  Megoldás: (b) A /var fájlrendszer lassan változó adatokat tartalmaz, ellenétben a /tmp-vel, így újraindításkor meg kell, hogy maradjon a tartalma.

1. A *Linux* rendszerben számtalan lehetőség van arra, hogy...
    - a) Két átlag felhasználó párhuzamosan futtasson két programot.
    - b) Két teljes jogú rendszergazda (*root*) legyen.
    - c) A rendszergazdát (*root*) megakadályozzuk, hogy bármit megtegyen.
    - d) Testre szabjuk a rendszert, szinte bármilyen eszközön való futtatás céljából.

  Megoldás:
      - (a) ZH kérdés volt. Viszont csak egy *root* (UID 0 és GUID 0) felhasználó lehet. Ezért van a *sudo*, ami egyedüli eszköz.
      - (d) A DoD (Amerikai Védelmi Minisztérium) is kiemelt kockázatnak tartja, hogy a *root* felhasználó bármit megtehet.
