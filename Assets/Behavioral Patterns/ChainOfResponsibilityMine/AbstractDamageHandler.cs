using UnityEngine;

namespace Behavioral_Patterns.ChainOfResponsibilityMine
{
    /// <summary>
    /// 责任链模式，抽象伤害处理类
    /// </summary>
    public abstract class AbstractDamageHandler
    {
        protected AbstractDamageHandler Successor;//责任链的后继者

        /// <summary>
        /// 设置后继者
        /// </summary>
        /// <param name="successor"></param>
        public void SetSuccessor(AbstractDamageHandler successor)
        {
            Successor = successor;
        }
    
        public abstract void HandleDamage(DamageInfo damageInfo);
    }
}
