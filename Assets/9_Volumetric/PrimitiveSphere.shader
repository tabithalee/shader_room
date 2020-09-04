Shader "Holistic9/PrimitiveSphere"
{
	Properties
	{
		_WhitesColor ("Egg Whites Color", Color) = (1,1,1,1)
		_YolkColor ("Egg Yolk Color", Color) = (1,1,0,1)
		_LightFactor ("LightAmount", Range(1,5)) = 1
		_ShadowLimit ("Decrease Shadows", Range(0,0.5)) = 0
		_RadiusSlider("Radius Slider", Range(0, 0.5)) = 0.25
		_EggOrigin("Egg Origin Adjuster", Vector) = (0,0,0)
	}
	SubShader
	{
		Tags { "Queue"="Transparent" }
		Blend SrcAlpha OneMinusSrcAlpha

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				//float3 normal : NORMAL;
			};

			struct v2f
			{
				float3 wPos : TEXCOORD0;
				// declaring a coordinate for saving origin in later
				float3 oPos : TEXCOORD1;
				float4 pos : SV_POSITION;
				//fixed4 diff : COLOR0;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.wPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				// saving the origin of the object; 4th coordinate should always be 1 for points
				o.oPos = mul(unity_ObjectToWorld, float4(0, 0, 0, 1)).xyz;
				//half3 worldNormal = UnityObjectToWorldNormal(v.normal);
				//half nl = max(0, dot(worldNormal, _WorldSpaceLightPos0.xyz));
				//o.diff = nl * _LightColor0;
				return o;
			}

			float _RadiusSlider;
			float3 _EggOrigin;

			#define STEPS 64
			#define STEP_SIZE 0.01

			bool SphereHit(float3 p, float3 centre, float radius)
			{
				return distance(p, centre) < radius;
			}

			float3 RaymarchHit(float3 origin, float3 position, float3 direction) {
				for (int i = 0; i < STEPS; i++) {

					if (SphereHit(position, origin, _RadiusSlider))
						return position;

					position += direction * STEP_SIZE;
				}

				return float3(0,0,0);
			}

			float4 _WhitesColor;
			float4 _YolkColor;
			float _LightFactor;
			float _ShadowLimit;
			
			fixed4 frag(v2f i) : SV_Target
			{
				float3 viewDirection = normalize(i.wPos - _WorldSpaceCameraPos);
				//world pos is the position of the PIXEL in world coordinates
				float3 worldPosition = i.wPos;
				float3 origin = i.oPos + _EggOrigin;
				float3 depth = RaymarchHit(origin, worldPosition, viewDirection);

				half3 worldNormal = depth - origin;
				half nl = max(_ShadowLimit, dot(worldNormal, _WorldSpaceLightPos0.xyz));

				if (length(depth) != 0)
				{
					depth *= _LightFactor * nl * _LightColor0;
					return _YolkColor * fixed4 (depth, 1);
				}
				else
				{
					return _WhitesColor;
				}
			}
			ENDCG
		}
	}
}
