#!/bin/bash
# Salir del script si alguna de las ejecuciones falla.
set -e

# Parametro del numero de servidores que se levantaran al ejecutar el comando por defecto.
SIZE=3

# Comprobamos si se han pasado parametros para en vez de levantar el numero por defecto de servidores levantar el pasado como parametro.
if [ $1 = "-size" ] && [[ $2 =~ ^-?[0-9]+$ ]]; then
	SIZE=$2
fi

# Mensaje informativo sobre el numero de servidores que se levantaran.
echo "El numero de servidores que se levantaran es: $SIZE"

# Parámetro que indica el directorio en que se va a trabajar.
WORKING_DIRECTORY=/tmp/CNVR

# Eliminar directorio de trabajo si existe
if [ -d "$WORKING_DIRECTORY" ]; then
    rm -r $WORKING_DIRECTORY
fi

# Crear directorio de trabajo, y directorio de datos de Zookeeper para cada host.
mkdir $WORKING_DIRECTORY
mkdir $WORKING_DIRECTORY/z1
mkdir $WORKING_DIRECTORY/z2
mkdir $WORKING_DIRECTORY/z3

# Clonar código desplegado en GitHub y mover al directorio.
cd $WORKING_DIRECTORY
git clone https://github.com/revilla-92/zookeeper.git

# Extraer tar.gz en el directorio zookeeper.
cd zookeeper
tar xvf zookeeper-3.4.10.tar.gz

# Modificar directorio de datos en archivos de configuración mediante sed.
find . -wholename ./localhost_zoo1.cfg -type f -exec sed -i s#"/tmp/CNVR"#"$WORKING_DIRECTORY"#g {} +
find . -wholename ./localhost_zoo2.cfg -type f -exec sed -i s#"/tmp/CNVR"#"$WORKING_DIRECTORY"#g {} +
find . -wholename ./localhost_zoo3.cfg -type f -exec sed -i s#"/tmp/CNVR"#"$WORKING_DIRECTORY"#g {} +

# Copiar los archivos de configuración, una vez modificados.
mv lib $WORKING_DIRECTORY
mv pfinal.jar $WORKING_DIRECTORY
mv zookeeper-3.4.10 $WORKING_DIRECTORY
mv localhost_zoo1.cfg $WORKING_DIRECTORY/zookeeper-3.4.10/conf
mv localhost_zoo2.cfg $WORKING_DIRECTORY/zookeeper-3.4.10/conf
mv localhost_zoo3.cfg $WORKING_DIRECTORY/zookeeper-3.4.10/conf

# Eliminar directorio zookeeper.
cd ..
rm -rf zookeeper

# Crear archivos de descripción de los hosts en el directorio de datos.
echo 1 > z1/myid
echo 2 > z2/myid
echo 3 > z3/myid

# Cambiar al directorio de zookeeper.
cd zookeeper-3.4.10

# Exportar classpath.
export CLASSPATH=$CLASSPATH:$WORKING_DIRECTORY/pfinal.jar:$CLASSPATH:$WORKING_DIRECTORY/lib/*

# Conceder permisos de ejecución a los binarios de Zookeeper, y de escritura al usuario root.
chmod 755 $WORKING_DIRECTORY/zookeeper-3.4.10/bin/*.sh

# Si nos encontramos en los ordenadores del laboratorio necesitamos realizar esta acción antes.
echo ""
echo "==========================================================="
echo "Si se ejecuta desde un PC del laboratorio ejecutar antes:"
echo " ln -sf /opt/Oracle/jdk1.8 java_home"
echo "==========================================================="
echo ""

# Arrancar los servidores que conformarán el entorno zookeeper.
echo ""
echo "==========================================================="
echo "Arrancando los servidores que conforman el conjunto Zookeeper:"
$WORKING_DIRECTORY/zookeeper-3.4.10/bin/zkServer.sh start $WORKING_DIRECTORY/zookeeper-3.4.10/conf/localhost_zoo1.cfg
$WORKING_DIRECTORY/zookeeper-3.4.10/bin/zkServer.sh start $WORKING_DIRECTORY/zookeeper-3.4.10/conf/localhost_zoo2.cfg
$WORKING_DIRECTORY/zookeeper-3.4.10/bin/zkServer.sh start $WORKING_DIRECTORY/zookeeper-3.4.10/conf/localhost_zoo3.cfg
echo "==========================================================="
echo ""

# Verificamos el estado de los servidores del entorno Zookeeper.
echo ""
echo "==========================================================="
echo "El estado del servidor 1 de Zookeeper:"
$WORKING_DIRECTORY/zookeeper-3.4.10/bin/zkServer.sh status $WORKING_DIRECTORY/zookeeper-3.4.10/conf/localhost_zoo1.cfg
echo ""
echo "El estado del servidor 2 de Zookeeper:"
$WORKING_DIRECTORY/zookeeper-3.4.10/bin/zkServer.sh status $WORKING_DIRECTORY/zookeeper-3.4.10/conf/localhost_zoo2.cfg
echo ""
echo "El estado del servidor 3 de Zookeeper:"
$WORKING_DIRECTORY/zookeeper-3.4.10/bin/zkServer.sh status $WORKING_DIRECTORY/zookeeper-3.4.10/conf/localhost_zoo3.cfg
echo "==========================================================="
echo ""

# Lanzar mensajes en consola con instrucciones de ejecución en varias terminales.
echo ""
echo "==========================================================="
echo "Ejecutar los siguientes comandos para acceder a la CLI (Command Line Interface) de cada uno de los servidores del conjunto Zookeeper:"
echo " $WORKING_DIRECTORY/zookeeper-3.4.10/bin/zkCli.sh -server localhost:2181"
echo " $WORKING_DIRECTORY/zookeeper-3.4.10/bin/zkCli.sh -server localhost:2182"
echo " $WORKING_DIRECTORY/zookeeper-3.4.10/bin/zkCli.sh -server localhost:2183"
echo "==========================================================="

# Cambiamos al directorio donde se encuentra el programa y lo ejecutamos
cd $WORKING_DIRECTORY

# Levantamos tantos servidores como indicados en el parametro o los de por defecto.
for ((n=0;n<$SIZE;n++));
do
	xterm -hold -e "java -Djava.net.preferIPv4Stack=true es.upm.dit.cnvr.pfinal.MainBank --debug -size $SIZE" &
done