package view
{
	import flash.geom.Point;
	
	import event.GameEvent;
	
	import spine.SpineboyExample;
	
	import starling.display.Button;
	import starling.display.ButtonState;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;
	
	public class StarlingRoot extends Sprite
	{
		

		[Embed(source = "/assets/ui/leftBtn.png")]
		public var leftClass:Class;
		
		[Embed(source = "/assets/ui/rightBtn.png")]
		public var rightClass:Class;
		
		private var leftBtn:Button;
		private var rightBtn:Button;
		private var isMove:Boolean;
		private var direction:int = 1;
		private var dirControl:Sprite;
		
		private var _bgView:BackgroundView;
		private var _spineboyExample:SpineboyExample;
		private var _controlView:ControlView;
		
		public function StarlingRoot()
		{
			super();
			
			_bgView = new BackgroundView();
			addChild(_bgView)
			
			
			_spineboyExample = new SpineboyExample();
			addChild(_spineboyExample);

			dirControl = new Sprite();
			addChild(dirControl);
			
			leftBtn = new Button(Texture.fromBitmap(new leftClass));
			dirControl.addChild(leftBtn);
			
			
			rightBtn = new Button(Texture.fromBitmap(new rightClass));
			dirControl.addChild(rightBtn);
			rightBtn.x = 150;
			
			_controlView = new ControlView();
			addChild(_controlView);
			
			addEvent();
		}
		
		private function playActionHandler(e:GameEvent):void
		{
			trace(e.data);
			switch(e.data)
			{
				case "攻击":
				{
					_spineboyExample.setState("gongji1",false)
					break;
				}
				case "防御":
				{
					_spineboyExample.setState("huanchong_q",false);
					break;
				}
				case "大招":
				{
					_spineboyExample.setState("jineng1",false);
					break;
				}
				default:
				{
					break;
				}
			}
		}
		
		private function addEvent():void
		{
			addEventListener(Event.ADDED_TO_STAGE,addToStage);
			_controlView.addEventListener(GameEvent.CONTROL_ACTION,playActionHandler);			
			dirControl.addEventListener(TouchEvent.TOUCH,touchHandler);
		}
		
		private function touchHandler(e:TouchEvent):void
		{
			if(!_spineboyExample.isEnd)
			{
				return;
			}
			var currTarget:DisplayObject = e.currentTarget as DisplayObject;
			var touch:Touch = e.getTouch(currTarget);
			if(touch)
			{
				
				if(touch.phase == TouchPhase.BEGAN)
				{
					
					_spineboyExample.setState("yidong");
					
					if(e.target == leftBtn)
					{
						isMove = true;
						_spineboyExample.scaleX = -1
						//_spineboyExample.x = 100 - _spineboyExample.x;	
						direction = 1;
					}
					else if(e.target == rightBtn)
					{
						isMove = true;
						_spineboyExample.scaleX = 1
						//_spineboyExample.x = 0;	
						direction = 2;
					}
					
				}
				else if(touch.phase == TouchPhase.ENDED)
				{
					isMove = false;
					//待机
					_spineboyExample.setState("daiji");
				}
				else if(touch.phase == TouchPhase.MOVED)
				{
					
					var localPt:Point = dirControl.globalToLocal(new Point(touch.globalX,touch.globalY))
					if(0<= localPt.x && localPt.x <= 132 && localPt.y >=0 && localPt.y <= 125)
					{
						isMove = true;
						direction = 1;
						leftBtn.state = ButtonState.DOWN;
						rightBtn.state = ButtonState.UP;
						_spineboyExample.scaleX = -1
					}
					else if(133<= localPt.x && localPt.x <= 270 && localPt.y >=0 && localPt.y <= 125)
					{
						isMove = true;
						direction = 2;
						leftBtn.state = ButtonState.UP;
						rightBtn.state = ButtonState.DOWN;
						_spineboyExample.scaleX = 1
					}	
					else
					{
						isMove = false;
						leftBtn.state = ButtonState.UP;
						rightBtn.state = ButtonState.UP;
					}
				}
				
				
			}
			
		}
		
		private function addToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE,addToStage);
			dirControl.y = stage.stageHeight - dirControl.height;
			_controlView.x = stage.stageWidth - _controlView.width;
			_controlView.y = stage.stageHeight - 100;
			
			
			addEventListener(Event.ENTER_FRAME,frameHandler);
		}
		
		private function frameHandler(e:Event):void
		{
			if(isMove)
			{
				_bgView.move(direction);
				boyRun(direction);
			}
			
		}
		
		private function boyRun(direction:uint):void{
			
			if( direction == 2 && _spineboyExample.x + 100 >= stage.stageWidth - _spineboyExample.width - 100)
			{
				return;
			}
			if(direction == 1 && _spineboyExample.x  <= 100){
				
				return
			}
			var factor:int = direction == 2?1:-1;  
			if(_bgView.isInboundary){
			   factor = direction == 2?5:-5;
			}

			_spineboyExample.x += factor;
		}
		
	}
}