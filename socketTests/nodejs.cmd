haxe -main Main -js bin/main.js -lib nodejs -cp src -cp .. -debug -D analyzer -dce full
set NODE_PATH=%USERPROFILE%\node_modules
cd bin
node main.js
pause