# Image Optimization

## Prerequisites

Before using the script, ensure that ImageMagick is installed. If not, you can install it using Homebrew:

```bash
brew install imagemagick
```

### Usage
1. Place the script in the directory containing your selected images, e.g., /used_img/.
2. In the command line, navigate to the script directory and grant execution permissions:

```bash
chmod +x optimize_images.sh
```
3. Run the script:

```bash
./optimize_images.sh
```

### Script Output
The script creates a folder named optimize_img, which contains two subfolders: jpg_png and webp. Each subfolder includes two versions of images, optimized for mobile (300px) and desktop (600px).

### HTML Markup
Additionally, the script generates a picture.html file. This file provides a demo markup for implementing responsive images using the <picture> element and <source> tags. Replace the placeholder paths in the HTML file with the actual paths to your optimized images.

```html
<picture>
  <source media="(max-width: 767.97px)" srcset="optimize_img/webp/01_300px.webp">
  <source media="(min-width: 767.98px)" srcset="optimize_img/webp/01_600px.webp">
  <img src="optimize_img/jpg_png/01.jpg" alt="Your Image Description">
</picture>
```

Ensure to customize the paths accordingly for your project.
