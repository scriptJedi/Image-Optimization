#!/bin/bash

# Определение путей к папкам
jpg_png_folder="imgs/jpg_png"
webp_folder="imgs/webp"

# Создание папок
mkdir -p "$jpg_png_folder"
mkdir -p "$webp_folder"

# Общие параметры обработки изображений
quality=50
resize_large=1200
resize_small=300

echo '<picture>' > picture.html

for file in *.*; 
do
    # Исключаем файлы с расширением svg
    if [[ "$file" == *.svg || ( "$file" != *.jpg && "$file" != *.jpeg && "$file" != *.png ) ]]; then
        continue
    fi

    filename="${file%.*}"
    extension="${file##*.}"
    resolution=$(magick identify -format "%w" "$file")

    if [[ "$extension" == "jpg" || "$extension" == "jpeg" ]]; then
        # Если файл JPEG и разрешение больше 1200, то resize, иначе только quality
        if ((resolution > 1200)); then
            magick convert "$file" -resize $resize_large -quality $quality "$jpg_png_folder/$filename.jpg"
        else
            magick convert "$file" -quality $quality "$jpg_png_folder/$filename.jpg"
        fi
    elif [[ "$extension" == "png" ]]; then
        # Если файл PNG и разрешение больше 1200, то resize, иначе только quality
        if ((resolution > 1200)); then
            magick convert "$file" -resize $resize_large -quality $quality "$jpg_png_folder/$filename.png"
        else
            magick convert "$file" -quality $quality "$jpg_png_folder/$filename.png"
        fi
    else
        # В остальных случаях сохраняем как JPG
        magick convert "$file" -resize $resize_large -quality $quality "$jpg_png_folder/$filename.jpg"
    fi

    magick convert "$file" -resize $resize_large -quality $quality "$webp_folder/$filename"_1200px.webp
    magick convert "$file" -resize $resize_small -quality $quality "$webp_folder/$filename"_300px.webp
done

echo '  <source media="(max-width: 767.97px)" srcset="'$webp_folder'/01_300px.webp">' >> picture.html
echo '  <source media="(min-width: 767.98px)" srcset="'$webp_folder'/01_1200px.webp">' >> picture.html
echo '  <img src="'$jpg_png_folder'/01.jpg" alt="Your Image Description">' >> picture.html

echo '</picture>' >> picture.html

echo -e '\033[1;32m████─████─█───█─████─█───███─███─███\033[0m'
echo -e '\033[1;32m█──█─█──█─██─██─█──█─█───█────█──█──\033[0m'
echo -e '\033[1;32m█────█──█─█─█─█─████─█───███──█──███\033[0m'
echo -e '\033[1;32m█──█─█──█─█───█─█────█───█────█──█──\033[0m'
echo -e '\033[1;32m████─████─█───█─█────███─███──█──███\033[0m'
