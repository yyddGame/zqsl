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

package spine {

import spine.animation.Animation;
import spine.atlas.Atlas;
import spine.attachments.AtlasAttachmentLoader;
import spine.attachments.AttachmentLoader;
import spine.starling.SkeletonAnimation;
import spine.starling.StarlingAtlasAttachmentLoader;
import spine.starling.StarlingTextureLoader;

import starling.core.Starling;
import starling.display.DisplayObject;
import starling.display.Sprite;
import starling.events.Touch;
import starling.events.TouchEvent;
import starling.events.TouchPhase;
import starling.textures.Texture;
import starling.textures.TextureAtlas;

public class RaptorExample extends Sprite 
{
	[Embed(source = "/assets/luxi.json", mimeType = "application/octet-stream")]
	static public const RaptorJson:Class;
	
	[Embed(source = "/assets/luxi.atlas", mimeType = "application/octet-stream")]
	static public const RaptorAtlas:Class;
	
	[Embed(source = "/assets/luxi.png")]
	static public const RaptorAtlasTexture:Class;
	[Embed(source = "/assets/luxi2.png")]
	static public const RaptorAtlasTexture2:Class;
	
	private var skeleton:SkeletonAnimation;
	private var skeleton2:SkeletonAnimation;
	private var gunGrabbed:Boolean;

	private var actionList:Array = [];
	private var index:uint;
	public function RaptorExample ()
	{
		var attachmentLoader:AttachmentLoader;
		var obj:Object = {};
		obj["luxi.png"] = new RaptorAtlasTexture();
		obj["luxi2.png"] = new RaptorAtlasTexture2()
		var spineAtlas:Atlas = new Atlas(new RaptorAtlas(), new StarlingTextureLoader(obj));
		attachmentLoader = new AtlasAttachmentLoader(spineAtlas);

		var json:SkeletonJson = new SkeletonJson(attachmentLoader);
		json.scale = 0.5;
		var skeletonData:SkeletonData = json.readSkeletonData(new RaptorJson());

		skeleton = new SkeletonAnimation(skeletonData, true);
		skeleton.x = 400;
		skeleton.y = 560;
		skeleton.state.setAnimationByName(0, "pao", true);
		
		for each (var animation:Animation in skeletonData.animations) 
		{
			actionList.push(animation.name);
		}
		

		addChild(skeleton);
		Starling.juggler.add(skeleton);
		
		
//		var attachmentLoader2:AttachmentLoader;
//		var spineAtlas2:Atlas = new Atlas(new lxtxAtlas(), new StarlingTextureLoader(new lxtxAtlasTexture()));
//		attachmentLoader2 = new AtlasAttachmentLoader(spineAtlas2);
//		
//		var json:SkeletonJson = new SkeletonJson(attachmentLoader2);
//		json.scale = 0.5;
//		var skeletonData2:SkeletonData = json.readSkeletonData(new lxtxJson());
//		
		
		Starling.current.stage.addEventListener(TouchEvent.TOUCH, onClick);
	}

	private function onClick (event:TouchEvent) : void {
		
		var touch:Touch = event.getTouch(event.target as DisplayObject);
		if (touch && touch.phase == TouchPhase.ENDED) 
		{
			index ++;
			if(index >= actionList.length)
			{
				index = 0;
			}

			var bl:Boolean;
			switch(actionList[index])
			{
				case "pao":
				case "pao2":
				case "daiji":	
				{
					bl = true;
					break;
				}
				default:
				{
					break;
				}
			}
			skeleton.state.setAnimationByName(0, actionList[index], bl);
			trace(actionList[index]);
			
		}
	}
}
}
