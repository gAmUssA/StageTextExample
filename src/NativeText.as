package
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	import flash.text.StageText;
	import flash.text.StageTextInitOptions;
	
	// TBD: StageText Events
	public class NativeText extends Sprite
	{
		private var st:StageText;
		private var numberOfLines:uint;
		private var _width:uint, _height:uint;
		private var snapshot:Bitmap;
		
		public var borderThickness:uint = 2;
		public var borderColor:uint = 0x000000;
		public var borderCornerSize:uint = 0;
		
		public function NativeText(numberOfLines:uint = 1)
		{
			super();
			
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemoveFromStage);
			
			this.numberOfLines = numberOfLines;
			var stio:StageTextInitOptions = new StageTextInitOptions((this.numberOfLines > 1));
			this.st = new StageText(stio);
			
			this.calculateHeight();
		}
		
		private function onAddedToStage(e:Event):void
		{
			this.st.stage = this.stage;
			this.setUpViewPort();
		}
		
		private function onRemoveFromStage(e:Event):void
		{
			this.st.dispose();
		}
		
		//// StageText properties and functions ///
		
		public function set autoCapitalize(autoCapitalize:String):void
		{
			this.st.autoCapitalize = autoCapitalize;
		}
		
		public function set autoCorrect(autoCorrect:Boolean):void
		{
			this.st.autoCorrect = autoCorrect;
		}
		
		public function set color(color:uint):void
		{
			this.st.color = color;
		}
		
		public function set displayAsPassword(displayAsPassword:Boolean):void
		{
			this.st.displayAsPassword = displayAsPassword;
		}
		
		public function set editable(editable:Boolean):void
		{
			this.st.editable = editable;
		}
		
		public function set fontFamily(fontFamily:String):void
		{
			this.st.fontFamily = fontFamily;
		}
		
		public function set fontPosture(fontPosture:String):void
		{
			this.st.fontPosture = fontPosture;
		}

		public function set fontSize(fontSize:uint):void
		{
			this.st.fontSize = fontSize;
			this.calculateHeight();
		}

		public function set fontWeight(fontWeight:String):void
		{
			this.st.fontWeight = fontWeight;
		}
		
		public function set locale(locale:String):void
		{
			this.st.locale = locale;
		}
		
		public function set maxChars(maxChars:int):void
		{
			this.st.maxChars = maxChars;
		}
		
		public function set restrict(restrict:String):void
		{
			this.st.restrict = restrict;
		}
		
		public function set returnKeyLabel(returnKeyLabel:String):void
		{
			this.st.returnKeyLabel = returnKeyLabel;
		}
		
		public function get selectionActiveIndex():int
		{
			return this.st.selectionActiveIndex;
		}
		
		public function get selectionAnchorIndex():int
		{
			return this.st.selectionAnchorIndex;
		}
		
		public function set softKeyboardType(softKeyboardType:String):void
		{
			this.st.softKeyboardType = softKeyboardType;
		}
		
		public function set text(text:String):void
		{
			this.st.text = text;
		}
		
		public function set textAlign(textAlign:String):void
		{
			this.st.textAlign = textAlign;
		}
		
		public override function set visible(visible:Boolean):void
		{
			this.visible = visible;
			this.st.visible = visible;
		}
		
		public function get multiline():Boolean
		{
			return this.st.multiline;
		}
		
		public function assignFocus():void
		{
			this.st.assignFocus();
		}
		
		public function selectRange(anchorIndex:int, activeIndex:int):void
		{
			this.st.selectRange(anchorIndex, activeIndex);
		}
		
		//// Additional functions ////
		
		public function freeze():void
		{
			var bmd:BitmapData = new BitmapData(this.st.viewPort.width, this.st.viewPort.height);
			this.st.drawViewPortToBitmapData(bmd);
			this.snapshot = new Bitmap(bmd);
			this.snapshot.x = this.borderThickness / 2;
			this.snapshot.y = this.borderThickness / 2;
			this.addChild(this.snapshot);
			this.st.visible = false;
		}
		
		public function unfreeze():void
		{
			if (this.snapshot != null && this.contains(this.snapshot))
			{
				this.removeChild(this.snapshot);
				this.snapshot = null;
				this.st.visible = true;
			}
		}
		
		//// Functions that must be overridden to make this work ///
		
		public override function set width(width:Number):void
		{
			this._width = width;
			if (this.stage != null && this.stage.contains(this)) this.setUpViewPort();
		}
		
		public override function get width():Number
		{
			return this._width;
		}
		
		public override function set height(height:Number):void
		{
			// This is a NOP since the height is set automatically
			// based on things like font size, etc.
		}

		public override function get height():Number
		{
			return this._height;
		}
		
		public override function set x(x:Number):void
		{
			super.x = x;
			if (this.stage != null && this.stage.contains(this)) this.setUpViewPort();
		}
		
		public override function set y(y:Number):void
		{
			super.y = y;
			if (this.stage != null && this.stage.contains(this)) this.setUpViewPort();
		}

		private function setUpViewPort():void
		{
			this.st.viewPort = new Rectangle(this.x + (this.borderThickness / 2), this.y + (this.borderThickness / 2), this._width - (this.borderThickness / 2), this._height - (this.borderThickness / 2));
			this.graphics.clear();
			this.graphics.lineStyle(this.borderThickness, this.borderColor);
			this.graphics.drawRoundRect(0, 0, this._width, this._height, this.borderCornerSize, this.borderCornerSize);
			this.graphics.endFill();
		}
		
		private function calculateHeight():void
		{
			this._height = (this.st.fontSize * this.numberOfLines) + ((this.st.fontSize / 2) * this.numberOfLines);
		}
	}
}