using Behavioral_Patterns.Observer_Strategy_Achievement.ObserverEvent;

namespace Behavioral_Patterns.Observer_Strategy_Achievement.StrategyMode
{
    public class BossKillLowHpHandler:IAchievementHandler
    {
        public bool HandleAchievement(IGameAchievementEvent gameEvent, AchievementConfig config)
        {
            if (!(gameEvent is BossKilledEvent evt)) return false;

            if (evt.PlayerHpPercent >= 0.1f) return false;

            return evt.KillsCount >= config.AchievementTargets[0];
        }
    }
}