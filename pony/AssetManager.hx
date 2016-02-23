/**
* Copyright (c) 2012-2016 Alexander Gordeyko <axgord@gmail.com>. All rights reserved.
*
* Redistribution and use in source and binary forms, with or without modification, are
* permitted provided that the following conditions are met:
*
*   1. Redistributions of source code must retain the above copyright notice, this list of
*      conditions and the following disclaimer.
*
*   2. Redistributions in binary form must reproduce the above copyright notice, this list
*      of conditions and the following disclaimer in the documentation and/or other materials
*      provided with the distribution.
*
* THIS SOFTWARE IS PROVIDED BY ALEXANDER GORDEYKO ``AS IS'' AND ANY EXPRESS OR IMPLIED
* WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
* FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL ALEXANDER GORDEYKO OR
* CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
* CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
* SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
* ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
* NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
* ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*
* The views and conclusions contained in the software and documentation are those of the
* authors and should not be interpreted as representing official policies, either expressed
* or implied, of Alexander Gordeyko <axgord@gmail.com>.
**/
package pony;

import haxe.rtti.Meta;
#if pixijs
import pony.pixi.PixiAssets;
#end
import pony.time.DeltaTime;
using Lambda;

/**
 * AssetManager
 * @author AxGord <axgord@gmail.com>
 */
class AssetManager {

	private static var loadedAssets:Array<String> = [];
	private static var globalLoad:Map<String, Array<Void->Void>> = new Map();
	
	public static dynamic function monitor(current:Int, total:Int):Void {}
	
	public static function loadPack(pathes:Array<String>, assets:Array<String>, cb:Int->Int->Void):Void {
		if (assets.length == 0) {
			cb(0, 0);
			return;
		}
		if (pathes.length == 0) {
			loadPath(assets, cb);
			return;
		} else if (pathes.length == 1) {
			loadPath([for (a in assets) pathes[0] + '/' + a], cb);
			return;
		}
		var total = pathes.length * assets.length;
		var loaded:Array<Int> = [];
		var i = 0;
		function update() {
			var s = 0;
			for (l in loaded) s += l;
			cb(s, total);
		}
		var called:Bool = false;
		for (path in pathes) {
			loaded.push(0);
			var n = i++;
			loadPath(path + '/', assets, function(a:Int, _) {
				if (a == 0) return;
				loaded[n] = a;
				update();
				called = true;
			});
		}
		if (!called) cb(0, total);
	}
	
	public static function loadPath(path:String='', assets:Array<String>, cb:Int->Int->Void):Void {
		var i = 0;
		var l = assets.length;
		for (asset in assets) {
			load(path+asset, function() cb(++i, l));
		}
		if (i == 0) cb(0, l);
	}
	
	public static function load(asset:String, cb:Void->Void):Void {
		if (loadedAssets.indexOf(asset) != -1) {
			cb();
			return;
		}
		if (globalLoad.exists(asset)) {
			globalLoad[asset].push(cb);
		} else {
			globalLoad[asset] = [];
			_load(asset, function() {
				cb();
				globalLoaded(asset);
			});
		}
	}
	
	private static function globalLoaded(asset:String):Void {
		loadedAssets.push(asset);
		for (f in globalLoad[asset]) f();
		globalLoad[asset] = null;
		monitor(loadedAssets.length, globalLoad.count());
	}
	
	public static function backLoad(asset:String):Void {
		if (loadedAssets.indexOf(asset) != -1) return;
		if (!globalLoad.exists(asset)) {
			globalLoad[asset] = [];
			_load(asset, globalLoaded.bind(asset));
		}
	}
	
	public static function loadPackWithChilds(cl:String, pathes:Array<String>, assets:Array<String>, cb:Int->Int->Void):Void {
		var chs = Meta.getType(Type.resolveClass(cl)).assets_childs;
		if (chs == null) {
			loadPack(pathes, assets, cb);
			return;
		}
		var p = cbjoin(cb);
		loadPack(pathes, assets, p.a);
		loadChildPack(chs, p.b);
	}
	
	private static function loadChildPack(chs:Array<Dynamic>, cb:Int->Int->Void):Void {
		var f = cb;
		for (i in 0...(chs.length-1)) {
			var p = cbjoin(f);
			f = p.a;
			var s = Type.resolveClass(chs[i]);
			Reflect.getProperty(s, 'loadAllAssets')(true, p.b);
		}
		var s = Type.resolveClass(chs[chs.length - 1]);
		Reflect.getProperty(s, 'loadAllAssets')(true, f);
	}

	private static function cbjoin(cb:Int->Int->Void):Pair<Int->Int->Void, Int->Int->Void> {
		var aCurrent:Int = 0;
		var aTotal:Int = 0;
		var bCurrent:Int = 0;
		var bTotal:Int = 0;
		function a(c:Int, t:Int) {
			aCurrent = c;
			aTotal = t;
			cb(bCurrent+c, bTotal+t);
		}
		function b(c:Int, t:Int) {
			bCurrent = c;
			bTotal = t;
			cb(aCurrent+c, aTotal+t);
		}
		return new Pair(a, b);
	}
	
	public static function loadComplete(source:(Int->Int->Void)->Void, cb:Void->Void):Void {
		var last:Bool = true;
		var check = function(c:Int, t:Int) last = c == t;
		source(function(c:Int, t:Int) check(c, t));
		DeltaTime.fixedUpdate < function() {
			if (last) cb();
			else check = function(c:Int, t:Int) if (c == t) cb();
		}
	}
	
	#if pixijs
	@:extern inline public static function _load(asset:String, cb:Void->Void):Void PixiAssets.load(asset, cb);
	@:extern inline public static function image(asset:String, name:String) return PixiAssets.image(asset, name);
	#else
	@:extern inline public static function _load(asset:String, cb:Void->Void):Void cb();
	@:extern inline public static function image(asset:String, name:String) return asset;
	#end
}