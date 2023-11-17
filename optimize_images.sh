#!/bin/bash

mkdir -p optimize_img/jpg
mkdir -p optimize_img/webp

for file in *.*
do
    filename="${file%.*}"

    magick convert "$file" -resize 50% optimize_img/jpg/"$filename".jpg

    magick convert "$file" -resize 600 -quality 50 optimize_img/webp/"$filename"_600px.webp
    magick convert "$file" -resize 300 -quality 50 optimize_img/webp/"$filename"_300px.webp
done

echo '<picture>' > picture.html

echo '  <source media="(max-width: 600px)" srcset="01_300px.webp">' >> picture.html
echo '  <source media="(min-width: 601px)" srcset="01_600px.webp">' >> picture.html
echo '  <img src="01.jpg" alt="Your Image Description">' >> picture.html

echo '</picture>' >> picture.html

echo "Complete!"
