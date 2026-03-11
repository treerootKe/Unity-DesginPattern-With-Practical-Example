using Behavioral_Patterns.Observer_Strategy_Achievement.ObserverEvent;
using UnityEngine;

namespace Behavioral_Patterns.Observer_Strategy_Achievement
{
    public class ObserverStrategyTest:MonoBehaviour
    {
        void Start()
        {
            // 初始化系统
            AchievementManager.Instance.Init();

            // === 模拟游戏流程 ===

            // 场景1：玩家打了一只无关的小怪（不是Boss成就关心的ID）
            // 这里的 BossId 999 在监听列表里找不到对应配置，处理器会直接返回 false
            AchievementManager.Instance.TriggerEvent(new BossKilledEvent 
            { 
                BossId = 999, KillsCount = 12, Duration = 5, PlayerHpPercent = 1.0f 
            });

            // 场景2：玩家击败了雷龙，耗时8秒，满血
            // 成就ID 1 (雷龙速杀): 需要耗时<10秒 -> 满足 -> 解锁
            // 成就ID 2 (化险为夷): 需要血量<10% -> 不满足 -> 忽略
            AchievementManager.Instance.TriggerEvent(new BossKilledEvent 
            { 
                BossId = 101, Duration = 8, PlayerHpPercent = 1.0f 
            });

            // 场景3：玩家金币变化
            // 只有金币成就会收到这个事件，Boss成就完全不会被干扰
            AchievementManager.Instance.TriggerEvent(new QuantityChangedEvent 
            { 
                CurrentQuantity = 10500 
            });
        }
    }
}