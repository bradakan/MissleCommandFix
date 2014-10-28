package  objects
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class ExplosionClass extends MovieClip
	{
		public static const END_EXPLOSION : String = "endOfExplosion";
		var _asset : MovieClip;
		var _removeMe : Boolean = false;
		
		
		public function ExplosionClass() 
		{
			_asset = new Explosion();
			addChild(_asset);
		}
		
		
		public function update()
		{
			if (_asset.currentFrame == _asset.framesLoaded)
			{
				dispatchEvent(new Event(END_EXPLOSION,true));
			}
		}
		
		public function get removeMe():Boolean 
		{
			return _removeMe;
		}
		
		public function set removeMe(value:Boolean):void 
		{
			_removeMe = value;
		}
	}

}