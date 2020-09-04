Shader "Holistic/BasicLambert"
{
    Properties{
        _Colour("Colour", Color) = (1, 1, 1, 1)
    }

        SubShader{

            Tags{
                "Queue" = "Geometry"
            }

          CGPROGRAM
            #pragma surface surf Lambert

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
