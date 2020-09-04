Shader "Holistic/PropChallenge3" {

	Properties{
		_myTex("Example Texture", 2D) = "white" {}
	}

		SubShader{

			CGPROGRAM
				#pragma surface surf Lambert

				struct Input {
					float2 uv_myTex;
				};

				sampler2D _myTex;

				void surf(Input IN, inout SurfaceOutput o) {
					fixed4 green = fixed4(1, 0, 1, 1);
					o.Albedo = (tex2D(_myTex, IN.uv_myTex) * green).rgb;

				}

			ENDCG
	}

		FallBack "Diffuse"
}