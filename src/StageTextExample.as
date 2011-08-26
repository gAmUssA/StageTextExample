package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageQuality;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.text.StageText;
	import flash.text.StageTextInitOptions;
	
	public class StageTextExample extends Sprite
	{
		private var initialized:Boolean = false;
		public function StageTextExample()
		{
			super();
			this.stage.align = StageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;
			this.stage.addEventListener(Event.RESIZE, doLayout);
		}
		
		private var nt:NativeText;
		private var randomizeButton:Button;
		private var squareButton:Button;
		private var square:Sprite;
		
		private function doLayout(e:Event):void
		{
			if (this.initialized) return;
			this.initialized = true;

			this.removeChildren();
			
			this.nt = new NativeText(1);
			this.nt.fontSize = 12;
			nt.borderThickness = 5;
			this.nt.width = this.stage.stageWidth - (this.stage.stageWidth * .1);
			this.nt.x = (this.stage.stageWidth / 2) - (this.nt.width / 2);
			this.nt.y = (this.stage.stageHeight / 3) - (this.nt.height);
			this.addChild(this.nt);
			
			this.randomizeButton = new Button("Randomize");
			this.randomizeButton.x = ((this.stage.stageWidth / 2) - randomizeButton.width) - 10;
			this.randomizeButton.y = this.stage.stageHeight - this.randomizeButton.height - 10;
			this.randomizeButton.addEventListener(MouseEvent.CLICK, onRandomize);
			this.addChild(this.randomizeButton);
			
			this.squareButton = new Button("Toggle Square");
			this.squareButton.x = (this.stage.stageWidth / 2) + 10;
			this.squareButton.y = this.stage.stageHeight - this.squareButton.height - 10;
			this.squareButton.addEventListener(MouseEvent.CLICK, onToggleSquare);
			this.addChild(this.squareButton);
			
			this.square = new Sprite();
			this.square.graphics.beginFill(0xff0000);
			this.square.graphics.drawRect(0, 0, this.stage.stageWidth / 2, this.stage.stageHeight / 2);
			this.square.x = this.stage.stageWidth / 4;
			this.square.y = this.stage.stageHeight / 6;
		}
		
		private function onRandomize(e:MouseEvent):void
		{
			
		}
		
		private function onToggleSquare(e:MouseEvent):void
		{
			if (this.square != null && this.contains(this.square))
			{
				this.removeChild(this.square);
				this.nt.unfreeze();
			}
			else
			{
				this.nt.freeze();
				this.addChild(this.square);
			}
		}
	}
}