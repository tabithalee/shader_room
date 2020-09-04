Shader "Holistic6/BlendTest" {
	Properties {
		_MainTex ("Texture", 2D) = "black" {}
	}
	SubShader {
		Tags {"Queue" = "Transparent"}

		//Blend SrcAlpha OneMinusSrcAlpha
		//Blend OneMinusDstColor Zero
		Blend OneMinusSrcColor One

		Pass{
			SetTexture [_MainTex] {combine texture}
		}
	}
}
