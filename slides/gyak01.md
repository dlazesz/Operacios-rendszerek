
# Operációs rendszerek I.<br/> 1. gyakorlat

---

# Ubuntu telepítés virtuális gépre<br/> Ezúttal Live CD-n keresztül...

---

# Amíg települ...

---

# Fontosabb ismérvek: Csomagkezelő

- Újabban divatos néven "Software Market"
    - Több csomagkezelő létezik, eltérő filozófiával (megkerülhetőek, de nem célszerű)
- Főbb feladatai:
    - Csomagok hitelesítése GPG kulccsal
    - Frissítések biztosítása, könnyű telepítése
    - Függőségi kapcsolatok kezelése
    - Forrás és bináris csomagok kezelése
    - Licence trükkök kijátszása végett

---

# Linux és a valóság

- Az igazi hardver támogatása egyre jobb
    - Régen internetről kellett hálókártya drivert tölteni, hogy működjön
- Azért voltak és vannak problémák
    - ACPI: [Régen egyszerűbb volt Windows-nak látszani](http://www.linuxtopia.org/online_books/linux_kernel/kernel_configuration/re78.html), de [megmagyarázták miért](http://www.osnews.com/comments/17689)...
    - [Az ACPI örökzöld téma](https://lkml.org/lkml/2014/3/11/618)
    - Flash: [Pepper Plugin API](https://code.google.com/p/ppapi/) vs. [NPAPI](http://en.wikipedia.org/wiki/NPAPI) [Mára megoldott(?)...](http://itsfoss.com/fix-flash-player-issue-chromium-in-ubuntu-14-04/) [vagy mégsem?](http://xkcd.com/619/)
- Több minden van alapból mind Windowson (Office, médialejátszó, böngészó, tömörítő, stb.)
- Ellentétben a Microsofttal, itt a szolgálatatások funkciójuk alapján vannak elnevezve (httpd, named, sshd, stb.)
- Minden funkciót ellátó programból több független implementáció elérhető
    - Más szempontok szerint fejlesztik őket
    - Szem előtt tartják az igények és a felhasználók sokféleségét
    - Nincs "legjobb" változat

---

# Különbségek a Windows-hoz képest

- A fájlnevek majdnem bármilyen karaktert tartalmazhatnak
- A kiterjesztések gyakorlatilag nem számítanak, mert a fájltípusok detektálhatóak
    - *file* parancs
- A szöveges fájlok és rendszer "stringjeinek" karakterkódolása UTF-8, nem windows-1250
- A szöveges fájlok sorvégei csak soremelésből állnak (\\n), nincs kocsi vissza (\\r)
- Kis és nagybetűk nem összecserélhetők!!!
- A parancssor használható, sőt... ;)
- Majdnem 100% kompatibilitás a Windows-zal, persze kicsit lemaradva...
    - Active Directory (LDAP)
    - Nyomtató és fájlmegosztás (Samba)
    - Bináris fájl kompatibilitás (Wine)

---

# A fájlrendszer

- A háttértárolón az adatok binárisan vannak tárolva
- Ebből értelmezhető adatra lenne szükségünk
- Sőt az adatbiztonság sem utolsó
    - Hardverhibák kiküszöbölése
    - Titkosítás
- Sok fájlrendszer van. A feladatuk a tárolás.
    - FAT(16|32), exFat, NTFS
    - Ext[2-4], reiserFS
    - UFS, ZFS, Btrfs és a többiek
- A különféle fájlrendszereket egységesen kell kezelni
    - Hogy jelenjenek meg a rendszerben?
    - Hogy lehet közöttük adatot mozgatni?

---

# A Unix fájlrendszer főbb jellemzői

- A gyökér(root) könyvtárból nyílik minden. Jelölése: "/"
- EGYSÉGES, fa(!) hierarchiát épít
- Az összes partíció erre a fára csatolódik fel (mount)
    - Innentől egységesen kezelődik
    - Az operációs rendszer elrejti a különbségeket (eszköz fajtája, tárolási logika)
    - A rendszermagon (kernel) belül a megfelelő alrendszerek végzik a tényleges munkát (de ez kívülről nem látszik)
- Virtuális fájlrendszer, mindennek megvan a helye benne
    - Minden(!) fájl: a fájlok, a hálózat(/dev/eth0), COM portok (/dev/SttyX), stb..
    - Vannak "virtuális partíciók", amik megkönnyítik a kommunikációt az operációs rendszerrel (/proc, /sys, /dev)
    - Hardverváltozáskor az eszközleíró fájlok dinamikusan frissülnek (udev)
    - Nagyjából egy felépítés minden "\*Nix" rendszeren, igyekeznek szabványosítani
    - Később: Mini fájlrendszerek is létrehozhatóak egy alkönyvtáron belül (chroot)

---

# A fizikaitól a virtuális fájlrendszerig

Partíció, vagy lemez

- Szuperblokk
- i-node
- Adatblokkok
- Illetve még mások is, de azok user-space-ből nem elérhetőek.

Szuperblokk: Egy-egy partíció azonosítására szolgál:

- Magic number (azonosító)
- Egyedi azonosító
- Partíció mérete
- Blokkméret
- Partíción lévő szabad és foglalt blokkok száma
- i-node-ok száma
- És még sok minden

---

# i-node

- Nevének eredetét és jelentését homály fedi...
- Minden könyvtárnak, fájlnak, eszköz-fájlnak, stb. van egy ilyen i-node-ja
- Ez tartalmazza az adott objektum adatait:
    - Jogosultságok, tulajdonos, csoport
    - Legutolsó módosítás, elérés, i-node módosítás ideje
    - Hard link-ek száma, fájlméret
- NEM tartalmazza:
    - Létrehozás időpontját
    - A fájl, könyvtár, stb. nevét
- Egy fájl lehet több helyen is a fájlrendszerben (információ: *stat* parancs)
    - Egy-egy fájlnak több elérési útja is van, akkor melyik a neve?
- Könyvtárak ugyanolyan fájlok, mint a többi
    - Azaz egy új könyvtárban egyből lesz két bejegyzés: ./..
    - A . a saját i-node-ra a .. a szülő i-node-jára egy hard link

---

# Linkek

Hard linkek:

- Ha egy i-node-ot egy könyvtárba beteszünk, akkor lesz egy új (név,i-node) pár
- Ilyenkor a törlések kezelése véget az i-node-ban is számon tartják az ilyen bejegyzéseket
    - Egy könyvtárnak legalább két hard-link értéke van (mindkét irányban láncolt lista)
- Csak fájlra és egy partíción belül tudunk létrehozni

Soft linkek (sym(bolic) link):

- Ilyenkor létrejön egy új i-node
- Tartalmazza, hogy melyik másik i-node-ra hivatkozik
- Bármire létrehozhatunk
- A parancsok wrapper-ezése egy tipikus alkalmazási területe

---

# Próbáljuk ki a parancsokat!

1. *stat* parancs segítségével nézzünk meg egy könyvtárat és egy fájlt!
1. Csináljunk egy hard linket egy fájlnak (*ln fájl link*)!
1. Csináljunk egy soft linket egy fájlnak (*ln -s fájl link*)!
1. Nézzük meg *ls -l* paranccsal őket!
1. Mozdítsuk el az eredeti fájl!
1. Nézzük megy a linkeket! Melyik működik melyik nem?
1. Töröljük az eredeti fájlt!
1. Nézzük megy a linkeket! Melyik működik melyik nem?
1. Hogyan változott a linkek száma?

---

# Fontosabb könyvtárak a gyökérben:

- /etc: beállítások
- /home: felhasználók könyvtárai
- /root: *root* felhasználó könyvtára
- /boot: a bootoláshoz szükséges cuccok: kernel, initrd stb.
- /media: a felcsatolt médiák (flopy, cd, dvd, pendrive, stb.)
- /dev: a rendszerben elérhető eszközök és beállításaik
- /proc: az összes futó "feladat" információi
- /sys: Linux: hardver információk, OpenBSD: a kernel forrása
- /tmp: az ideiglenes fájlok tárolóhelye
- /var: a változó fájlok (naplók, nyomtatási sor, beérkező levelek) tárolóhelye
- /bin, /sbin, /usr/bin (az utóbbi időben csak /usr/bin): futtatható fájlok
- /run: a futásidőben szükséges eszköz információk

---

# /proc könyvtár

- Ez egy virtuális könyvtár (a kernel állapota van fájlokba transzportálva)
- Fontosabb fájljai:
    - /proc/cmdline : milyen paraméterekkel indult a kernel
    - /proc/cpuinfo: processzorok állapota
    - /proc/interrupts: Hol vannak a megszakítások és melyik hányszor váltódott ki
    - /proc/io(mem|ports): Kommunikációs memória és kapuk beosztása
    - /proc/meminfo: A memória állapotát mutatja
    - /proc/modules: A betöltött kernel modulok
    - /proc/version: A kernel verziója
    - /proc/self: Egy link az adott folyamat paramétereire
    - /proc/self/cmdline: Hogy hívtuk meg a programot
    - /proc/self/environ: Környezeti változói
    - /proc/self/limits: Mennyi erőforrást ehet

---

# /dev könyvtár

- /dev/null: fekete lyuk, mindent elnyel
- /dev/random: véletlenszám forrás (blocking)
- /dev/urandom: "kimeríthetetlen" véletlen szám forrás (kevesebb entrópia, non-blocking)
- /dev/zero: nullákat (0x00) ad vissza
- /dev/full: mindig azt írja, hogy tele van az eszköz
- /dev/shm: osztott ramdisk

---

# Fájlrendszerek tulajdonságai: Ext2-3

- Ext2
    - Régi alapvető fájlrendszer
    - Nem nagyon használjuk már
    - Nem tartalmaz naplózást
    - Előnye, hogy létezik rá Windows driver
    - Hátránya, lassan lehet leellenőrizni
- Ext3
    - Ext2 kiterjesztés, naplózással
    - De kompatibilis az Ext2 driverekkel (Windows alatt is!)
    - Bekapcsolható benne B-fák használata könyvtárak esetén (ilyenkor csak olvasni fogjuk tudni Ext2-es driverrel)
    - Lassú, Nem kezeli az extenteket
    - Nincs on-line (unmount nélküli) defregmentálás és partíció ellenőrzés
    - Adattömörítés hiánya, limitek, nem tökéletes naplózás

---
# Fájlrendszerek tulajdonságai: Ext4, Reiser*

- Ext4
    - Kompatibilis az Ext3 driverekkel
    - Limitek tovább növelve
    - Gyorsabb ellenőrzés
    - A 2038-as problémát orvosolja (még 204 évig)
- ReiserFS
    - Profi fájlrendszer, teljesen máshogy működik, mint az Ext-ek
    - Online növelhető a mérete, offline csökkenthető is
    - Tail packing, naplózás
    - Gyors
    - Vannak műveletek, amik nem egyből szinkronizálnak
    - Nincs defregmentálás
    - Bonyolult, fa újragenerálás nehézkes (persze ilyen nem szoktunk akarni csinálni)

---

# További profi fájlrendszerek

- Reiser4
    - Még profibb
    - Nem része a Vanilla Linux kernelnek
    - Hans Reiser rács mögött...
- XFS: Neki van Linux portja
- UFS: Neki nincs (Unix File System, másnéven: BSD Fast File System)
- ZFS
    - Meg neki sincs (csak majdnem), de jelenleg ez tűnik a csúcsnak
    - Mac Darwinok is ezt használják manapság
- BtrFS
    - ZFS-t utánzó rendszer főleg Linuxra
    - Stabil(?)
    - Impresszív feature-ök ([Demo](https://www.youtube.com/v/9H7e6BcI5Fo?start=209))

---

# Partíciók

- A "\*Nix" rendszerekben a partíció is fájl
- Régi jelölés (IDE): /dev/hd[a-z][1-9]
- SCSI, SATA, pendrive, stb: /dev/sd[a-z][1-9]
    - Már minden s-el kezdődik, az egyszerűsítés végett
- *cd /dev; ls -l | grep sda*
- Partíciók kezelésére az fdisk parancs használható
    - Az elérhető meghajtók listája (rootként!): *fdisk -l*
    - Léteznek természetesen grafikus eszközök is erre a célra (*cfdisk*, *gparted*)
    - Meg kell adni, hogy milyen típusú legyen a partíció
- Miután létrehoztuk a fájlrendszert, meg kell formáznunk (*mkfs.\**)
    - mkfs.ext2
    - mkfs.reiserfs, stb
- Ha le szeretnénk ellenőrizni, akkor az *fsck.\** parancsok a barátaink
    - fsck.ext3, stb.

---

# Fájlrendszerek felcsatolása (mount)

Ha használatba akarjuk venni a megformázott partíciót egyszerűen a *mount*-ot kell hívni:

- *mount /dev/sdb1 /mnt*
- Vannak speciális opciói is a *mount* parancsnak
    - Partíció típusa (ha nem tudná magától)
    - Csak olvasható, vagy írható is legyen
- Loop back device-ok: Ha szeretnénk egy image fájlt felcsatolni
    - pl.: Daemon tools Windows alatt
    - *mount fájl.iso célkönyvtár [-t fájlrendszer típusa] -o loop*
    - Fontos, a Cd-k fájlrendszere iso9660
    - A FAT(16|32) pedig vfat
- /etc/fstab: "automatikusan végrehajtandó" csatolások (rendszerindításkor felcsatolódnak)
- /etc/mtab: aktuális csatolások (dinamikusan frissül)

---

# Próbáljuk ki a parancsokat!

1. Próbáljunk írni a /dev/null-ba! (*echo "valami" > /dev/null*)
1. Próbáljunk írni a /dev/full-ba! (*echo "valami" > /dev/full*)
1. Próbáljunk olvasni a /dev/null-ból! (*cat /dev/null*)
1. Próbáljunk olvasni a /dev/urandom-ból! (*cat /dev/urandom* Ctrl+c-vel lehet leállítani!)
1. Próbáljunk olvasni a /dev/zero-ból! (*cat /dev/zero* Ctrl+c-vel lehet leállítani!)
1. Próbáljuk meg kiolvasni az adott parancs paramétereit a /proc-ból! (*cat /proc/self/cmdline*)
1. Nézzük meg a /etc/fstab fájlt és a mezőit! (*cat /etc/fstab*)
1. Hasonlítsuk össze a /proc/mounts-al! (*cat /proc/mounts*)
1. Nézzük meg a támogatott fájlrendszereket! (*cat /proc/filesystems*)
1. Nézzük meg a betöltött kernel modulokat! (*cat /proc/modules*)

---

# Egységes jogosultság kezelés (oktális)
- Három szint (User, Group, Other/World)
- Három mód: 1 (eXecute), 2 (Write), 4 (Read)
    - Könyvtáron az eXecute a listázás joga
- Setuid, Setgid: könyvtárakon értelmetlen, futtatható fájlok esetén a fájl tulajdonosának jogával fut bárki futtatja
    - Tulaj x joga helyett s van: ilyenkor a program futáskor a tulajdonos jogaival fut
    - Csoport x joga helyett s van: ilyenkor a program futáskor a csoport jogaival fut
    - Ha nagy S van, az azt jelenti, hogy a tulajnak/csoportnak nincs x joga rá
- sTicky bit: Linux: fájlokon értelmetlen, könyvtárakon "a tartalma örökli a jogosultságokat"
 [Más Unix rendszereken másképp viselkedhet!](http://en.wikipedia.org/wiki/Sticky_bit#Usage)
    - Lehet a harmadik blokk végén az x betű t lesz, ha meg van adva, T ha nincs
    - Csak a tulajdonos törölheti, vagy módosíthatja
- +/- jelekkel lehet a jogokat megadni és megvonni (pl.: *chmod +x script.sh*)
- *chmod u=rwx,g=rw,o= file.txt*: Egyenlőségjel csak azokat a jogokat adja meg, a többit elveszi, vessző felsorolás

---

# Fájlok típusai

- -: fájl
- d: könyvtár
- b: blokk fájl (például pendrive)
- l: szimbolikus link
- s: socket

Az ls parancs nem tudja magától kiírni a számokat ([forrás](http://stackoverflow.com/a/1796009)):

    !bash
    ls -l | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/) *2^(8-i)); \
    if(k)printf("%0o ",k);print}'

Parancsok:

- *stat*: fájl információk
- *ls -id*, *ls -l*: "LiSt content"
- *ln*: link létrehozása

---

# Próbáljuk ki a parancsokat!

1. Értelmezzük az *ls -l* kimenetét!
1. *chmod*-dal adjunk és vegyünk el jogokat egy fájlról!
1. Nézzük meg a változásokat *ls -l*-el!
1. Számoljuk ki a különböző jogok otkális kódját!
1. Potenciális állásinterjú kérdés:
    - Ext* fájlrendszeren nem tudod root-ként sem törölni a fájlt. Miért?
    - Medoldás: *lsattr*, *chattr*
    - *chattr +i*: sebezhetetlenné teszi a fájlt (invunerable)
    - *lsattr*: megmutatja az attribútumait
    - Különösen rendszerfájlok esetén hasznos, mert védi őket a vírusoktól!

---

# A parancssor: A prompt felépítése

- Felhasználónév
- kukac
- Gép neve
- kettőspont
- Aktuális könyvtár (A saját könyvtár röviden "~")
- Sima felhasználó esetén Dollárjel($), Rendszergazda esetén Kettős kereszt(#)
- A PS1 megváltoztatásával átírható...

# Példa:

    indba@users:~$
    root@users:~#

- Érdekesség: A jelszó begépelésénél a kurzor nem mozdul
- A fölfelé nyíl billentyűvel az előzőleg beírt parancsok előhozhatóak

