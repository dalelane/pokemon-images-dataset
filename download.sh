#!/bin/sh

set -e

echo "downloading images"
while read line
do
  POKEMON=$(echo "${line%,*}" | tr -dc '[[:print:]]')
  TYPE=$(echo "${line#*,}" | tr -dc '[[:print:]]')

  mkdir -p "images/$TYPE"
  curl --silent -o "images/$TYPE/$POKEMON.jpg" "https://img.pokemondb.net/artwork/$POKEMON.jpg"
done < pokemon-names.csv

echo "resizing images"
for type in images/*/
do
  echo "$type"
  mogrify -resize 224x224\> "$type/*.jpg"
done
