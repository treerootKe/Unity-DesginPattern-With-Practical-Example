using System;
using System.Collections.Generic;
using UnityEngine;

namespace Behavioral_Patterns.ChainOfResponsibility_Achievement
{
/// <summary>
    /// 成就管理器 - 单例
    /// </summary>
    public class AchievementManager : MonoBehaviour
    {
        public static AchievementManager Instance { get; private set; }

        [Header("配置")] [SerializeField] private float checkInterval = 5f; // 批量检查间隔（秒）
        [SerializeField] private float distanceCheckThreshold = 100f; // 距离检查阈值（米）

        private PlayerAchievementData _playerData = new PlayerAchievementData();
        private List<AchievementDefinition> _allAchievements = new List<AchievementDefinition>();

        // 事件订阅表：事件类型 -> 关注该事件的成就ID列表
        private Dictionary<Type, List<string>> _eventSubscribers = new Dictionary<Type, List<string>>();

        // 待检查队列（避免每帧检查）
        private HashSet<string> _pendingChecks = new HashSet<string>();
        private float _lastCheckTime;

        // 距离累积缓存（用于批量更新）
        public float _pendingLandDistance = 0f;
        public float _pendingWaterDistance = 0f;

        private void Awake()
        {
            if (Instance == null)
            {
                Instance = this;
                DontDestroyOnLoad(gameObject);
                InitializeAchievements();
            }
            else
            {
                Destroy(gameObject);
            }
        }

        private void Update()
        {
            // 批量检查逻辑
            if (Time.time - _lastCheckTime >= checkInterval && _pendingChecks.Count > 0)
            {
                ProcessPendingChecks();
                _lastCheckTime = Time.time;
            }

            // 距离数据批量提交
            if (_pendingLandDistance >= distanceCheckThreshold)
            {
                _playerData.TotalLandDistance += _pendingLandDistance;
                _pendingLandDistance = 0f;
                RequestCheck<PlayerMoveEvent>();
            }
        }

        /// <summary>
        /// 初始化所有成就定义
        /// </summary>
        private void InitializeAchievements()
        {
            // 定义"陆地行者"系列成就

            // 成就1：陆地行走 1KM
            var land1K = new AchievementDefinition
            {
                Id = "land_walker_1k",
                Name = "初行者",
                Description = "在陆地上累计行走 1 公里",
                HandlerChain = new TerrainDistanceChecker(TerrainType.Land, 1000f),
                RelevantEvents = { typeof(PlayerMoveEvent) }
            };
            RegisterAchievement(land1K);

            // 成就2：陆地行走 10KM
            var land10K = new AchievementDefinition
            {
                Id = "land_walker_10k",
                Name = "旅行者",
                Description = "在陆地上累计行走 10 公里",
                HandlerChain = new TerrainDistanceChecker(TerrainType.Land, 10000f),
                RelevantEvents = { typeof(PlayerMoveEvent) }
            };
            RegisterAchievement(land10K);

            // 成就3：陆地行走 100KM
            var land100K = new AchievementDefinition
            {
                Id = "land_walker_100k",
                Name = "冒险家",
                Description = "在陆地上累计行走 100 公里",
                HandlerChain = new TerrainDistanceChecker(TerrainType.Land, 100000f),
                RelevantEvents = { typeof(PlayerMoveEvent) }
            };
            RegisterAchievement(land100K);

            // 成就4：复合条件 - 等级10 + 陆地行走10KM
            var chain = new LevelHandler(10);
            chain.SetSuccessor(new TerrainDistanceChecker(TerrainType.Land, 10000f));

            var veteran = new AchievementDefinition
            {
                Id = "veteran_walker",
                Name = "老兵行者",
                Description = "达到10级且在陆地上行走10公里",
                HandlerChain = chain,
                RelevantEvents = { typeof(PlayerMoveEvent), typeof(EnemyKilledEvent) }
            };
            RegisterAchievement(veteran);
        }

        private void RegisterAchievement(AchievementDefinition achievement)
        {
            _allAchievements.Add(achievement);

            // 建立事件订阅
            foreach (var eventType in achievement.RelevantEvents)
            {
                if (!_eventSubscribers.ContainsKey(eventType))
                {
                    _eventSubscribers[eventType] = new List<string>();
                }

                _eventSubscribers[eventType].Add(achievement.Id);
            }
        }

        #region 事件处理

        /// <summary>
        /// 由玩家移动脚本调用 - 每帧调用，但只做轻量级记录
        /// </summary>
        public void RecordMovement(Vector3 from, Vector3 to, TerrainType terrain)
        {
            float distance = Vector3.Distance(from, to);

            // 只累积数据，不触发检查
            switch (terrain)
            {
                case TerrainType.Land:
                    _pendingLandDistance += distance;
                    break;
                case TerrainType.Water:
                    _pendingWaterDistance += distance;
                    break;
            }
        }

        /// <summary>
        /// 由击杀系统调用
        /// </summary>
        public void RecordKill(string enemyType)
        {
            _playerData.TotalKillCount++;
            RequestCheck<EnemyKilledEvent>();
        }

        /// <summary>
        /// 请求检查某类事件相关的成就
        /// </summary>
        private void RequestCheck<TEvent>(TEvent specificValue = default)
        {
            if (!_eventSubscribers.TryGetValue(typeof(TEvent), out var achievementIds))
                return;

            foreach (var id in achievementIds)
            {
                // 跳过已解锁的
                if (_playerData.UnlockedAchievements.Contains(id))
                    continue;

                _pendingChecks.Add(id);
            }
        }

        /// <summary>
        /// 批量处理待检查成就
        /// </summary>
        private void ProcessPendingChecks()
        {
            foreach (var achievementId in _pendingChecks)
            {
                var achievement = _allAchievements.Find(a => a.Id == achievementId);
                if (achievement == null) continue;

                var context = new AchievementCheckContext
                {
                    AchievementId = achievement.Id,
                    AchievementName = achievement.Name,
                    PlayerData = _playerData
                };

                achievement.HandlerChain.Handle(context);

                if (context.IsUnlocked)
                {
                    UnlockAchievement(achievement);
                }
            }

            _pendingChecks.Clear();
        }

        private void UnlockAchievement(AchievementDefinition achievement)
        {
            _playerData.UnlockedAchievements.Add(achievement.Id);

            Debug.Log($"<color=yellow>【成就解锁】</color> {achievement.Name} - {achievement.Description}");

            // 这里可以触发UI显示、保存存档等
            OnAchievementUnlocked?.Invoke(achievement);
        }

        public event Action<AchievementDefinition> OnAchievementUnlocked;

        #endregion
    }
}