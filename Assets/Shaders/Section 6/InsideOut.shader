Shader "Holistic6/InsideOut" {
	Properties{
		_MainTex("Diffuse", 2D) = "white" {}
	}

		SubShader{
			Tags{
				"Queue" = "Geometry"
			}

			Cull Front

			CGPROGRAM
			#pragma surface surf Lambert vertex:vert

			sampler2D _MainTex;

			struct Input {
				float2 uv_MainTex;
			};

			void vert(inout appdata_full v) {
				v.normal.xyz = v.normal * -1;
			}

			void surf(Input IN, inout SurfaceOutput o) {
				o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
			}

			ENDCG
	}
		Fallback "Diffuse"
}