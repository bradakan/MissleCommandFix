package  objects
{
	
	import flash.display.MovieClip;
	import utils.MathVector;
	import flash.events.Event;
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class MissleClass extends MovieClip
	{
		public static const EXPLODE : String = "explode";

		var _target : MathVector;
		var _path : MathVector;
		var _speed : Number = 8;
		var _asset : MovieClip;
		var _startX :Number;
		var _startY :Number;
		
		
		public function MissleClass(targetX : Number, targetY : Number, AssetClass : Class, startX :Number, startY :Number) 
		{
			_asset = new AssetClass();
			_target = new MathVector(targetX, targetY);
			_startX = startX; _startY = startY;
			addEventListener(Event.ADDED_TO_STAGE, init);	
			this.rotation = - (Math.atan2(startX - targetX, startY - targetY) *  (180 / Math.PI));
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			addChild(_asset);
			this.x = _startX;
			this.y = _startY;
			_path = new MathVector(_target.dx - this.x,_target.dy - this.y);
			if (_asset is Missle)
			{
				_speed = 2;
			}
		}
		
		public function update()
		{
			
			if (_path.length > _speed)
			{
				_path.dx = _target.dx - this.x;
				_path.dy = _target.dy - this.y;
				this.x += _path.nx * _speed;
				this.y += _path.ny * _speed;
			}
			else 
			{
				explode();
			}

			
		}
		
	
		public function get speed():Number 
		{
			return _speed;
		}
		
		public function get asset():MovieClip 
		{
			return _asset;
		}
		
		public function get target():MathVector 
		{
			return _target;
		}
		
		public function set target(value:MathVector):void 
		{
			_target = value;
		}
		public function explode()
		{
			dispatchEvent(new Event(EXPLODE,true));
		}
		
	}

}