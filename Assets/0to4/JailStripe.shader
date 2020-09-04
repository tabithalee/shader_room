Shader "Holistic/WorldPosJailStripe"
{
    Properties{
        _diffuseTex("Diffuse Texture", 2D) = "white" {}
        _Color1("Color 1", Color) = (0, 0.5, 0.5, 0)
        _Color2("Color 2", Color) = (0, 0.5, 0.5, 0)
        _ratioSlider("Stripe Ratio Slider", Range(0, 1)) = 0.5
        _widthSlider("Stripe Width Slider", Range(1,20)) = 10
    }

        SubShader{

          CGPROGRAM
            #pragma surface surf Lambert

            struct Input {
                float2 uv_diffuseTex;
                float3 viewDir;
                float3 worldPos;
            };

            sampler2D _diffuseTex;
            float4 _Color1;
            float4 _Color2;
            half _ratioSlider;
            half _widthSlider;

            void surf(Input IN, inout SurfaceOutput o) {
                half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
                o.Emission = frac((IN.worldPos.y-1) * (20 - _widthSlider) * 0.5) > _ratioSlider ? _Color1 * rim : _Color2 * rim;
                o.Albedo = tex2D(_diffuseTex, IN.uv_diffuseTex);
            }

          ENDCG
    }
        Fallback "Diffuse"
}
