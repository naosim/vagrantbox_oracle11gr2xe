echo "*****************Install Pachages*****************"
apt-get update
apt-get -y install alien libaio1 unixodbc unzip

echo "*****************Unzip And Convert rpm To deb*****************"
unzip /share/oracle-xe-11.2.0-1.0.x86_64.rpm.zip
alien --to-deb --scripts Disk1/oracle-xe-11.2.0-1.0.x86_64.rpm oracle-xe_11.2.0-2_amd64.deb

echo "*****************Copy chkconfig file*****************"
cp -f /share/chkconfig /sbin/chkconfig
chmod 755 /sbin/chkconfig
ln -s /usr/bin/awk /bin/awk

echo "*****************Install Oracle*****************"
dpkg --install oracle-xe_11.2.0-2_amd64.deb

echo "*****************Copy init files*****************"
cp -f /share/init.ora /u01/app/oracle/product/11.2.0/xe/config/scripts/init.ora
cp -f /share/initXETemp.ora /u01/app/oracle/product/11.2.0/xe/config/scripts/initXETemp.ora

echo "*****************Set oracle password*****************"
/etc/init.d/oracle-xe configure responseFile=/share/xe.rsp >> ora_install.log

echo "*****************Stop Oracle*****************"
service oracle-xe stop

echo "*****************Change Charactor Set*****************"
cp /share/.bash_profile /u01/app/oracle/
chown oracle:dba /u01/app/oracle/.bash_profile
chmod 644 /u01/app/oracle/.bash_profile 
sudo -u oracle -i env /u01/app/oracle/product/11.2.0/xe/bin/createdb.sh -dbchar JA16EUC

echo "*****************Start Oracle*****************"
service oracle-xe start
