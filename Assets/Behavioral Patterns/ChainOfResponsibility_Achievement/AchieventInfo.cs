using System;
using System.Collections.Generic;
using UnityEngine;

namespace Behavioral_Patterns.ChainOfResponsibility_Achievement
{
    #region 事件系统

    /// <summary>
    /// 游戏事件基类
    /// </summary>
    public class GameEvent
    {
        public float Timestamp { get; } = Time.time;
    }

    /// <summary>
    /// 移动事件 - 玩家每次移动时触发
    /// </summary>
    public class PlayerMoveEvent : GameEvent
    {
        public Vector3 FromPosition { get; set; }
        public Vector3 ToPosition { get; set; }
        public float Distance { get; set; } // 本次移动距离
        public TerrainType Terrain { get; set; } // 地形类型
    }

    public enum TerrainType
    {
        Land, // 陆地
        Water, // 水域
        Air, // 空中
        Desert, // 沙漠
    }

    /// <summary>
    /// 击杀事件
    /// </summary>
    public class EnemyKilledEvent : GameEvent
    {
        public string EnemyType { get; set; }
        public int Count { get; set; } = 1;
    }

    #endregion

    #region 成就数据存储

    /// <summary>
    /// 持久化的玩家统计数据 - 实际游戏中会存档
    /// </summary>
    [Serializable]
    public class PlayerAchievementData
    {
        // 累积数据
        public float TotalLandDistance { get; set; }
        public float TotalWaterDistance { get; set; }
        public int TotalKillCount { get; set; }
        public int CurrentLevel { get; set; }
        public HashSet<string> CompletedQuests { get; set; } = new HashSet<string>();

        // 已解锁成就记录（避免重复解锁）
        public HashSet<string> UnlockedAchievements { get; set; } = new HashSet<string>();
    }

    #endregion

    #region 改进的请求对象

    /// <summary>
    /// 成就检查上下文
    /// </summary>
    public class AchievementCheckContext
    {
        public string AchievementId { get; set; }
        public string AchievementName { get; set; }
        public PlayerAchievementData PlayerData { get; set; }
        public GameEvent TriggerEvent { get; set; } // 触发此次检查的事件

        public bool IsUnlocked { get; set; } = false;
        public string UnlockMessage { get; set; }
    }

    #endregion

    #region 抽象处理者（改进版）

    /// <summary>
    /// 抽象处理者：支持增量检查
    /// </summary>
    public abstract class AchievementHandler
    {
        protected AchievementHandler _successor;

        public void SetSuccessor(AchievementHandler successor)
        {
            _successor = successor;
        }

        /// <summary>
        /// 检查是否满足解锁条件
        /// </summary>
        public abstract bool CheckCondition(AchievementCheckContext context);

        /// <summary>
        /// 处理请求
        /// </summary>
        public void Handle(AchievementCheckContext context)
        {
            if (CheckCondition(context))
            {
                // 当前条件满足，如果没有下家，说明全部条件通过
                if (_successor == null)
                {
                    context.IsUnlocked = true;
                }
                else
                {
                    _successor.Handle(context);
                }
            }
            // 条件不满足，链条中断，不解锁
        }
    }

    #endregion

    #region 具体处理者

    /// <summary>
    /// 地形移动距离检查器
    /// </summary>
    public class TerrainDistanceChecker : AchievementHandler
    {
        private TerrainType _targetTerrain;
        private float _requiredDistance;

        public TerrainDistanceChecker(TerrainType terrain, float requiredDistance)
        {
            _targetTerrain = terrain;
            _requiredDistance = requiredDistance;
        }

        public override bool CheckCondition(AchievementCheckContext context)
        {
            float actualDistance = _targetTerrain switch
            {
                TerrainType.Land => context.PlayerData.TotalLandDistance,
                TerrainType.Water => context.PlayerData.TotalWaterDistance,
                _ => 0f
            };

            bool passed = actualDistance >= _requiredDistance;

#if UNITY_EDITOR
            if (!passed)
            {
                Debug.Log($"[成就检查] {context.AchievementName}: 距离不足 " +
                          $"({_targetTerrain} {actualDistance:F1}/{_requiredDistance}m)");
            }
#endif

            return passed;
        }
    }

    /// <summary>
    /// 等级检查器
    /// </summary>
    public class LevelHandler : AchievementHandler
    {
        private int _requiredLevel;

        public LevelHandler(int requiredLevel)
        {
            _requiredLevel = requiredLevel;
        }

        public override bool CheckCondition(AchievementCheckContext context)
        {
            return context.PlayerData.CurrentLevel >= _requiredLevel;
        }
    }

    /// <summary>
    /// 击杀数检查器
    /// </summary>
    public class KillCountHandler : AchievementHandler
    {
        private int _requiredKills;

        public KillCountHandler(int requiredKills)
        {
            _requiredKills = requiredKills;
        }

        public override bool CheckCondition(AchievementCheckContext context)
        {
            return context.PlayerData.TotalKillCount >= _requiredKills;
        }
    }

    #endregion

    #region 成就定义

    /// <summary>
    /// 成就配置（后续可以通过Luban配置表读取成就数据）
    /// </summary>
    public class AchievementDefinition
    {
        public string Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public AchievementHandler HandlerChain { get; set; } // 该成就的检查链
        public List<Type> RelevantEvents { get; set; } = new List<Type>(); // 关注哪些事件
    }

    #endregion
}