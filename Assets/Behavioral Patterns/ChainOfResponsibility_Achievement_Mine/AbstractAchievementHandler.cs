namespace Behavioral_Patterns.ChainOfResponsibility_Achievement_Mine
{
    public abstract class AbstractAchievementHandler
    {
        protected AbstractAchievementHandler Successor;
        
        public void SetSuccessor(AbstractAchievementHandler successor)
        {
            Successor = successor;
        }
        
        
    }
}