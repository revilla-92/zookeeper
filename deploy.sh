#!/bin/sh
# Salir del script si alguna de las ejecuciones falla.
set -e

# ======================================================================================================================================
# Parametros por defecto
# ======================================================================================================================================

# Parámetro que indica el directorio en que se va a trabajar.
WORKING_DIRECTORY=/tmp/CNVR
# Activar o desactivar modo debug (true o false).
DEFAULT_DEBUG=false

# ======================================================================================================================================
# Funciones
# ======================================================================================================================================

# Imprimir '=' hasta el final de la linea.
line () {
	for i in $(seq 1 $(stty size | cut -d' ' -f2)); do 
		echo -n "="
	done
	echo ""
}

# Imprime ayuda por pantalla.
print_help () {
	echo "Parámetros:"
	echo ""
	echo "   --id=n:    asigna ID del equipo dentro del sistema distribuido. Obligatorio."
	echo "   --debug:   activa o desactiva el modo debug. Por defecto: desactivado."
	echo ""
	echo "Requisitos:"
	echo ""
	echo "   - Archivo conf/localhost_zoo.cfg con la configuración de cada host."
	echo "   - Archivo conf/hosts.properties con la configuración de los tres hosts."
	echo ""
	echo "Ejemplos:"
	echo ""
	echo "   ./zookeeper.sh --id=1"
	echo "   ./zookeeper.sh --id=1 --debug"
}

# Sale del script con un codigo de error y un mensaje en consola.
err () {
	print_help
	exit 1
}

# ======================================================================================================================================
# Lectura de parametros configurables
# ======================================================================================================================================

# Parametros pasados por consola con nombre concreto
while [ $# -gt 0 ]; do
	case "$1" in
		--id=*)
			MY_ID="${1#*=}"
			;;
		--debug)
			DEBUG=true
			;;
		*)
			err
	esac
	shift
done

# Salir si no se ha pasado como parametro la ID del equipo dentro del sistema distribuido.
if [ ${#MY_ID} -lt 1 ]; then
	err
fi

# Valores por defecto para las variables.
if [ ${#DEBUG} -lt 1 ]; then
	DEBUG=$DEFAULT_DEBUG
fi

# Variables que almacenan el contenido de las directivas a pasarle al Java.
if $DEBUG; then
	DEBUG_DIRECTIVE="--debug"
	echo "Modo debug activado"
fi

# ======================================================================================================================================
# Main
# ======================================================================================================================================

# Crear directorio de trabajo, y directorio de datos de Zookeeper para este host.
mkdir -p $WORKING_DIRECTORY
mkdir -p $WORKING_DIRECTORY/z1

# Borrar bases de datos previas si existen.
if [ -d $WORKING_DIRECTORY/dbs ]; then
	rm -r $WORKING_DIRECTORY/dbs
fi
mkdir $WORKING_DIRECTORY/dbs

# Extraer tar.gz en el directorio zookeeper, si no existe ya.
if [ ! -d $WORKING_DIRECTORY/zookeeper-3.4.10 ]; then
	tar -zxvf ./zk/zookeeper-3.4.10.tar.gz -C $WORKING_DIRECTORY
fi

# Copiar configuración al directorio de configuración de Zookeeper.
cp ./conf/localhost_zoo.cfg $WORKING_DIRECTORY/zookeeper-3.4.10/conf

# Leer propiedades de conf/hosts.properties.
. ./conf/hosts.properties

# Modificar directorio de datos en archivos de configuración mediante sed.
find $WORKING_DIRECTORY -wholename $WORKING_DIRECTORY/zookeeper-3.4.10/conf/localhost_zoo.cfg -type f -exec sed -i s#"WORKING_DIRECTORY"#"$WORKING_DIRECTORY"#g {} +
find $WORKING_DIRECTORY -wholename $WORKING_DIRECTORY/zookeeper-3.4.10/conf/localhost_zoo.cfg -type f -exec sed -i s#"HOST1"#"$HOST1_IP"#g {} +
find $WORKING_DIRECTORY -wholename $WORKING_DIRECTORY/zookeeper-3.4.10/conf/localhost_zoo.cfg -type f -exec sed -i s#"HOST2"#"$HOST2_IP"#g {} +
find $WORKING_DIRECTORY -wholename $WORKING_DIRECTORY/zookeeper-3.4.10/conf/localhost_zoo.cfg -type f -exec sed -i s#"HOST3"#"$HOST3_IP"#g {} +

# Crear archivos de descripción de los hosts en el directorio de datos.
echo $MY_ID > $WORKING_DIRECTORY/z1/myid

# Conceder permisos de ejecución a los binarios de Zookeeper, y de escritura al usuario root.
chmod 755 $WORKING_DIRECTORY/zookeeper-3.4.10/bin/*.sh

# ======================================================================================================================================
# Copiar claves publicas de los participantes a ~/.ssh/authorized_keys
# ======================================================================================================================================

# Eliminar antiguo authorized_keys
if [ -f ~/.ssh/authorized_keys ]; then
	rm ~/.ssh/authorized_keys
fi
# Copiar authorized_keys
cp ./conf/authorized_keys ~/.ssh
# Modificar permisos de authorized_keys
chmod 600 ~/.ssh/authorized_keys

# ======================================================================================================================================
# Levantar sistema distribuido
# ======================================================================================================================================

# Si nos encontramos en los ordenadores del laboratorio necesitamos realizar esta acción antes.
line
echo "Si se ejecuta desde un PC del laboratorio ejecutar antes:"
echo " ln -sf /opt/Oracle/jdk1.8 java_home"
ln -sf /opt/Oracle/jdk1.8 java_home

# Arrancar los servidores que conformarán el entorno zookeeper.
line
echo "Arrancando el servidor $MY_ID"
$WORKING_DIRECTORY/zookeeper-3.4.10/bin/zkServer.sh start $WORKING_DIRECTORY/zookeeper-3.4.10/conf/localhost_zoo.cfg

# Verificamos el estado de los servidores del entorno Zookeeper.
line
echo "El estado del servidor $MY_ID de Zookeeper:"
$WORKING_DIRECTORY/zookeeper-3.4.10/bin/zkServer.sh status $WORKING_DIRECTORY/zookeeper-3.4.10/conf/localhost_zoo.cfg

# Lanzar mensajes en consola con instrucciones de ejecución en varias terminales.
line
echo "Ejecutar los siguientes comandos para acceder a la CLI (Command Line Interface) de este servidor del conjunto Zookeeper:"
echo " $WORKING_DIRECTORY/zookeeper-3.4.10/bin/zkCli.sh -server localhost:2181"
line

# ======================================================================================================================================
# Levantar procesos
# ======================================================================================================================================

# Cambiamos al directorio donde se encuentra el programa y lo ejecutamos.
cd $WORKING_DIRECTORY

# Arrancamos
echo "Ejecutar el siguiente comando para levantar el servidor del sistema distribuido."
echo " xterm -hold -e \"export CLASSPATH=\$CLASSPATH:$PWD/pfinal.jar:$PWD/lib/* && java -Djava.net.preferIPv4Stack=true es.upm.dit.cnvr.pfinal.MainBank $DEBUG_DIRECTIVE --size=3\" &"
