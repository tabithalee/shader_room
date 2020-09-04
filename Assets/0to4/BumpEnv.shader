Shader "Holistic/BumpEnv"
{
    Properties{
        _diffuseTex("Diffuse Texture", 2D) = "white" {}
    // note bump instead of white so it isn't interpreted as a colour image
        _bumpTex("Bump Texture", 2D) = "bump" {}
        _mySlider("Bump Amount", Range(0,10)) = 1
        _brightness("Brightness", Range(0,10)) = 1
        _myCube("Cube Map", CUBE) = "white" {}
    }
        SubShader{

          CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _diffuseTex;
            sampler2D _bumpTex;
            half _mySlider;
            half _brightness;
            samplerCUBE _myCube;

            struct Input {
                float2 uv_diffuseTex;
                float2 uv_bumpTex;
                float3 worldRefl; INTERNAL_DATA
            };

            void surf(Input IN, inout SurfaceOutput o) {
                o.Albedo = (tex2D(_diffuseTex, IN.uv_diffuseTex)).rgb * _brightness;
                o.Normal = UnpackNormal(tex2D(_bumpTex, IN.uv_bumpTex));
                o.Normal *= float3(_mySlider, _mySlider, 1);
                o.Emission = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
            }

          ENDCG
    }
        Fallback "Diffuse"
}
