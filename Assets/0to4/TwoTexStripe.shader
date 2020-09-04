Shader "Holistic/TwoTexStripe"
{
    Properties{
       _stripeTex1("Stripe Texture 1", 2D) = "white" {}
       _stripeTex2("Stripe Texture 2", 2D) = "white" {}
       _widthSlider("Stripe Width Slider", Range(1,20)) = 10
    }

        SubShader{

          CGPROGRAM
            #pragma surface surf Lambert

            struct Input {
                float2 uv_stripeTex1;
                float2 uv_stripeTex2;
                float3 viewDir;
                float3 worldPos;
            };

            sampler2D _stripeTex1;
            sampler2D _stripeTex2;
            half _ratioSlider;
            half _widthSlider;

            void surf(Input IN, inout SurfaceOutput o) {
                half rim = saturate(dot(normalize(IN.viewDir), o.Normal));
                o.Emission = frac(IN.worldPos.y * (20 - _widthSlider) * 0.5) > 0.4 ? 
                    tex2D(_stripeTex1, IN.uv_stripeTex1) * rim : tex2D(_stripeTex2, IN.uv_stripeTex2) * rim;
                o.Emission *= frac(IN.worldPos.x * (20 - _widthSlider) * 0.5) > 0.4 ?
                    tex2D(_stripeTex1, IN.uv_stripeTex1) * rim : tex2D(_stripeTex2, IN.uv_stripeTex2) * rim;
            }

          ENDCG
        }
            Fallback "Diffuse"
}
