Shader "Holistic/PropChallenge4" {

	Properties{
		_myDiffuseTex("Diffuse Texture", 2D) = "white" {}
		_myEmissiveTex("Emissive Texture", 2D) = "white" {}
		_eSlider("Emissive Slider", Range(1, 3)) = 1
		_dSlider("Diffuse Slider", Range(0, 1)) = 1

	}

		SubShader{

			CGPROGRAM
				#pragma surface surf Lambert

				struct Input {
					float2 uv_myDiffuseTex;
				};

				sampler2D _myDiffuseTex;
				sampler2D _myEmissiveTex;
				half _eSlider;
				half _dSlider;

				void surf(Input IN, inout SurfaceOutput o) {
					o.Albedo = tex2D(_myDiffuseTex, IN.uv_myDiffuseTex).rgb;
					o.Emission = tex2D(_myEmissiveTex, IN.uv_myDiffuseTex).rgb;
					o.Albedo *= float3(_dSlider, _dSlider, _dSlider);
					o.Emission *= float3(_eSlider, _eSlider, _eSlider);

				}

			ENDCG
	}

		FallBack "Diffuse"
}