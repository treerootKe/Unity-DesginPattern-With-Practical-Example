namespace Behavioral_Patterns.ChainOfResponsibility_Achievement
{
    /// <summary>
    /// 成就检查抽象类
    /// </summary>
    public abstract class AbstractAchievementChecker
    {
        protected AbstractAchievementChecker Successor; // 成就检查器链的后继者
        
        /// <summary>
        /// 设置后继者
        /// </summary>
        /// <param name="successor">后继者</param>
        public void SetSuccessor(AbstractAchievementChecker successor)
        {
            Successor = successor;
        }
        
        /// <summary>
        /// 检查成就
        /// </summary>
        public abstract void Check();
    }
}