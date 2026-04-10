Shader "UI/Particles/Additive"
{
  Properties
  {
    [HDR] _TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
    _MainTex ("Particle Texture", 2D) = "white" {}
    [Enum(UnityEngine.Rendering.BlendMode)] _BlendSrc ("Blend mode Source", float) = 5
    [Enum(UnityEngine.Rendering.BlendMode)] _BlendDst ("Blend mode Destination", float) = 1
    _StencilComp ("Stencil Comparison", float) = 8
    _Stencil ("Stencil ID", float) = 0
    _StencilOp ("Stencil Operation", float) = 0
    _StencilWriteMask ("Stencil Write Mask", float) = 255
    _StencilReadMask ("Stencil Read Mask", float) = 255
    _ColorMask ("Color Mask", float) = 15
    [Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip ("Use Alpha Clip", float) = 0
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "PreviewType" = "Plane"
      "QUEUE" = "Transparent"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: 
    {
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 0
        WriteMask 0
        Pass Keep
        Fail Keep
        ZFail Keep
        PassFront Keep
        FailFront Keep
        ZFailFront Keep
        PassBack Keep
        FailBack Keep
        ZFailBack Keep
      } 
      Blend Zero Zero
      ColorMask 0
      // m_ProgramMask = 6
      CGPROGRAM
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex_ST;
      
      uniform float4 _TintColor;
      
      uniform float4 _ClipRect;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 color : COLOR0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      OUT_Data_Vert vert(appdata_t in_v)
      {
          
          u_xlat0 = in_v.vertex.yyyy * unity_ObjectToWorld[1];
          
          u_xlat0 = unity_ObjectToWorld[0] * in_v.vertex.xxxx + u_xlat0;
          
          u_xlat0 = unity_ObjectToWorld[2] * in_v.vertex.zzzz + u_xlat0;
          
          u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
          
          u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
          
          u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
          
          u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
          
          out_v.vertex = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.color = in_v.color;
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          out_v.texcoord1 = in_v.vertex;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      bool4 u_xlatb0;
      
      float4 u_xlat1_d;
      
      float4 u_xlat16_1;
      
      float4 u_xlat16_2;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlatb0.xy = greaterThanEqual(in_f.texcoord1.xyxx, _ClipRect.xyxx).xy;
          
          u_xlatb0.zw = greaterThanEqual(_ClipRect.zzzw, in_f.texcoord1.xxxy).zw;
          
          u_xlat0_d.x = u_xlatb0.x ? float(1.0) : 0.0;
          
          u_xlat0_d.y = u_xlatb0.y ? float(1.0) : 0.0;
          
          u_xlat0_d.z = u_xlatb0.z ? float(1.0) : 0.0;
          
          u_xlat0_d.w = u_xlatb0.w ? float(1.0) : 0.0;
      
      ;
          
          u_xlat0_d.xy = u_xlat0_d.zw * u_xlat0_d.xy;
          
          u_xlat0_d.x = u_xlat0_d.y * u_xlat0_d.x;
          
          u_xlat16_1 = in_f.color * _TintColor;
          
          u_xlat16_2 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat1_d = u_xlat16_1 * u_xlat16_2;
          
          u_xlat1_d.w = u_xlat0_d.x * u_xlat1_d.w;
          
          out_f.color = u_xlat1_d;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
