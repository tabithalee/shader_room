Shader "Holistic/MyBasicLambert"
{
    Properties{
        _Colour("Colour", Color) = (1, 1, 1, 1)
    }

        SubShader{

            Tags{
                "Queue" = "Geometry"
            }

          CGPROGRAM
            #pragma surface surf BasicLambert

            // atten for attenuation of light intensity
            half4 LightingBasicLambert(SurfaceOutput s, half3 lightDir, half atten) {
                half NdotL = dot(s.Normal, lightDir);
                half4 c;
                c.rgb = s.Albedo * _LightColor0.rgb * saturate(NdotL * atten);
                c.a = s.Alpha;
                return c;
            }

            float4 _Colour;

            struct Input {
                float2 uv_MainTex;
            };

            void surf(Input IN, inout SurfaceOutput o) {
                o.Albedo = _Colour.rgb;
            }

          ENDCG
    }
        Fallback "Diffuse"
}
