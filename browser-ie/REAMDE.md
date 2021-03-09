
##Run a internetexplorer-browser (wined) through vnc to a docker container

#from
https://linuxconfig.org/install-wine-on-ubuntu-20-04-focal-fossa-linux
https://www.linuxquestions.org/questions/mandriva-30/how-to-open-internet-explorer-in-wine-384877/
https://appdb.winehq.org/objectManager.php?sClass=application&iId=25
https://askubuntu.com/questions/1194126/problem-in-installing-internet-explorer-8

#on the container run install i8 and run browser
```
WINEARCH=win32
winecfg
winetricks ie8
wine 'C:\Program Files\Internet Explorer\iexplore'
```
