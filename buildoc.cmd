haxe -cs cs --no-output -xml api/cs.xml --macro include('pony',true,['pony.flash','pony.db','pony.magic','pony.nodejs','pony.midi','pony.net.Protobuf','pony.unity3d','pony.math.Smooth','pony.macro','pony.time']) -lib HUGS -lib traits -D dox -D doc_gen -D WITHOUTUNITY
haxe -swf fl.swf --no-output -xml api/flash.xml --macro include('pony',true,['pony.db','pony.fs','pony.magic','pony.midi','pony.net.Protobuf','pony.nodejs','pony.unity3d','pony.math.Smooth','pony.ui.FocusManager']) -lib mconsole -lib traits -swf-version 11.8 -D doc_gen
haxe -neko n.n --no-output -xml api/neko.xml -cp tests/test -main TestMain -lib mconsole -lib traits -lib munit --macro include('pony',true,['pony.flash','pony.magic','pony.midi','pony.net','pony.nodejs','pony.unity3d','pony.math.Smooth']) -D dox -D doc_gen -lib Continuation
haxe -js js.js --no-output -xml api/nodejs.xml -lib traits --macro include('pony',true,['pony.net.Protobuf','pony.flash','pony.fs','pony.macro','pony.magic','pony.unity3d','pony.math.Smooth','pony.ui.FocusManager']) -D dox -lib nodejs -D doc_gen -lib Continuation
neko RemStar.n api
haxelib run dox -o "C:\data\WeSer\www\Pony\docs" -i api --title Pony -in pony.*