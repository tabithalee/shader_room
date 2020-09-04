Shader "Holistic8/Ocean" {
		Properties
		{
			_MainTex("Diffuse", 2D) = "white" {}
			_UnderTex("Under", 2D) = "white" {}

			_Tint("Colour Tint", Color) = (1,1,1,1)
			_Freq("Frequency", Range(0,5)) = 3
			_Speed("Speed", Range(0,100)) = 10
			_Amp("Amplitude", Range(0,1)) = 0.5

			_ScrollY("Scroll Y", Range(-5,5)) = 1
			_ScrollY2("Scroll Y 2", Range(-5,5)) = 1
		}
			SubShader
			{
				CGPROGRAM
				#pragma surface surf Lambert vertex:vert

				struct Input {
					float2 uv_MainTex;
					float2 uv_UnderTex;
					float3 vertColor;
				};

				float4 _Tint;
				float _Freq;
				float _Speed;
				float _Amp;
				float _ScrollY;
				float _ScrollY2;

				struct appdata
				{
					float4 vertex : POSITION;
					float3 normal : NORMAL;
					float4 texcoord : TEXCOORD0;
					float4 texcoord1 : TEXCOORD1;
					float4 texcoord2 : TEXCOORD2;
				};

				void vert(inout appdata v, out Input o)
				{
					UNITY_INITIALIZE_OUTPUT(Input, o);
					float t = _Time * _Speed;
					float waveHeight = sin(t + v.vertex.x * _Freq) * _Amp +
						sin(t * 2 + v.vertex.x * _Freq * 2) * _Amp;
					v.vertex.y = v.vertex.y + waveHeight;
					v.normal = normalize(float3(v.normal.x + waveHeight, v.normal.y, v.normal.z));
					o.vertColor = 0.35 * (waveHeight + 2);
				}

				sampler2D _MainTex;
				sampler2D _UnderTex;

				void surf(Input IN, inout SurfaceOutput o)
				{
					_ScrollY *= _Time;
					_ScrollY2 *= 2 * _Time;
					float2 newuv = IN.uv_MainTex + float2(_ScrollY, _ScrollY);
					float2 newuv2 = IN.uv_UnderTex + float2(_ScrollY2, _ScrollY2);
					o.Albedo = 0.5 * (tex2D(_MainTex, newuv) + tex2D(_UnderTex, newuv2)) * IN.vertColor.rgb;
				}
				ENDCG
			}
	}