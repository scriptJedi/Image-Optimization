# Image Optimization

## Prerequisites

Before using the script, ensure that ImageMagick is installed. If not, you can install it using Homebrew:

```bash
brew install imagemagick
```

### Usage
1. Place the script in the directory containing your selected images, e.g., /folder_name/.
2. Run the script:

```bash
./optimize_images.sh
```

### Script Output
The script creates a folder named imgs, which contains two subfolders: jpg and webp. Each subfolder includes two versions of images, optimized for mobile (300px) and desktop (1200px).

### HTML Markup
Additionally, the script generates a picture.html file. This file provides a demo markup for implementing responsive images using the <picture> element and <source> tags. Replace the placeholder paths in the HTML file with the actual paths to your optimized images.

```html
<picture>
  <source media="(max-width: 767.98px)" srcset="imgs/webp/01_600px.webp">
  <source media="(min-width: 767.99px)" srcset="imgs/webp/01_1200px.webp">
  <img src="imgs/jpg_png/01.jpg" alt="Your Image Description">
</picture>
```

Ensure to customize the paths accordingly for your project.
