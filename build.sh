clear
# thank you and goodbye
rm out/app.js
rm out/youtube.js
rm out/index.html

# build elm
elm make --debug src/Main.elm --output out/app.js

# copy javascript
cp src/youtube.js out/

# copy html
cp src/index.html out/

