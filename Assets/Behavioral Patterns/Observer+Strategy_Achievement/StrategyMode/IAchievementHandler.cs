using Behavioral_Patterns.Observer_Strategy_Achievement.ObserverEvent;

namespace Behavioral_Patterns.Observer_Strategy_Achievement.StrategyMode
{
    public interface IAchievementHandler
    {
        bool HandleAchievement(IGameAchievementEvent gameEvent, AchievementConfig config);
    }
}