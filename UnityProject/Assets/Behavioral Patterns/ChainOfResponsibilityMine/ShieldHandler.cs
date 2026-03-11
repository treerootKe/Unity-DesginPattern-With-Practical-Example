

using UnityEngine;

namespace Behavioral_Patterns.ChainOfResponsibilityMine
{
    /// <summary>
    /// 护盾处理类
    /// </summary>
    public class ShieldHandler : AbstractDamageHandler
    {
        public override void HandleDamage(DamageInfo damageInfo)
        {
            if (damageInfo.TargetInfo.CurrentShield > 0)
            {
                var currentShield = damageInfo.TargetInfo.CurrentShield;
                var currentDamage = damageInfo.CurrentDamage;
                damageInfo.CurrentDamage = currentDamage > currentShield ? currentDamage - currentShield : 0;
                damageInfo.TargetInfo.CurrentShield = currentDamage > currentShield ? 0 : currentShield - currentDamage;
                
                Debug.Log("Shield remaining: " + damageInfo.TargetInfo.CurrentShield);
                
                // 如果护盾吸收了所有伤害，则返回
                if (damageInfo.CurrentDamage <= 0)
                {
                    return;
                }
            }
            
            if (Successor != null)
            {
                Successor.HandleDamage(damageInfo);
            }
        }
    }
}