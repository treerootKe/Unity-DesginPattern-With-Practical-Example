// Upgrade NOTE: commented out 'float3 _WorldSpaceCameraPos', a built-in variable

Shader "CustomStandardV2"
{
  Properties
  {
    _Color ("Color", Color) = (1,1,1,1)
    _MainTex ("Albedo", 2D) = "white" {}
    _ColorScale ("Color Scale", Range(1, 10)) = 1
    _Cutoff ("Alpha Cutoff", Range(0, 1)) = 0.5
    _Glossiness ("Smoothness", Range(0, 1)) = 0.5
    _GlossMapScale ("Smoothness Scale", Range(-1, 1)) = -0.8
    _SmoothnessRemapMin ("Smoothness RemapMin", float) = 0
    _SmoothnessRemapMax ("Smoothness RemapMax", float) = 1
    [Gamma] _Metallic ("Metallic", Range(0, 1)) = 0
    _MetallicGlossMap ("Metallic", 2D) = "white" {}
    _MetallicRemapMin ("Metallic RemapMin", float) = 0
    _MetallicRemapMax ("Metallic RemapMax", float) = 1
    [ToggleOff] _SpecularHighlights ("Specular Highlights", float) = 1
    [ToggleOff] _GlossyReflections ("Glossy Reflections", float) = 1
    [ToggleOff] _NotFixSubstance ("Not Fix Substance's roughness", float) = 1
    [Toggle] _HeightFog ("Height Fog", float) = 0
    _HeightFogColor ("Height Fog Color", Color) = (0,0,1,1)
    _HeightFogDensity ("Height Fog Density", float) = 1
    _HeightFogStart ("Height Fog Start", float) = -10
    _HeightFogEnd ("Height Fog End", float) = 10
    [Toggle] _RimLight ("Rim Light", float) = 0
    [HDR] _RimColor ("Rim Color", Color) = (0.5,0.5,0.5,1)
    _RimPower ("Rim Power", Range(0.01, 10)) = 0.01
    _RimSpread ("Rim Spread", Range(-15, 4.99)) = 0.01
    _RimOffset ("Rim Offset", Vector) = (0,0,0,0)
    [Toggle] _Translucent ("Translucent", float) = 0
    _Translucency ("Translucency", Range(0, 50)) = 20
    _TransScattering ("Scaterring Falloff", Range(1, 50)) = 10
    _TransDirect ("Trans Direct", Range(0, 1)) = 0.1
    _TransAmbient ("Trans Ambient", Range(0, 1)) = 0
    _TransColor ("Trans Color", Color) = (1,0,0,0)
    _TransMap ("Trans Map", 2D) = "black" {}
    [Enum(Trans Map,0,Metallic B,1)] _TransMapChannel ("Translucent map channel", float) = 0
    [Toggle] _AdjustHSV ("Adjust HSV", float) = 0
    _AdjustHue ("Hue", Range(0, 360)) = 0
    _AdjustSaturation ("Saturation", Range(0, 5)) = 1
    _AdjustValue ("Value", Range(0, 5)) = 1
    _BumpScale ("Scale", float) = 1
    _BumpMap ("Normal Map", 2D) = "bump" {}
    _OcclusionStrength ("Strength", Range(0, 1)) = 1
    [HDR] _EmissionColor ("Color", Color) = (0,0,0,1)
    _EmissionTexture ("Emission", 2D) = "white" {}
    [Enum(Metallic B,0,Emission Texture,1)] _EmissionMapChannel ("Emission map channel", float) = 0
    [HideInInspector] _Mode ("__mode", float) = 0
    [HideInInspector] _SrcBlend ("__src", float) = 1
    [HideInInspector] _DstBlend ("__dst", float) = 0
    [HideInInspector] _ZWrite ("__zw", float) = 1
    [HideInInspector] _CullMode ("__cullMode", float) = 2
    [Toggle] _Shadow ("Shadow", float) = 0
    [Toggle] _ShadowOffsetToggle ("ShadowOffsetToggle", float) = 1
    _ShadowOffset ("_Offset", Vector) = (-0.5,-1,2,0)
    _ShadowColor ("_Color", Color) = (0,0,0,0.8)
    [Toggle] _Perspective ("Perspective", float) = 0
    [Toggle] _Overlay ("Hit Color", float) = 0
    [KeywordEnum(Rim,Albedo)] _HitColorChannel ("HitColorType", float) = 0
    _OverlayColor ("Color", Color) = (1,1,1,1)
    _FinalColor ("Color", Color) = (1,1,1,1)
    _OverlayMultiple ("Multiple", float) = 1
    _OverlayRimPower ("Rim Power", Range(0.01, 10)) = 0.01
    _OverlayRimSpread ("Rim Spread", Range(0, 4.99)) = 0.01
    _OverlayRimOffset ("Rim Offset", Vector) = (0,0,0,0)
    [HDR] _HitColor ("Color", Color) = (1,1,1,1)
    _HitMultiple ("Multiple", float) = 1
    _HitRimPower ("Rim Power", Range(0.01, 10)) = 0.01
    _HitRimSpread ("Rim Spread", Range(-15, 4.99)) = 0.01
    _HitRimOffset ("Rim Offset", Vector) = (0,0,0,0)
    [Toggle] _Streamer ("Streamer", float) = 0
    _StreamerTex ("Texture", 2D) = "white" {}
    _StreamerMask ("Mask", 2D) = "white" {}
    _StreamerNoise ("Noise", 2D) = "white" {}
    _StreamerNoiseSpeed ("NoiseSpeed", float) = 1
    _StreamerColor ("Color", Color) = (1,1,1,1)
    _StreamerAlpha ("Alpha", float) = 1
    _StreamerScrollX ("speed X", float) = 1
    _StreamerScrollY ("speed Y", float) = 0
    [KeywordEnum(UVPos,ScreenPos,ModelPos)] _StreamerChannel ("StreamerType", float) = 0
    [Toggle] _Contrast ("AdjustContrast", float) = 0
    _ContrastScale ("ContrastSacle", Range(0, 2)) = 1
    [Toggle] _Reflect ("Reflect", float) = 0
    _ReflectCubMap ("Reflect CubeMap", Cube) = "_Skybox" {}
    _ReflectMask ("Reflect Mask", 2D) = "white" {}
    [HDR] _ReflectColor ("Reflect Color", Color) = (0,0,0,1)
    _ReflectStrength ("Reflect Strength", Range(0, 2)) = 0
    _ReflectMode ("Reflect Mode", Range(0, 1)) = 1
    _ViewDirTex1 ("ViewDirTex1", 2D) = "white" {}
    [HDR] _SpecColor02 ("Spec Color", Color) = (0,0,0,1)
    _TimeScale ("Time Sca1e", Range(0, 10)) = 0
    _SpecScale ("SpecScale", Range(0.01, 3)) = 1
    _SpecStrength ("Spec Strength", Range(0, 10)) = 0
    _Alpha ("Alpha", Range(0, 1)) = 1
  }
  SubShader
  {
    Tags
    { 
      "PerformanceChecks" = "False"
      "RenderType" = "Opaque"
    }
    LOD 300
    Pass // ind: 1, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "PerformanceChecks" = "False"
        "RenderType" = "Opaque"
      }
      LOD 300
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 3
        ReadMask 255
        WriteMask 255
        Pass IncrSat
        Fail Keep
        ZFail Keep
        PassFront IncrSat
        FailFront Keep
        ZFailFront Keep
        PassBack IncrSat
        FailBack Keep
        ZFailBack Keep
      } 
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile DIRECTIONAL LIGHTPROBE_SH SHADOWS_OFF _ALPHATEST_ON _HITCOLORCHANNEL_RIM _STREAMERCHANNEL_UVPOS
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      // uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 unity_SHAr;
      
      uniform float4 unity_SHAg;
      
      uniform float4 unity_SHAb;
      
      uniform float4 unity_SHBr;
      
      uniform float4 unity_SHBg;
      
      uniform float4 unity_SHBb;
      
      uniform float4 unity_SHC;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex_ST;
      
      uniform float _Metallic;
      
      uniform float _Glossiness;
      
      uniform float4 _WorldSpaceLightPos0;
      
      uniform float4 unity_SpecCube0_HDR;
      
      uniform float4 _LightColor0;
      
      uniform float4 _Color;
      
      uniform float _ColorScale;
      
      uniform float _Cutoff;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D unity_NHxRoughness;
      
      uniform samplerCUBE unity_SpecCube0;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float4 texcoord4 : TEXCOORD4;
          
          float4 texcoord5 : TEXCOORD5;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float4 texcoord4 : TEXCOORD4;
          
          float4 texcoord5 : TEXCOORD5;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float3 u_xlat16_2;
      
      float4 u_xlat16_3;
      
      float3 u_xlat16_4;
      
      float u_xlat15;
      
      float u_xlat16;
      
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
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          u_xlat16_2.x = (-_Metallic) * 0.959999979 + 0.959999979;
          
          u_xlat0.x = (-u_xlat16_2.x) + _Glossiness;
          
          u_xlat0.w = u_xlat0.x + 1.0;
          
          #ifdef UNITY_ADRENO_ES3
          u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
          
          #else
          u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
          
          #endif
          u_xlat1.xyz = in_v.vertex.yyy * unity_ObjectToWorld[1].xyz;
          
          u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_v.vertex.xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_v.vertex.zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_v.vertex.www + u_xlat1.xyz;
          
          u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
          
          u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat16 = inversesqrt(u_xlat16);
          
          u_xlat0.xyz = float3(u_xlat16) * u_xlat1.xyz;
          
          out_v.texcoord1 = u_xlat0;
          
          u_xlat1.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat1.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat1.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat15 = inversesqrt(u_xlat15);
          
          u_xlat1.xyz = float3(u_xlat15) * u_xlat1.xyz;
          
          u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
          
          u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
          
          u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
          
          u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
          
          u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
          
          u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
          
          u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
          
          u_xlat1.w = 1.0;
          
          u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
          
          u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
          
          u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
          
          u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
          
          out_v.texcoord2.xyz = max(u_xlat16_2.xyz, float3(0.0, 0.0, 0.0));
          
          out_v.texcoord2.w = 0.0;
          
          u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
          
          u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
          
          out_v.texcoord4.yzw = u_xlat1.xyz * (-u_xlat16_2.xxx) + u_xlat0.xyz;
          
          u_xlat16_2.x = dot(u_xlat1.xyz, (-u_xlat0.xyz));
          
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
          
          #else
          u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
          
          #endif
          out_v.texcoord5.xyz = u_xlat1.xyz;
          
          u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
          
          u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
          
          out_v.texcoord5.w = u_xlat16_2.x * u_xlat16_2.x;
          
          out_v.texcoord4.x = 0.0;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      int u_xlatb0;
      
      float3 u_xlat16_1;
      
      float4 u_xlat16_2_d;
      
      float3 u_xlat16_3_d;
      
      float3 u_xlat16_4_d;
      
      float3 u_xlat16_5;
      
      float u_xlat16_6;
      
      float3 u_xlat16_7;
      
      float u_xlat16_19;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat16_1.x = u_xlat16_0.w * _Color.w + (-_Cutoff);
          
          u_xlat16_7.xyz = u_xlat16_0.xyz * _Color.xyz;
          
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0 = (u_xlat16_1.x<0.0);
          
          #else
          u_xlatb0 = u_xlat16_1.x<0.0;
          
          #endif
          if(u_xlatb0)
      {
              discard;
      }
          
          u_xlat0_d.xz = (-float2(float2(_Glossiness, _Glossiness))) + float2(1.0, 1.0);
          
          u_xlat16_1.x = (-u_xlat0_d.x) * 0.699999988 + 1.70000005;
          
          u_xlat16_1.x = u_xlat0_d.x * u_xlat16_1.x;
          
          u_xlat16_1.x = u_xlat16_1.x * 6.0;
          
          u_xlat16_2_d = textureLod(unity_SpecCube0, in_f.texcoord4.yzw, u_xlat16_1.x);
          
          u_xlat16_1.x = u_xlat16_2_d.w + -1.0;
          
          u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
          
          u_xlat16_1.x = log2(u_xlat16_1.x);
          
          u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.y;
          
          u_xlat16_1.x = exp2(u_xlat16_1.x);
          
          u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
          
          u_xlat16_3_d.xyz = u_xlat16_2_d.xyz * u_xlat16_1.xxx;
          
          u_xlat16_4_d.xyz = u_xlat16_7.xyz * float3(_ColorScale) + float3(-0.0399999991, -0.0399999991, -0.0399999991);
          
          u_xlat16_1.xyz = u_xlat16_7.xyz * float3(_ColorScale);
          
          u_xlat16_4_d.xyz = float3(float3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4_d.xyz + float3(0.0399999991, 0.0399999991, 0.0399999991);
          
          u_xlat16_5.xyz = (-u_xlat16_4_d.xyz) + in_f.texcoord1.www;
          
          u_xlat16_5.xyz = in_f.texcoord5.www * u_xlat16_5.xyz + u_xlat16_4_d.xyz;
          
          u_xlat16_3_d.xyz = u_xlat16_3_d.xyz * u_xlat16_5.xyz;
          
          u_xlat16_19 = (-_Metallic) * 0.959999979 + 0.959999979;
          
          u_xlat16_1.xyz = float3(u_xlat16_19) * u_xlat16_1.xyz;
          
          u_xlat16_3_d.xyz = in_f.texcoord2.xyz * u_xlat16_1.xyz + u_xlat16_3_d.xyz;
          
          u_xlat16_19 = dot(in_f.texcoord4.yzw, _WorldSpaceLightPos0.xyz);
          
          u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
          
          u_xlat16_6 = u_xlat16_19 * u_xlat16_19;
          
          u_xlat0_d.y = u_xlat16_6;
          
          u_xlat0_d.x = texture(unity_NHxRoughness, u_xlat0_d.yz).x;
          
          u_xlat0_d.x = u_xlat0_d.x * 16.0;
          
          u_xlat16_1.xyz = u_xlat0_d.xxx * u_xlat16_4_d.xyz + u_xlat16_1.xyz;
          
          u_xlat0_d.x = dot(in_f.texcoord5.xyz, _WorldSpaceLightPos0.xyz);
          
          #ifdef UNITY_ADRENO_ES3
          u_xlat0_d.x = min(max(u_xlat0_d.x, 0.0), 1.0);
          
          #else
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0.0, 1.0);
          
          #endif
          u_xlat16_4_d.xyz = u_xlat0_d.xxx * _LightColor0.xyz;
          
          out_f.color.xyz = u_xlat16_1.xyz * u_xlat16_4_d.xyz + u_xlat16_3_d.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: FORWARD_DELTA
    {
      Name "FORWARD_DELTA"
      Tags
      { 
        "LIGHTMODE" = "FORWARDADD"
        "PerformanceChecks" = "False"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      LOD 300
      ZWrite Off
      Blend Zero One
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile POINT_COOKIE _ALPHATEST_ON _SPECULARHIGHLIGHTS_OFF
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      
      
      
      struct appdata_t
      {
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 vertex : Position;
      
      };
      
      
      struct OUT_Data_Frag
      {
      
      };
      
      
      13000000756E6974795F576F726C64546F536861646F77000000000004000000040000000100000004000000500000000D000000756E6974795F4D617472697856000000000000000400000004000000010000000000000070010000000000000800000024476C6F62616C732001000009000000140000005F576F726C64537061636543616D657261506F730000000001000000030000000000000000000000000000000A000000756E6974795F5348427200000000000001000000040000000000000000000000100000000A000000756E6974795F5348426700000000000001000000040000000000000000000000200000000A000000756E6974795F53484262000000000000010000000400000000000000000000003000000009000000756E6974795F5348430000000000000001000000040000000000000000000000400000000B0000005F4D61696E5465785F53540000000000010000000400000000000000000000001001000013000000756E6974795F4F626A656374546F576F726C640000000000040000000400000001000000000000005000000013000000756E6974795F576F726C64546F4F626A656374000000000004000000040000000100000000000000900000000E000000756E6974795F4D6174726978565000000000000004000000040000000100000000000000D00000000000000002000000110000005F536861646F774D617054657874757265000000000000000200000002000000040000000F000000756E6974795F53706563437562653000000000000100000001000000080000003C51070C040000000000000000000000000000000000000007000000
      ENDCG
      
    } // end phase
    Pass // ind: 3, name: SHADOW
    {
      Name "SHADOW"
      Tags
      { 
        "LIGHTMODE" = "ALWAYS"
        "PerformanceChecks" = "False"
        "QUEUE" = "Transparent"
        "RenderType" = "Transparent"
      }
      LOD 300
      ZWrite Off
      Stencil
      { 
        Ref 1
        ReadMask 255
        WriteMask 255
        Pass Replace
        Fail Keep
        ZFail Keep
        PassFront Replace
        FailFront Keep
        ZFailFront Keep
        PassBack Replace
        FailBack Keep
        ZFailBack Keep
      } 
      Blend SrcAlpha OneMinusSrcAlpha
      // m_ProgramMask = 6
      Program "vp"
      {
        SubProgram "gles3 hw_tier00"
        {
          
          "!!!!GLES3
        SubProgram "gles3 hw_tier01"
        {
          
          "!!!!GLES3
        SubProgram "gles3 hw_tier02"
        {
          
          "!!!!GLES3
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "_SHADOWOFFSETTOGGLE_ON" }
          
          "!!!!GLES3
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "_SHADOWOFFSETTOGGLE_ON" }
          
          "!!!!GLES3
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "_SHADOWOFFSETTOGGLE_ON" }
          
          "!!!!GLES3
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "_SHADOW_ON" }
          
          "!!!!GLES3
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "_SHADOW_ON" }
          
          "!!!!GLES3
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "_SHADOW_ON" }
          
          "!!!!GLES3
        SubProgram "gles3 hw_tier00"
        {
           Keywords { "_SHADOWOFFSETTOGGLE_ON" "_SHADOW_ON" }
          
          "!!!!GLES3
        SubProgram "gles3 hw_tier01"
        {
           Keywords { "_SHADOWOFFSETTOGGLE_ON" "_SHADOW_ON" }
          
          "!!!!GLES3
        SubProgram "gles3 hw_tier02"
        {
           Keywords { "_SHADOWOFFSETTOGGLE_ON" "_SHADOW_ON" }
          
          "!!!!GLES3
      }
      Program "fp"
      {
      }
      Program "gp"
      {
      }
      Program "hp"
      {
      }
      Program "dp"
      {
      }
      Program "surface"
      {
      }
      Program "rtp"
      {
      }
      
    } // end phase
  }
  SubShader
  {
    Tags
    { 
      "PerformanceChecks" = "False"
      "RenderType" = "Opaque"
    }
    LOD 150
    Pass // ind: 1, name: FORWARD
    {
      Name "FORWARD"
      Tags
      { 
        "LIGHTMODE" = "FORWARDBASE"
        "PerformanceChecks" = "False"
        "RenderType" = "Opaque"
      }
      LOD 150
      ZWrite Off
      Cull Off
      Stencil
      { 
        Ref 0
        ReadMask 255
        WriteMask 255
        Pass IncrSat
        Fail Keep
        ZFail Keep
        PassFront IncrSat
        FailFront Keep
        ZFailFront Keep
        PassBack IncrSat
        FailBack Keep
        ZFailBack Keep
      } 
      Blend Zero Zero
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile DIRECTIONAL LIGHTPROBE_SH SHADOWS_OFF _ALPHATEST_ON _HITCOLORCHANNEL_RIM _STREAMERCHANNEL_UVPOS
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      #define CODE_BLOCK_VERTEX
      
      
      // uniform float3 _WorldSpaceCameraPos;
      
      uniform float4 unity_SHAr;
      
      uniform float4 unity_SHAg;
      
      uniform float4 unity_SHAb;
      
      uniform float4 unity_SHBr;
      
      uniform float4 unity_SHBg;
      
      uniform float4 unity_SHBb;
      
      uniform float4 unity_SHC;
      
      uniform float4 unity_ObjectToWorld[4];
      
      uniform float4 unity_WorldToObject[4];
      
      uniform float4 unity_MatrixVP[4];
      
      uniform float4 _MainTex_ST;
      
      uniform float _Metallic;
      
      uniform float _Glossiness;
      
      uniform float4 _WorldSpaceLightPos0;
      
      uniform float4 unity_SpecCube0_HDR;
      
      uniform float4 _LightColor0;
      
      uniform float4 _Color;
      
      uniform float _ColorScale;
      
      uniform float _Cutoff;
      
      uniform sampler2D _MainTex;
      
      uniform sampler2D unity_NHxRoughness;
      
      uniform samplerCUBE unity_SpecCube0;
      
      
      
      struct appdata_t
      {
          
          float4 vertex : POSITION0;
          
          float3 normal : NORMAL0;
          
          float2 texcoord : TEXCOORD0;
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float4 texcoord4 : TEXCOORD4;
          
          float4 texcoord5 : TEXCOORD5;
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 texcoord : TEXCOORD0;
          
          float4 texcoord1 : TEXCOORD1;
          
          float4 texcoord2 : TEXCOORD2;
          
          float4 texcoord4 : TEXCOORD4;
          
          float4 texcoord5 : TEXCOORD5;
      
      };
      
      
      struct OUT_Data_Frag
      {
          
          float4 color : SV_Target0;
      
      };
      
      
      float4 u_xlat0;
      
      float4 u_xlat1;
      
      float3 u_xlat16_2;
      
      float4 u_xlat16_3;
      
      float3 u_xlat16_4;
      
      float u_xlat15;
      
      float u_xlat16;
      
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
          
          out_v.texcoord.xy = in_v.texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
          
          u_xlat16_2.x = (-_Metallic) * 0.959999979 + 0.959999979;
          
          u_xlat0.x = (-u_xlat16_2.x) + _Glossiness;
          
          u_xlat0.w = u_xlat0.x + 1.0;
          
          #ifdef UNITY_ADRENO_ES3
          u_xlat0.w = min(max(u_xlat0.w, 0.0), 1.0);
          
          #else
          u_xlat0.w = clamp(u_xlat0.w, 0.0, 1.0);
          
          #endif
          u_xlat1.xyz = in_v.vertex.yyy * unity_ObjectToWorld[1].xyz;
          
          u_xlat1.xyz = unity_ObjectToWorld[0].xyz * in_v.vertex.xxx + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_ObjectToWorld[2].xyz * in_v.vertex.zzz + u_xlat1.xyz;
          
          u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_v.vertex.www + u_xlat1.xyz;
          
          u_xlat1.xyz = u_xlat1.xyz + (-_WorldSpaceCameraPos.xyz);
          
          u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat16 = inversesqrt(u_xlat16);
          
          u_xlat0.xyz = float3(u_xlat16) * u_xlat1.xyz;
          
          out_v.texcoord1 = u_xlat0;
          
          u_xlat1.x = dot(in_v.normal.xyz, unity_WorldToObject[0].xyz);
          
          u_xlat1.y = dot(in_v.normal.xyz, unity_WorldToObject[1].xyz);
          
          u_xlat1.z = dot(in_v.normal.xyz, unity_WorldToObject[2].xyz);
          
          u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
          
          u_xlat15 = inversesqrt(u_xlat15);
          
          u_xlat1.xyz = float3(u_xlat15) * u_xlat1.xyz;
          
          u_xlat16_2.x = u_xlat1.y * u_xlat1.y;
          
          u_xlat16_2.x = u_xlat1.x * u_xlat1.x + (-u_xlat16_2.x);
          
          u_xlat16_3 = u_xlat1.yzzx * u_xlat1.xyzz;
          
          u_xlat16_4.x = dot(unity_SHBr, u_xlat16_3);
          
          u_xlat16_4.y = dot(unity_SHBg, u_xlat16_3);
          
          u_xlat16_4.z = dot(unity_SHBb, u_xlat16_3);
          
          u_xlat16_2.xyz = unity_SHC.xyz * u_xlat16_2.xxx + u_xlat16_4.xyz;
          
          u_xlat1.w = 1.0;
          
          u_xlat16_3.x = dot(unity_SHAr, u_xlat1);
          
          u_xlat16_3.y = dot(unity_SHAg, u_xlat1);
          
          u_xlat16_3.z = dot(unity_SHAb, u_xlat1);
          
          u_xlat16_2.xyz = u_xlat16_2.xyz + u_xlat16_3.xyz;
          
          out_v.texcoord2.xyz = max(u_xlat16_2.xyz, float3(0.0, 0.0, 0.0));
          
          out_v.texcoord2.w = 0.0;
          
          u_xlat16_2.x = dot(u_xlat0.xyz, u_xlat1.xyz);
          
          u_xlat16_2.x = u_xlat16_2.x + u_xlat16_2.x;
          
          out_v.texcoord4.yzw = u_xlat1.xyz * (-u_xlat16_2.xxx) + u_xlat0.xyz;
          
          u_xlat16_2.x = dot(u_xlat1.xyz, (-u_xlat0.xyz));
          
          #ifdef UNITY_ADRENO_ES3
          u_xlat16_2.x = min(max(u_xlat16_2.x, 0.0), 1.0);
          
          #else
          u_xlat16_2.x = clamp(u_xlat16_2.x, 0.0, 1.0);
          
          #endif
          out_v.texcoord5.xyz = u_xlat1.xyz;
          
          u_xlat16_2.x = (-u_xlat16_2.x) + 1.0;
          
          u_xlat16_2.x = u_xlat16_2.x * u_xlat16_2.x;
          
          out_v.texcoord5.w = u_xlat16_2.x * u_xlat16_2.x;
          
          out_v.texcoord4.x = 0.0;
          
          return;
      
      }
      
      
      #define CODE_BLOCK_FRAGMENT
      
      
      
      float3 u_xlat0_d;
      
      float4 u_xlat16_0;
      
      int u_xlatb0;
      
      float3 u_xlat16_1;
      
      float4 u_xlat16_2_d;
      
      float3 u_xlat16_3_d;
      
      float3 u_xlat16_4_d;
      
      float3 u_xlat16_5;
      
      float u_xlat16_6;
      
      float3 u_xlat16_7;
      
      float u_xlat16_19;
      
      OUT_Data_Frag frag(v2f in_f)
      {
          
          u_xlat16_0 = texture(_MainTex, in_f.texcoord.xy);
          
          u_xlat16_1.x = u_xlat16_0.w * _Color.w + (-_Cutoff);
          
          u_xlat16_7.xyz = u_xlat16_0.xyz * _Color.xyz;
          
          #ifdef UNITY_ADRENO_ES3
          u_xlatb0 = (u_xlat16_1.x<0.0);
          
          #else
          u_xlatb0 = u_xlat16_1.x<0.0;
          
          #endif
          if(u_xlatb0)
      {
              discard;
      }
          
          u_xlat0_d.xz = (-float2(float2(_Glossiness, _Glossiness))) + float2(1.0, 1.0);
          
          u_xlat16_1.x = (-u_xlat0_d.x) * 0.699999988 + 1.70000005;
          
          u_xlat16_1.x = u_xlat0_d.x * u_xlat16_1.x;
          
          u_xlat16_1.x = u_xlat16_1.x * 6.0;
          
          u_xlat16_2_d = textureLod(unity_SpecCube0, in_f.texcoord4.yzw, u_xlat16_1.x);
          
          u_xlat16_1.x = u_xlat16_2_d.w + -1.0;
          
          u_xlat16_1.x = unity_SpecCube0_HDR.w * u_xlat16_1.x + 1.0;
          
          u_xlat16_1.x = log2(u_xlat16_1.x);
          
          u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.y;
          
          u_xlat16_1.x = exp2(u_xlat16_1.x);
          
          u_xlat16_1.x = u_xlat16_1.x * unity_SpecCube0_HDR.x;
          
          u_xlat16_3_d.xyz = u_xlat16_2_d.xyz * u_xlat16_1.xxx;
          
          u_xlat16_4_d.xyz = u_xlat16_7.xyz * float3(_ColorScale) + float3(-0.0399999991, -0.0399999991, -0.0399999991);
          
          u_xlat16_1.xyz = u_xlat16_7.xyz * float3(_ColorScale);
          
          u_xlat16_4_d.xyz = float3(float3(_Metallic, _Metallic, _Metallic)) * u_xlat16_4_d.xyz + float3(0.0399999991, 0.0399999991, 0.0399999991);
          
          u_xlat16_5.xyz = (-u_xlat16_4_d.xyz) + in_f.texcoord1.www;
          
          u_xlat16_5.xyz = in_f.texcoord5.www * u_xlat16_5.xyz + u_xlat16_4_d.xyz;
          
          u_xlat16_3_d.xyz = u_xlat16_3_d.xyz * u_xlat16_5.xyz;
          
          u_xlat16_19 = (-_Metallic) * 0.959999979 + 0.959999979;
          
          u_xlat16_1.xyz = float3(u_xlat16_19) * u_xlat16_1.xyz;
          
          u_xlat16_3_d.xyz = in_f.texcoord2.xyz * u_xlat16_1.xyz + u_xlat16_3_d.xyz;
          
          u_xlat16_19 = dot(in_f.texcoord4.yzw, _WorldSpaceLightPos0.xyz);
          
          u_xlat16_19 = u_xlat16_19 * u_xlat16_19;
          
          u_xlat16_6 = u_xlat16_19 * u_xlat16_19;
          
          u_xlat0_d.y = u_xlat16_6;
          
          u_xlat0_d.x = texture(unity_NHxRoughness, u_xlat0_d.yz).x;
          
          u_xlat0_d.x = u_xlat0_d.x * 16.0;
          
          u_xlat16_1.xyz = u_xlat0_d.xxx * u_xlat16_4_d.xyz + u_xlat16_1.xyz;
          
          u_xlat0_d.x = dot(in_f.texcoord5.xyz, _WorldSpaceLightPos0.xyz);
          
          #ifdef UNITY_ADRENO_ES3
          u_xlat0_d.x = min(max(u_xlat0_d.x, 0.0), 1.0);
          
          #else
          u_xlat0_d.x = clamp(u_xlat0_d.x, 0.0, 1.0);
          
          #endif
          u_xlat16_4_d.xyz = u_xlat0_d.xxx * _LightColor0.xyz;
          
          out_f.color.xyz = u_xlat16_1.xyz * u_xlat16_4_d.xyz + u_xlat16_3_d.xyz;
          
          out_f.color.w = 1.0;
          
          return;
      
      }
      
      
      ENDCG
      
    } // end phase
    Pass // ind: 2, name: FORWARD_DELTA
    {
      Name "FORWARD_DELTA"
      Tags
      { 
        "LIGHTMODE" = "FORWARDADD"
        "PerformanceChecks" = "False"
        "RenderType" = "Opaque"
        "SHADOWSUPPORT" = "true"
      }
      LOD 150
      ZWrite Off
      Blend Zero One
      // m_ProgramMask = 6
      CGPROGRAM
      #pragma multi_compile POINT_COOKIE _ALPHATEST_ON _SPECULARHIGHLIGHTS_OFF
      //#pragma target 4.0
      
      #pragma vertex vert
      #pragma fragment frag
      
      #include "UnityCG.cginc"
      
      
      
      
      
      struct appdata_t
      {
      
      };
      
      
      struct OUT_Data_Vert
      {
          
          float4 vertex : SV_POSITION;
      
      };
      
      
      struct v2f
      {
          
          float4 vertex : Position;
      
      };
      
      
      struct OUT_Data_Frag
      {
      
      };
      
      
      13000000756E6974795F576F726C64546F536861646F77000000000004000000040000000100000004000000500000000D000000756E6974795F4D617472697856000000000000000400000004000000010000000000000070010000000000000800000024476C6F62616C732001000009000000140000005F576F726C64537061636543616D657261506F730000000001000000030000000000000000000000000000000A000000756E6974795F5348427200000000000001000000040000000000000000000000100000000A000000756E6974795F5348426700000000000001000000040000000000000000000000200000000A000000756E6974795F53484262000000000000010000000400000000000000000000003000000009000000756E6974795F5348430000000000000001000000040000000000000000000000400000000B0000005F4D61696E5465785F53540000000000010000000400000000000000000000001001000013000000756E6974795F4F626A656374546F576F726C640000000000040000000400000001000000000000005000000013000000756E6974795F576F726C64546F4F626A656374000000000004000000040000000100000000000000900000000E000000756E6974795F4D6174726978565000000000000004000000040000000100000000000000D00000000000000002000000110000005F536861646F774D617054657874757265000000000000000200000002000000040000000F000000756E6974795F53706563437562653000000000000100000001000000080000003C51070C040000000000000000000000000000000000000007000000
      ENDCG
      
    } // end phase
  }
  FallBack "VertexLit"
}
