using UnityEngine;

namespace Behavioral_Patterns.ChainOfResponsibilityMine
{
    public class DamageInfo
    {
        public float OriginalDamage; // 原始伤害
        public float CurrentDamage;  // 当前伤害
        public CharactersInfo TargetInfo; // 目标对象信息
        public GameObject ObjAttacker; // 攻击者对象
        
        public DamageInfo(float originalDamage, CharactersInfo targetInfo, GameObject objAttacker)
        {
            OriginalDamage = originalDamage;
            CurrentDamage = originalDamage;
            TargetInfo = targetInfo;
            ObjAttacker = objAttacker;
        }
    }
}