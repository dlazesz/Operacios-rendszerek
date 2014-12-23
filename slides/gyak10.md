
# Operációs rendszerek I.<br/> 10. gyakorlat

---

# Alternatív Linuxok, Oprendszerek

- Egyre több kütyü futtat valamilyen szoftvert
- Egyre több minden csatlakozik az internetre/valamilyen hálózatra
- Egyre több pénz van a kutatásban (hardver és softver)
- Legyen az új kütyü
    - Kicsi
    - Gyors (számolás, hálózat, reakcióidő stb.)
    - Olcsó
    - Fogyasszon keveset
    - Bővíthető, mert a gyártó sem tudja mit akar egy-két év múlva...
- Az operációs rendszer fölösleges drágító tényező! Főleg, ha fejleszteni is kell!
    - Emeljük le a polcról és szabjuk testre! (Linux, FreeBSD, stb.)
    - Licence problémák, feature-öket nem támogatja, a hardvert mem támogatja

---

# Alternatív Linuxok, Oprendszerek

- Tulajdoképpen a hardver is drága és csak a baj van vele!
    - Felhő!
    - Vékony kliens, ami épp csak megjeleníteni és kommunikálni tud
- Igazából mindegy mi, csak szabványos legyen!
    - Legalább fejlesztő szinten!
    - Kell egy *toolkit*, amit majd használ mindenki! Ami nem korlátoz, de gyorsítja a fejlesztést!
- Nevezhetjük sokmindennek
    - Framework
    - Middleware
    - Böngésző
    - Oprendszer
    - A lényeg, hogy a célszoftvert futtassa!

---

# Alternatív Linuxok, Oprendszerek

- Hogyan hat ez az oprendszerekre?
    - Feature, kutatási célú oprendszerek jelennek meg
    - A kód kinyitására van kényszerítve mindenki, különben fizetni is kell a fejlesztőket!
    - Lopni kell gátlástalanul!
    - Szabványosítani kell, legalább a saját portfólión belül!
- Eredmény
    - A tömegnek fejlesztünk, soha nem jó semmi mindenkinek...
    - ...de az se baj, mert jön az újabb verzió! Majd az!
    - Nagyon sok verzió kis eltéréssel ("Remixek")
    - Kevés az igazi authentikusan új projekt, ami "nem ugyanazt implementálja", ami már máshol működik, majd a hamvába hal...
    - Mindenki ugyanazzal küzd... Nincs igazi előrehaladás, mert a versenytársak (pl Kína/Kórea) is lopnak...
    - Felpezsdül a fejlődés!
    - *de facto* szabványok alakulnak ki! (Ilyen a *Nix pontosabban a Linux)

---

# Van egy trend

