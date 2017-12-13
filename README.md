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

Los datos a configurar de cada uno son su IP para la red que conecta el servidor con el exterior (`enp1s0`, por lo general), y el nombre del usuario (parámetros `HOST${MY_ID}_IP` y `HOST${MY_ID}_USER`, respectivamente). 

Al configurarlo, anota el identificador de host (el número de host configurado, por ejemplo `2` si se ha configurado `HOST2`), que usaremos posteriormente como valor del parámetro `--id` al llamar al script de despliegue.

#### Para obtener la IP del servidor

```sh
ifconfig enp1s0 | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p'
```

Sustituye `enp1s0` por el nombre del interfaz que conecta el servidor con la red externa, si no es esa.

#### Para obtener el nombre de usuario

```sh
whoami
```

### 3. Configura las claves públicas

Configura las claves públicas, que permitirán el intercambio de archivos entre los hosts que forman el sistema distribuido.

Para ello, edita el archivo `conf/authorized_keys` e inserta las claves de los tres usuarios de los hosts.

Si no tienes una clave pública (comprueba mediante `cat ~/.ssh/id_rsa.pub`), genera una mediante:

```sh
ssh-keygen
```

### 4. Despliega el escenario

Despliega el escenario medinte el script `deploy.sh`, que se encuentra en el dierctorio raiz del proyecto, pasando como parámetro el identificador del host actual, y opcionalmente el parámetro `--debug` para activar el *modo debug*, que imprimirá mensajes informativos por consola.

```sh
./deploy.sh --id=${MY_ID}
```

Por ejemplo, si se han configurado los datos del host actual en las variables `HOST1_IP` y `HOST1_USER` de `conf/hosts.properties`:

```sh
./deploy.sh --id=1
```
