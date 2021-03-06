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
import haxe.io.Bytes;
import pony.events.Signal0;
import pony.events.Signal1;
import pony.events.Signal2;
import pony.net.rpc.RPC;
import pony.net.rpc.IRPC;
import pony.net.rpc.RPCLog;
import pony.net.rpc.RPCFileTransport;
import pony.net.rpc.RPCPing;

/**
 * RemoteProtocol
 * @author AxGord <axgord@gmail.com>
 */
class RemoteProtocol extends RPC<RemoteProtocol> implements IRPC {

	@:sub public var log:RPCLog;
	@:sub public var file:RPCFileTransport;
	@:sub public var ping:RPCPing;

	@:rpc public var onAuth:Signal1<String>;
	@:rpc public var onReady:Signal0;
	@:rpc public var onCommand:Signal1<String>;
	@:rpc public var onCommandComplete:Signal2<String, Int>;
	@:rpc public var onZipLog:Signal1<Bytes>;
	@:rpc public var onGetInitFile:Signal0;

	@:rpc public var onGetFile:Signal1<String>;

}