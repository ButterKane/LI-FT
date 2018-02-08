// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Custom/SH_Water"
{
	Properties
	{
		_Texture0("Texture 0", 2D) = "white" {}
		_Tile_01("Tile_01", Int) = 100
		_Tile_02("Tile_02", Int) = 50
		_Direction_01("Direction_01", Range( 0 , 360)) = 0
		_Direction_02("Direction_02", Range( 0 , 360)) = 180
		_Amplitude_01("Amplitude_01", Int) = 5
		_Amplitude_02("Amplitude_02", Int) = 5
		_ColorLight("ColorLight", Color) = (1,0,0,0)
		_ColorDeep("ColorDeep", Color) = (0.1801471,0.558722,0.875,0)
		_Smoothness("Smoothness", Range( 0 , 1)) = 0.9149065
		_Spec_Int("Spec_Int", Range( 0 , 1)) = 0
		_SpecColor_Int("SpecColor_Int", Range( 0 , 1)) = 0
		_Translucency_Int("Translucency_Int", Range( 0 , 10)) = 0
		_Tesselation("Tesselation", Int) = 0
		[Header(Translucency)]
		_Translucency("Strength", Range( 0 , 50)) = 1
		_TransNormalDistortion("Normal Distortion", Range( 0 , 1)) = 0.1
		_TransScattering("Scaterring Falloff", Range( 1 , 50)) = 2
		_TransDirect("Direct", Range( 0 , 1)) = 1
		_TransAmbient("Ambient", Range( 0 , 1)) = 0.2
		[Toggle]_SwitchZtoY("Switch Z to Y", Int) = 0
		_TransShadow("Shadow", Range( 0 , 1)) = 0.9
		_DepthFadeColorInfluence("DepthFadeColorInfluence", Range( 0 , 1)) = 0
		_DepthFade("DepthFade", Float) = 1
		[Header(Refraction)]
		_ChromaticAberration("Chromatic Aberration", Range( 0 , 0.3)) = 0.1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" }
		Cull Back
		GrabPass{ }
		CGPROGRAM
		#include "UnityCG.cginc"
		#include "UnityPBSLighting.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 5.0
		#pragma multi_compile _ALPHAPREMULTIPLY_ON
		#pragma shader_feature _SWITCHZTOY_ON
		#pragma surface surf StandardSpecularCustom alpha:fade keepalpha finalcolor:RefractionF exclude_path:deferred nofog vertex:vertexDataFunc tessellate:tessFunction 
		struct Input
		{
			float3 worldPos;
			float4 screenPos;
			INTERNAL_DATA
			float3 worldNormal;
		};

		struct appdata
		{
			float4 vertex : POSITION;
			float4 tangent : TANGENT;
			float3 normal : NORMAL;
			float4 texcoord : TEXCOORD0;
			float4 texcoord1 : TEXCOORD1;
			float4 texcoord2 : TEXCOORD2;
			float4 texcoord3 : TEXCOORD3;
			fixed4 color : COLOR;
			UNITY_VERTEX_INPUT_INSTANCE_ID
		};

		struct SurfaceOutputStandardSpecularCustom
		{
			fixed3 Albedo;
			fixed3 Normal;
			half3 Emission;
			fixed3 Specular;
			half Smoothness;
			half Occlusion;
			fixed Alpha;
			fixed3 Translucency;
		};

		uniform float4 _ColorDeep;
		uniform float4 _ColorLight;
		uniform int _Amplitude_01;
		uniform int _Amplitude_02;
		uniform sampler2D _CameraDepthTexture;
		uniform float _DepthFade;
		uniform float _DepthFadeColorInfluence;
		uniform float _SpecColor_Int;
		uniform float _Spec_Int;
		uniform float _Smoothness;
		uniform half _Translucency;
		uniform half _TransNormalDistortion;
		uniform half _TransScattering;
		uniform half _TransDirect;
		uniform half _TransAmbient;
		uniform half _TransShadow;
		uniform float _Translucency_Int;
		uniform sampler2D _GrabTexture;
		uniform float _ChromaticAberration;
		uniform sampler2D _Texture0;
		uniform int _Tile_01;
		uniform float _Direction_01;
		uniform int _Tile_02;
		uniform float _Direction_02;
		uniform int _Tesselation;

		float4 tessFunction( appdata v0, appdata v1, appdata v2 )
		{
			float4 temp_cast_4 = _Tesselation;
			return temp_cast_4;
		}

		void vertexDataFunc( inout appdata v )
		{
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 appendResult8 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 temp_output_10_0 = ( appendResult8 / _Tile_01 );
			float temp_output_172_0 = ( ( _Direction_01 / 360.0 ) * ( 2.0 * UNITY_PI ) );
			float2 appendResult140 = (float2(cos( temp_output_172_0 ) , sin( temp_output_172_0 )));
			float dotResult146 = dot( temp_output_10_0 , appendResult140 );
			float temp_output_159_0 = ( temp_output_172_0 + ( 0.5 * UNITY_PI ) );
			float2 appendResult164 = (float2(cos( temp_output_159_0 ) , sin( temp_output_159_0 )));
			float dotResult161 = dot( temp_output_10_0 , appendResult164 );
			float2 appendResult151 = (float2(dotResult146 , dotResult161));
			float2 panner11 = ( appendResult151 + 0.1 * _Time.y * float2( 0.5,0.5 ));
			float2 temp_output_203_0 = ( appendResult8 / _Tile_02 );
			float temp_output_189_0 = ( ( _Direction_02 / 360.0 ) * ( 2.0 * UNITY_PI ) );
			float2 appendResult195 = (float2(cos( temp_output_189_0 ) , sin( temp_output_189_0 )));
			float dotResult197 = dot( temp_output_203_0 , appendResult195 );
			float temp_output_190_0 = ( temp_output_189_0 + ( 0.5 * UNITY_PI ) );
			float2 appendResult196 = (float2(cos( temp_output_190_0 ) , sin( temp_output_190_0 )));
			float dotResult198 = dot( temp_output_203_0 , appendResult196 );
			float2 appendResult199 = (float2(dotResult197 , dotResult198));
			float2 panner200 = ( appendResult199 + 0.15 * _Time.y * float2( 0.5,0.5 ));
			float temp_output_206_0 = ( ( ( _Amplitude_01 * (-1.0 + (tex2Dlod( _Texture0, float4( panner11, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) ) + ( _Amplitude_02 * (-1.0 + (tex2Dlod( _Texture0, float4( panner200, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) ) ) / 2.0 );
			float3 appendResult26 = (float3((float)0 , temp_output_206_0 , (float)0));
			float3 appendResult248 = (float3((float)0 , (float)0 , temp_output_206_0));
			#ifdef _SWITCHZTOY_ON
				float3 staticSwitch247 = appendResult26;
			#else
				float3 staticSwitch247 = appendResult248;
			#endif
			v.vertex.xyz += staticSwitch247;
		}

		inline half4 LightingStandardSpecularCustom(SurfaceOutputStandardSpecularCustom s, half3 viewDir, UnityGI gi )
		{
			#if !DIRECTIONAL
			float3 lightAtten = gi.light.color;
			#else
			float3 lightAtten = lerp( _LightColor0.rgb, gi.light.color, _TransShadow );
			#endif
			half3 lightDir = gi.light.dir + s.Normal * _TransNormalDistortion;
			half transVdotL = pow( saturate( dot( viewDir, -lightDir ) ), _TransScattering );
			half3 translucency = lightAtten * (transVdotL * _TransDirect + gi.indirect.diffuse * _TransAmbient) * s.Translucency;
			half4 c = half4( s.Albedo * translucency * _Translucency, 0 );

			SurfaceOutputStandardSpecular r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Specular = s.Specular;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandardSpecular (r, viewDir, gi) + c;
		}

		inline void LightingStandardSpecularCustom_GI(SurfaceOutputStandardSpecularCustom s, UnityGIInput data, inout UnityGI gi )
		{
			UNITY_GI(gi, s, data);
		}

		inline float4 Refraction( Input i, SurfaceOutputStandardSpecularCustom o, float indexOfRefraction, float chomaticAberration ) {
			float3 worldNormal = o.Normal;
			float4 screenPos = i.screenPos;
			#if UNITY_UV_STARTS_AT_TOP
				float scale = -1.0;
			#else
				float scale = 1.0;
			#endif
			float halfPosW = screenPos.w * 0.5;
			screenPos.y = ( screenPos.y - halfPosW ) * _ProjectionParams.x * scale + halfPosW;
			#if SHADER_API_D3D9 || SHADER_API_D3D11
				screenPos.w += 0.00000000001;
			#endif
			float2 projScreenPos = ( screenPos / screenPos.w ).xy;
			float3 worldViewDir = normalize( UnityWorldSpaceViewDir( i.worldPos ) );
			float3 refractionOffset = ( ( ( ( indexOfRefraction - 1.0 ) * mul( UNITY_MATRIX_V, float4( worldNormal, 0.0 ) ) ) * ( 1.0 / ( screenPos.z + 1.0 ) ) ) * ( 1.0 - dot( worldNormal, worldViewDir ) ) );
			float2 cameraRefraction = float2( refractionOffset.x, -( refractionOffset.y * _ProjectionParams.x ) );
			float4 redAlpha = tex2D( _GrabTexture, ( projScreenPos + cameraRefraction ) );
			float green = tex2D( _GrabTexture, ( projScreenPos + ( cameraRefraction * ( 1.0 - chomaticAberration ) ) ) ).g;
			float blue = tex2D( _GrabTexture, ( projScreenPos + ( cameraRefraction * ( 1.0 + chomaticAberration ) ) ) ).b;
			return float4( redAlpha.r, green, blue, redAlpha.a );
		}

		void RefractionF( Input i, SurfaceOutputStandardSpecularCustom o, inout fixed4 color )
		{
			#ifdef UNITY_PASS_FORWARDBASE
				color.rgb = color.rgb + Refraction( i, o, 1.3, _ChromaticAberration ) * ( 1 - color.a );
				color.a = 1;
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardSpecularCustom o )
		{
			float3 ase_worldPos = i.worldPos;
			float3 normalizeResult75 = normalize( ddy( ase_worldPos ) );
			float3 normalizeResult74 = normalize( ddx( ase_worldPos ) );
			float4 appendResult84 = (float4(cross( normalizeResult75 , normalizeResult74 ).x , cross( normalizeResult75 , normalizeResult74 ).z , cross( normalizeResult75 , normalizeResult74 ).y , 0.0));
			float4 __Normal217 = appendResult84;
			o.Normal = __Normal217.xyz;
			float4 transform125 = mul(unity_ObjectToWorld,float4(0,0,0,1));
			int __Amplitude224 = ( ( _Amplitude_01 + _Amplitude_02 ) / 2 );
			float __VertexOffset230 = ( ( ( ase_worldPos.y - transform125.y ) / ( __Amplitude224 * 2 ) ) + 0.5 );
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth207 = LinearEyeDepth(UNITY_SAMPLE_DEPTH(tex2Dproj(_CameraDepthTexture,UNITY_PROJ_COORD(ase_screenPos))));
			float distanceDepth207 = abs( ( screenDepth207 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthFade ) );
			float __DepthFade235 = distanceDepth207;
			float clampResult241 = clamp( __DepthFade235 , 0.0 , 1.0 );
			float lerpResult237 = lerp( __VertexOffset230 , ( 1.0 - clampResult241 ) , _DepthFadeColorInfluence);
			float4 lerpResult102 = lerp( _ColorDeep , _ColorLight , lerpResult237);
			float4 __Albedo228 = lerpResult102;
			float4 temp_output_229_0 = __Albedo228;
			o.Albedo = temp_output_229_0.rgb;
			float4 lerpResult177 = lerp( float4( 1,1,1,0 ) , __Albedo228 , _SpecColor_Int);
			o.Specular = ( lerpResult177 * _Spec_Int ).rgb;
			o.Smoothness = _Smoothness;
			o.Translucency = ( __Albedo228 * _Translucency_Int * __VertexOffset230 ).rgb;
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float fresnelNDotV87 = dot( WorldNormalVector( i , __Normal217.xyz ), ase_worldViewDir );
			float fresnelNode87 = ( 0.1 + 0.9 * pow( 1.0 - fresnelNDotV87, 1.2 ) );
			float clampResult180 = clamp( ( fresnelNode87 * distanceDepth207 ) , 0.0 , 1.0 );
			float __Opacity220 = clampResult180;
			o.Alpha = __Opacity220;
			o.Normal = o.Normal + 0.00001 * i.screenPos * i.worldPos;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
1927;35;1906;1004;819.4059;572.1913;1.304457;True;True
Node;AmplifyShaderEditor.CommentaryNode;212;-3152.114,627.1282;Float;False;3335.888;1537.568;Height;53;137;201;187;169;186;168;188;160;189;172;190;159;163;193;139;192;138;191;162;194;204;196;164;195;140;203;197;146;161;198;199;151;11;23;13;200;12;182;183;181;24;184;20;202;206;27;26;21;8;10;224;225;226;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;201;-3102.114,1744.445;Float;False;Property;_Direction_02;Direction_02;4;0;180;0;360;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;137;-3074.092,1058.622;Float;False;Property;_Direction_01;Direction_01;3;0;0;0;360;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;187;-2720.327,1745.324;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;360.0;False;1;FLOAT
Node;AmplifyShaderEditor.PiNode;169;-2781.534,1211.589;Float;False;1;0;FLOAT;2.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;168;-2753.895,1062.541;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;360.0;False;1;FLOAT
Node;AmplifyShaderEditor.PiNode;186;-2747.966,1894.371;Float;False;1;0;FLOAT;2.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;172;-2577.401,1085.223;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;189;-2543.833,1768.006;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.PiNode;160;-2670.227,1371.915;Float;False;1;0;FLOAT;0.5;False;1;FLOAT
Node;AmplifyShaderEditor.PiNode;188;-2635.305,2054.697;Float;False;1;0;FLOAT;0.5;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;190;-2354.321,1982.025;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;159;-2387.889,1299.243;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0,0;False;1;FLOAT
Node;AmplifyShaderEditor.IntNode;13;-1014.182,1009.517;Float;False;Property;_Amplitude_01;Amplitude_01;5;0;5;0;1;INT
Node;AmplifyShaderEditor.WorldPosInputsNode;9;-2817.34,259.0427;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.IntNode;181;-1033.33,1122.353;Float;False;Property;_Amplitude_02;Amplitude_02;6;0;5;0;1;INT
Node;AmplifyShaderEditor.IntNode;204;-2252.491,1657.118;Float;False;Property;_Tile_02;Tile_02;2;0;50;0;1;INT
Node;AmplifyShaderEditor.SinOpNode;192;-2263.702,1869.374;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CosOpNode;139;-2285.716,1096.049;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CosOpNode;193;-2252.148,1778.831;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;8;-2234.934,776.6541;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.IntNode;21;-2168.935,903.9434;Float;False;Property;_Tile_01;Tile_01;1;0;100;0;1;INT
Node;AmplifyShaderEditor.CosOpNode;162;-2130.979,1278.747;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SinOpNode;194;-2099.056,2052.072;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;242;-3050.294,-596.764;Float;False;2169.104;716.7085;Color;18;129;126;125;227;128;166;236;130;131;241;240;239;230;237;3;104;102;228;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;225;-802.0011,1054.105;Float;False;2;2;0;INT;0;False;1;INT;0;False;1;INT
Node;AmplifyShaderEditor.SinOpNode;163;-2132.624,1369.289;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CosOpNode;191;-2097.411,1961.53;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SinOpNode;138;-2297.271,1186.592;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.Vector4Node;129;-3000.294,-414.4988;Float;False;Constant;_Vector1;Vector 1;7;0;0,0,0,1;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.CommentaryNode;222;-3054.331,2309.562;Float;False;1279.747;441.1527;Opacity;8;209;87;207;208;180;216;220;235;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;195;-2078.195,1805.971;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.DynamicAppendNode;140;-2111.763,1123.188;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleDivideOpNode;226;-659.2831,1050.623;Float;False;2;0;INT;0;False;1;INT;2;False;1;INT
Node;AmplifyShaderEditor.SimpleDivideOpNode;10;-1964.315,773.4407;Float;False;2;0;FLOAT2;0,0,0,0;False;1;INT;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.SimpleDivideOpNode;203;-2047.869,1526.615;Float;False;2;0;FLOAT2;0,0;False;1;INT;0,0;False;1;FLOAT2
Node;AmplifyShaderEditor.DynamicAppendNode;164;-1928.651,1295.941;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.DynamicAppendNode;196;-1895.083,1978.724;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.CommentaryNode;218;-2225.921,209.7928;Float;False;1373.543;266.7134;Normal;8;72;73;74;75;76;83;84;217;;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldPosInputsNode;126;-2782.586,-233.5114;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.DotProductOpNode;197;-1814.182,1670.634;Float;False;2;0;FLOAT2;0.0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;125;-2793.557,-409.1103;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;227;-2812.62,-37.67379;Float;False;224;0;1;INT
Node;AmplifyShaderEditor.RegisterLocalVarNode;224;-523.527,1043.66;Float;False;__Amplitude;-1;True;1;0;INT;0;False;1;INT
Node;AmplifyShaderEditor.RangedFloatNode;209;-2879.176,2601.758;Float;False;Property;_DepthFade;DepthFade;22;0;1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.DotProductOpNode;146;-1847.75,987.8514;Float;False;2;0;FLOAT2;0.0,0,0,0;False;1;FLOAT2;0,0;False;1;FLOAT
Node;AmplifyShaderEditor.DotProductOpNode;161;-1685.861,1233.178;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT
Node;AmplifyShaderEditor.DotProductOpNode;198;-1652.293,1915.96;Float;False;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT
Node;AmplifyShaderEditor.DdxOpNode;72;-2175.921,261.7928;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.DdyOpNode;73;-2175.921,366.5062;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleSubtractOpNode;128;-2519.016,-226.3486;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;199;-1551.193,1669.532;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.DepthFade;207;-2660.829,2603.395;Float;False;1;0;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;151;-1584.761,986.7498;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.NormalizeNode;75;-1972.921,365.7928;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.NormalizeNode;74;-1969.921,259.7928;Float;False;1;0;FLOAT3;0.0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;166;-2496.061,-60.03793;Float;False;2;2;0;INT;0;False;1;INT;2;False;1;INT
Node;AmplifyShaderEditor.GetLocalVarNode;236;-2056.814,-79.39256;Float;False;235;0;1;FLOAT
Node;AmplifyShaderEditor.TexturePropertyNode;23;-1346.554,1041.92;Float;True;Property;_Texture0;Texture 0;0;0;None;False;white;Auto;0;1;SAMPLER2D
Node;AmplifyShaderEditor.SimpleDivideOpNode;130;-2340.62,-133.1068;Float;False;2;0;FLOAT;0.0;False;1;INT;0;False;1;FLOAT
Node;AmplifyShaderEditor.PannerNode;200;-1326.112,1654.847;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;1;FLOAT;0.15;False;1;FLOAT2
Node;AmplifyShaderEditor.CrossProductOpNode;76;-1738.918,290.7928;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.PannerNode;11;-1378.318,709.629;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;1;FLOAT;0.1;False;1;FLOAT2
Node;AmplifyShaderEditor.RegisterLocalVarNode;235;-2427.196,2646.451;Float;False;__DepthFade;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;182;-1034.812,1303.299;Float;True;Property;_TextureSample1;Texture Sample 1;6;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ClampOpNode;241;-1832.084,-73.41206;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SamplerNode;12;-1065.02,677.128;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.BreakToComponentsNode;83;-1556.918,299.7928;Float;False;FLOAT3;1;0;FLOAT3;0,0,0;False;16;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;131;-2187.923,-131.4824;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.5;False;1;FLOAT
Node;AmplifyShaderEditor.TFHCRemapNode;183;-683.809,1328;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;-1.0;False;4;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;239;-2131.599,4.944513;Float;False;Property;_DepthFadeColorInfluence;DepthFadeColorInfluence;21;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.TFHCRemapNode;24;-714.0171,701.8293;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;-1.0;False;4;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;84;-1297.918,297.3929;Float;False;FLOAT4;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.RegisterLocalVarNode;230;-2048.929,-160.9957;Float;False;__VertexOffset;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.OneMinusNode;240;-1680.406,-68.77372;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;184;-421.2102,1325.399;Float;False;2;2;0;INT;0;False;1;FLOAT;0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-451.4175,699.2286;Float;False;2;2;0;INT;0;False;1;FLOAT;0;False;1;FLOAT
Node;AmplifyShaderEditor.ColorNode;104;-1719.729,-386.2758;Float;False;Property;_ColorLight;ColorLight;7;0;1,0,0,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;237;-1486.428,-106.0998;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;216;-3004.331,2364.92;Float;False;217;0;1;FLOAT4
Node;AmplifyShaderEditor.RegisterLocalVarNode;217;-1095.376,297.3633;Float;False;__Normal;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.ColorNode;3;-1717.959,-546.764;Float;False;Property;_ColorDeep;ColorDeep;8;0;0.1801471,0.558722,0.875,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.LerpOp;102;-1288.571,-398.1126;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.FresnelNode;87;-2757.163,2359.562;Float;False;Tangent;4;0;FLOAT3;0,0,0;False;1;FLOAT;0.1;False;2;FLOAT;0.9;False;3;FLOAT;1.2;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;202;-234.3621,1023.37;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.IntNode;27;-442.6578,837.3811;Float;False;Constant;_Int1;Int 1;1;0;0;0;1;INT
Node;AmplifyShaderEditor.GetLocalVarNode;229;-349.3565,-325.142;Float;False;228;0;1;COLOR
Node;AmplifyShaderEditor.RegisterLocalVarNode;228;-1124.191,-403.0236;Float;False;__Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;208;-2448.06,2536.091;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;206;-72.72997,1149.406;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;2.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;176;-374.8833,-509.9258;Float;False;Property;_SpecColor_Int;SpecColor_Int;11;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.LerpOp;177;-5.243346,-556.496;Float;False;3;0;COLOR;1,1,1,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.DynamicAppendNode;248;100.9706,1045.419;Float;True;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.DynamicAppendNode;26;-56.22552,792.4073;Float;True;FLOAT3;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT3
Node;AmplifyShaderEditor.ClampOpNode;180;-2232.753,2486.487;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;174;-461.2077,-68.07885;Float;False;Property;_Translucency_Int;Translucency_Int;12;0;0;0;10;0;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;231;-403.8253,27.28036;Float;False;230;0;1;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;179;110.8276,-21.40757;Float;False;Property;_Spec_Int;Spec_Int;10;0;0;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;219;449.0023,-119.7458;Float;False;217;0;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;28;407.6152,78.52923;Float;False;Property;_Smoothness;Smoothness;9;0;0.9149065;0;1;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;178;463.3289,-31.46542;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.RangedFloatNode;100;493.7942,181.4781;Float;False;Constant;_IOR;IOR;2;0;1.3;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.IntNode;243;432.9902,421.4728;Float;False;Property;_Tesselation;Tesselation;13;0;0;0;1;INT
Node;AmplifyShaderEditor.RegisterLocalVarNode;220;-2017.585,2507.141;Float;False;__Opacity;-1;True;1;0;FLOAT;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.StaticSwitch;247;268.9706,893.4194;Float;False;Property;_SwitchZtoY;Switch Z to Y;20;0;0;False;True;;2;0;FLOAT3;0.0;False;1;FLOAT3;0.0,0,0,0;False;1;FLOAT3
Node;AmplifyShaderEditor.GetLocalVarNode;221;429.9119,324.9886;Float;False;220;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;173;176.1534,121.7187;Float;False;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.GrabScreenPosition;254;295.8629,-661.7195;Float;False;0;0;5;FLOAT4;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;835.1769,-37.77055;Float;False;True;7;Float;ASEMaterialInspector;0;0;StandardSpecular;Custom/SH_Water;False;False;False;False;False;False;False;False;False;True;False;False;False;False;True;False;False;Back;0;0;False;0;0;Transparent;1;True;False;0;False;Transparent;Transparent;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;True;1;15;10;25;False;1;True;2;SrcAlpha;OneMinusSrcAlpha;0;SrcAlpha;OneMinusSrcAlpha;OFF;OFF;0;False;7.62;0,0,0,0;VertexScale;False;Cylindrical;False;Relative;0;;0;14;23;0;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;187;0;201;0
WireConnection;168;0;137;0
WireConnection;172;0;168;0
WireConnection;172;1;169;0
WireConnection;189;0;187;0
WireConnection;189;1;186;0
WireConnection;190;0;189;0
WireConnection;190;1;188;0
WireConnection;159;0;172;0
WireConnection;159;1;160;0
WireConnection;192;0;189;0
WireConnection;139;0;172;0
WireConnection;193;0;189;0
WireConnection;8;0;9;1
WireConnection;8;1;9;3
WireConnection;162;0;159;0
WireConnection;194;0;190;0
WireConnection;225;0;13;0
WireConnection;225;1;181;0
WireConnection;163;0;159;0
WireConnection;191;0;190;0
WireConnection;138;0;172;0
WireConnection;195;0;193;0
WireConnection;195;1;192;0
WireConnection;140;0;139;0
WireConnection;140;1;138;0
WireConnection;226;0;225;0
WireConnection;10;0;8;0
WireConnection;10;1;21;0
WireConnection;203;0;8;0
WireConnection;203;1;204;0
WireConnection;164;0;162;0
WireConnection;164;1;163;0
WireConnection;196;0;191;0
WireConnection;196;1;194;0
WireConnection;197;0;203;0
WireConnection;197;1;195;0
WireConnection;125;0;129;0
WireConnection;224;0;226;0
WireConnection;146;0;10;0
WireConnection;146;1;140;0
WireConnection;161;0;10;0
WireConnection;161;1;164;0
WireConnection;198;0;203;0
WireConnection;198;1;196;0
WireConnection;72;0;9;0
WireConnection;73;0;9;0
WireConnection;128;0;126;2
WireConnection;128;1;125;2
WireConnection;199;0;197;0
WireConnection;199;1;198;0
WireConnection;207;0;209;0
WireConnection;151;0;146;0
WireConnection;151;1;161;0
WireConnection;75;0;73;0
WireConnection;74;0;72;0
WireConnection;166;0;227;0
WireConnection;130;0;128;0
WireConnection;130;1;166;0
WireConnection;200;0;199;0
WireConnection;76;0;75;0
WireConnection;76;1;74;0
WireConnection;11;0;151;0
WireConnection;235;0;207;0
WireConnection;182;0;23;0
WireConnection;182;1;200;0
WireConnection;241;0;236;0
WireConnection;12;0;23;0
WireConnection;12;1;11;0
WireConnection;83;0;76;0
WireConnection;131;0;130;0
WireConnection;183;0;182;1
WireConnection;24;0;12;1
WireConnection;84;0;83;0
WireConnection;84;1;83;2
WireConnection;84;2;83;1
WireConnection;230;0;131;0
WireConnection;240;0;241;0
WireConnection;184;0;181;0
WireConnection;184;1;183;0
WireConnection;20;0;13;0
WireConnection;20;1;24;0
WireConnection;237;0;230;0
WireConnection;237;1;240;0
WireConnection;237;2;239;0
WireConnection;217;0;84;0
WireConnection;102;0;3;0
WireConnection;102;1;104;0
WireConnection;102;2;237;0
WireConnection;87;0;216;0
WireConnection;202;0;20;0
WireConnection;202;1;184;0
WireConnection;228;0;102;0
WireConnection;208;0;87;0
WireConnection;208;1;207;0
WireConnection;206;0;202;0
WireConnection;177;1;229;0
WireConnection;177;2;176;0
WireConnection;248;0;27;0
WireConnection;248;1;27;0
WireConnection;248;2;206;0
WireConnection;26;0;27;0
WireConnection;26;1;206;0
WireConnection;26;2;27;0
WireConnection;180;0;208;0
WireConnection;178;0;177;0
WireConnection;178;1;179;0
WireConnection;220;0;180;0
WireConnection;247;0;26;0
WireConnection;247;1;248;0
WireConnection;173;0;229;0
WireConnection;173;1;174;0
WireConnection;173;2;231;0
WireConnection;0;0;229;0
WireConnection;0;1;219;0
WireConnection;0;3;178;0
WireConnection;0;4;28;0
WireConnection;0;7;173;0
WireConnection;0;8;100;0
WireConnection;0;9;221;0
WireConnection;0;11;247;0
WireConnection;0;14;243;0
ASEEND*/
//CHKSM=D68788223198C8C6A48E2C51F856CCD9185F0CFB