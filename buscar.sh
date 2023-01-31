#!/bin/sh

#
#function con 3 argumentos que realiza la busqueda
#Nota: se elimina de la sintaxys la palabra function porque el script esta creado
#para ejecutarse con #!/bin/sh, de manera que pueda ejecutarse sin problemas con bash y con sh.
buscar()
{
echo "\t ……….Resultados obtenidos de la busqueda………. \r"
echo " "
#Se redirige la salida output del comando a una variable
salidaOuput=$(find $3 -iname $2 -type $1)
#si la cadena contenida en la variable esta vacia muestra que no se encontraron resultados
if test -z "${salidaOuput}"
then
echo "\t ……….No se encontraron resultados………."
echo " "
echo " "
echo "\t\t ……….Termino la busqueda………. \r"
#sino entonces
else
#redirige la salida output de la variable a un archivo de texto
echo $salidaOuput > busquedaOutput.txt
#Se utiliza un for para leer linea por linea el archivo
#para no utilizar otra vez el comando find $3 -iname $2 -type $1
for linea in $(cat busquedaOutput.txt);
do
echo "$linea" ;
done
#se elimina el archivo
rm -rf busquedaOutput.txt
echo " "
echo "\t\t ……….Termino la busqueda………. \r"
fi
}

echo -n "Introduce el nombre del archivo: "
read archivo
echo -n "Introduce el tipo f(file)/d(directorio/l(enlaces): "
read tipo
echo "Seleccion el path en el que desea realizar la busqueda: "
echo "1 – Home"
echo "2 – Carpeta actual"
echo "3 – Todo el sistema"
echo "4 – Carpeta personalizada"
read opcion
case $opcion in
1)
path=$/data/data/com.termux/files/home
;;
2)
path=$PWD
;;
3)
path=/
;;
4)
echo "Ingrese el path en donde se va a realizar la busqueda: "
read p
path=$p
;;
*)
echo "Seleción erronea…."
echo "Se realizara la busqueda en el path actual"
path=$PWD
;;
esac
#se hace el llamado a la function buscar y se le pasan 3 parametros
buscar $tipo $archivo $path
#fin script de búsqueda
