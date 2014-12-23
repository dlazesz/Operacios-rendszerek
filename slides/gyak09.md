
# Operációs rendszerek I.<br/> 9. gyakorlat

---

# Arch linux telepítés
1. A telepítő CD letöltése [innen](https://www.archlinux.org/download/) a kedvenc szervert választva...
    - Van magyar szerver is! (mfa.kfki.hu)
    - Amint látjuk ez egy legális használati esete a BitTorrentnek! ;)
    - Ne felejtsük el ellenőrizni, hogy az ISO jól töltődött-e le! (A Firefox nem mindig szól, ha nem volt írásjog, elég hely stb...)
1. *sh --version* Ez is csak bash...
1. Billentyűkiosztás: *loadkeys hu*
    - Itt vannak a kiosztások: /usr/share/kbd/keymaps/hu...
1. Konzolos ékezetek: *setfont lat2-16*
    - */usr/share/kbd/consolefonts/lat2...*
1. Internet csiholása: *dhcpcd*
    - Figyeljük meg a device nevét, mert később kelleni fog!
    - Itt már nincs *ifconfig* mert az [elavult](https://blog.timheckman.net/2011/12/22/why-you-should-replace-ifconfig/)
    - Helyette: *ip link show* vagy *netstat -i* [forrás](http://www.cyberciti.biz/faq/linux-list-network-interfaces-names-command/)

---

# Arch linux telepítés

1. Partícionálás: *cfdisk*

        msdos
        1GB linux swap, 1.5GB linux /var, 4.5GB linux /, 1GB linux /home
        write -> yes !!!

1. Formázás

        mkswap /dev/sda1 && swapon /dev/sda1
        mkfs.ext4 /dev/sda2 && mkfs.ext4 /dev/sda3 && mkfs.ext4 /dev/sda4

1. Partíciók csatolása (A /boot-ot is lehet külön és akkor több linux lehet egy /boot-tal, sőt akkor könnyebb őket egymástól függetlenül újratelepíteni...)

        mount /dev/sda3 /mnt && mkdir /mnt/var
        mount /dev/sda2 /mnt/var && mkdir /mnt/home && mount /dev/sda4 /mnt/home

1. Tükör kiválasztása: *nano /etc/pacman.d/mirrorlist*
1. Telepítés: *pacstrap /mnt base base-devel* (Ez kb 2 perc ha jó a kapcsolat)

---

# Arch linux telepítés

1. *fstab* generálása: *genfstab -p /mnt >> /mnt/etc/fstab*
    - Itt lehet a gyökérnek *ro* opciót adni később!
    - [Érdemes megnézni a kódját, tanulságos!](https://github.com/falconindy/arch-install-scripts/blob/master/genfstab.in)
1. Belépés a *chroot-ba*: *arch-chroot /mnt*
1. Gépnév beállítása: *echo "arch_gep" > /etc/hostname*
1. Időzóna beállítása: *ln -sf /usr/share/zoneinfo/Europe/Budapest /etc/localtime*
1. Hardver óra beállítása: *hwclock --systohc --utc*
1. Locale beállítása: *nano /etc/locale.gen*
    - Itt kiszedni a hu_HU.UTF-8 elől a kommentet
    - *locale-gen*
    - *echo "LANG=hu_HU.UTF8" > /etc/locale.conf*
1. Konzol beállítása: *nano /etc/vconsole.conf*

        KEYMAP=hu
        FONT=lat2-16

---

# Arch linux telepítés

1. Hálózat beállítása: *systemctl enable dhcpcd@[Az eszköz neve].service*
1. Induló ramdisk beállítása: *nano /etc/mkinitcpio.conf*
    - Itt jó az alap beállítás, de éredemes körülnézni
    - *mkinitcpio -p linux*
1. GRUB telepítése: *pacman -S grub*
    - *grub --install --target=i386-pc --recheck /dev/sda*
    - *grub-mkconfig -o /boot/grub/grub.cfg*
1. pacman -S sudo
1. *root* jelszó megadása: *passwd*
1. Normál felhasználó hozzáadása: *useradd -m -G wheel -s /bin/bash felhasználónév* (jelszó beállítása: *passwd felhasználónév*)
1. Újraindítás!
1. (Opcionális): Írjuk át az */etc/fstab*-ban read-only-vá a fájlrendszert! ([régi leírás](http://www.gentoo-wiki.info/HOWTO_Read-only_root_filesystem))

        /dev/sda3   /   ext4    defaults,ro 0   1

---

# Az Arch linux lehetőségei

1. AUR (Arch User Repository): Mint az Ubuntu PPA-ja, csak jobb!
    - Inkább hasonlít a FreeBSD ports tree-jére (később!)
    - Minden szoftverből, ami nincs a repo-kban, csinálhatunk saját "csomagot" (PKGBUILD), ha más még nem tette... [Kereshető adatbázis!](https://aur.archlinux.org) ([Ubuntu hasonló](http://packages.ubuntu.com/) [és ez](http://www.ubuntuupdates.org/ppas))
    - Telepíthető mintha hivatalos csomag lenne... (Meg kell bíznunk a karbantartóban!)
1. Kétféle módszer van az ilyen telepítésre
    - *yaourt*: Egy wrapper a *pacman* csomagkezelőhöz. Nincs belőle hivatalos csomag! :(
    - *makepkg*: A letöltött PKGBUILD-et lefordítja és telepíti (Ezt használja a *yaourt* is!)
1. Telepítsük a *yaourt*-ot *makepkg*-vel!
    - [Itt található a leírás](https://archlinux.fr/yaourt-en)
1. Telepítsük a *debootstrap* programot *yaourt*-tal... ([használat leírása](https://sites.google.com/site/uxhakx/debootstrap-on-archlinux-howto))
    - Előbb a *fakeroot* és *binutils* csomagokat kell telepíteni (különben hiányozni fognak)
1. [Arch Rollback Machine (ARM)](https://wiki.archlinux.org/index.php/Arch_Rollback_Machine)
1. A *systemd* kirpóbálható mert az Arch Linux azt használja már rég

---

# További tudnivalók

- [Grafikus felület és LXDE telepítése pár csomag segítségével egyszerűen](http://www.archlinuxuser.com/2013/01/how-to-install-lxde-desktop-on-archlinux.html)
- [Arch wiki](https://wiki.archlinux.org/index.php): kifogyhtatlan információforrás ([Például könnyűsúlyú programokat keresni](https://wiki.archlinux.org/index.php/Lightweight_Applications))
- [A Systemd már a PPPOE-t is magába szívja.](http://www.phoronix.com/scan.php?page=news_item&px=MTgyODQ) [Közben készül a KDBUS](http://www.phoronix.com/scan.php?page=news_item&px=MTgyNTQ)
    - [Systemd](http://boycottsystemd.org/) [ellenes](http://uselessd.darknedgy.net/) [hangok](http://ewontfix.com/14/)

# Az Arch Linuxtól függetlenül

- [Nix csomagkezelő](http://nixos.org/nix/) [és a barátja a Guix](http://phoronix.com/scan.php?page=news_item&px=MTg0MzI)
- [A Debiannál nem döntenek az Init rendszerről](https://lists.debian.org/debian-devel/2014/11/msg00891.html) ([Debianos leírás a boot gyorsítására](https://wiki.debian.org/BootProcessSpeedup))
- [Linux Bootolása Windows-os bootloaderből](http://www.murga-linux.com/puppy/viewtopic.php?t=14873)
- [A Linux kernel mostantól explicit GNU89-es dialektust használ](http://phoronix.com/scan.php?page=news_item&px=MTg0MTQ)
- [18 éve távolról kihasználható sebezhetőséget javított a Microsoft](http://hup.hu/cikkek/20141112/18_eve_tavolrol_kihasznalhato_sebezhetoseget_javitott_a_microsoft)
- [Miguel de Icaza: A Microsoft megnyitja a .NET-et](http://hup.hu/cikkek/20141112/miguel_de_icaza_a_microsoft_megnyitja_a_net_-et)
- [A Chrome fejlesztők immár clang-gel készítik az éles linuxos Chrome verziókat](http://hup.hu/cikkek/20141117/a_chrome_fejlesztok_immar_clang-gel_keszitik_az_eles_linuxos_chrome_verziokat)<br/>([Az OpenMandriva is váltott Clang-ra](http://www.phoronix.com/scan.php?page=news_item&px=MTgzMzI))

---

# FreeBSD

- A Berkely egyetemen született [1993-ban](http://www.phoronix.com/scan.php?page=news_item&px=MTgyODM). Ez Unix, csak a nevet kellett megváltoztatni...
- A megengedő Licencelése miatt például az OS X integráns részévé vált
- Nagyon hagyománykövető, sok "hasznos újítás" nincs benne, viszont kicsi és gyors!
- A fókusz a rendszer integráns egységén van
    - Nincs külön kernel és userspace, viszont van alaprendszer és ports tree
    - Jól dokumentált ([FreeBSD Handbook,](http://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/index.html) [FAQ](https://www.freebsd.org/doc/en_US.ISO8859-1/books/faq/))
    - [Kezdőtől](http://www.freebsd.org/projects/newbies.html) a [profi szintig!](http://www.freebsd.org/doc/en_US.ISO8859-1/books/handbook/system-administration.html)
    - [Be lehet kapcsolódni a fejlesztésbe](http://www.freebsd.org/projects/ideas/ideas.html) (Lásd. [Kövesdán](https://www.freebsd.org/news/status/report-2010-04-2010-06.html#BSD-Licensed-grep-in-Base-System) [Gábor](http://hup.hu/cikkek/20100617/bsdl-es_iconv_a_freebsd_alaprendszerhez))
- Nincs Unicode támogatás, sőt elég limitált a nyelvi támogatás, de [dolgoznak](https://www.b1c1l1.com/blog/2011/05/09/using-utf-8-unicode-on-freebsd/) [rajta](https://wiki.freebsd.org/Newcons)
- [Az UEFI bootolást és telepítést támogatja](http://www.phoronix.com/scan.php?page=news_item&px=MTgyODk) [Sőt! ZFS root-ot is lehet csinálni!](https://wiki.freebsd.org/RootOnZFS)
- A telepítés már egyszerűbb ([bsdinstall(8) a Freebsd 9.0 óta](https://www.freebsd.org/doc/handbook/using-bsdinstall.html)) mint régen ([sysinstall(8)](https://www.freebsd.org/doc/handbook/using-sysinstall.html))...
- [Összehasonlítás a Linuxszal](http://brioteam.com/linux-versus-freebsd-comprehensive-comparison)

---

# FreeBSD elöljáróban

- [20 éves a FreeBSD ports fa!](http://hup.hu/cikkek/20140821/20_eves_a_freebsd_ports_fa)
    - [GNU verzió: GNU SRC (Source Release Collection)](http://www.gnu.org/software/gsrc/)
    - [FreeBSD lokális repó használata](http://hup.hu/node/134879)
    - [Ports használata](https://www.freebsd.org/doc/handbook/ports.html)
- Ahogy az Arch Linuxnál a [Manjaro](http://manjaro.org/), a FreeBSD-nél a [PC-BSD](http://www.pcbsd.org/) egy az eredetiből "remixelt" rendzer, ami a kezdőket célozza meg...
    - A PC-BSD-nek van saját [*Lumina* nevű](https://github.com/pcbsd/lumina) [Asztali környezete](http://hup.hu/cikkek/20141103/video_a_pc-bsd_lumina_nevu_desktop_kornyezete)
- A FreeBSD *de facto* verziókezelője az [SVN](https://www.freebsd.org/doc/handbook/svn.html), az OpenBSD-nek a [CVS](http://www.openbsd.org/anoncvs.html)
    - A legtöbb frissítés is [ezen keresztül történik](https://www.freebsd.org/doc/handbook/updating-upgrading.html)
- Van benne [Linux-bináris kompatibilitási réteg](https://www.freebsd.org/doc/handbook/linuxemu.html)
    - Sőt! [Lassan az egész Linux kernel API meglesz, a driverek portolhatósága miatt](http://www.phoronix.com/scan.php?page=news_item&px=MTgzMjY)
- Az X-en, ellentétben a konzollal nyilván [be lehet konfigurálni](https://www.freebsd.org/doc/handbook/l10n.html), nyelveket (l10n)...
- A boot folyamat [részletesen megérthető](https://www.freebsd.org/doc/handbook/boot.html)

---

# FreeBSD telepítés

---

# Próbáljuk ki a parancsokat!

1. *cat*-oljunk egy könyvtárat!
1. Nézegessük meg a könyvtárakat, mi a különbség a Linux fájlrendszerhez képest?
1. Nézzük meg az ifconfig kimenetét! Mik a hálókártyák nevei?
1. Frissítsük a Ports fát! (*portsnap fetch extract*)
1. Fordítsuk le az *lsof*-et forrásból! (/usr/ports/sysutils/lsof)
    - Mire is jó ez a parancs? (*man lsof*)
    - Linuxon is elérhető!
1. Telepítsük a Hunspell-t a csomagból! (*pkg install hunspell && hunspell -d hu_HU*)
1. Nézzük meg, hogy milyen *grep*-et használ a FreeBSD! (*grep --version*)
    - A GNU eszközök néhol felfedezhetők, de törekszenek az eliminálásukra!
1. Milyen c fordító érhető el a rendszeren? (cc --version)
    - A *gcc* már száműzve lett!
1. Nézzük meg, hogy milyen *tar*-t használ a FreeBSD! (*tar --version*)

---

# Néhány információ a végére

- [A fájlrendszerek, az adatvesztés és a ZFS](http://hup.hu/cikkek/20140924/a_fajlrendszerek_az_adatvesztes_es_a_zfs)
    - [A ZFS Linuxon használatra kész](https://clusterhq.com/blog/state-zfs-on-linux/)<br/>(alkalmazási lehetőség: [71 TiB DIY NAS ZFS on Linux-szal](http://hup.hu/cikkek/20140902/71_tib_diy_nas_zfs_on_linux-szal))
- [A Fujitsu szerint A Btrfs használtra kész](http://www.phoronix.com/scan.php?page=news_item&px=MTgzMzM)
- [Ext4 felépítése és az adatvisszanyerés lehetőségei](http://computer-forensics.sans.org/blog/2010/12/20/digital-forensics-understanding-ext4-part-1-extents)
- [Könnyen használható Linux kernel titkosító API kivezetés készül az userspace-be](http://www.phoronix.com/scan.php?page=news_item&px=MTgzMzk)
- [TP-Link és más routerek gyári firmwarejében backdoor (Proof-of-Concept kód)](http://sekurak.pl/tp-link-httptftp-backdoor/)
- A [Live](http://en.wikipedia.org/wiki/Ksplice) [Kernel](http://en.wikipedia.org/wiki/Kpatch) [patchelés](http://en.wikipedia.org/wiki/KGraft) után szabadon:
    - [CRIU 1.0 - userspace checkpoint / restore eszköz Linuxra](http://hup.hu/cikkek/20131126/criu_1_0_userspace_checkpoint_restore_eszkoz_linuxra)
    - [Futó process mentése fájlba (Cryopid)](https://github.com/maaziz/cryopid) és a párja [még több funkcióval (Cryopid2)](http://sourceforge.net/projects/cryopid2/)
- [A Skype a böngészőbe költözik](http://www.hwsw.hu/hirek/53179/skype-bongeszo-microsoft-chat-video-webrtc.html)
    - Megjegyzés: Az [SDL (Simple DirectMedia Layer)](http://hu.wikipedia.org/wiki/Simple_DirectMedia_Layer) is csak egy [köztesréteg](http://hu.wikipedia.org/wiki/%C3%9Czenetorient%C3%A1lt_k%C3%B6ztesr%C3%A9teg). Ahogy a Böngésző és régebben a cross-platform frameworkök... (lásd.: virtualizáció)
- [Julian Assange könyve a hackerkedésről](http://www.xs4all.nl/~suelette/underground/)
