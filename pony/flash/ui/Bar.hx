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
package pony.flash.ui;

import flash.display.MovieClip;
import flash.events.MouseEvent;
import pony.events.Signal1;
import pony.magic.HasSignal;
import pony.time.DeltaTime;

/**
 * Bar
 * @author AxGord
 */
class Bar extends MovieClip implements FLStage implements HasSignal {
#if !starling
	@:stage private var bar:MovieClip;
	
	private var total:Float;
	
	public var value(default, set):Float = 0;
	@:auto public var onComplete:Signal1<Float>;
	@:auto public var onDynamic:Signal1<Float>;
	
	public function new() {
		super();
		DeltaTime.fixedUpdate.once(init, -1);
		addEventListener(MouseEvent.CLICK, clickHandler);
	}
	
	private function clickHandler(_):Void {
		value = mouseX / total;
	}
	
	private function init():Void {
		total = width;
		bar.width = 0;
	}
	
	public function set_value(v:Float):Float {
		if (value == v) return v;
		eDynamic.dispatch(v);
		eComplete.dispatch(v);
		bar.width = v * total;
		return value = v;
	}
#end
}