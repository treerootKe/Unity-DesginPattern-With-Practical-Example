using System;
using System.Collections.Generic;
using Behavioral_Patterns.Observer_Strategy_Achievement.ObserverEvent;
using Behavioral_Patterns.Observer_Strategy_Achievement.StrategyMode;
using UnityEngine;

namespace Behavioral_Patterns.Observer_Strategy_Achievement
{
    public class AchievementManager
    {
        // 单例
        public static readonly AchievementManager Instance = new AchievementManager();

        // 【核心1】：事件监听字典
        // Key: 事件类型
        // Value: 关心该事件的成就配置列表
        private readonly Dictionary<Type, List<AchievementConfig>> _eventListeners =
            new Dictionary<Type, List<AchievementConfig>>();

        private readonly AchievementStrategyFactory _strategyFactory = new AchievementStrategyFactory();

        // 模拟的配置数据
        private readonly List<AchievementConfig> _allConfigs = new List<AchievementConfig>();

        public void Init()
        {
            // 1. 注册处理器（策略）
            _strategyFactory.RegisterStrategy(AchievementStrategyType.BossKillCount, new BossKillCountHandler(), typeof(BossKilledEvent));
            _strategyFactory.RegisterStrategy(AchievementStrategyType.BossKillLowHp, new BossKillLowHpHandler(), typeof(BossKilledEvent));
            _strategyFactory.RegisterStrategy(AchievementStrategyType.QuantityReach, new QuantityReachHandler(), typeof(BossKilledEvent));
            
            // 2. 模拟加载配置表（实际从Json/DB读取）
            LoadConfigs();

            // 3. 【关键步骤】：建立事件监听映射
            RegisterListeners();
        }

        // 模拟配置
        private void LoadConfigs()
        {
            _allConfigs.Add(new AchievementConfig
            {
                AchievementId = 1, AchievementStrategyType = AchievementStrategyType.BossKillCount, AchievementCategory = "战斗成就",
                AchievementParentsName = "Boss达人",
                AchievementName = "雷龙猎杀者", AchievementDescription = "击杀雷龙*次",
                AchievementTargets = new List<long>() { 10, 20, 30 },
            });

            _allConfigs.Add(new AchievementConfig
            {
                AchievementId = 2, AchievementStrategyType = AchievementStrategyType.BossKillLowHp, AchievementCategory = "战斗成就",
                AchievementParentsName = "Boss达人",
                AchievementName = "化险为夷·雷龙", AchievementDescription = "玩家血量低于10%，击杀雷龙*次",
                AchievementTargets = new List<long>() { 10, 20, 30 },
            });

            _allConfigs.Add(new AchievementConfig
            {
                AchievementId = 1, AchievementStrategyType = AchievementStrategyType.QuantityReach, AchievementCategory = "生涯成就",
                AchievementParentsName = "盆满钵满",
                AchievementName = "金币收藏家", AchievementDescription = "金币数量达到*",
                AchievementTargets = new List<long>() { 1000, 10000, 100000 },
            });
        }

        /// <summary>
        /// 【核心逻辑】：根据配置自动注册监听
        /// </summary>
        private void RegisterListeners()
        {
            foreach (var config in _allConfigs)
            {
                Type eventType = _strategyFactory.GetEventType(config.AchievementStrategyType);

                if (eventType == null) continue;

                // 如果字典里没有这个事件类型的列表，创建一个
                if (!_eventListeners.ContainsKey(eventType))
                {
                    _eventListeners.Add(eventType, new List<AchievementConfig>());
                }

                // 将配置加入监听列表
                _eventListeners[eventType].Add(config);
            }
        }

        /// <summary>
        /// 【核心逻辑】：触发事件（替代责任链的传递）
        /// </summary>
        public void TriggerEvent(IGameAchievementEvent evt)
        {
            Type eventType = evt.GetType();

            // 1. 检查有没有人监听这个事件
            if (!_eventListeners.ContainsKey(eventType))
            {
                Debug.Log("No listeners for this event type.");
                return;
            }

            // 2. 获取所有关心此事件的成就列表
            var interestedConfigs = _eventListeners[eventType];

            // 3. 遍历执行相关成就的策略处理方法
            foreach (var config in interestedConfigs)
            {
                // 获取策略处理器
                var handler = _strategyFactory.GetHandler(config.AchievementStrategyType);

                // 执行判断
                bool isUnlocked = handler.HandleAchievement(evt, config);

                if (isUnlocked)
                {
                    UnlockAchievement(config);
                }
            }
        }

        private void UnlockAchievement(AchievementConfig config)
        {
            UnityEngine.Debug.Log($"[成就解锁] {config.AchievementName} (ID:{config.AchievementId})");
        }
    }
}