using System;
using System.Collections.Generic;
using DataTables;

namespace Behavioral_Patterns.Observer_Strategy_Achievement.StrategyMode
{
    /// <summary>
    /// 成就策略工厂
    /// </summary>
    public class AchievementStrategyFactory
    {
        private readonly Dictionary<AchievementStrategyType, IAchievementHandler> _strategyDict = new Dictionary<AchievementStrategyType, IAchievementHandler>();
        
        private readonly Dictionary<AchievementStrategyType, Type> _eventTypeDict = new Dictionary<AchievementStrategyType, Type>();
        
        /// <summary>
        /// 注册成就策略
        /// </summary>
        /// <param name="AchievementStrategyType">策略类型</param>
        /// <param name="strategyHandler">具体策略处理器</param>
        /// <param name="eventType">事件类型</param>
        public void RegisterStrategy(AchievementStrategyType AchievementStrategyType, IAchievementHandler strategyHandler, Type eventType)
        {
            _strategyDict.Add(AchievementStrategyType, strategyHandler);

            _eventTypeDict.TryAdd(AchievementStrategyType, eventType);
        }
        
        /// <summary>
        /// 获取成就策略处理器
        /// </summary>
        /// <param name="AchievementStrategyType">策略类型</param>
        /// <returns></returns>
        public IAchievementHandler GetHandler(AchievementStrategyType AchievementStrategyType)
        {
            return _strategyDict.GetValueOrDefault(AchievementStrategyType);
        }

        /// <summary>
        /// 获取成就对应事件类型
        /// </summary>
        /// <param name="AchievementStrategyType">成就策略类型</param>
        /// <returns></returns>
        public Type GetEventType(AchievementStrategyType AchievementStrategyType)
        {
            return _eventTypeDict.GetValueOrDefault(AchievementStrategyType);
        }
    }
}