- Csak a kinézettel variálnak: Desktop Manager (amivel "bejelentkezel") és Window Manager (amit "használsz") "csere után" [kész az új rendszer](http://hup.hu/cikkek/20141123/quantum_os)
- Az "Debian-Ubuntu-Arch" tengely és a "Fedora-CentOS-OpenSuse" tengely régóta kialakult
    - Ezekről az utakról nincs nagyon letérés ([Valami az apt debian-arch linux vonalon](http://hup.hu/node/128885))
    - Nagy a szekértáborok közötti harc, pedig mindenki ugyan abból dolgozik...
    - Illetve a BSD, Mac OS, Windows hármasság. Bár itt inkább csak megszokásról van szó.
- Játék projektek töménytelen számban vannak. Általában egyfősek, és nem lehet rájuk építeni hosszútávon... Tanulásra, ötlet merítésre jók.
- Érdekes ötlet: TinyCore Linux: Nagyon kicsi (10MB!), minimalista rendszer
    - Az egész rendszer az initrd-be van pakolva... (az egész OS = kernel + init ramdisk)
    - [Szinte 100%-ban testreszabható](http://wiki.tinycorelinux.net/wiki:dynamic_root_filesystem_remastering)
    - [Futás közben csatolja fel a saját csomagjait](http://wiki.tinycorelinux.net/wiki:remastering)
    - [Számtalan csomagja van, jól használható pl.: vékony/vastag kliensnek](http://distro.ibiblio.org/tinycorelinux/4.x/x86/tcz/)
    - Gyorsan bootol (<10s), akár hálózatról! (Diskless client) Aktívan fejlesztik!

---

# Felületes osztályozás (mainstream)

- Remixek: [Starch Linux](https://starchlinux.org), [Linux Mint](http://www.linuxmint.com/), stb. Teljesen "szabad"-ok: [GNewSense](http://www.gnewsense.org/), [Trisquel](http://trisquel.info/)
- Saját Ablakkezelők, shellek (Ezek egy sima remixnél picitt többek): [PeppermintOS](http://peppermintos.com/), [Xpud](http://www.xpud.org/about.en.html)
- Hibridek: BSD kernel + GNU Userland ([ArchBSD](https://archbsd.net/), [Debian GNU/kFreeBSD](https://www.debian.org/ports/kfreebsd-gnu/)), Windows + GNU Userland [CygWin](https://www.cygwin.com/), GNU Hurd + GNU Userland: [GNU Hurd](https://www.gnu.org/software/hurd/hurd.html) ([Debian Hurd](https://wiki.debian.org/Debian_GNU/Hurd_TODO), [Arch Hurd](http://www.archhurd.org/))
- [Linux from Scratch (LFS)](http://hup.hu/cikkek/20140923/linux_from_scratch_beyond_linux_from_scratch_7_6): Gyakorlatilag egy Howto, hogy hogyan kell mindent lefordítani és bekonfigurálni. És akár ezt több féle módon összelegózva az elemeket... (A régi keményvonalas [Gentoo](https://www.gentoo.org/)-ra hasonlít. A Gentoo el-Arch-osodott, sokan áttértek az Arch-ra
- Újraimlementálások: [ReactOS](https://www.reactos.org/), [FreeVMS](http://www.freevms.net/), [Haiku](https://www.haiku-os.org/), [NetBSD mikrokernel alapon](http://2014.eurobsdcon.org/talks-and-schedule/talks/#AndrewTanenbaum)
- Extremitások: [LinuxBBQ](http://linuxbbq.org/) (Nagyon sok kipróbálható szoftver egy helyen), Kicsik: [TinyCore Linux](http://distro.ibiblio.org/tinycorelinux/) (10MB!!!), [Minimal Linux Live](http://minimal.linux-bg.org/) ([Tutorial](http://minimal.linux-bg.org/the_dao_of_minimal_linux_live.txt)) [Lista az ilyen disztribúciókról](http://bengross.com/smallunix/)
- Különutasok (átlalában GNU Userlanddel): [Minix](http://hup.hu/cikkek/20140916/minix_3_3_0), [L4 mikrokernel](http://en.wikipedia.org/wiki/L4_microkernel_family), [Plan9](http://en.wikipedia.org/wiki/Plan_9_from_Bell_Labs), [HelenOS](http://www.helenos.org/)
- Célrendzerek: [DBan](http://www.dban.org/download) (Biztonságos merevlemez törlő), [Clonezilla](http://clonezilla.org/) (Partíció klónozó), [FreeNAS](http://www.freenas.org/) (NAS), [OpenWall](http://www.openwall.com/) (Tűzfal), [Hiren's Boot CD](http://www.hiren.info/pages/bootcd) (Rescue), [OpenWRT](https://openwrt.org/) (Router)
- "Mobil-célú rendszerek": [Android](https://www.android.com/), [FirefoxOS](https://www.mozilla.org/en-US/firefox/os/), [Jolla](http://jolla.com/), [Bada](http://developer.bada.com/apis/index.do), [Tizen](https://www.tizen.org/), [Moblin+Maemo=MeeGo](http://en.wikipedia.org/wiki/MeeGo)
- Céges "lopások" (oda-vissza): [Fedora](http://fedoraproject.org/)-[RedHat](http://www.redhat.com/en)-[CentOS](http://www.centos.org/)-[Scienific Linux](https://www.scientificlinux.org/) (Cern)-[Oracle Unbreakable Linux kernel](http://www.oracle.com/us/technologies/linux/overview/index.html), [OpenSuse](https://www.opensuse.org/hu/)-[Suse](https://www.suse.com/), [Debian](http://www.debian.org/)-[Ubuntu](http://www.ubuntu.com/), stb.

---

# Felsorolás a teljesség igénye nélkül

- Firmware szintű rendszerek: [CoreBoot](http://www.coreboot.org/), [gPXE/EtherBoot](http://etherboot.org/wiki/index.php), [iPXE](http://ipxe.org/), [BusyBox](http://www.busybox.net/)
- [Fuzix](http://hup.hu/cikkek/20141103/fuzix_os_alan_cox_unix_system_v_elmenyt_nyujto_os-t_jelentett_be): System V élményt nyújtó 2.2-es Linux rendszer...
- [Debian Pendriveon](http://hup.hu/node/131458): A probléma, hogy egy pendrive-on hordozható, testhezálló linux kéne, örök...
- [TinyOS](http://tinyos.net/): Beágyazott rendszerekre készült OS
- [SyllableOS](http://web.syllable.org/pages/index.html): A REBOL (mostmár nyíltforrású) nyelv köré épülő rendszer
- [SkyOS](http://www.skyos.org/): Hobby projekt, egyfős kereskedelmi oprendszer
- [Java New Operating System Design Effort (Jnode)](http://www.jnode.org/): Java alapú oprendszer
- [Inferno](http://www.vitanuova.com/inferno/): Böngészőben is lehet(ett) futtatni IE-alatt
- [KoblibriOS](http://kolibrios.org/en/): ASM-ben írták, nagyon-nagyon pehelysúlyú!
- [AROS Research Operating System](http://aros.sourceforge.net/): Egyik célja az AmigaOS kompatibilitás, mint a WINE Linux alatt...
- Van képzeletbeli [térkép](http://www.dedoimedo.com/computers/linux-world-map-reloaded.html) is! :)
- [Utánuk](http://www.thefreecountry.com/operating-systems/alternative.shtml) [lehet](http://www.osfree.org) [olvasni](http://www.pcworld.com/article/228048/the_secret_world_of_alternative_operating_systems.html): [Distrowatch.com](http://distrowatch.com/) ([lemezképek](http://virtualboxes.org/images/) [letöltése](http://virtualboximages.com/))

---

# Mi a jövő?

- Nincs jó hardver támogatás mindenhol! (=Mindenhova drivert fejleszteni kidobott pénz. Jól kell pozícionálni a terméket, lásd Apple!)
- Virtualizáció, de a kütyüknek/vastag klienseknek futnia kell valamin...
- [Szabad szoftveres felhasználóknak szánt hardveradatbázist jelentett be az FSF](http://hup.hu/cikkek/20140909/szabad_szoftveres_felhasznaloknak_szant_hardveradatbazis_karbantartasat_jelentette_be)
- [A Haiku MAJDNEM kernelt váltot!](http://lwn.net/Articles/610566/) [De mégsem!](http://hup.hu/cikkek/20140829/haiku_hogyan_tovabb)
- Portolható driverek!
    - [Rumpkernel](http://rumpkernel.org/)
    - [DDEkit](http://os.inf.tu-dresden.de/ddekit/)
    - [Genode OS framework](http://genode.org/)
- Van ahol ez már majdnem a jelen
    - [A Hurdba integrálták](http://news.slashdot.org/story/14/02/10/1732223/gnu-hurd-gets-improvements-user-space-driver-support-and-more) [az Userspace drivereket](http://www.phoronix.com/scan.php?page=news_item&px=MTU5OTI)
    - [Minix over Linux](http://sbesc.lisha.ufsc.br/sbesc2012/dl50)
    - [Az OS X támogatja a Windows drivereket](https://discussions.apple.com/thread/1424192?tstart=0)
    - [A FreeBSD Linux kernel API-t kap](http://www.phoronix.com/scan.php?page=news_item&px=MTgzMjY)

---

# Főleg a Videókártya drivereket érinti

- Van két féle szabány: Direct3D (DirectX) és OpenGL
    - Sok a szabadalom, Licence stb. Útját állja a fejlesztésnek...
- Több elképzelés van
    - [X11-Xorg](http://www.phoronix.com/scan.php?page=news_item&px=MTcyNDQ9) (30 éves): Saját driverek kellenek a Kernel driverek mellé... ([spagetti kód](http://en.wikipedia.org/wiki/Gallium3D#mediaviewer/File:Gallium3D_example_matrix.svg))
    - Wayland vs. Mir: Új elképzelés [absztrakt driverek](http://www.x.org/wiki/Events/XDC2014/XDC2014HuttererLibInput/xdc-2014.html), a kernel szintjén specializálódnak
- API fordítás: OpenGL <-> Direct3D (gyorsabb, mint egy rossz driver) Lásd. Wine
- Manpság a 2D-t is a GPU gyorsítja, azt is próbálják egységesíteni ([GLAMOR](http://www.freedesktop.org/wiki/Software/Glamor/))
- [Architektúra](http://en.wikipedia.org/wiki/Free_and_open-source_graphics_device_driver)
- [Gallium3D](http://en.wikipedia.org/wiki/Gallium3D): Két részre vágja a különbözőségeket, többi helyen egységes felület van...
- Efölé még jön a "köztesréteg" (SDL), amire épül a *játékmotor* és ettől lesz lassú az egész
    - A zárt kódú driverek megpatkolják a rendszert, ezért gyorsabbak (pl.: Az Nvidia bináris libGL.so-ja)
- A Linuxban már nagyjából működik, próbálják azt portolni mindenhova... Miért nem szedik külön? (Linux Driver API más kernelekbe)

---

# Vicc kategória

- A kevésbé ismert [Windows 93](http://hup.hu/node/136350) ([böngészőben kipróbálható](http://hvg.hu/tudomany/20141028_windows_93_bongeszo_verzio), [mégtöbb infó](http://hup.hu/node/136350))
- [Az Openbsd-ből kiszedik a betölthető kernelmodulokat](http://www.phoronix.com/scan.php?page=news_item&px=MTgyNDI), [de berakják az USB3-támogatást](http://hup.hu/cikkek/20141108/usb3_tamogatas_az_openbsd-ben)
- [Android Easter Egg](http://hup.hu/node/136485)
- [JSLinux](http://bellard.org/jslinux/): Böngészőben futó linux (JavaScript VM-en)
    - Lehet büntetlenül kísérletezni... Pl.: *cat /dev/urandom > /dev/mem*
    - [Jor1k](http://hup.hu/cikkek/20130627/jor1k_javascript-ben_irt_linuxot_futatto_openrisc_1000_emulator): OpenRISC emulátor JavaScriptben
    - [A lehetőségek határtalanok](https://github.com/s-macke/jor1k/wiki/Explore-the-emulator)
    - [NAND memória emulátor](http://nxr.netbsd.org/xref/src/sys/dev/nand/nandemulator.c#370)
    - [A feltaláló oldala, tartogat még érdekességeket](http://belllard.org)
- [Ubuntu JUJU](https://juju.ubuntu.com/): szerver összehúzogató a Canonical-tól
- [OneGet: Linux-szerű csomagkezelő Windows-ra](http://www.howtogeek.com/200334/windows-10-includes-a-linux-style-package-manager-named-oneget/) ([Magyarul](http://pcforum.hu/hirek/16586/Beepitett+Linux-szeru+csomagkezelovel+fog+erkezni+a+Windows+10.html))
- [Telnet Fun linkek](http://www.blinkenlights.nl/services.html) [és véresen komoly linkek (BBS)](http://www.telnet.org/htm/places.htm)
- [Ingyenes Shellek](http://shells.red-pill.eu/)

---

# Vicc kategória

- [Shell in a Box](https://code.google.com/p/shellinabox/): Javascript alapú shell "hozzáférés", [van okosabb is](https://github.com/liftoff/GateOne)
- [Unix Haters Handbook](http://web.mit.edu/~simsong/www/ugh.pdf): Kötelező olvasmány! Szép önkritika!
- [Steve Ballmer távozott a Microsoft igazgatótanácsából](http://hup.hu/cikkek/20140820/steve_ballmer_tavozott_a_microsoft_igazgatotanacsabol)
- [Az LA Clippers és a Microsoft összefogásából születet logó](http://macdailynews.files.wordpress.com/2014/05/140527_clippers.jpg)
- [Linux Portál műsor felvételei](http://linuxportal.prociweb.hu/)
- [A Wine tesztelésekor találtak egy Linux kernel hibát](https://bugs.winehq.org/show_bug.cgi?id=33275#c15)
- A Google a ChromeOS-ben először [dobta](http://www.phoronix.com/scan.php?page=news_item&px=MTgxMTg) majd nyomásra [visszaállította](http://www.phoronix.com/scan.php?page=news_item&px=MTgxNTQ) az Ext* támogatást ([bugreport](https://code.google.com/p/chromium/issues/detail?id=274041))
    - [Pedig még windowson is támogatott](http://ext2read.blogspot.com/2010/04/ext2read-22-released-now-with-lvm2-and.html)
    - [És csak létező parancsokat kell bedrótozni](https://help.ubuntu.com/community/RenameUSBDrive#ext2.2C_ext3.2C_and_ext4)
- [20 éves a CUPS](https://www.cups.org/blog.php?L732): aki használta az tudja miért vicces a blogbejegyzés
- [Régi](http://www.in-ulm.de/~mascheck/various/ash/) [Shellekről](http://www.in-ulm.de/~mascheck/) [információk](http://www.in-ulm.de/~mascheck/bourne/)
- [Linuxot futtató DIY számítógép forrasztásmentes próbapanelen](http://hup.hu/cikkek/20141123/68_katy_linuxot_futtato_diy_szamitogep_forrasztasmentes_probapanelen) ([angolul](http://www.bigmessowires.com/2014/11/17/68-katy-68000-linux-on-a-solderless-breadboard/))


---

# Függelék

---

# Sehova nem fértek be

- [WinXP biztonságos használata LAN-on](http://hup.hu/node/135533)
- [Hogyan váltsunk iOS-ről Android-ra](http://hup.hu/treyblog/20140902/hogyan_valtsunk_ios-rol_android-ra)
- [Zentyal Server 4.0 - DHCP, DNS, tartományvezérlő, fájlszerver pillanatok alatt](http://hup.hu/cikkek/20141102/kiprobaltuk_zentyal_4_0_0_dhcp_dns_tartomanyvezerlo_fajlszerver_pillanatok_alatt)
- [Firesheep: Hogyan lopjunk cookie-t a hálózatról](http://systembash.com/content/firesheep-should-be-a-call-to-arms-for-system-network-web-admins/)
    - [Programszintű lehalgatás a hálózaton](http://systembash.com/content/command-line-packet-sniffing-existing-running-process-in-linux/)
- [Brute force SSH próbálkozások blokkolása](http://systembash.com/content/block-brute-force-ssh/)
- [Apt-get update GPG kulcs hiba megoldása](http://systembash.com/content/apt-get-update-gpg-key-errors-and-fix/)
- [Pascal fordító Ubuntun](http://systembash.com/content/experimenting-with-pascal-on-ubuntu/)
- [Mac OS rootpipe bug](http://hup.hu/cikkek/20141105/rootpipe)
- [Windows 7: Optimalizálás](http://www.dirtywindows.hu/publ/blogs/nameless/windows_7_optimalizalas_lassabb_szamitogepekre/7-1-0-522) [lassabb számítógépekre](http://pctamogatas.blogspot.hu/2011/05/linux-lassu-regi-gepre-2-resz-lubuntu.html#uds-search-results)
- [Új segédprogram az OpenBSD-ben: rcctl(8)](http://hup.hu/cikkek/20140831/uj_segedprogram_az_openbsd-ben_rcctl) (az OpenBSD service kezelésén javít)
- [Módosított deb csomag visszacsomagolása](http://www.commandlinefu.com/commands/view/10037/put-an-unpacked-.deb-package-back-together)
- [GNU Make nyelv](http://www.slideshare.net/mimimau/introduction-to-gnu-make-programming-language)

---

# Példa a nyíltforrású fejlesztési folyamatra

- Előzmények
    - A Linux képernyőkímélő kezelése nem volt egységes (elkezdték szabványosítani)
    - Az Ubuntu Unity "nem tudta még" implementálni a szabbányt
    - Következmény: A VLC-vel nézted a filmet, és elsötétült a képernyő 10 percenként
- Caffeine: egy program, ami meg tudta akadályozni a képernyővédő indulását (bárhogyis)
    - Volt neki appletje, ahol ezt a módot ki-be lehetett kapcsolgatni. Jó volt így.
    - Működött ez egészen nem sokkal ezelőttig... (2.5-ös verzió)
- Aztán jött a 2.7-es verzió: Megszüntették az appletet. Egy (fölösleges) démon maradt
- Az elv: A GÉP, ha teljes képernyőn van, akkor olyan mint a TV -> hagy menjen!
    - ... ha nincs semmi teljes képernyőn, csak akkor sötétedjen el!
- Lett [bug](https://bugs.launchpad.net/caffeine/+bug/1321750) ([nem is egy](https://bugs.launchpad.net/caffeine/+bug/1266953)), [workaround](http://joao.machado-family.com/2014/05/30/disabling-screensaver-ubuntu-14-04-caffeine/), [fork](https://github.com/mildmojo/caffeine-plus), magyarázat([Eddig volt rossz, javítsák az XDG-t](https://bugs.launchpad.net/caffeine/+bug/1266953/comments/9))
- Tanulság: Nem működik azóta sem... Miért kellett hozzányúlni egyáltalán? Miért nem lehet ilyenkor megtartani a régi funkcionalitást IS?
- Számtalan példa van: Firefox az Auróra kinézettel, Gnome3, stb.

---

# A slideok reprodukálása

- [Számtalan](http://www.impressivewebs.com/html-slidedeck-toolkits/) [HTML5-ös](https://github.com/regebro/hovercraft) [slideshow-generátor](http://en.wikipedia.org/wiki/Web-based_slideshow) [létezik](http://morgangoose.com/blog/2010/09/12/using-rst-for-presentations/) [a neten](http://c4lpt.co.uk/directory-of-learning-performance-tools/presentation-creation-hosting-tools/)
- Én a [landslide-ot](https://github.com/adamzap/landslide) választottam, [Markdownnal](http://commonmark.org/)
    - *landslide -i -t light -d alma.html alma.md*
    - Az RST formátum kicsit okosabb, abból a [PandDoc](http://johnmacfarlane.net/pandoc/) tud vázlatot generálni
    - Én a [PicoCMS-t](http://picocms.org/) használom [némi módosítással](https://github.com/dlazesz/Pico) az oldal és a vázlatok kiszolgálására

# Még egypár érdekesebb link

- [John](http://konteo.blogrepublik.eu/2014/11/19/john-titor-tortenete/) [Titor](http://en.wikipedia.org/wiki/John_Titor#In_popular_culture) és az [Y2k38 probléma](http://maul.deepsky.com/~merovech/2038.html)
- [Miért kell letiltani a gyors Boot-ot Windows 8 Dualbootkor?](http://askubuntu.com/questions/452071/why-disable-fast-boot-on-windows-8-when-having-dual-booting)
- [Fizikailag létező partíció VirtualBox merevlemezként](http://hup.hu/node/136887) ([angolul](http://www.serverwatch.com/server-tutorials/using-a-physical-hard-drive-with-a-virtualbox-vm.html))
- [DOS-Unix-VMS parancsok összehasonlítása](http://progkor.inf.elte.hu/minimum.htm) ([VMS DCL cheatsheet](http://progkor.inf.elte.hu/200506.2/gyak/VMS.htm), [FAQ](http://progkor.inf.elte.hu/kerd_val.htm), [Unix összefoglaló](http://progkor.inf.elte.hu/200506.2/unix.html))
- [Linux parancsok+példakimenettel](http://progkor.inf.elte.hu/200506.2/gyak/index.htm)
- [Zh minták](http://progkor.inf.elte.hu/200506.2/kovetel.htm)
- [Bash](http://hup.hu/node/77463) [szintetizátor](https://github.com/watsyurname529/linuxbeeppiano)


---

# Potenciális ZH feladatok

1. *echo*-zzuk ki úgy a három dolgot hogy mindegyik között 6 szóköz legyen!
    - Probléma: A szóköz mezőelválasztó az üres mezőket kiszedi a szövegből (=sok egymást követő szóközből egyet csinál)
    - Megoldás: IFS átállítása VAGY szóközök védése VAGY idézőjel használata:<br/> *echo "Hello &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;little &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;world"*
2. Implementáljuk a Windows-os *pause* parancsot (parancsként legyen hívható)!
    - Probléma: Nincs *pause* helyette van *read* sok paraméterrel. Ezt kell jól megszerkeszteni! Parancsként hívhatónak kel lennie, akkor vagy függvény, vagy PATH-ban lévő shell scipt kell nekünk!

            !bash
            pause() {
              local dummy
              read -s -r -p "Press any key to continue..." -n 1 dummy
            }

3. Csináljunk vízszintes vonalat!
    - [Több kreatív megoldás](http://wiki.bash-hackers.org/snipplets/print_horizontal_line)
