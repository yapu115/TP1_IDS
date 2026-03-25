#!/bin/bash

if [ "$1" == "-d" ]; then
  echo "Eliminando el entorno de EPNro1..."

  rm -rf "$HOME/TP1_IDS/EPNro1"

  pkill -f "consolidar.sh"
  echo "Entorno eliminado y procesos finalizados"
  
fi

opcion=0

ARCHIVO_SALIDA="$HOME/TP1_IDS/EPNro1/salida/$FILENAME.txt"

while [ $opcion -ne 6 ]; do

clear

echo "----------------------"
echo "    MENÚ PRINCIPAL     "
echo "----------------------"
echo "1. Crear entorno"
echo "2. Correr proceso"
echo "3. Mostrar listado de alumnos"
echo "4. Mostrar las 10 notas más altas"
echo "5. Mostrar datos del alumno"
echo "6. Salir"
echo "---------------------"
echo ""

read opcion

case $opcion in

	1)
	  if [ ! -d  "$HOME/TP1_IDS/EPNro1" ]; then
	    echo "Creando entorno..."
	    mkdir EPNro1
	    mkdir EPNro1/entrada
	    mkdir EPNro1/salida
	    mkdir EPNro1/procesado
	    cat ejemplo.txt >> EPNro1/entrada/ejemplo.txt
	    cat ejemplo2.txt >> EPNro1/entrada/ejemplo2.txt
	    cp "$HOME/TP1_IDS/consolidar.sh" "$HOME/TP1_IDS/EPNro1/"
	    echo "Entorno creado."
	  else
	    echo "Entorno ya creado"
	  fi
	  read -p "Presione [Enter] para continuar"
	  ;;

	2)
	  if [ -d "$HOME/TP1_IDS/EPNro1" ]; then
	    echo "Corriendo proceso..."
	    echo ""
	    bash EPNro1/consolidar.sh &
	  else
	    echo "Primero debe crear el entorno"
	  fi
	  read -p "Presione [Enter] para continuar"
	  ;;

	3)
	  if [ -f "$ARCHIVO_SALIDA" ]; then
	    echo "Mostrando lista de alumnos..."
	    echo ""
	    echo "------------------------------------"
	    sort -k1 -n "$ARCHIVO_SALIDA"
	    echo "------------------------------------"
	    echo ""
	  else
	    echo "El archivo $FILENAME.txt aún no existe en la carpeta salida"
	  fi
	  read -p "Presione [Enter] para continuar"
	  ;;

	4)
	  if [ -f "$ARCHIVO_SALIDA" ]; then
	    echo "Mostrando las 10 notas más altas..."
	    echo ""
	    echo "------------------------------------"
	    sort -k5 -nr "$ARCHIVO_SALIDA" | head -n 10
	    echo "------------------------------------"
	    echo ""
	  else
	    echo "El archivo $FILENAME.txt aún no existe en la carpeta salida"
	  fi
	  read -p "Presione [Enter] para continuar"
	  ;;

	5)
	  if [ -f "$ARCHIVO_SALIDA" ]; then

	    echo -n "Ingrese el número de padrón a buscar: "
	    read padron
	    echo ""
	    echo "------------------------------------"

	    resultado=$(grep "^$padron" "$ARCHIVO_SALIDA")

	    if [ $? -ne 0 ]; then
	      echo "No se encontró ningún alumno con el padrón $padron"
	    else
	      echo "Datos del alumno encontrado"
	      echo "$resultado"
	    fi
	    echo "------------------------------------"
	    echo ""
	  else
	    echo "El archivo $FILENAME.txt aún no existe en la carpeta salida"
	  fi
	  read -p "Presione [Enter] para continuar"
	  ;;

	6)
	  echo "Saliendo del sistema"
	  exit 0
	  ;;

	*)
	  echo "Opción inválida"
	  read -p "Presione [Enter] para continuar"
	  ;;

esac

done
