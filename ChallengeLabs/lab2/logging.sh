This is not script. Just step sequence.

1. mkdir $HOME/archive $HOME/backup
2. cd /var/log
3. tar -cvf $HOME/archive/log.tar *.log
4. cd $HOME/archive/
5. tar -tf log.tar
6. cd ../backup/
7. tar -xf ../archive/log.tar
8. ls
