class Clouds {

  var clouds = new Array<h3d.scene.CustomObject>();
  public var sceneObject = new h3d.scene.Object();

  public function new() {

  	var gridMesh = new h3d.prim.Grid(1, 1);
  	gridMesh.uvs = [for( y in 0...2 ) for( x in 0...2 ) new h3d.prim.UV(x, 1-y)];
  	gridMesh.addNormals();

    var textures = [
      hxd.Res.cloud1.toTexture(),
      hxd.Res.cloud2.toTexture(),
      hxd.Res.cloud3.toTexture()
    ];

    for(i in 0...3) {
      var material = new h3d.mat.Material(new shaders.BaseTexturedMesh());
      material.mainPass.getShader(shaders.BaseTexturedMesh).color = new h3d.Vector(1,1,1,0.5);
      material.mainPass.getShader(shaders.BaseTexturedMesh).ambient = new h3d.Vector(1,1,1,1);
      material.mainPass.getShader(shaders.BaseTexturedMesh).diffuse = textures[i];
      material.mainPass.blend(SrcAlpha, OneMinusSrcAlpha);
      material.mainPass.depthWrite = false;
      material.mainPass.depthTest = Always;
      material.mainPass.culling = None;

      var cloud = new h3d.scene.CustomObject(gridMesh, material);
      cloud.setScale(10);
      cloud.setPos(-5, -5, near + (i/3.0) * (spacing - near));
      clouds.push(cloud);
      sceneObject.addChild(cloud);
    }
  }
  var near = 2.0;
  var spacing = 20.0;

  public function update(dt : Float) : Void {
    for(cloud in clouds) {
      cloud.z -= dt * 0.25;

      var alpha = -Math.abs((cloud.z-(spacing/2)-near)/(spacing/2))+1;
      cloud.material.mainPass.getShader(shaders.BaseTexturedMesh).color = new h3d.Vector(1,1,1, alpha);
      if(cloud.z < near) {
        cloud.z = spacing;
        // cloud.material.mainPass.getShader(shaders.BaseTexturedMesh).color = new h3d.Vector(1,1,1,1);
      }
    }
  }
}
