# thank you and goodbye
rm out/app.js
rm out/index.html

# build elm
elm make src/Main.elm --output out/app.js

# copy html
cp src/index.html out/
