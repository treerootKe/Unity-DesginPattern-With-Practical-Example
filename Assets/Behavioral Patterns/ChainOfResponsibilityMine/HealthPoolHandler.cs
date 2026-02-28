using UnityEngine;

namespace Behavioral_Patterns.ChainOfResponsibilityMine
{
    /// <summary>
    /// 血量处理类
    /// </summary>
    public class HealthPoolHandler: AbstractDamageHandler
    {
        public override void HandleDamage(DamageInfo damageInfo)
        {
            damageInfo.TargetInfo.CurrentHealth -= damageInfo.CurrentDamage;
            Debug.Log("HealthPoolHandler: Health is reduced! Health is now " + damageInfo.TargetInfo.CurrentHealth);
            
            // 如果死亡，执行死亡逻辑，不触发伤害反弹
            if (damageInfo.TargetInfo.CurrentHealth <= 0)
            {
                Debug.Log("HealthPoolHandler: Character is dead!");
                return;
            }

            // 如果没有死亡，触发伤害反弹
            if (Successor != null)
            {
                Successor.HandleDamage(damageInfo);
            }
        }   
    }
}