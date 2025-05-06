#!/bin/sh
OUTPUT_FILE="src/pages/sinai-pics.html"
IMAGE_DIR="src/pics"

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
	<link rel="stylesheet" href="../styles/sinai-pics.css">
</head>
<body>
	<header>
		<div class="header_container">
			<a href="../../index.html">
				<u>OLDTEAMHOST</u>
			</a>
			<a href="https://github.com/oldteamhost">
				.github
			</a>
			<a href="https://t.me/+Ft1ABe8P8Tc1YzZi">
				.telegram
			</a>
			<a href="https://github.com/oldteamhost/nesca4">
				.nesca4
			</a>
		</div>
	</header>
	<div class="container">
		<ul>
EOF

for img in "$IMAGE_DIR"/comp_*.{jpg,jpeg}; do
  [ -e "$img" ] || continue
  filename=$(basename "$img")
  echo "			<li><a href=\"../../$IMAGE_DIR/$filename\"><img src=\"../../$IMAGE_DIR/$filename\" alt=\"$filename\"></a></li>" >> "$OUTPUT_FILE"
done

cat >> "$OUTPUT_FILE" <<EOF
		</ul>
	</div>
	<footer>
		<div class="copyright">
			Copyright &copy; 2025, OldTeam.
			<br><br>
			Если вы не хотите видить здесь какое-то изоображение, то можете написать администратору. Если хотите добавить изоображение, (1) необходимо
			закинуть его в папку src/pics (только .jpg/.jpeg); после этого необходимо (2) запустить скрипт genpics.sh (для успешного запуска
			скрипта нужен jpegoptim). Ну и (3) кинуть модный GET PUll.
		</div>
	</footer>
</body>
</html>
EOF
