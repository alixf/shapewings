package shaders;

class SkyShader extends hxsl.Shader {

	static var SRC = {
			@global var camera : {
				var view : Mat4;
				var proj : Mat4;
			};

			@input var input : {
				var position : Vec3;
				var uv : Vec2;
			};

			var output : {
				var position : Vec4;
				var color : Vec4;
				var depth : Float;
			}

			var calculatedUV : Vec2;
			var calculatedPosition : Vec3;

			function vertex() {
				calculatedUV = input.uv;
				output.position = vec4(input.position, 1);
				output.position = camera.view * camera.proj * output.position;
			}

			function fragment() {
				output.color = vec4(calculatedUV.xyx, 1);
			}
		}
}
