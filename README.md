Xperia L Rootkit for Linux
==========================

Bash script untuk _rooting_ ponsel Xperia L

## Penggunaan:

```
shell@linux:~> chmod u+x install.sh
shell@linux:~> ./install.sh
```

Tunggu sampai semua proses selesai, ponsel akan _reboot_. Setelah _reboot_, periksa apakah proses _rooting_ berhasil atau gagal dengan cara:

### Terminal Linux
``` 
shell@linux:~> ./adb_linux shell
shell@android:/ $ su
root@android:/ # whoami
root
```

### Android Terminal Emulator
![ATE](http://bintang1992.files.wordpress.com/2014/01/screenshot_2014-01-03-09-43-221.png)

Jika keluaran pada terminal seperti di atas berarti ponsel anda berhasil di-_root_.

Diuji coba pada:

- Linux: openSUSE 12.3 64 bit
- Ponsel: Xperia L C1025
- Android: 4.2.2
- Build number: 15.3.A.1.12
 
## Kontak

Twitter: [@go2n]

Email: [sh dot setyana at gmail dot com]

Blog: [http://sarwo.hadi.setyana.net]

  [@go2n]: http://twitter.com/go2n
  [sh dot setyana at gmail dot com]: mailto:sh.setyana@gmail.com
  [http://sarwo.hadi.setyana.net]: http://sarwo.hadi.setyana.net
 
