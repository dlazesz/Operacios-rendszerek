#!/bin/bash

# Ennél sokkal egyszerűbben is megoldható a feladat, de mivel ez csak egy script nem számít annyira a szépség...
# A Zh közben vázoltam például, hogy a pontok számolása direktben is történhet asszociatív tömbökkel:
# például: 1a -> 2, 1b-> -1, 1c-> -1, 1d -> 2, 2a -> -1, 2b -> -1, 2c -> 2, 2d -> -1, stb...
# És a válasznak megfelelő indexek értékét kell csak szummázni...

# Nevek kiszedése (a fejléc kivételével
# Fájlnévvé alakítás, ami *.log lesz, hogy a nevek.txt listával ne ütközzön!
cat bemenet.csv | tail -n+2 | cut -d"," -f1 | sed 's/^.*$/&.log/g' | sed 's/ /_/g' > nevek.txt

# Végig megyünk a nevek listáján
# És közben a megfelelő sort belerakjuk megfelelő fájlba, de csak a pontokat!
i=2
while read; do

cat bemenet.csv | tail -n+$i | head -n1 | cut -d"," -f2- > $REPLY

i=$((i+1))
done < nevek.txt

# Csak a log fájlokat dolgozzuk fel, a névlistát meg az eredeti fájlt nem!
# Beolvassuk a fix Referenciát! És "bool"-lal jelöljük a jó válaszokat az a,b,c,d tömb megfelelő indexében.
# Ehhez a mezőelválasztót ideiglenesen átírjuk vesszőre, hogy ne kelljen tördelni a sorokat manuálisan.
ls *.log | awk 'BEGIN {
	p = "Referencia.log"
	FS=","
	while((getline < p)>0) { # Fájl megnyitása, soronkénti olvasása
		for (i=1; i<=NF;i++)
		{
		  a[i]=0
		  b[i]=0
		  c[i]=0
		  d[i]=0
		  if (length($i)>0) { # Karakterenként megyünk végig! lásd. Awk manual...
			split($i, chars, "")
			for (j=1; j <= length($i); j++){
				if (chars[j] == "a") a[i]=1
				if (chars[j] == "b") b[i]=1
				if (chars[j] == "c") c[i]=1
				if (chars[j] == "d") d[i]=1
			}
		  }
		}
    }
    close(p);	
    FS=" "  # Visszaállítjuk a mezőelválasztót, hogy ne legyen baj. 
} 
{	FS=","  # Inicializálunk
	p = $0 # Ez lesz a fájlnév, mert azt adtuk be az AWK-nak
	nev=$0 # A névből képeztük a fájlnevet. Most ennyi elég is
	pontok=0
	while((getline < p)>0) { # Fájl megnyitása, soronkénti olvasása
		for (i=1; i<=NF;i++)
		{
		  if (length($i)>0) {
			split($i, chars, "")  # A bool értékek alapján kiszámoljuk a pontokat. Lehetne sokkal szebben is...
			for (j=1; j <= length($i); j++){
			if (chars[j] == "a" && a[i]==1) pontok=pontok+2
			if (chars[j] == "a" && a[i]==0) pontok--
			if (chars[j] == "b" && b[i]==1) pontok=pontok+2
			if (chars[j] == "b" && b[i]==0) pontok--
			if (chars[j] == "c" && c[i]==1) pontok=pontok+2
			if (chars[j] == "c" && a[i]==0) pontok--
			if (chars[j] == "d" && d[i]==1) pontok=pontok+2
			if (chars[j] == "d" && d[i]==0) pontok--
			}
		  }
		}
    }
    close(p);
	printf("%s: %d\n",nev, pontok)  # Kiírjuk, nem számít, hogyan majd finomítunk
	FS=" "
}' | sed -e 's/\.log//g' -e 's/_/ /g' # Visszaalakítjuk a fájlnevet névvé, mert ez is csak egy csővezeték...
rm *.log nevek.txt # Ideiglenes fájlokat törörüljük
