# zookeeper

_Herramienta automatizada para el despliegue de un sistema distribuido Zookeeper escrito en Java_.

## Instrucciones

### 1. Clona el proyecto

Clona el repositorio en tu workspace:

```sh
git clone https://github.com/revilla-92/zookeeper.git && cd zookeeper
```

### 2. Configura los hosts

Modifica el archivo `conf/hosts.properties`, donde puedes configurar los datos de los tres servidores que componen el sistema distribuido.

Los datos a configurar de cada uno son su IP para la red que conecta el servidor con el exterior (`enp1s0`, por lo general), y el nombre del usuario (parametros `HOST${MY_ID}_IP` y `HOST${MY_ID}_USER`, respectivamente). 

Al configurarlo, anota el identificador de host (el numero de host configurado, por ejemplo `2` si se ha configurado `HOST2`), que usaremos posteriormente como valor del parametro `--id` al llamar al script de despliegue.

#### Para obtener la IP del servidor

```sh
ifconfig enp1s0 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'
```

#### Para obtener el nombre de usuario

```sh
whoami
```

### 3. Configura las claves

Configura las claves publcias, que permitiran el inetrcambio de archivos entre los hosts que forman el sistema distribuido.

Para ello, edita el archivo `conf/authorized_keys` e inserta las claves de los tres usuarios de los hosts.

Si no tienes una clave publica (comprueba mediante `cat ~/.ssh/id_rsa.pub`), geenra una mediante:

```sh
ssh-keygen
```

### 4. Despliega el escenario

Despliega el escenario medinte el script `deploy.sh`, que se encuentra en el dierctorio raiz del proyecto, pasando como parametro el identificador del host actual, y opcionalmente el parametro `--debug` para activar el *modo debug*, que imprimira mensajes informativos por consola.

```sh
./deploy.sh --id=${MY_ID}
```

Por ejemplo, si se han configurado los datos del host actual en las variables `HOST1_IP` y `HOST1_USER` de `conf/hosts.properties`:

```sh
./deploy.sh --id=1
```