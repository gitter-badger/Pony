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

import pixi.core.graphics.Graphics;
import pixi.core.sprites.Sprite;
import pixi.extras.BitmapText.BitmapTextStyle;
import pony.color.UColor;
import pony.geom.IWH;
import pony.geom.Point;
import pony.ui.gui.ButtonImgN;
import pony.ui.touch.pixi.Touchable;

/**
 * TextButton
 * @author AxGord <axgord@gmail.com>
 */
class TextButton extends Sprite implements IWH {

	public var core:ButtonImgN;
	public var text(get, set):String;
	public var btext(default, null):BTextLow;
	public var size(get, never):Point<Float>;
	private var color:Array<UColor>;
	private var lines:Array<Graphics>;
	private var prevline:Graphics;
	
	public function new(color:Array<UColor>, text:String, font:String, ?ansi:String, line:Float=0, linepos:Float=0) {
		super();
		this.color = color;
		btext = new BTextLow(text, {font: font, tint: color[0].rgb}, ansi, true);
		btext.interactive = false;
		btext.interactiveChildren = false;
		addChild(btext);
		var g = new Graphics();
		g.lineStyle();
		g.beginFill(0, 0);
		g.drawRect(0, 0, size.x, size.y);
		g.endFill();
		addChildAt(g, 0);
		g.buttonMode = true;
		if (line > 0) {
			lines = [];
			for (c in color) {
				var g = new Graphics();
				g.lineStyle(line, c.rgb, 1-c.af);
				
				var pos:Float = 0;
				var step:Bool = false;
				while (pos <= size.x) {
					var end = false;
					if (pos == size.x) {
						end = true;
					}
					if (step) {
						g.lineTo(pos, size.y);
						pos += 5;
					} else {
						g.moveTo(pos, size.y);
						pos += 10;
					}
					if (end) break;
					else if (pos > size.x) pos = size.x;
					step = !step;
				}
				g.y = linepos;
				g.visible = false;
				addChild(g);
				lines.push(g);
				if (lines.length > 2) break;
			}
			prevline = lines[0];
			prevline.visible = true;
		}
		
		core = new ButtonImgN(new Touchable(g));
		core.onImg << imgHandler;
	}
	
	private function imgHandler(n:Int):Void {
		n--;
		if (n > color.length) n = color.length - 1;
		btext.tint = color[n];
		
		if (prevline != null) {
			prevline.visible = false;
			prevline = null;
		}
		if (lines[n] != null) {
			lines[n].visible = true;
			prevline = lines[n];
		}
	}
	
	@:extern inline private function get_text():String return btext.text;
	@:extern inline private function set_text(t:String):String return btext.t = t;
	
	inline private function get_size():Point<Float> return btext.size;
	
	inline public function wait(cb:Void->Void):Void btext.wait(cb);
	
	public function destroyIWH():Void destroy();
	
}