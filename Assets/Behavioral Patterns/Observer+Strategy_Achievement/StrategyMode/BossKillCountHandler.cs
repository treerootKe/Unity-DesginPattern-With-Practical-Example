using Behavioral_Patterns.Observer_Strategy_Achievement.ObserverEvent;

namespace Behavioral_Patterns.Observer_Strategy_Achievement.StrategyMode
{
    /// <summary>
    /// 击杀Boss数量成就处理
    /// </summary>
    public class BossKillCountHandler:IAchievementHandler
    {
        public bool HandleAchievement(IGameAchievementEvent gameEvent, AchievementConfig config)
        {
            if (!(gameEvent is BossKilledEvent bossKilledEvent))
            {
                return false;
            }

            if (!(bossKilledEvent.KillsCount > config.AchievementTargets[0]))
            {
                return false;
            }
            
            return true;
        }
    }
}