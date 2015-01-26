package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import utils.MathVector;
	import factories.MissleFactory;
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
		var explosion : ExplosionClass;
		var _score : int = 0;
		var _enemyAmount : int = 10;
		
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
			missleArray = [];
			explosionArray = [];
			targetArray = new Array;
			
			playerArray = [turret = new Turret(50, stage.stageHeight -100),turret = new Turret(stage.stageWidth / 2, stage.stageHeight - 100),turret = new Turret(stage.stageWidth - 50, stage.stageHeight - 100)];
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
				trace("dead");
			}
			else
			{
				_score++;
				trace(_score);
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
		}
		
		private function shoot (e:MouseEvent):void
		{
			var targetNumber : Number = Math.floor(Math.random() * playerArray.length);
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