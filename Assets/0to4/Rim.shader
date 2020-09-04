Shader "Holistic/Rim"
{
    Properties{
        _RimColor ("Rim Color", Color) = (0, 0.5, 0.5, 0)
        _powerSlider ("Power Slider", Range (0.5,8)) = 1

    }

    SubShader{

      CGPROGRAM
        #pragma surface surf Lambert

        struct Input {
            float3 viewDir;
        };

        float4 _RimColor;
        half _powerSlider;

        void surf(Input IN, inout SurfaceOutput o) {
            half rim = 1 - saturate(dot(normalize(IN.viewDir), o.Normal));
            o.Emission = _RimColor.rgb * pow(rim, _powerSlider);
        }

      ENDCG
    }
        Fallback "Diffuse"
}
