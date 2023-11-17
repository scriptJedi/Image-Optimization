#!/bin/bash

# Определение путей к папкам
jpg_png_folder="optimize_img/jpg_png"
webp_folder="optimize_img/webp"

# Создание папок
mkdir -p "$jpg_png_folder"
mkdir -p "$webp_folder"

for file in *.*
do
    # Исключаем файлы с расширением svg
    if [[ "$file" == *.svg ]]; then
        continue
    fi

    filename="${file%.*}"
    extension="${file##*.}"
    resolution=$(magick identify -format "%w" "$file")

    if [[ "$extension" == "jpg" || "$extension" == "jpeg" ]]; then
        # Если файл JPEG и разрешение больше 600, то resize, иначе только quality
        if ((resolution > 600)); then
            magick convert "$file" -resize 600 -quality 50 "$jpg_png_folder/$filename.jpg"
        else
            magick convert "$file" -quality 50 "$jpg_png_folder/$filename.jpg"
        fi
    elif [[ "$extension" == "png" ]]; then
        # Если файл PNG и разрешение больше 600, то resize, иначе только quality
        if ((resolution > 600)); then
            magick convert "$file" -resize 600 -quality 50 "$jpg_png_folder/$filename.png"
        else
            magick convert "$file" -quality 50 "$jpg_png_folder/$filename.png"
        fi
    else
        # В остальных случаях сохраняем как JPG
        magick convert "$file" -resize 600 -quality 50 "$jpg_png_folder/$filename.jpg"
    fi

    magick convert "$file" -resize 600 -quality 50 "$webp_folder/$filename"_600px.webp
    magick convert "$file" -resize 300 -quality 50 "$webp_folder/$filename"_300px.webp
done

echo '<picture>' > picture.html

echo '  <source media="(max-width: 767.97px)" srcset="'$webp_folder'/01_300px.webp">' >> picture.html
echo '  <source media="(min-width: 767.98px)" srcset="'$webp_folder'/01_600px.webp">' >> picture.html
echo '  <img src="'$jpg_png_folder'/01.jpg" alt="Your Image Description">' >> picture.html

echo '</picture>' >> picture.html

echo "Complete!"
