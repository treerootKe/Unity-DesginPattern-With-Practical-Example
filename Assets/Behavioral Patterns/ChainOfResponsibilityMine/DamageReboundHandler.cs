using UnityEngine;

namespace Behavioral_Patterns.ChainOfResponsibilityMine
{
    public class DamageReboundHandler: AbstractDamageHandler
    {
        public override void HandleDamage(DamageInfo damageInfo)
        {
            Debug.Log("DamageReboundHandler: Damage is rebound!");
        }
        
    }
}