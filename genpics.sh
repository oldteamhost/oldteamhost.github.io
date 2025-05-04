#!/bin/sh
OUTPUT_FILE="sinai-pics.html"
IMAGE_DIR="database/sinaitemp"

for img in "$IMAGE_DIR"/*.{jpg,jpeg}; do
  [ -e "$img" ] || continue
  filename=$(basename "$img")
  case "$filename" in
    comp_*) continue ;;
  esac
  comp_file="$IMAGE_DIR/comp_$filename"
  jpegoptim --max=70 --strip-all --all-progressive --dest="$IMAGE_DIR" --overwrite "$img"
  mv "$IMAGE_DIR/$(basename "$img")" "$comp_file"
done

cat > "$OUTPUT_FILE" <<EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>sinai-pics</title>
<style>
h1{color: azure;text-decoration: underline; margin-bottom: 0em;}
    body {
      text-align: center;
      font-family: monospace;
      background-color: #0d0d0d;
      color: Snow;
      margin: 0; /* Убираем отступы у тела страницы */
      padding: 0; /* Убираем внутренние отступы у тела страницы */
    }
    .container {
      max-width: 60%; /* Ограничиваем ширину контейнера */
      margin: 0 auto; /* Центрируем контейнер */
      padding: 20px; /* Добавляем внутренние отступы */
    }
    a { color: gray; text-decoration: underline; }
    a:focus { outline-style: dashed; outline-width: 1px; outline-color: red; }
ul {
  list-style-type: none;
  padding: 0;
  margin: 0;
  display: grid;
  border: 1px solid azure;
  grid-template-columns: repeat(3, 1fr); /* 3 колонки */
}

li {
  margin: 0;
}

img {
  display: block;
  width: 100%;
  height: 200px; /* фиксированная высота */
  object-fit: cover; /* обрезает изображение по размеру блока */
}
  </style>
</head>
<body>
  <h1>sinai-random-pics</h1>
  <div class="container">
  <ul>
EOF

for img in "$IMAGE_DIR"/comp_*.{jpg,jpeg}; do
  [ -e "$img" ] || continue
  filename=$(basename "$img")
  echo "    <li><a href=\"$IMAGE_DIR/$filename\"><img src=\"$IMAGE_DIR/$filename\" alt=\"$filename\"></a></li>" >> "$OUTPUT_FILE"
done

cat >> "$OUTPUT_FILE" <<EOF
    </ul>
  </div>
	<br>
<pre>
Если вы не хотите видить здесь какое-то изоображение, то можете написать администратору. Если хотите добавить изоображение, (1) необходимо
закинуть его в папку /database/sinaitemp (только .jpg/.jpeg); после этого необходимо (2) запустить скрипт genpics.sh (для успешного запуска
скрипта нужен jpegoptim). Ну и (3) кинуть модный GET PUll.
</pre>
<br><br>
</body>
</html>
EOF
