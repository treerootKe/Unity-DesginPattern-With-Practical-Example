namespace Behavioral_Patterns.Observer_Strategy_Achievement.ObserverEvent
{
    public class BossKilledEvent: IGameAchievementEvent
    {
        public int BossId;          // Boss ID
        public int KillsCount;       // 击杀次数
        public float Duration;      // 击杀耗时
        public float PlayerHpPercent; // 玩家剩余血量百分比
    }
}