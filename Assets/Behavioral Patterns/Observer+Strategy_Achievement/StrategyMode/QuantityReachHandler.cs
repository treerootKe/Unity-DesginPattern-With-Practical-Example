using Behavioral_Patterns.Observer_Strategy_Achievement.ObserverEvent;

namespace Behavioral_Patterns.Observer_Strategy_Achievement.StrategyMode
{
    /// <summary>
    /// 判断数量类型的成就，如：行走的距离、某一种道具收集数量......
    /// </summary>
    public class QuantityReachHandler:IAchievementHandler
    {
        public bool HandleAchievement(IGameAchievementEvent gameEvent, AchievementConfig config)
        {
            if (!(gameEvent is QuantityChangedEvent quantityChangedEvent))
            {
                return false;
            }

            if (!(quantityChangedEvent.CurrentQuantity > config.AchievementTargets[0]))
            {
                return false;
            }
            
            return true;
        }
    }
}