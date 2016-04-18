class Levels {
  public function new() {
  }

  var levels : Array<{enemies : Array<Dynamic>, environment : Int}> = [
    {
      enemies : [
        {type : 0, x : 0, y : 0, delay : 2.0, hp : 2, stopAt : 10.0},
        {type : 4},
        {type : 0, x : -1, y : 0, delay : 0.0, hp : 2, stopAt : 10.0},
        {type : 0, x : 1, y : 0, delay : 2.0, hp : 2, stopAt : 10.0},
        {type : 4},
        {type : 0, x : -1, y : -0.5, delay : 0.0, hp : 2, stopAt : 10.0},
        {type : 0, x : 0, y : 0, delay : 0.5, hp : 2, stopAt : 10.0},
        {type : 1, x : 1, y : 0.5, delay : 2.5, hp : 2, stopAt : 10.0},
        {type : 4},
        {type : 0, x : -1, y : -1, delay : 0, hp : 3, stopAt : 10.0},
        {type : 1, x : 1, y : 1, delay : 0.5, hp : 3, stopAt : 10.0},
        {type : 0, x : -1, y : 1, delay : 1.5, hp : 3, stopAt : 10.0},
        {type : 1, x : 1, y : -1, delay : 2, hp : 3, stopAt : 10.0},
        {type : 4},
        {type : 0, x : -0.5, y : -0.5, delay : 0, hp : 3, stopAt : 10.0},
        {type : 0, x : 0, y : -0.5, delay : 2, hp : 3, stopAt : 10.0},
        {type : 0, x : 0.5, y : -0.5, delay : 3, hp : 3, stopAt : 10.0},
        {type : 1, x : 0.5, y : 0.5, delay : 4, hp : 3, stopAt : 10.0},
        {type : 1, x : 0, y : 0.5, delay : 5, hp : 4, stopAt : 10.0},
        {type : 1, x : -0.5, y : 0.5, delay : 6, hp : 4, stopAt : 10.0},
        {type : 2, x : 0, y : 0, delay : 7, hp : 5, stopAt : 10.0},
        {type : 4},
      ],
      environment : 0
    },
    {
      enemies : [
        {type : 0, x : -0.5, y : -0.5, delay : 3, hp : 3, stopAt : 10.0},
        {type : 0, x : 0, y : -0.5, delay : 3, hp : 3, stopAt : 10.0},
        {type : 0, x : 0.5, y : -0.5, delay : 3, hp : 3, stopAt : 10.0},
        {type : 1, x : 0.5, y : 0.5, delay : 3, hp : 3, stopAt : 10.0},
        {type : 1, x : 0, y : 0.5, delay : 3, hp : 4, stopAt : 10.0},
        {type : 1, x : -0.5, y : 0.5, delay : 3, hp : 4, stopAt : 10.0},
        {type : 2, x : 0, y : 0, delay : 3, hp : 5, stopAt : 10.0},
        {type : 4},
        {type : 0, x : Math.cos(0.0 / 8.0 * Math.PI*2), y : Math.sin(0.0 / 8.0 * Math.PI*2), delay : 1, hp : 2, stopAt : 10.0},
        {type : 0, x : Math.cos(1.0 / 8.0 * Math.PI*2), y : Math.sin(1.0 / 8.0 * Math.PI*2), delay : 2, hp : 3, stopAt : 10.0},
        {type : 0, x : Math.cos(2.0 / 8.0 * Math.PI*2), y : Math.sin(2.0 / 8.0 * Math.PI*2), delay : 3, hp : 2, stopAt : 10.0},
        {type : 0, x : Math.cos(3.0 / 8.0 * Math.PI*2), y : Math.sin(3.0 / 8.0 * Math.PI*2), delay : 4, hp : 3, stopAt : 10.0},
        {type : 0, x : Math.cos(4.0 / 8.0 * Math.PI*2), y : Math.sin(4.0 / 8.0 * Math.PI*2), delay : 5, hp : 2, stopAt : 10.0},
        {type : 0, x : Math.cos(5.0 / 8.0 * Math.PI*2), y : Math.sin(5.0 / 8.0 * Math.PI*2), delay : 6, hp : 3, stopAt : 10.0},
        {type : 0, x : Math.cos(6.0 / 8.0 * Math.PI*2), y : Math.sin(6.0 / 8.0 * Math.PI*2), delay : 7, hp : 2, stopAt : 10.0},
        {type : 0, x : Math.cos(7.0 / 8.0 * Math.PI*2), y : Math.sin(7.0 / 8.0 * Math.PI*2), delay : 8, hp : 3, stopAt : 10.0},
        {type : 4},
        {type : 1, x : Math.cos(0.0 / 8.0 * Math.PI*2), y : Math.sin(0.0 / 8.0 * Math.PI*2), delay : 1, hp : 12, stopAt : 10.0},
        {type : 1, x : Math.cos(1.0 / 8.0 * Math.PI*2), y : Math.sin(1.0 / 8.0 * Math.PI*2), delay : 2, hp : 13, stopAt : 10.0},
        {type : 1, x : Math.cos(2.0 / 8.0 * Math.PI*2), y : Math.sin(2.0 / 8.0 * Math.PI*2), delay : 3, hp : 12, stopAt : 10.0},
        {type : 1, x : Math.cos(3.0 / 8.0 * Math.PI*2), y : Math.sin(3.0 / 8.0 * Math.PI*2), delay : 4, hp : 13, stopAt : 10.0},
        {type : 1, x : Math.cos(4.0 / 8.0 * Math.PI*2), y : Math.sin(4.0 / 8.0 * Math.PI*2), delay : 5, hp : 12, stopAt : 10.0},
        {type : 1, x : Math.cos(5.0 / 8.0 * Math.PI*2), y : Math.sin(5.0 / 8.0 * Math.PI*2), delay : 5.5, hp : 13, stopAt : 10.0},
        {type : 1, x : Math.cos(6.0 / 8.0 * Math.PI*2), y : Math.sin(6.0 / 8.0 * Math.PI*2), delay : 6, hp : 12, stopAt : 10.0},
        {type : 1, x : Math.cos(7.0 / 8.0 * Math.PI*2), y : Math.sin(7.0 / 8.0 * Math.PI*2), delay : 6.4, hp : 13, stopAt : 10.0},
        {type : 4},
        {type : 2, x : Math.cos(7.0 / 8.0 * Math.PI*2), y : Math.sin(7.0 / 8.0 * Math.PI*2), delay : 1, hp : 12, stopAt : 10.0},
        {type : 2, x : Math.cos(6.0 / 8.0 * Math.PI*2), y : Math.sin(6.0 / 8.0 * Math.PI*2), delay : 1.5, hp : 13, stopAt : 10.0},
        {type : 2, x : Math.cos(5.0 / 8.0 * Math.PI*2), y : Math.sin(5.0 / 8.0 * Math.PI*2), delay : 2, hp : 12, stopAt : 10.0},
        {type : 2, x : Math.cos(4.0 / 8.0 * Math.PI*2), y : Math.sin(4.0 / 8.0 * Math.PI*2), delay : 2.5, hp : 13, stopAt : 10.0},
        {type : 2, x : Math.cos(3.0 / 8.0 * Math.PI*2), y : Math.sin(3.0 / 8.0 * Math.PI*2), delay : 3, hp : 12, stopAt : 10.0},
        {type : 2, x : Math.cos(2.0 / 8.0 * Math.PI*2), y : Math.sin(2.0 / 8.0 * Math.PI*2), delay : 3.5, hp : 13, stopAt : 10.0},
        {type : 2, x : Math.cos(1.0 / 8.0 * Math.PI*2), y : Math.sin(1.0 / 8.0 * Math.PI*2), delay : 4, hp : 12, stopAt : 10.0},
        {type : 2, x : Math.cos(0.0 / 8.0 * Math.PI*2), y : Math.sin(0.0 / 8.0 * Math.PI*2), delay : 4.5, hp : 13, stopAt : 10.0},
        {type : 4},
        {type : 2, x : -0.5, y : -0.5, delay : 0, hp : 10, stopAt : 10.0},
        {type : 1, x : 0, y : -0.5, delay : 2, hp : 10, stopAt : 10.0},
        {type : 2, x : 0.5, y : -0.5, delay : 3, hp : 10, stopAt : 10.0},
        {type : 2, x : 0.5, y : 0.5, delay : 4, hp : 10, stopAt : 10.0},
        {type : 1, x : 0, y : 0.5, delay : 5, hp : 10, stopAt : 10.0},
        {type : 2, x : -0.5, y : 0.5, delay : 6, hp : 10, stopAt : 10.0},
        {type : 1, x : -0.5, y : 0, delay : 7, hp : 10, stopAt : 10.0},
        {type : 0, x : 0, y : 0, delay : 7, hp : 10, stopAt : 10.0},
        {type : 1, x : 0.5, y : 0, delay : 7, hp : 10, stopAt : 10.0},
        {type : 4},
      ],
      environment : 1
    },
    {
      enemies : [
        {type : 0, x : -0.5, y : -0.5, delay : 0, hp : 10, stopAt : 10.0},
        {type : 1, x : 0, y : -0.5, delay : 2, hp : 10, stopAt : 10.0},
        {type : 0, x : 0.5, y : -0.5, delay : 3, hp : 10, stopAt : 10.0},
        {type : 1, x : 0.5, y : 0.5, delay : 4, hp : 10, stopAt : 10.0},
        {type : 0, x : 0, y : 0.5, delay : 5, hp : 10, stopAt : 10.0},
        {type : 1, x : -0.5, y : 0.5, delay : 6, hp : 10, stopAt : 10.0},
        {type : 0, x : -0.5, y : 0, delay : 7, hp : 10, stopAt : 10.0},
        {type : 1, x : 0, y : 0, delay : 7, hp : 10, stopAt : 10.0},
        {type : 0, x : 0.5, y : 0, delay : 7, hp : 10, stopAt : 10.0},
        {type : 4},
        {type : 2, x : Math.cos(7.0 / 8.0 * Math.PI*2), y : Math.sin(7.0 / 8.0 * Math.PI*2), delay : 1, hp : 10, stopAt : 10.0},
        {type : 1, x : Math.cos(6.0 / 8.0 * Math.PI*2), y : Math.sin(6.0 / 8.0 * Math.PI*2), delay : 3, hp : 10, stopAt : 10.0},
        {type : 2, x : Math.cos(5.0 / 8.0 * Math.PI*2), y : Math.sin(5.0 / 8.0 * Math.PI*2), delay : 1.5, hp : 10, stopAt : 10.0},
        {type : 1, x : Math.cos(4.0 / 8.0 * Math.PI*2), y : Math.sin(4.0 / 8.0 * Math.PI*2), delay : 3.5, hp : 10, stopAt : 10.0},
        {type : 2, x : Math.cos(3.0 / 8.0 * Math.PI*2), y : Math.sin(3.0 / 8.0 * Math.PI*2), delay : 2, hp : 10, stopAt : 10.0},
        {type : 1, x : Math.cos(2.0 / 8.0 * Math.PI*2), y : Math.sin(2.0 / 8.0 * Math.PI*2), delay : 4, hp : 10, stopAt : 10.0},
        {type : 2, x : Math.cos(1.0 / 8.0 * Math.PI*2), y : Math.sin(1.0 / 8.0 * Math.PI*2), delay : 2.5, hp : 10, stopAt : 10.0},
        {type : 1, x : Math.cos(0.0 / 8.0 * Math.PI*2), y : Math.sin(0.0 / 8.0 * Math.PI*2), delay : 4.5, hp : 10, stopAt : 10.0},
        {type : 4},
        {type : 3, x : Math.cos(7.0 / 8.0 * Math.PI*2), y : Math.sin(7.0 / 8.0 * Math.PI*2), delay : 0.5, hp : 20, stopAt : 10.0},
        {type : 1, x : Math.cos(6.0 / 8.0 * Math.PI*2), y : Math.sin(6.0 / 8.0 * Math.PI*2), delay : 0.5, hp : 20, stopAt : 10.0},
        {type : 2, x : Math.cos(5.0 / 8.0 * Math.PI*2), y : Math.sin(5.0 / 8.0 * Math.PI*2), delay : 1, hp : 20, stopAt : 10.0},
        {type : 3, x : Math.cos(4.0 / 8.0 * Math.PI*2), y : Math.sin(4.0 / 8.0 * Math.PI*2), delay : 1, hp : 20, stopAt : 10.0},
        {type : 2, x : Math.cos(3.0 / 8.0 * Math.PI*2), y : Math.sin(3.0 / 8.0 * Math.PI*2), delay : 1.5, hp : 20, stopAt : 10.0},
        {type : 1, x : Math.cos(2.0 / 8.0 * Math.PI*2), y : Math.sin(2.0 / 8.0 * Math.PI*2), delay : 1.5, hp : 20, stopAt : 10.0},
        {type : 2, x : Math.cos(1.0 / 8.0 * Math.PI*2), y : Math.sin(1.0 / 8.0 * Math.PI*2), delay : 2, hp : 20, stopAt : 10.0},
        {type : 3, x : Math.cos(0.0 / 8.0 * Math.PI*2), y : Math.sin(0.0 / 8.0 * Math.PI*2), delay : 2, hp : 20, stopAt : 10.0},
        {type : 4},
        {type : 2, x : Math.cos(0.0 / 8.0 * Math.PI*2), y : Math.sin(0.0 / 8.0 * Math.PI*2), delay : 0, hp : 12, stopAt : 10.0},
        {type : 2, x : Math.cos(1.0 / 8.0 * Math.PI*2), y : Math.sin(1.0 / 8.0 * Math.PI*2), delay : 0, hp : 13, stopAt : 10.0},
        {type : 2, x : Math.cos(2.0 / 8.0 * Math.PI*2), y : 0.25, delay : 0, hp : 12, stopAt : 10.0},
        {type : 2, x : Math.cos(3.0 / 8.0 * Math.PI*2), y : Math.sin(3.0 / 8.0 * Math.PI*2), delay : 0, hp : 13, stopAt : 10.0},
        {type : 2, x : Math.cos(4.0 / 8.0 * Math.PI*2), y : Math.sin(4.0 / 8.0 * Math.PI*2), delay : 0, hp : 12, stopAt : 10.0},
        {type : 2, x : Math.cos(5.0 / 8.0 * Math.PI*2), y : Math.sin(5.0 / 8.0 * Math.PI*2), delay : 0, hp : 13, stopAt : 10.0},
        {type : 2, x : Math.cos(6.0 / 8.0 * Math.PI*2), y : Math.sin(6.0 / 8.0 * Math.PI*2), delay : 0, hp : 12, stopAt : 10.0},
        {type : 2, x : Math.cos(7.0 / 8.0 * Math.PI*2), y : Math.sin(7.0 / 8.0 * Math.PI*2), delay : 0, hp : 13, stopAt : 10.0},
      ],
      environment : 2
    }
  ];

  var currentLevel : Null<{enemies : Array<Dynamic>}>;
  var enemyIndex : Int;
  var levelIndex = 0;
  var currentSong : hxd.res.Sound;

  public function startLevel(level : Int) {
    levelIndex = level;
    currentLevel = levels[level];
    enemyIndex = 0;
    clock = 0.0;

    if(currentSong != null)
      currentSong.stop();
    currentSong = switch(level) {
      case 1 : hxd.Res.song2_150;
      case 2 : hxd.Res.song2_180;
      default : hxd.Res.song2_120;
    }
		currentSong.play(true, 0.33);
  }

  var clock = 0.0;
  public function update(dt : Float) {
    if(currentLevel == null)
      return;

    clock += dt / Game.instance.wantedFPS;

    if(enemyIndex >= currentLevel.enemies.length) {
      nextLevel();
      return;
    }

    var nextEnemy = currentLevel.enemies[enemyIndex];

    if(nextEnemy.type == 4) {
      if(Game.instance.enemies.length == 0) {
        clock = 0.0;
        enemyIndex++;
      }
    } else {
      if(clock > nextEnemy.delay) {
        var newEnemy = new Enemy(nextEnemy.type);
        newEnemy.stopAt = nextEnemy.stopAt;
		    newEnemy.sceneObject.setPos(nextEnemy.x * 0.75, nextEnemy.y * 0.5, 30.0);
        newEnemy.hp = nextEnemy.hp;
        Game.instance.addEnemy(newEnemy);
        enemyIndex++;
      }
    }
  }

  public function nextLevel() {
    startLevel(cast Math.min(levels.length, levelIndex+1));
  }
}
