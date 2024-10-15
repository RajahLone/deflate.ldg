# deflate.ldg

Library using the LDG system and the zlib functions (crc32, deflate and inflate algorithms, etc).

Used by:

* KK Commander to handle PKZIP archives (zip, unzip).
* Troll and Crésus to create backup archives (zip).

Other programs can use it, please read the how-to and functions calls in the st-guide documentation and exemple.

# installation for makefiles

- pre-requisite: different targets of libldg.a in /opt/cross-mint/m68k-atari-mint/lib/

- in an empty folder, 
   ```mkdir ./build/68000```  
   ```mkdir ./build/68020```  
   ```mkdir ./build/ColfFire```  

- get [deflate_r6_src.zip](https://ptonthat.fr/files/deflate/deflate_r6_src.zip) and unpack the contents of /deflate.ldg/ to ./

- deflate.ldg.xcodeproj is for Xcode 16.0, you may not need it if you use something else.
