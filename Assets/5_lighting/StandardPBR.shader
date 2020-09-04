Shader "Holistic/StandardPBR"
{
    Properties{
        _Colour("Colour", Color) = (1, 1, 1, 1)
        _MetallicTex("Metallic (R)", 2D) = "white" {}

         // a map to determine which parts of the map we want to be shiny
        _Metallic("Metallic", Range(0.0, 1.0)) = 0.0

        _myEmission("Emission", Range(0.0, 7.0)) = 0.0
    }

        SubShader{

            Tags{
                "Queue" = "Geometry"
            }

          CGPROGRAM
            #pragma surface surf Standard // note if using Standard the Input structure is now SurfaceOutputStandard

            sampler2D _MetallicTex;
            half _Metallic;
            half _myEmission;
            fixed4 _Colour;

            struct Input {
                float2 uv_MetallicTex;
            };

            void surf(Input IN, inout SurfaceOutputStandard o) {
                o.Albedo = _Colour.rgb;
                o.Smoothness = (1 - tex2D(_MetallicTex, IN.uv_MetallicTex).r);
                o.Metallic = _Metallic;
                o.Emission = _myEmission * tex2D(_MetallicTex, IN.uv_MetallicTex).r;
            }

          ENDCG
    }
        Fallback "Diffuse"
}
