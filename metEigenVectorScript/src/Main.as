package 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import utils.MathVector;
	import factories.MissleFactory;
	import factories.NonGameplayFactory;
	import objects.*;
	import flash.media.Sound;
	
	/**
	 * ...
	 * @author Rocky Tempelaars
	 */
	public class Main extends Sprite 
	{
		private var _canMakeMissle : Boolean = true;
		var playerArray : Array;
		var missleArray : Array;
		var targetArray : Array;
		var explosionArray : Array;
		var missle : MissleClass;
		var turret : Turret;
		var city : Target;
		var missleFactory : MissleFactory;
		var carFactory : NonGameplayFactory;
		var explosion : ExplosionClass;
		var _score : int = 0;
		var _enemyAmount : int = 10;
		var _cars:Array = [];
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.addEventListener(MouseEvent.CLICK, shoot);
			// entry point
			
			missleFactory = new MissleFactory();
			carFactory = new NonGameplayFactory();
			missleArray = [];
			explosionArray = [];
			targetArray = new Array;
			_cars = [carFactory.makeCar(stage.stageWidth,stage.stageHeight),carFactory.makeCar(stage.stageWidth,stage.stageHeight),carFactory.makeCar(stage.stageWidth,stage.stageHeight),]
			
			for (var car : int = 0; car < _cars.length; car++ )
			{
				addChild(_cars[car]);
			}
			
			playerArray = [new Turret(50, stage.stageHeight -100),new Turret(stage.stageWidth / 2, stage.stageHeight - 100),new Turret(stage.stageWidth - 50, stage.stageHeight - 100)];
			for (var i : uint = 0; i < playerArray.length; i++ )
			{
				addChild(playerArray[i]);
				targetArray.push(playerArray[i]);
			}
			
			for (var i : uint = 0; i < _enemyAmount; i++ )
			{
				makeMissle();
			}
			
			
			addEventListener(MissleClass.EXPLODE, explodeMissle);
			addEventListener(ExplosionClass.END_EXPLOSION, removeExplosion);
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function removeExplosion(e:Event):void 
		{
			var currentExplosion : ExplosionClass = e.target as ExplosionClass;
			var index : int = explosionArray.indexOf(currentExplosion);
			removeChild(explosionArray[index]);
			explosionArray.splice(index,1);
		}
		
		private function explodeMissle(e:Event):void 
		{
			var currentMissle : MissleClass = e.target as MissleClass;
			var index:int = missleArray.indexOf(currentMissle);
			//if (currentMissle.asset is PlayerMissle)
			//{
				
				var explosion = missleFactory.makeExplosion(currentMissle.x, currentMissle.y);
				addChild(explosion);
				explosionArray.push(explosion);
			//}
			removeMissle(index);
		}
		
		
		private function loop(e:Event):void
		{
			
			missleOuterLoop : for (var i : int = missleArray.length - 1; i >= 0; i-- )
			{
				for (var l : int = explosionArray.length - 1; l >= 0; l-- )
				{
					var distanceVector : MathVector = new MathVector(missleArray[i].x - explosionArray[l].x,missleArray[i].y - explosionArray[l].y);
					if (distanceVector.length < 30)
					{
						missleArray[i].explode();
						continue missleOuterLoop;
					}
				}
				missleArray[i].update();
			}
			
			for (var k : int = explosionArray.length - 1; k >= 0; k-- )
			{
				explosionArray[k].update();
			}

			playerOuterLoop : for (var j : int = playerArray.length -1; j >= 0; j-- )
			{
				for (var l : int = explosionArray.length - 1; l >= 0; l-- )
				{
					var distanceVector : MathVector = new MathVector(playerArray[j].x - explosionArray[l].x,playerArray[j].y - explosionArray[l].y);
						if (distanceVector.length < 30)
						{
							removeChild(playerArray[j]);
							playerArray.splice(j, 1);
							continue playerOuterLoop;
						}
				}
				playerArray[j].update();			
			}
			if (playerArray.length == 0)
			{
				//trace("dead");
			}
			else
			{
				_score++;
				//trace(_score);
			}
			if (playerArray.length == 0)
			{
				stage.removeEventListener(MouseEvent.CLICK, shoot);
				_canMakeMissle = false;
			}
			
			if (missleArray.length < _enemyAmount + Math.floor(_score / 100) && _canMakeMissle == true)
			{
				makeMissle();
				
			}
			
			for (var car : int = 0; car < _cars.length; car++ )
			{
				_cars[car].update();
			}
		}
		
		private function shoot (e:MouseEvent):void
		{
			if (playerArray.length == 3)
			{
				var zero :int = Math.sqrt(((playerArray[0].x - mouseX) * (playerArray[0].x - mouseX))+ ((playerArray[0].y - mouseY) * (playerArray[0].y - mouseY)));
				var one :int = Math.sqrt(((playerArray[1].x - mouseX) * (playerArray[1].x - mouseX))+ ((playerArray[1].y - mouseY) * (playerArray[1].y - mouseY)));
				var two :int = Math.sqrt(((playerArray[2].x - mouseX) * (playerArray[2].x - mouseX))+ ((playerArray[2].y - mouseY) * (playerArray[2].y - mouseY)));
				var targetNumber : Number;// = Math.floor(Math.random() * playerArray.length);
				if (zero < one && zero < two)
				{
					targetNumber = 0;
				}
				else if (one < two)
				{
					targetNumber = 1;
				}
				else
				{
					targetNumber = 2;
				}
			}
			else if (playerArray.length == 2)
			{
				var zero :int = Math.sqrt(((playerArray[0].x - mouseX) * (playerArray[0].x - mouseX))+ ((playerArray[0].y - mouseY) * (playerArray[0].y - mouseY)));
				var one :int = Math.sqrt(((playerArray[1].x - mouseX) * (playerArray[1].x - mouseX))+ ((playerArray[1].y - mouseY) * (playerArray[1].y - mouseY)));
				var targetNumber : Number;// = Math.floor(Math.random() * playerArray.length);
				if (zero < one)
				{
					targetNumber = 0;
				}
				else
				{
					targetNumber = 1;
				}			
			}
			else
			{
				targetNumber = 0;
			}
			missle = missleFactory.makeMissle(mouseX,mouseY,MissleFactory.PLAYER_MISSLE,playerArray[targetNumber].x,playerArray[targetNumber].y,stage.stageWidth);
			addChild(missle);
			missleArray.push(missle);
		}
		
		private function removeMissle(index:int)
		{
			removeChild(missleArray[index]);
			missleArray.splice(index,1);
		}
		function makeMissle()
		{
			var targetNumber : Number = Math.floor(Math.random() * targetArray.length);
			missle = missleFactory.makeMissle(targetArray[targetNumber].x,targetArray[targetNumber].y,MissleFactory.ENEMY_1,0,0,stage.stageWidth);
			missleArray.push(missle);
			addChild(missle);
		}
	}
	
}