Shader "Holistic/WorldPosStripe"
{
    Properties{
        _Color1("Color 1", Color) = (0, 0.5, 0.5, 0)
        _Color2("Color 2", Color) = (0, 0.5, 0.5, 0)
        _Color3("Color 3", Color) = (0, 0.5, 0.5, 0)
        _cutoffSlider("Dot Product Cutoff", Range(0, 1)) = 0.5
        _cutoffSlider2("Dot Product Cutoff 2", Range(0, 1)) = 1

    }

        SubShader{

          CGPROGRAM
            #pragma surface surf Lambert

            struct Input {
                float3 viewDir;
                float3 worldPos;
            };

            float4 _Color1;
            float4 _Color2;
            float4 _Color3;
            half _cutoffSlider;
            half _cutoffSlider2;

            void surf(Input IN, inout SurfaceOutput o) {
                o.Albedo = (IN.worldPos.y -1) > _cutoffSlider ? _Color1 : (IN.worldPos.y-1) > _cutoffSlider2 ? _Color2 : _Color3;
            }

          ENDCG
    }
        Fallback "Diffuse"
}
