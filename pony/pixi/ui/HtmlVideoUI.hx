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
package pony.pixi.ui;

import pony.HtmlVideo;

class HtmlVideoUI extends HtmlContainer {

	public var video(default, null):HtmlVideo;
	public var muted(get, set):Bool;

	public function new(targetRect:pony.geom.Rect<Float>, ?css:String, ?app:pony.pixi.App, ?options:HtmlVideoOptions, fixed:Bool = false) {
		super(targetRect, app, fixed);
		video = new HtmlVideo(options);
		video.appendTo(app.parentDom);
		htmlContainer.targetStyle = video.style;
		if (css != null) video.style.cssText += css;
	}

	public inline function hide():Void video.visible.disable();
	public inline function show():Void video.visible.enable();

	@:extern private inline function get_muted():Bool return video.muted.enabled;
	@:extern private inline function set_muted(v:Bool):Bool return video.muted.enabled = v;

}