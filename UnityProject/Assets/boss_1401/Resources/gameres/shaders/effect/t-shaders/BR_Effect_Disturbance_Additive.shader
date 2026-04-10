Shader "BR/Effect/Disturbance/Additive"
{
  Properties
  {
    [HDR] _TintColor ("Tint Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB) Trans (A)", 2D) = "black" {}
    _NoiseTex ("Noise Tex(RG)", 2D) = "white" {}
    _Speed ("XY noise1,ZW noise 2", Vector) = (0.5,0.5,0.5,0)
    _NoiseOffset ("Noise Offset", Range(-2, 2)) = 1.5
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
    Pass // ind: 1, name: BR_Effect_Disturbance_Additive
    {
      Name "BR_Effect_Disturbance_Additive"
      Tags
      { 
        "IGNOREPROJECTOR" = "true"
        "PreviewType" = "Plane"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      ZWrite Off
      Cull Off
      Blend SrcAlpha One
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
      
      uniform float4 _Time;
      
      uniform float _NoiseOffset;
      
      uniform float4 _TintColor;
      
      uniform float4 _Speed;
      
      uniform sampler2D _NoiseTex;
      
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
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float2 texcoord : TEXCOORD0;
          
          float4 color : COLOR0;
      
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
          
          u_xlat0 = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
          
          out_v.vertex = u_xlat0;
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          out_v.color = in_v.color;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float4 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      float2 u_xlat16_1;
      
      float u_xlat16_2;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat0_d = _Time.xxxx * _Speed + in_f.texcoord.xyxy;
          
          u_xlat16_0.x = texture(_NoiseTex, u_xlat0_d.xy).x;
          
          u_xlat16_2 = texture(_NoiseTex, u_xlat0_d.zw).y;
          
          u_xlat16_1.x = u_xlat16_2 * u_xlat16_0.x;
          
          u_xlat16_1.xy = u_xlat16_1.xx * float2(_NoiseOffset) + in_f.texcoord.xy;
          
          u_xlat16_0 = texture(_MainTex, u_xlat16_1.xy);
          
          u_xlat0_d = u_xlat16_0 * _TintColor;
          
          u_xlat16_1.x = in_f.color.w * _TintColor.w;
          
          out_f.color.w = u_xlat0_d.w * u_xlat16_1.x;
          
          out_f.color.xyz = u_xlat0_d.xyz * in_f.color.xyz;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
  }
  FallBack Off
}
