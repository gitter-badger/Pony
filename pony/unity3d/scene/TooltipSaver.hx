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
package pony.unity3d.scene;

import unityengine.MonoBehaviour;
using hugs.HUGSWrapper;

/**
 * TooltipSaver
 * @author AxGord <axgord@gmail.com>
 */

@:nativeGen class TooltipSaver extends MonoBehaviour {

	private var tooltips:Array<Tooltip>;
	
	private function Start():Void {
		var tooltip:Tooltip = null;
		if (tooltip == null) tooltip = gameObject.getTypedComponent(Tooltip);
		if (tooltip == null) tooltip = gameObject.getParentTypedComponent(Tooltip);
		if (tooltip == null) {
			tooltips = gameObject.getComponentsInChildrenOfType(Tooltip).haxeArray();
		} else
			tooltips = [tooltip];
	}
	
	inline private function saveColors():Void {
		for (e in tooltips) e.saveColors();
	}
	
}