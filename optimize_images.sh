#!/bin/bash

# Определение путей к папкам
jpg_folder="images/jpg"
webp_folder="images/webp"

# Создание папок
mkdir -p "$jpg_folder"
mkdir -p "$webp_folder"

# Общие параметры обработки изображений
quality=60
resize_large=1200
resize_small=600

echo '<picture>' > picture.html

for file in *.*; do
    # Исключаем файлы с расширением svg
    if [[ "$file" == *.svg || !("$file" =~ \.(jpg|jpeg|png)$) ]]; then
        continue
    fi

    filename="${file%.*}"
    extension="${file##*.}"
    resolution=$(magick identify -format "%w" "$file")

    # Преобразование PNG и JPEG в JPG
    if [[ "$extension" == "png" || "$extension" == "jpeg" || "$extension" == "jpg" ]]; then
        magick convert "$file" -background white -alpha remove -resize $resize_large -quality $quality "$jpg_folder/$filename.jpg"
    fi

    # Создание WebP для изображений
    magick convert "$file" -resize $resize_large -quality $quality "$webp_folder/$filename"_1200px.webp
    magick convert "$file" -resize $resize_small -quality $quality "$webp_folder/$filename"_600px.webp
done

# Добавление элементов <source> и <img> в HTML
echo '  <source media="(max-width: 767.97px)" srcset="'$webp_folder'/01_600px.webp">' >> picture.html
echo '  <source media="(min-width: 767.98px)" srcset="'$webp_folder'/01_1200px.webp">' >> picture.html
echo '  <img src="'$jpg_folder'/01.jpg" alt="Your Image Description">' >> picture.html

echo '</picture>' >> picture.html

# Вывод текстового арта
echo -e '\033[1;32m████─████─█───█─████─█───███─███─███\033[0m'
echo -e '\033[1;32m█──█─█──█─██─██─█──█─█───█────█──█──\033[0m'
echo -e '\033[1;32m█────█──█─█─█─█─████─█───███──█──███\033[0m'
echo -e '\033[1;32m█──█─█──█─█───█─█────█───█────█──█──\033[0m'
echo -e '\033[1;32m████─████─█───█─█────███─███──█──███\033[0m'
