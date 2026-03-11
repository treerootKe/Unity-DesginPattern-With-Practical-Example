namespace Behavioral_Patterns.Observer_Strategy_Achievement.ObserverEvent
{
    /// <summary>
    /// 数量变化事件
    /// </summary>
    public class QuantityChangedEvent: IGameAchievementEvent
    {
        public long CurrentQuantity;    // 当前数量
    }
}