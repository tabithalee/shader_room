Shader "Holistic/BumpEnvChallenge"
{
    Properties{
        _normalTex("Normal Map", 2D) = "bump" {}
        _myCube("Cube Map", CUBE) = "white" {}
    }
        SubShader{

        // Render Queue Stuff
        // make sure you set the "from shader" setting  in inspector
        // Tags {"Queue" = "Geometry+100"}
        // ZWrite Off // Uncomment if you want to turn off the Z Buffer

          CGPROGRAM
            #pragma surface surf Lambert

            sampler2D _normalTex;
            samplerCUBE _myCube;

            struct Input {
                float2 uv_normalTex;
                float3 worldRefl; INTERNAL_DATA
            };

            void surf(Input IN, inout SurfaceOutput o) {
                IN.worldRefl *= -1; // negative worldRefl gives mirror-like effect, otherwise transparency effect
                o.Normal = UnpackNormal(tex2D(_normalTex, IN.uv_normalTex)) * 0.3;
                o.Albedo = texCUBE(_myCube, WorldReflectionVector(IN, o.Normal)).rgb;
            }

          ENDCG
    }
        Fallback "Diffuse"
}
