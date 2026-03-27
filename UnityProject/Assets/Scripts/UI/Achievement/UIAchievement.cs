using System.Collections.Generic;
using DataTables;
using GlobalData;
using Tools;
using UnityEngine;
using UnityEngine.Serialization;

namespace UI.Achievement
{
    /// <summary>
    /// 成就管理UI
    /// </summary>
    public class UIAchievement:SingletonMono<UIAchievement>
    {
        public ObjectPoolMono<AchievementCategory> PoolAchievementCategory;//大类对象池
        public AchievementCategory defaultCategory;//大类的初始元素
        public Transform categoryParent;//大类的父物体
        
        public ObjectPoolMono<AchievementParent> PoolAchievementParent;//父类对象池
        public AchievementParent defaultParent;//父类的初始元素
        public Transform parentsParent;//父类的父物体
        
        public ObjectPoolMono<AchievementItem> PoolAchievementItem;//成就对象池
        public AchievementItem defaultItem;//成就的初始元素
        public Transform itemsParent;//成就的父物体
        
        /***********************Luban配置表数据***********************/
        private IReadOnlyDictionary<int, AchievementData> _dicAchievementData;
        /***********************Luban配置表数据***********************/
        
        private void FindComponent()
        {
            defaultCategory = transform.GetComponentInChildren<AchievementCategory>();
            categoryParent = transform.Find("Category Parent");
            defaultParent = transform.GetComponentInChildren<AchievementParent>();
            parentsParent = transform.Find("Parents Parent");
            defaultItem = transform.GetComponentInChildren<AchievementItem>();
            itemsParent = transform.Find("Items Parent");
        }
        
        private void Awake()
        {
            FindComponent();
        }

        private void Start()
        {
            _dicAchievementData = LubanConfigTable.Instance.LubanTables.AchievementTable.DataMap;

            PoolAchievementCategory = new ObjectPoolMono<AchievementCategory>(defaultCategory, 2, 10);
            PoolAchievementParent = new ObjectPoolMono<AchievementParent>(defaultParent, 3, 10);
            PoolAchievementItem = new ObjectPoolMono<AchievementItem>(defaultItem, 5, 50);
            
        }

        /// <summary>
        /// 初始化成就大类
        /// </summary>
        public void InitAchievementCategories()
        {
            foreach (var achievementItem in _dicAchievementData)
            {
                var categoryItem = PoolAchievementCategory.Get(categoryParent);
                categoryItem.InitCategory(achievementItem.Value.Category);
            }
        }
    }
}