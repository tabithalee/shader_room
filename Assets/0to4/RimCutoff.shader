Shader "Holistic/RimCutOff"
{
    Properties{
        _RimColor("Rim Color", Color) = (0, 0.5, 0.5, 0)
        _RimColor2("Rim Color 2", Color) = (0, 0.5, 0.5, 0)
        _fillColor("Fill Color", Color) = (0, 0.5, 0.5, 0)
        _cutoffSlider("Dot Product Cutoff", Range(0, 1)) = 0.5
        _cutoffSlider2("Dot Product Cutoff 2", Range(0, 1)) = 0.3

    }

        SubShader{

          CGPROGRAM
            #pragma surface surf Lambert

            struct Input {
                float3 viewDir;
            };

            float4 _RimColor;
            float4 _RimColor2;
            float4 _fillColor;
            half _cutoffSlider;
            half _cutoffSlider2;

            void surf(Input IN, inout SurfaceOutput o) {
                half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
                //o.Emission = _RimColor.rgb * rim > _cutoffSlider ? rim : 0;
                //o.Emission = rim > _cutoffSlider ? _RimColor : 0;
                o.Emission = rim > _cutoffSlider ? _RimColor : rim > _cutoffSlider2 ? _RimColor2 : _fillColor;
            }

          ENDCG
    }
        Fallback "Diffuse"
}
