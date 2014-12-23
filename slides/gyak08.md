
# Operációs rendszerek I.<br/> 8. gyakorlat

---

# Hálózati/Security trükkök

- Számtalan módon lehallgatható a hálózati forgalom, egyik mód: *ngrep*
- Megnézhetjük, milyen programok figyelnek valamilyen porton: netstat -lnp
- *ssh -X* és *ssh -Y*: képes X programok hálózaton történő továbbítására (Windows-ra is lehet: [Xming](http://www.straightrunning.com/XmingNotes/))
    - Az -Y verzió *Trusted* ezért engedékenyebb securty szempontból
- *ssh -f -N -L110:szerver:110 másik.szerver*: Portforwarding okosan
    - \-f: forkol a háttérbe
    - \-N: Nem futtat semmilyen parancsot
    - Ha van kulcsos azonosítás, akkor még az sem érdekli ha a shell */bin/true*-ra lett állítva!
    - Ha nem zárjuk le a felhasználói fiókot, csak a shellt állítjuk valamire, ami azonnal kilép (ami régi praktika) ez akkor is működni fog!
- Érdekes: [sslh - Applicative protocol multiplexer](http://www.rutschle.net/tech/sslh.shtml) [példa](http://www.ubuntugeek.com/sslh-sslssh-multiplexer.html)
- [Proxy SSH-n keresztül](http://systembash.com/content/a-poor-mans-vpn-proxy-web-connection-to-remote-server-via-ssh-and-tunnel/)

---

# Init hack

- Mit csináljunk, ha elfelejtettük a jelszót a rendszerünkhöz?
    - Várunk egy local root exploitra és azzal törjük fel...
    - Indítsuk újra liveCD-ről... Ami nyilván nincs kéznél vagy nem működik éppen...
    - Hackeljük meg az init-et!
    - Sőt ha már ott vagyunk: [Írjuk át Emacs-ra az initet!](http://www.informatimago.com/linux/emacs-on-user-mode-linux.html)

# Mi is a feladata tulajdonképpen az initnek?

- Az init a PID 1-es process
- Elindítja a különböző rendszerindítási scripteket (és menedzsereiket) külön szálként
- És vár, hogy mikor kell leállítani magát (rendzerleálláskor, újraindításkor)
- Jó ha: tulajonképpen el lehet feledkezni róla...
    - Nem kell leállítani, frissíteni
    - Nincsenek benne biztonsági és egyéb hibák

---

# Init: Példa kód

    !c
    #define _XOPEN_SOURCE 700
    #include <signal.h>
    #include <unistd.h>

    int main()
    {
        sigset_t set;
        int status;

        if (getpid() != 1) return 1;

        sigfillset(&set);
        sigprocmask(SIG_BLOCK, &set, 0);

        if (fork()) for (;;) wait(&status);

        sigprocmask(SIG_UNBLOCK, &set, 0);

        setsid();
        setpgid(0, 0);
        return execve("/etc/rc", (char *[]){ "rc", 0 }, (char *[]){ 0 });

- [Forrás](http://ewontfix.com/14/)
- Látjuk, hogy az alfeladatok teljesen elkülönülnek, azok futás közben cserélhetők
- Initet nem lehet futás közben cserélni!


---

# Rendszer a rendszerben (virtualizáció)

- Hogyan fordítsunk le 64bites binárist 32 bites oprendszeren és fordítva?
- Hogyan fordítsunk le egy kütyüre (ARM CPU, linux) valamit? ([Arch Linux verzió](http://archlinuxarm.org/developers/distcc-cross-compiling))
- Hogyan szeparáljuk a programokat egymástól? (Pl.: tesztelés céljából)
- Hogyan védjük a rendszert a felhasználóktól? ([SFTP chroot](http://www.debian-administration.org/articles/590) [SFTP-only SSH](http://www.minstrel.org.uk/papers/sftp/) [File control patch](http://www.yare.se/download_sftppatch.jsf))
- Hogyan telepítsük újra a GRUB-ot live CD-ről? (Pl.: Windows újratelepítés esetén [megoldás1](http://ubuntu.hu/node/13573#12), [megoldás2](http://www.debian-news.net/category/debian-guides/))
- [*chroot*](http://en.wikipedia.org/wiki/Chroot) (1979)
    1. Adott a virtuális fájlrendszerünk egy könyvtára...
    1. Megváltoztatjunk úgy a programok működését (a *chroot* rendszerhívással), hogy azt gondolják ez a root könyvtár ("/")...
- **Nem ilyen egyszerű**: A fájlrendszer felsőbb részeihez nem fér hozzá(csak az új rootból nyíló részfához), de a kernel interfészeit (/dev, /sys, /proc) át kell adni (*mount -o bind*). Ez biztonsági kockázatokat eredményez...
- De mégis használják: scriptek egyszerűsítik az ember dolgát, ahol nem fontos a biztonság ott jó. **Sokkal gyorsabb mint a többi virtualizációs megoldás!**

---

# A *chroot* Változatai ([forrás](http://en.wikipedia.org/wiki/Chroot))

- 1979: Az eredeti *chroot* koncepció
- 2000: *jail* parancs FreeBSD kifejezetten virtualizálásra
- 2005: *Solaris Containers* (Sun): "chroot on steroids"
- 2008: *LXC* és ráépülve *Dockler*
- 2013: A Linux kernel 3.8-ba bekerül az *usernamespaces*
- 2014: [A Canonical bejelenti az LXD-t](http://www.hwsw.hu/hirek/53142/linux-lxd-kontener-virtualizacio-lxc-docker-ubuntu-canonical-adatkozpont-szerver.html)

# Gyakorlatban:
- *schroot*: parancssorban váltogathatunk chrootok között és kezelhetjük őket
- Oprendszer telepítés "mappába":
    - *Debootsrap* (Debian, Ubuntu)
    - *pacbootsrap* (Arch Linux)
    - *febootstrap* (Fedora)
    - *zypper* (OpenSuse)

---

# Próbáljuk ki!

1. *sudo -s*
1. *apt-get install schroot debootstrap*
1. *mkdir -p /srv/chroot/ubuntu && nano /etc/schroot/chroot.d/ubuntu.conf*
1. Beírni:

        [ubuntu-chroot]
        description=Az első chrootom
        directory=/srv/chroot/ubuntu
        personality=linux32
        type=directory
        users=ubuntu
        root-users=ubuntu
        run-setup-scripts=true # Ezek miatt nem kell majd másolgatni
        run-exec-scripts=true

1. *debootstrap --variant=buildd --arch=i386 trusty /srv/chroot/ubuntu http://archive.ubuntu.com/ubuntu*
1. *schroot -c ubuntu-chroot*

---

# A chrootban próbáljuk ki!

1. *apt-get install file -y && file /bin/bash*
1. uname -a && arch
1. *locale*
    - *echo "hu_HU.UTF-8 UTF-8" > /var/lib/locales/supported.d/local*
    - locale-gen hu_HU.UTF-8
    - export LANG="hu_HU.UTF-8"
    - ln -sf /usr/share/zoneinfo/Europe/Budapest /etc/localtime
    - cd /usr/share/zoneinfo && tzselect
1. *ps -aux*
    - keressünk rá a gazda rendszerbeli felhasználónevünkre!
    - Ki tudjuk lőni az ottani programot!
1. chroot /srv/chroot/ubuntu
    - Most van net?
    - Miért nincs? (mert az /etc/resolv.conf -ot is át kell másolni!)

---

# Tanulság

- Lehet fordítani/futtatni 64bites gazda oprendszer alatt is 32-bites programot ([Ubuntu chroot leírás](http://www.binarytides.com/setup-chroot-ubuntu-debootstrap/))
    - És fordítva is! [Ilyenkor kell a hardver támogatás pl Qemu-val](https://wiki.debian.org/EmDebian/CrossDebootstrap)
    - [Sima fordítás esetén vasnak se kell támogatnia a 32-bitet!](http://stackoverflow.com/a/1511163)
- Így is lehet Ubuntut ([eredetileg Debiant](http://en.wikipedia.org/wiki/Debian-Installer#debootstrap)) [telepíteni...](http://wiki.shellium.org/w/Debootstrap_install) ([Debian debootstrap telepítés](https://wiki.debian.org/Debootstrap))
- Ha GUI-t akarunk a chroot-ból futtatni
    - *xhost +* parancs után menni fog ([forrás](https://wiki.debian.org/Schroot))
- Ha automatikusan akarunk szervereket indítani a chroot-ban
    - A gazda gép indulásakor lefutó scriptbe a következőt kell beírni ([forrás](https://wiki.ubuntu.com/DebootstrapChroot))
        - *schroot --all -- su -c /etc/init.d/rc\ 2 -*
- Olvasmányok
    - [Különféle virtualizációs módszerek összehasonlítása](http://en.wikipedia.org/wiki/Operating_system%E2%80%93level_virtualization)
    - [Arch linux telepítő scriptek:](https://github.com/falconindy/arch-install-scripts) Különösen a *common* fájlban: az *api_fs_mount()* függvény, hogy milyen dolgokat kell a chroot-ban beállítani, hogy működjön!



---

# Olvasmányok

- [GUID partíciós tábla](http://en.wikipedia.org/wiki/GUID_Partition_Table): Ez a jövő útja, leváltja a DOS partíciókat és az MBR-t
    - UEFI támogatás, nincs limitálva az elsődleges partíciók száma 3-ban, mint régen az MBR-nél. (A GUID-ban 128)
- [Csak olvasható gyökérfájlrendszer](https://sites.google.com/site/linuxpendrive/rorootfs) ([partíció fagyasztás](http://lethe.sourceforge.net/))
    - Biztonságosabb egy fokkal, gyorsabb (nem kell írni és erre várni, SSD-t kíméli)
- [Windows jelszó megváltoztatása linux alól](http://systembash.com/content/how-to-reset-windows-xp-vista-windows-7-passwords-with-ubuntu-9-10-live-image-and-a-usb-drive/)
- [Linux és Windows távoli telepítése Hálózatról (PXE Boot)](http://systembash.com/content/unattended-remote-os-installs-linux-windows/)
    - [Windows driverek beépítése a telepítőbe (nem nLite)](http://systembash.com/content/unattended-install-windows-drivers/)
    - [Linux beléptetése Active Directory-ba](http://systembash.com/content/4-steps-to-authenticate-ubuntu-logins-with-active-directory/)
    - [Ubuntu kirakati Tv-be](http://systembash.com/content/using-ubuntu-as-a-247-lobby-display-driver/)
- [Linux kernel futás közbeni patchelése (kGraft, Kpatch és Ksplice)](http://www.phoronix.com/scan.php?page=news_item&px=MTgzMjI)
- [Hogyan írjunk patchet a Linux kernelhez, hogy az be is kerüljön](http://blog.ffwll.ch/2014/08/review-training-slides.html)
- [Arch linux telepítés Btrfs GUID-ban fájlrendszerre, GPT partícióval régi gépbe SSD-re...](http://tincman.wordpress.com/2011/01/20/installing-arch-linux-onto-a-gpt-partitioned-btrfs-root-ssd-on-a-legacy-bios-system/)

---

# Marginálisan kapcsolódó linkek

- [Regkifhez generál nyelvet](http://regldg.com/tryit.php) ([Regexp kiértékelési érdekesség](http://hup.hu/node/128272))
- [Spam gyűjtemény](http://hup.hu/node/136521) ([itt](http://artinvoice.hu/spams/))
- [nogotofail - nyílt forrású SSL/TLS biztonsági tesztelőeszköz a Google-től](http://hup.hu/cikkek/20141105/nogotofail_nyilt_forrasu_ssl_tls_biztonsagi_teszteloeszkozt_adott_ki_a_google)
- [Hogyan hackeljünk? (Ethical hacking, tutorial videók)](http://www.hwsw.hu/hirek/46196/ethical-hacking-kepzes-jatek.html)
- [LAMP Security Toolkit](https://github.com/janoszen/LAMPSecurityToolkit/wiki)
- [Szerver biztonságosság tétele](http://hup.hu/node/111976)
- [Hackelt .htaccess pucoló script](http://hup.hu/node/130906)
- [Egysoros ideiglenes dinamikus DNS szolgáltatás](https://pagekite.net/)
- [C/C++ programot redukáló program hibakereséshez](http://embed.cs.utah.edu/creduce/)
- [Mindenféle programozás tanulási erőforrások összegyűjtve](http://resrc.io/)
- [Publikusan elérhető beállítás fájlok (már nem lehet regisztrálni)](http://dotfiles.org/)
    - *github*-on is lehet hostolni és tetszőleges új gép gyoran belakható vele...
- [Nyelvtechnológiai csomagok a Debianban](https://packages.debian.org/wheezy/science-linguistics)
