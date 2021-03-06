/**
* Copyright (c) 2012-2018 Alexander Gordeyko <axgord@gmail.com>. All rights reserved.
* 
* Redistribution and use in source and binary forms, with or without modification, are
* permitted provided that the following conditions are met:
* 
* 1. Redistributions of source code must retain the above copyright notice, this list of
*   conditions and the following disclaimer.
* 
* 2. Redistributions in binary form must reproduce the above copyright notice, this list
*   of conditions and the following disclaimer in the documentation and/or other materials
*   provided with the distribution.
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
**/
package pony.net.http;

/**
 * Cookie
 * @author AxGord
 */

class Cookie
{
	private var oldCookie:Map<String, String>;
	private var newCookie:Map<String, String>;
	
	public function new(?cookie:String, ?mapCookie:Map<String,String>)
	{
		newCookie = new Map<String, String>();
		oldCookie = new Map<String, String>();
		if (cookie != null) {
			var a:Array<String> = cookie.split(';');
			for (e in a) {
				var kv:Array<String> = e.split('=').map(StringTools.trim);
				//todo: fix double cookie problem
				oldCookie.set(kv[0], kv[1]);
			}
		} else if (mapCookie != null) oldCookie = mapCookie;
	}
	
	public function toString(?domain:String):String {
		//domain = domain != null ? 'domain=$domain' : '';
		var s:String = '';
		for (k in newCookie.keys()) {
			s += k + '=' + newCookie.get(k) + ';';// + ';HttpOnly;$domain';
		}
		return s;
	}
	
	public function get(name:String):String {
		if (newCookie.exists(name))
			return newCookie.get(name);
		else
			return oldCookie.get(name);
	}
	
	inline public function set(name:String, value:String):Void newCookie.set(name, value);
	
}