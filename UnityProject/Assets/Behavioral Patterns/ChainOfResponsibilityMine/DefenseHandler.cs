using UnityEngine;

namespace Behavioral_Patterns.ChainOfResponsibilityMine
{
    public class DefenseHandler: AbstractDamageHandler
    {
        public override void HandleDamage(DamageInfo damageInfo)
        {
            var damageReduction = damageInfo.TargetInfo.Defense * 0.1f;
            damageInfo.CurrentDamage -= damageReduction;
            
            // 确保伤害至少为1，避免防御过高导致伤害为0
            damageInfo.CurrentDamage = damageInfo.CurrentDamage <= 0 ? 1 : damageInfo.CurrentDamage;
            Debug.Log("DefenseHandler: Damage after defense is " + damageInfo.CurrentDamage);
            
            if (Successor != null)
            {
                Successor.HandleDamage(damageInfo);
            }
        }
        
    }
}