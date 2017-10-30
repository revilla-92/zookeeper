# Creando los directorios de trabajo.
mkdir /tmp/CNVR
mkdir /tmp/CNVR/z1
mkdir /tmp/CNVR/z2
mkdir /tmp/CNVR/z3

# Clonamos el proyecto de GitHub donde tenemos guardado los ficheros necesarios para la configuracion.
cd /tmp/CNVR
git clone https://github.com/revilla-92/zookeeper.git

# Descomprimimos zookeeper
cd zookeeper
tar xvf zookeeper-3.4.10.tar.gz

# Movemos lo anteriormente descargado donde corresponde en los directorio de trabajo.
mv zookeeper-3.4.10 /tmp/CNVR
mv localhost_zoo1.cfg /tmp/CNVR/zookeeper-3.4.10/conf
mv localhost_zoo2.cfg /tmp/CNVR/zookeeper-3.4.10/conf
mv localhost_zoo3.cfg /tmp/CNVR/zookeeper-3.4.10/conf

# Eliminamos el proyecto clonado
cd ..
rm -rf zookeeper

# Creamos el fichero myid
echo 1 > z1/myid
echo 2 > z2/myid
echo 3 > z3/myid

# Exportar variables de entorno
export CLASSPATH=$CLASSPATH:/tmp/CNVR/zookeeper-3.4.10/zookeeper-3.4.10.jar
export CLASSPATH=$CLASSPATH:/tmp/CNVR/zookeeper-3.4.10/lib/*

# Crear acceso directo a Java si no existe (útil en los ordenadores del alboratorio)
ln -sf /opt/Oracle/jdk1.8 java_home

# Cambiar permisos a los shell scripts de Zookeeper
chmod 711 /tmp/CNVR/zookeeper-3.4.10/bin/*.sh

# Movemos el directorio a zookeeper para a continuacion ejecutar los comandos que vienen comentados
cd zookeeper-3.4.10

# Ejecutar Zookeeper en tres terminales distintas, y ver el estado
xterm -hold -e "bin/zkServer.sh start conf/localhost_zoo1.cfg && bin/zkServer.sh status conf/localhost_zoo1.cfg " &
xterm -hold -e "bin/zkServer.sh start conf/localhost_zoo2.cfg && bin/zkServer.sh status conf/localhost_zoo2.cfg" &
xterm -hold -e "bin/zkServer.sh start conf/localhost_zoo3.cfg && bin/zkServer.sh status conf/localhost_zoo3.cfg" &

# Con sus respectivos CLI (Command Line Interface):
# bin/zkCli.sh -server localhost:2181
# bin/zkCli.sh -server localhost:2182
# bin/zkCli.sh -server localhost:2183
