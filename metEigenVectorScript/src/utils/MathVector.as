package utils  
{
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class MathVector 
	{
		
		private var _dx:Number;
		private var _dy:Number;
		private var _length:Number;
		private var _nx:Number;
		private var _ny:Number;
		
		public function MathVector(_dx:Number,_dy:Number) 
		{
			this._dx = _dx;
			this._dy = _dy;
			this._length = Math.sqrt(_dx * _dx + _dy * _dy);
			this._nx = _dx / _length;
			this._ny = _dy / _length;
			
			
		}
		
		public function set dx (DX:Number):void
		{
				this._dx = DX;
				this._length = Math.sqrt(_dx * _dx + _dy * _dy);
		}
		
		public function set dy (DY:Number):void
		{
			this._dy = DY;
			this._length = Math.sqrt(_dx * _dx + _dy * _dy);
		}
		
		public function get dx():Number
		{
			return _dx;
		}
		
		public function get dy():Number
		{
			return _dy;
		}
		public function get length():Number
		{
			return _length;
		}
		public function set length(i:Number):void
		{
			
		}
		
		public function get nx ():Number
		{
			this._nx = _dx / _length;
			return _nx;			
		}
		public function get ny ():Number
		{
			this._ny = _dy / _length;
			return _ny;
		}
		
	}

}