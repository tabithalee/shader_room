Shader "Holistic/BumpDiffuse"
{
    Properties{
        _diffuseTex("Diffuse Texture", 2D) = "white" {}
        // note bump instead of white so it isn't interpreted as a colour image
        _bumpTex("Bump Texture", 2D) = "bump" {}
        _mySlider ("Bump Amount", Range(0,30)) = 1
        _brightness ("Brightness", Range(0,10)) = 1
        _scaleSlider ("Texture Bump Scale", Range(0.5,2)) = 1
    }
        SubShader{

          CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _diffuseTex;
            sampler2D _bumpTex;
            half _mySlider;
            half _brightness;
            half _scaleSlider;

            struct Input {
                float2 uv_diffuseTex;
                float2 uv_bumpTex;
            };

            void surf(Input IN, inout SurfaceOutput o) {
                o.Albedo = (tex2D(_diffuseTex, IN.uv_diffuseTex * _scaleSlider)).rgb * _brightness;
                o.Normal = UnpackNormal(tex2D(_bumpTex, IN.uv_bumpTex * _scaleSlider));
                o.Normal *= float3(_mySlider, _mySlider, 1);
            }

          ENDCG
    }
        Fallback "Diffuse"
}
