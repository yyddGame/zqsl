/******************************************************************************
 * Spine Runtimes Software License
 * Version 2.3
 * 
 * Copyright (c) 2013-2015, Esoteric Software
 * All rights reserved.
 * 
 * You are granted a perpetual, non-exclusive, non-sublicensable and
 * non-transferable license to use, install, execute and perform the Spine
 * Runtimes Software (the "Software") and derivative works solely for personal
 * or internal use. Without the written permission of Esoteric Software (see
 * Section 2 of the Spine Software License Agreement), you may not (a) modify,
 * translate, adapt or otherwise create derivative works, improvements of the
 * Software or develop new applications using the Software or (b) remove,
 * delete, alter or obscure any trademarks or any copyright, trademark, patent
 * or other intellectual property or proprietary rights notices on or in the
 * Software, including any copy thereof. Redistributions in binary or source
 * form must include this license and terms.
 * 
 * THIS SOFTWARE IS PROVIDED BY ESOTERIC SOFTWARE "AS IS" AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 * EVENT SHALL ESOTERIC SOFTWARE BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 * ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *****************************************************************************/

package spine 
{

	import spine.animation.AnimationStateData;
	import spine.atlas.Atlas;
	import spine.attachments.AtlasAttachmentLoader;
	import spine.attachments.AttachmentLoader;
	import spine.starling.SkeletonAnimation;
	import spine.starling.StarlingTextureLoader;
	
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

public class SpineboyExample extends Sprite 
{
	[Embed(source = "/../outSource/avatar/ds/ds.json", mimeType = "application/octet-stream")]
	static public const SpineboyJson:Class;

	[Embed(source = "/../outSource/avatar/ds/ds.atlas", mimeType = "application/octet-stream")]
	static public const SpineboyAtlas:Class;

	[Embed(source = "/../outSource/avatar/ds/ds.png")]
	static public const SpineboyAtlasTexture:Class;

	private var skeleton:SkeletonAnimation;

	public var isEnd:Boolean = true;
	private var _state:String;
	public var modelContainer:Sprite
	public function SpineboyExample () {
		modelContainer = new Sprite();
		modelContainer.width = 150;
		modelContainer.height = 150;
		addChild(modelContainer);
		var spineAtlas:Atlas = new Atlas(new SpineboyAtlas(), new StarlingTextureLoader(new SpineboyAtlasTexture()));
		var attachmentLoader:AttachmentLoader = new AtlasAttachmentLoader(spineAtlas);
		var json:SkeletonJson = new SkeletonJson(attachmentLoader);
		json.scale = 0.6;
		var skeletonData:SkeletonData = json.readSkeletonData(new SpineboyJson());
		var stateData:AnimationStateData = new AnimationStateData(skeletonData);

		skeleton = new SkeletonAnimation(skeletonData, true,stateData);
		skeleton.skeleton.skinName = "pifu1"

		skeleton.scale = 0.5

		skeleton.state.setAnimationByName(0, "daiji", true);
		//skeleton.state.addAnimationByName(0, "gongji1", false, 3);
		//skeleton.state.addAnimationByName(0, "run", true, 0);

		modelContainer.addChild(skeleton);
		modelContainer.x = 100;
		modelContainer.y = 560;
		Starling.juggler.add(skeleton);

		addEventListener(TouchEvent.TOUCH, onClick);
	}

	private function onClick (event:TouchEvent) : void {
		var touch:Touch = event.getTouch(this);
		if (touch && touch.phase == TouchPhase.BEGAN) {
		}
	}
	private function completeHandler():void{
	}
	public function setState(state:String,isLoop:Boolean = true):void
	{
		if(!isEnd) return;
		_state = state;
		isEnd = false;
		isEnd = isLoop;
		skeleton.state.setAnimationByName(0, state, isLoop).onEnd = onEnd;
		if(!isLoop){
			skeleton.state.addAnimationByName(0, "daiji", true, 0);
			
		}
	}
	
	private function onEnd(value:*):Function
	{
		isEnd = true;
		trace(value)
		return null;
	}
	override public function set scaleX(value:Number):void{
		var scaleIsChange:Boolean = this.scaleX == value?false:true
		super.scaleX = value
        if(value == -1 && scaleIsChange){
			this.x = this.x + 150;
		}else if(value == 1 && scaleIsChange){
			this.x = this.x - 150;
		}
	}
	
}
}
