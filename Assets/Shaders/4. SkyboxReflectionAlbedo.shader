﻿Shader "SFS/SkyboxReflectionAlbedo" {
	
	// Shades the object with a given diffuse texture plus a given cube map to set
	// the emission based on the reflection vector for each pixel, generating a
	// reflection effect. If the geometry is flat shaded it should behave as a perfect
	// mirror (no interpolation of the reflection vector before sampling the cube map)
	// In contrast with previous shader it also accepts a color to compose with the reflective one

	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_Range ("Range Value", Range(0,5)) = 1
		_MainTex ("Main Texture (RGB)", 2D) = "white" {}
		_Cubemap ("Cube Map", CUBE) = "" {}
		_Float ("Float Value", Float) = 1
		_Vector ("Vector", Vector) = (1,1,1,1)
	}
	SubShader {

		CGPROGRAM

		#pragma surface surf Lambert

		fixed4 _Color;
		half _Range;
		sampler2D _MainTex;
		samplerCUBE _Cubemap;
		float _Float;
		float4 _Vector;

		struct Input {
			float2 uv_MainTex;
			float3 worldRefl;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Color.rgb + (tex2D(_MainTex, IN.uv_MainTex) * _Range).rgb;
			o.Emission = texCUBE(_Cubemap, IN.worldRefl).rgb;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
