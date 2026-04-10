Shader "Sanguo/Sanguo_particle_distort_add"
{
  Properties
  {
    _MainTex ("MainTex", 2D) = "white" {}
    _distort_tex ("distort_tex", 2D) = "white" {}
    _QD ("QD", float) = 0.1
    _U ("U", float) = 0.2
    _V ("V", float) = 0.1
    _U_MainTex ("U_MainTex", float) = 0
    _V_MainTex ("V_MainTex", float) = 0
    _Glow ("Glow", float) = 5
    _Color ("Color", Color) = (0.5,0.5,0.5,1)
    _Alpha ("Alpha", Range(0, 1)) = 1
    _MinX ("Min X", float) = -2000
    _MaxX ("Max X", float) = 2000
    _MinY ("Min Y", float) = -2000
    _MaxY ("Max Y", float) = 2000
  }
  SubShader
  {
    Tags
    { 
      "IGNOREPROJECTOR" = "true"
      "QUEUE" = "Transparent+1"
      "RenderType" = "Transparent"
    }
    Pass // ind: 1, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "LIGHTMODE" = "FORWARDBASE"
        "QUEUE" = "Transparent+1"
        "RenderType" = "Transparent"
        "SHADOWSUPPORT" = "true"
      }
      ZWrite Off
      Cull Off
      Blend One One
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile DIRECTIONAL
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _Time;
      
      uniform float4 _TimeEditor;
      
      uniform float4 _MainTex_ST;
      
      uniform float4 _distort_tex_ST;
      
      uniform float _QD;
      
      uniform float _U;
      
      uniform float _V;
      
      uniform float _U_MainTex;
      
      uniform float _V_MainTex;
      
      uniform float _Glow;
      
      uniform float4 _Color;
      
      uniform float _Alpha;
      
      uniform float _MinX;
      
      uniform float _MaxX;
      
      uniform float _MinY;
      
      uniform float _MaxY;
      
      uniform sampler2D _distort_tex;
      
      uniform sampler2D _MainTex;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float2 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
          
          float3 texcoord2 : TEXCOORD2;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
          
          float3 texcoord2 : TEXCOORD2;
      
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
          
          out_v.texcoord.xy = in_v.texcoord.xy;
          
          out_v.color = in_v.color;
          
          out_v.texcoord2.xyz = in_v.vertex.xyz;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float2 u_xlat1_d;
      
      float3 u_xlat16_1;
      
      bool2 u_xlatb1;
      
      float4 u_xlat2;
      
      float2 u_xlat6;
      
      float u_xlat9;
      
      int u_xlatb9;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d.x = _Time.y + _TimeEditor.y;
          
          u_xlat6.x = u_xlat0_d.x * _U_MainTex;
          
          u_xlat6.y = u_xlat0_d.x * _V_MainTex;
          
          u_xlat0_d.xy = float2(_U, _V) * u_xlat0_d.xx + in_f.texcoord.xy;
          
          u_xlat0_d.xy = u_xlat0_d.xy * _distort_tex_ST.xy + _distort_tex_ST.zw;
          
          u_xlat16_1.xyz = texture(_distort_tex, u_xlat0_d.xy).xyz;
          
          u_xlat0_d.xy = u_xlat6.xy + in_f.texcoord.xy;
          
          u_xlat0_d.xy = u_xlat16_1.xx * float2(_QD) + u_xlat0_d.xy;
          
          u_xlat0_d.xy = u_xlat0_d.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          u_xlat16_0 = texture(_MainTex, u_xlat0_d.xy);
          
          u_xlat2 = in_f.color * _Color;
          
          u_xlat2 = u_xlat16_0 * u_xlat2;
          
          u_xlat2 = u_xlat2 * float4(float4(_Glow, _Glow, _Glow, _Glow));
          
          u_xlat0_d.xyz = u_xlat16_1.xyz * u_xlat2.xyz;
          
          u_xlat0_d.xyz = u_xlat2.www * u_xlat0_d.xyz;
          
          u_xlat0_d.xyz = u_xlat16_0.www * u_xlat0_d.xyz;
          
          #ifdef UNITY_ADRENO_ES3
          u_xlatb9 = (_MaxX>=in_f.texcoord2.x);
          
          #else
          u_xlatb9 = _MaxX>=in_f.texcoord2.x;
          
          #endif
          u_xlat9 = u_xlatb9 ? 1.0 : float(0.0);
          
          u_xlatb1.xy = greaterThanEqual(in_f.texcoord2.xyxx, float4(_MinX, _MinY, _MinX, _MinX)).xy;
          
          u_xlat1_d.x = u_xlatb1.x ? float(1.0) : 0.0;
          
          u_xlat1_d.y = u_xlatb1.y ? float(1.0) : 0.0;
      
      ;
          
          u_xlat9 = u_xlat9 * u_xlat1_d.x;
          
          u_xlat9 = u_xlat1_d.y * u_xlat9;
          
          #ifdef UNITY_ADRENO_ES3
          u_xlatb1.x = (_MaxY>=in_f.texcoord2.y);
          
          #else
          u_xlatb1.x = _MaxY>=in_f.texcoord2.y;
          
          #endif
          u_xlat1_d.x = u_xlatb1.x ? 1.0 : float(0.0);
          
          u_xlat9 = u_xlat9 * u_xlat1_d.x;
          
          u_xlat1_d.x = u_xlat9 * _Alpha;
          
          out_f.color.w = u_xlat9;
          
          out_f.color.xyz = u_xlat0_d.xyz * u_xlat1_d.xxx;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
