package
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	import model.Constant;
	
	import starling.core.Starling;
	
	import view.StarlingRoot;

	[SWF(width = "800", height = "600", frameRate = "30", backgroundColor = "#dddddd")]
	public class Dragon extends Sprite
	{
		private var _starling:Starling;
		public function Dragon()
		{
			super();
			
			if(stage)
			{
				init();
			}
			else
			{
				addEventListener(Event.ADDED_TO_STAGE,init);
			}
		}
		
		public function init(e:Event = null):void
		{
			
			var viewRect:Rectangle = new Rectangle(0,0,stage.fullScreenWidth,stage.fullScreenHeight);//获取设备的窗口大小
			_starling = new Starling(StarlingRoot,stage,viewRect);//将设备窗口大小做为starling的视窗大小
			_starling.stage.stageWidth = 950;//设置starling舞台宽为我们制作时宽
			_starling.stage.stageHeight = 650;//设置starling舞台高为我们制作时高
			Constant.stage = _starling.stage;//将starling的stage做为全局静态变量使用
			_starling.showStats = true;
			_starling.start();
			return;
			var rect:Shape = new Shape();
			rect.graphics.beginFill(0xdddddd,0.5);
			rect.graphics.drawRect(0, 0, stage.fullScreenWidth, stage.fullScreenHeight);
			stage.addChild(rect);

			//调整对齐方式
			stage.align = StageAlign.TOP_LEFT;
//			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			
			//初始化宽高
			Constant.STAGE_WIDTH = stage.fullScreenWidth;
			Constant.STAGE_HEIGHT = stage.fullScreenHeight;
			//设置资源管理
//			var assetsManager:AssetManager = new AssetManager();    
			
			//EmbeddedAsstes为所有图片资源通过Embed加载资源集合类 
//			assetsManager.enqueue(EmbeddedAsstes);            
			var s:Starling = new Starling(StarlingRoot,stage);
			//设置长宽
			s.stage.stageWidth = Constant.STAGE_WIDTH;
			s.stage.stageHeight = Constant.STAGE_HEIGHT;   
			//关闭多点触控
			s.simulateMultitouch = false;
			//Stage3D渲染方法是否报告发生错误
			s.enableErrorChecking = false;
			//抗锯齿1~16 差别不大
			s.antiAliasing = 1;
			//显示FPS
			s.showStats = true;
			//调整帧率
			stage.frameRate = 60;
			s.start();
//			var background:Bitmap = new WelcomePic();
//			background.width  = Constant.STAGE_WIDTH;
//			background.height = Constant.STAGE_HEIGHT;
//			background.smoothing = true;
//			addChild(background);
			
			//启动Assets类加载资源，在启动前先放一个默认页面background
//			s.addEventListener(starling.events.Event.ROOT_CREATED, 
//				function onRootCreated(event:Object, app:Assets):void
//				{
//					//将监听移除，并将默认页面移除，并置空
//					s.removeEventListener(starling.events.Event.ROOT_CREATED, onRootCreated);
//					removeChild(background);
//					background = null;
//					
//					var bgTexture:Texture = Texture.fromEmbeddedAsset(WelcomePic);
//					
//					app.start(bgTexture,assetsManager);
//					
//					s.start();
//				});
//		}
			
			stage.addEventListener(Event.RESIZE,stageResizeHandler)
		}
		
		protected function stageResizeHandler(e:Event):void
		{
			trace(stage.width,stage.height);
			
		}
	}
}