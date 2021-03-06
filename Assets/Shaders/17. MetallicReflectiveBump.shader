﻿Shader "SFS/MetallicReflectiveBump" {
	
	// Shades the geometry with a metallic reflective bump mapped material.
	// Takes a normal map and a cube map. The normal map is unwrapped onto the surface
	// normals and multiplied by a fixed factor. The cube map is used to set the Albedo.

	Properties {
		_NormalTex ("Normal Map", 2D) = "bump" {}
		_Cubemap ("Cube Map", CUBE) = "" {}
		_Bump ("Bump Amount", Range(0,10)) = 1
		_Intensity ("Intensity", Range(0,10)) = 1
		_Brightness ("Brightness", Range(0,5)) = 1
	}
	SubShader {

		CGPROGRAM

		#pragma surface surf Lambert

		uniform sampler2D _NormalTex;
		uniform samplerCUBE _Cubemap;
		float _Bump, _Intensity, _Brightness;

		struct Input
		{
			float2 uv_NormalTex;
			float3 worldRefl; INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Normal = UnpackNormal(tex2D(_NormalTex, IN.uv_NormalTex)) * 0.3;
			o.Normal *= float3(_Bump,_Bump,_Intensity);

			o.Albedo = texCUBE(_Cubemap, WorldReflectionVector(IN, o.Normal)).rgb * _Brightness;
			
			//o.Albedo = texCUBE(_Cubemap, IN.worldRefl).rgb * _Brightness;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
