import flash.events.*;
import flash.media.*;
import flash.net.*;

private var nc:NetConnection;
private var ns:NetStream;

private function init():void {
    nc = new NetConnection();
	nc.objectEncoding = ObjectEncoding.AMF0;
    nc.addEventListener(NetStatusEvent.NET_STATUS, status_handler);
	nc.addEventListener(AsyncErrorEvent.ASYNC_ERROR, error_handler);
	nc.addEventListener(IOErrorEvent.IO_ERROR, error_handler);
	nc.addEventListener(IOErrorEvent.NETWORK_ERROR, error_handler);
    nc.client = this;
    nc.connect("rtmp://localhost/stream/rec");
}

private function status_handler(event:NetStatusEvent):void {
	status.text = event.info.code;
}

private function error_handler(event:Object):void {
	status.text = "ERROR: " + event.toString();
}

private function start_publish():void {
    var channel_name:String = input.text;
    if (!channel_name) return;

    ns = new NetStream(nc);
    ns.addEventListener(NetStatusEvent.NET_STATUS, status_handler);

    var mic:Microphone = Microphone.getMicrophone();
    if (!mic) {
        status.text = "No mic found";
        return;
    }

    publish_button.enabled = false;
    start_button.enabled = true;
    stop_button.enabled = true;

//    mic.setSilenceLevel(0); //??
    mic.rate = 16;
	mic.codec = SoundCodec.SPEEX;
	mic.framesPerPacket = 2;
	mic.gain = 50;
	mic.setUseEchoSuppression(false);
	//mic.muted = false;
	mic.encodeQuality = 5;

    ns.attachAudio(mic);
    ns.publish(channel_name, "live");
}

public function record_start():void {
    nc.call("record", new Responder(function():void {}), "start");
}

public function record_stop():void {
    nc.call("record", new Responder(function():void {}), "stop");
	ns.close();
}

