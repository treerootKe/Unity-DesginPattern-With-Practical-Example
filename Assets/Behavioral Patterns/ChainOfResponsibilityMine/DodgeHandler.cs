using UnityEngine;

namespace Behavioral_Patterns.ChainOfResponsibilityMine
{
    /// <summary>
    /// 闪避处理类
    /// </summary>
    public class DodgeHandler : AbstractDamageHandler
    {
        public override void HandleDamage(DamageInfo damageInfo)
        {
            var dodgeNumber = Random.Range(0, 1.0f);
            if (dodgeNumber < damageInfo.TargetInfo.DodgeChance)
            {
                damageInfo.CurrentDamage = 0;
                Debug.Log("Dodge!");
                return;
            }

            if (Successor != null)
            {
                Successor.HandleDamage(damageInfo);
            }
        }
    }
}