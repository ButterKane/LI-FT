// Upgrade NOTE: upgraded instancing buffer 'SH_Tree' to new syntax.

// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "SH_Tree"
{
	Properties
	{
		_PrincipalColor("PrincipalColor", Color) = (1,0.3823529,0.497363,0)
		_SecondaryColor("SecondaryColor", Color) = (1,0.6838235,0.8211967,0)
		_Heightmap("Heightmap", 2D) = "white" {}
		_Height_Mask("Height_Mask", Int) = 20
		_Tile01("Tile01", Int) = 5000
		_Int01("Int01", Int) = 3
		_Speed01("Speed01", Float) = 0.1
		_Tile02("Tile02", Int) = 50
		_Int02("Int02", Int) = 5
		_Speed02("Speed02", Float) = 0.1
		_Delay("Delay", Int) = 0
		_WindDirection("WindDirection", Range( 0 , 2)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma multi_compile_instancing
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float4 vertexColor : COLOR;
		};

		uniform int _Height_Mask;
		uniform sampler2D _Heightmap;
		uniform float _Speed01;
		uniform int _Tile01;
		uniform int _Int01;
		uniform float _Speed02;
		uniform int _Tile02;
		uniform int _Int02;
		uniform int _Delay;
		uniform float _WindDirection;

		UNITY_INSTANCING_BUFFER_START(SH_Tree)
			UNITY_DEFINE_INSTANCED_PROP(float4, _SecondaryColor)
#define _SecondaryColor_arr SH_Tree
			UNITY_DEFINE_INSTANCED_PROP(float4, _PrincipalColor)
#define _PrincipalColor_arr SH_Tree
		UNITY_INSTANCING_BUFFER_END(SH_Tree)

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float mulTime106 = _Time.y * _Speed01;
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float4 appendResult19 = (float4(ase_worldPos.x , ase_worldPos.z , 0.0 , 0.0));
			float2 panner22 = ( ( appendResult19 / _Tile01 ).xy + mulTime106 * float2( 0.5,0.5 ));
			float mulTime107 = _Time.y * _Speed02;
			float2 panner43 = ( ( appendResult19 / _Tile02 ).xy + mulTime107 * float2( 0.5,0.5 ));
			float VcolR85 = v.color.r;
			float4 temp_cast_2 = _Delay;
			float4 temp_output_81_0 = ( appendResult19 - temp_cast_2 );
			float2 panner66 = ( ( temp_output_81_0 / _Tile01 ).xy + _Speed01 * float2( 0.5,0.5 ));
			float VcolG86 = v.color.g;
			float4 temp_cast_4 = _Delay;
			float2 panner65 = ( ( temp_output_81_0 / _Tile02 ).xy + mulTime107 * float2( 0.5,0.5 ));
			float2 appendResult95 = (float2(sin( ( _WindDirection * UNITY_PI ) ) , cos( ( _WindDirection * UNITY_PI ) )));
			float4 appendResult28 = (float4(( ( ( ( ( ase_vertex3Pos.z / _Height_Mask ) * (-1.0 + (tex2Dlod( _Heightmap, float4( panner22, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * _Int01 ) + ( (-1.0 + (tex2Dlod( _Heightmap, float4( panner43, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * VcolR85 * _Int02 ) ) + ( ( _Int01 * (-1.0 + (tex2Dlod( _Heightmap, float4( panner66, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * VcolG86 ) + ( (-1.0 + (tex2Dlod( _Heightmap, float4( panner65, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * VcolG86 * _Int02 ) ) ) * appendResult95 ).x , ( ( ( ( ( ase_vertex3Pos.z / _Height_Mask ) * (-1.0 + (tex2Dlod( _Heightmap, float4( panner22, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * _Int01 ) + ( (-1.0 + (tex2Dlod( _Heightmap, float4( panner43, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * VcolR85 * _Int02 ) ) + ( ( _Int01 * (-1.0 + (tex2Dlod( _Heightmap, float4( panner66, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * VcolG86 ) + ( (-1.0 + (tex2Dlod( _Heightmap, float4( panner65, 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) * VcolG86 * _Int02 ) ) ) * appendResult95 ).y , (float)0 , 0.0));
			v.vertex.xyz += appendResult28.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float VcolG86 = i.vertexColor.g;
			float4 _SecondaryColor_Instance = UNITY_ACCESS_INSTANCED_PROP(_SecondaryColor_arr, _SecondaryColor);
			float VcolR85 = i.vertexColor.r;
			float4 _PrincipalColor_Instance = UNITY_ACCESS_INSTANCED_PROP(_PrincipalColor_arr, _PrincipalColor);
			o.Albedo = ( ( VcolG86 * _SecondaryColor_Instance ) + ( VcolR85 * _PrincipalColor_Instance ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=13701
1927;35;1906;1004;2789.662;-1040.677;1.812245;True;True
Node;AmplifyShaderEditor.WorldPosInputsNode;18;-2814.353,980.3422;Float;False;0;4;FLOAT3;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.IntNode;82;-2356.797,1788.018;Float;False;Property;_Delay;Delay;10;0;0;0;1;INT
Node;AmplifyShaderEditor.DynamicAppendNode;19;-2420.289,1048.403;Float;False;FLOAT4;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.RangedFloatNode;100;-1573.645,605.7377;Float;False;Property;_Speed01;Speed01;6;0;0.1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleSubtractOpNode;81;-2023.038,1605.328;Float;False;2;0;FLOAT4;0,0,0,0;False;1;INT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.IntNode;21;-1969.372,624.0834;Float;False;Property;_Tile01;Tile01;4;0;5000;0;1;INT
Node;AmplifyShaderEditor.IntNode;41;-1941.71,975.1643;Float;False;Property;_Tile02;Tile02;7;0;50;0;1;INT
Node;AmplifyShaderEditor.RangedFloatNode;101;-1691.441,1033.427;Float;False;Property;_Speed02;Speed02;9;0;0.1;0;0;0;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;63;-1659.915,1984.133;Float;False;2;0;FLOAT4;0,0,0,0;False;1;INT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleTimeNode;106;-1354.366,540.4969;Float;False;1;0;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;64;-1572.981,1625.015;Float;False;2;0;FLOAT4;0,0,0,0;False;1;INT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleDivideOpNode;42;-1656.546,853.1743;Float;False;2;0;FLOAT4;0,0,0,0;False;1;INT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.SimpleTimeNode;107;-1521.093,1042.489;Float;False;1;0;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleDivideOpNode;20;-1419.21,404.3435;Float;False;2;0;FLOAT4;0,0,0,0;False;1;INT;0,0,0,0;False;1;FLOAT4
Node;AmplifyShaderEditor.PannerNode;43;-1377.041,854.475;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;1;FLOAT;0.1;False;1;FLOAT2
Node;AmplifyShaderEditor.TexturePropertyNode;37;-1466.931,1167.312;Float;True;Property;_Heightmap;Heightmap;2;0;Assets/Material/Textures/T_PerlinNoise.png;False;white;Auto;0;1;SAMPLER2D
Node;AmplifyShaderEditor.PannerNode;22;-1139.705,405.6442;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;1;FLOAT;0.1;False;1;FLOAT2
Node;AmplifyShaderEditor.PannerNode;66;-1293.476,1626.316;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;1;FLOAT;0.1;False;1;FLOAT2
Node;AmplifyShaderEditor.PannerNode;65;-1380.41,1985.434;Float;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0.5,0.5;False;1;FLOAT;0.1;False;1;FLOAT2
Node;AmplifyShaderEditor.SamplerNode;16;-826.4067,373.1431;Float;True;Property;_T_PerlinNoise;T_PerlinNoise;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;38;-1080.222,818.1946;Float;True;Property;_TextureSample0;Texture Sample 0;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.VertexColorNode;1;-1633.701,-397.2343;Float;False;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.IntNode;80;-997.1567,235.7893;Float;False;Property;_Height_Mask;Height_Mask;3;0;20;0;1;INT
Node;AmplifyShaderEditor.SamplerNode;70;-980.1769,1593.815;Float;True;Property;_TextureSample2;Texture Sample 2;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SamplerNode;69;-1083.591,1949.154;Float;True;Property;_TextureSample1;Texture Sample 1;1;0;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.PosVertexDataNode;7;-990.4675,45.76503;Float;False;0;0;5;FLOAT3;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.RangedFloatNode;92;-174.6794,1114.105;Float;False;Property;_WindDirection;WindDirection;11;0;0;0;2;0;1;FLOAT
Node;AmplifyShaderEditor.TFHCRemapNode;74;-629.1729,1618.516;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;-1.0;False;4;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.IntNode;45;-621.8245,1214.072;Float;False;Property;_Int02;Int02;8;0;5;0;1;INT
Node;AmplifyShaderEditor.TFHCRemapNode;46;-641.4094,832.1742;Float;False;5;0;FLOAT;0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;-1.0;False;4;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.TFHCRemapNode;72;-644.7787,1963.133;Float;False;5;0;FLOAT;0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;-1.0;False;4;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;89;-634.439,2158.75;Float;False;86;0;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;85;-1307.253,-429.4342;Float;False;VcolR;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.RegisterLocalVarNode;86;-1305.973,-275.8154;Float;False;VcolG;-1;True;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;88;-671.8552,1008.641;Float;False;85;0;1;FLOAT
Node;AmplifyShaderEditor.IntNode;24;-466.5222,577.7643;Float;False;Property;_Int01;Int01;5;0;3;0;1;INT
Node;AmplifyShaderEditor.SimpleDivideOpNode;36;-580.8284,212.453;Float;False;2;0;FLOAT;0.0;False;1;INT;0;False;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;90;-628.8785,1809.419;Float;False;86;0;1;FLOAT
Node;AmplifyShaderEditor.TFHCRemapNode;30;-475.4026,397.8445;Float;False;5;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;1.0;False;3;FLOAT;-1.0;False;4;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;75;-403.7054,1975.88;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;INT;0;False;1;FLOAT
Node;AmplifyShaderEditor.PiNode;99;146.4738,1115.467;Float;False;1;0;FLOAT;1.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;76;-366.5728,1615.916;Float;False;3;3;0;INT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-400.3361,844.9209;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;INT;0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-212.8024,395.2439;Float;False;3;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;INT;0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;77;-107.0051,1692.98;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;48;-79.88843,691.313;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0,0,0,0;False;1;FLOAT
Node;AmplifyShaderEditor.SinOpNode;93;376.4516,1095.054;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.CosOpNode;94;373.73,1169.899;Float;False;1;0;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.SimpleAddOpNode;91;146.9318,870.3651;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT
Node;AmplifyShaderEditor.DynamicAppendNode;95;586.0173,1096.415;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.ColorNode;34;-669.1483,-253.987;Float;False;InstancedProperty;_PrincipalColor;PrincipalColor;0;0;1,0.3823529,0.497363,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.ColorNode;50;-333.8809,-292.6631;Float;False;InstancedProperty;_SecondaryColor;SecondaryColor;1;0;1,0.6838235,0.8211967,0;0;5;COLOR;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;96;765.6453,903.1789;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT2;0.0;False;1;FLOAT2
Node;AmplifyShaderEditor.GetLocalVarNode;87;-530.1983,41.66331;Float;False;85;0;1;FLOAT
Node;AmplifyShaderEditor.GetLocalVarNode;84;-298.4906,-394.8702;Float;False;86;0;1;FLOAT
Node;AmplifyShaderEditor.BreakToComponentsNode;97;901.727,905.9005;Float;False;FLOAT2;1;0;FLOAT2;0.0;False;16;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT;FLOAT
Node;AmplifyShaderEditor.IntNode;29;953.8832,1049.154;Float;False;Constant;_Int2;Int 2;1;0;0;0;1;INT
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-281.5,26;Float;True;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;37.75996,-206.6597;Float;True;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR
Node;AmplifyShaderEditor.SimpleAddOpNode;57;348.7486,-15.71221;Float;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;1;COLOR
Node;AmplifyShaderEditor.DynamicAppendNode;28;1196.463,883.1268;Float;False;FLOAT4;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;642.7999,48.19999;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;SH_Tree;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;18;1
WireConnection;19;1;18;3
WireConnection;81;0;19;0
WireConnection;81;1;82;0
WireConnection;63;0;81;0
WireConnection;63;1;41;0
WireConnection;106;0;100;0
WireConnection;64;0;81;0
WireConnection;64;1;21;0
WireConnection;42;0;19;0
WireConnection;42;1;41;0
WireConnection;107;0;101;0
WireConnection;20;0;19;0
WireConnection;20;1;21;0
WireConnection;43;0;42;0
WireConnection;43;1;107;0
WireConnection;22;0;20;0
WireConnection;22;1;106;0
WireConnection;66;0;64;0
WireConnection;66;1;100;0
WireConnection;65;0;63;0
WireConnection;65;1;107;0
WireConnection;16;0;37;0
WireConnection;16;1;22;0
WireConnection;38;0;37;0
WireConnection;38;1;43;0
WireConnection;70;0;37;0
WireConnection;70;1;66;0
WireConnection;69;0;37;0
WireConnection;69;1;65;0
WireConnection;74;0;70;1
WireConnection;46;0;38;1
WireConnection;72;0;69;1
WireConnection;85;0;1;1
WireConnection;86;0;1;2
WireConnection;36;0;7;3
WireConnection;36;1;80;0
WireConnection;30;0;16;1
WireConnection;75;0;72;0
WireConnection;75;1;89;0
WireConnection;75;2;45;0
WireConnection;99;0;92;0
WireConnection;76;0;24;0
WireConnection;76;1;74;0
WireConnection;76;2;90;0
WireConnection;47;0;46;0
WireConnection;47;1;88;0
WireConnection;47;2;45;0
WireConnection;23;0;36;0
WireConnection;23;1;30;0
WireConnection;23;2;24;0
WireConnection;77;0;76;0
WireConnection;77;1;75;0
WireConnection;48;0;23;0
WireConnection;48;1;47;0
WireConnection;93;0;99;0
WireConnection;94;0;99;0
WireConnection;91;0;48;0
WireConnection;91;1;77;0
WireConnection;95;0;93;0
WireConnection;95;1;94;0
WireConnection;96;0;91;0
WireConnection;96;1;95;0
WireConnection;97;0;96;0
WireConnection;14;0;87;0
WireConnection;14;1;34;0
WireConnection;56;0;84;0
WireConnection;56;1;50;0
WireConnection;57;0;56;0
WireConnection;57;1;14;0
WireConnection;28;0;97;0
WireConnection;28;1;97;1
WireConnection;28;2;29;0
WireConnection;0;0;57;0
WireConnection;0;11;28;0
ASEEND*/
//CHKSM=63B7E55BDED98D59645CF4FAE3706BA91379B825