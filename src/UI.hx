class UI {

  var emptyBallTile = hxd.Res.ball_empty.toTile();
  var redBallTile = hxd.Res.ball_red.toTile();
  var blueBallTile = hxd.Res.ball_blue.toTile();

  var hpBalls = new Array<h2d.Bitmap>();
  var shieldBalls = new Array<h2d.Bitmap>();

  var hp = 3;

  var powerUpFill : h2d.Bitmap;
  var ui : h2d.Sprite;
  var tutorial : h2d.Bitmap;
  var gameOver : h2d.Bitmap;
  var title : h2d.Bitmap;

  var hexagon : h2d.Bitmap;
  var square : h2d.Bitmap;
  var triangle : h2d.Bitmap;
  var s2d : h2d.Scene;

  public function new(s2d : h2d.Scene) {

    this.s2d = s2d;

    ui = new h2d.Sprite(s2d);

    for( i in 0...3 ) {
			var ball = new h2d.Bitmap(redBallTile, ui);
      ball.setScale(0.5);
			ball.x = 16 + i * (16 + emptyBallTile.width * 0.5);
			ball.y = 16;
      hpBalls.push(ball);
		}
    for( i in 0...3 ) {
			var ball = new h2d.Bitmap(blueBallTile, ui);
			ball.x = 16 + (i + 3) * (16 + emptyBallTile.width * 0.5);
			ball.y = 16;
      ball.setScale(0.5);
      ball.alpha = 0;
      shieldBalls.push(ball);
		}

		powerUpFill = new h2d.Bitmap(hxd.Res.powerup_fill.toTile(), ui);
    powerUpFill.x = 8;
    powerUpFill.y = 32 + emptyBallTile.height * 0.5;
    powerUpFill.scaleX = 0.0;

		var powerUpGauge = new h2d.Bitmap(hxd.Res.powerup_empty.toTile(), ui);
    powerUpGauge.x = 0;
    powerUpGauge.y = 32 + emptyBallTile.height * 0.5;

    triangle = new h2d.Bitmap(hxd.Res.triangle.toTile(), ui);
    square = new h2d.Bitmap(hxd.Res.square.toTile(), ui);
    hexagon = new h2d.Bitmap(hxd.Res.hexagon.toTile(), ui);

    hexagon.x = s2d.width - 200; hexagon.setScale(0.33); hexagon.y = (1 - 0.33) * 128;
    square.x = s2d.width - 150; square.setScale(0.5); square.y = (1 - 0.5) * 128;
    triangle.x = s2d.width - 100 + (0.33 * 64); triangle.setScale(0.33); triangle.y = (1 - 0.33) * 128;

    tutorial = new h2d.Bitmap(hxd.Res.tutorial.toTile(), ui);
    gameOver = new h2d.Bitmap(hxd.Res.gameOver.toTile(), ui);
    gameOver.alpha = 0;

    title = new h2d.Bitmap(hxd.Res.title.toTile(), ui);
    title.alpha = 1;
  }

  public function switchShape(shape : Int) {
    switch(shape) {
      case 0 :
          moveBitmap(hexagon, hexagon.x, s2d.width - 200, hexagon.y, (1 - 0.33) * 128, 0.33);
          scaleBitmap(hexagon, hexagon.scaleX, 0.33, 0.33);
          moveBitmap(square, square.x, s2d.width - 150, square.y, (1 - 0.5) * 128, 0.33);
          scaleBitmap(square, square.scaleX, 0.5, 0.33);
          moveBitmap(triangle, triangle.x, s2d.width - 100 + (0.33 * 64), triangle.y, (1 - 0.33) * 128, 0.33);
          scaleBitmap(triangle, triangle.scaleX, 0.33, 0.33);
      case 1 :
          moveBitmap(square, square.x, s2d.width - 200, square.y, (1 - 0.33) * 128, 0.33);
          scaleBitmap(square, square.scaleX, 0.33, 0.33);
          moveBitmap(triangle, triangle.x, s2d.width - 150, triangle.y, (1 - 0.5) * 128, 0.33);
          scaleBitmap(triangle, triangle.scaleX, 0.5, 0.33);
          moveBitmap(hexagon, hexagon.x, s2d.width - 100 + (0.33 * 64), hexagon.y, (1 - 0.33) * 128, 0.33);
          scaleBitmap(hexagon, hexagon.scaleX, 0.33, 0.33);
      case 2 :
          moveBitmap(triangle, triangle.x, s2d.width - 200, triangle.y, (1 - 0.33) * 128, 0.33);
          scaleBitmap(triangle, triangle.scaleX, 0.33, 0.33);
          moveBitmap(hexagon, hexagon.x, s2d.width - 150, hexagon.y, (1 - 0.5) * 128, 0.33);
          scaleBitmap(hexagon, hexagon.scaleX, 0.5, 0.33);
          moveBitmap(square, square.x, s2d.width - 100 + (0.33 * 64), square.y, (1 - 0.33) * 128, 0.33);
          scaleBitmap(square, square.scaleX, 0.33, 0.33);
    }
  }

  public function showGameOver() {
    fadeBitmap(gameOver, gameOver.alpha, 1, 2);
  }
  public function hideGameOver() {
    fadeBitmap(gameOver, gameOver.alpha, 0, 0.25);
    hexagon.x = s2d.width - 200; hexagon.setScale(0.33); hexagon.y = (1 - 0.33) * 128;
    square.x = s2d.width - 150; square.setScale(0.5); square.y = (1 - 0.5) * 128;
    triangle.x = s2d.width - 100 + (0.33 * 64); triangle.setScale(0.33); triangle.y = (1 - 0.33) * 128;
  }

  public function fadeBitmap(bitmap : h2d.Bitmap, from : Float, to : Float, duration : Float) {
    var clock = 0.0;
    bitmap.alpha = from;
    Game.instance.animations.push(function(dt : Float) {
      clock += dt / Game.instance.wantedFPS;
      if(clock > duration) {
        bitmap.alpha = to;
        return true;
      } else {
        bitmap.alpha = Math2.lerp(from, to, clock / duration);
        return false;
      }
    });
  }

  public function scaleBitmap(bitmap : h2d.Bitmap, from : Float, to : Float, duration : Float) {
    var clock = 0.0;
    bitmap.setScale(from);
    Game.instance.animations.push(function(dt : Float) {
      clock += dt / Game.instance.wantedFPS;
      if(clock > duration) {
        bitmap.setScale(to);
        return true;
      } else {
        bitmap.setScale(Math2.lerp(from, to, clock / duration));
        return false;
      }
    });
  }

  public function moveBitmap(bitmap : h2d.Bitmap, xFrom : Float, xTo : Float, yFrom : Float, yTo : Float, duration : Float) {
    var clock = 0.0;
    bitmap.x = xFrom;
    bitmap.y = yFrom;
    Game.instance.animations.push(function(dt : Float) {
      clock += dt / Game.instance.wantedFPS;
      if(clock > duration) {
        bitmap.x = xTo;
        bitmap.y = yTo;
        return true;
      } else {
        bitmap.x = Math2.lerp(xFrom, xTo, Math2.easeInOutBack(clock / duration, 0, 1, 1));
        bitmap.y = Math2.lerp(yFrom, yTo, Math2.easeInOutBack(clock / duration, 0, 1, 1));
        return false;
      }
    });
  }

  public function setHP(hp : Int) {
    for( i in 0...3 ) {
			hpBalls[i].tile = (hp > i) ? redBallTile : emptyBallTile;
		}
    this.hp = hp;
  }

  public function setShield(shield : Int) {
    for( i in 0...3 ) {
			shieldBalls[i].alpha = (shield > i) ? 1.0 : 0.0;
		}
  }

  public function setPowerUp(powerUp : Float) {
    powerUpFill.scaleX = powerUp / 100.0;
  }

  var titleOk = false;
  public function onEvent(e : hxd.Event) : Void {
    switch(e.kind) {
      case EKeyDown :
        switch(e.keyCode) {
          case 13: // Enter
            if(!titleOk) {
              fadeBitmap(title, title.alpha, 0, 0.25);
              titleOk = true;
            } else {
              fadeBitmap(tutorial, tutorial.alpha, 0, 0.25);
            }
          default :
        }
        default:
    }
  }
}
