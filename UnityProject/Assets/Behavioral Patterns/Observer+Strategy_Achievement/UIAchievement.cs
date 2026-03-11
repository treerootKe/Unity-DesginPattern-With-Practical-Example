using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Serialization;

namespace Behavioral_Patterns.Observer_Strategy_Achievement
{
    public class UIAchievement : MonoBehaviour
    {
        public List<string> achievementCategories = new List<string>()
        {
            "生涯成就", "战斗成就", "地区成就"
        }; //成就所有大类
        
        public List<string> lifeAchievementsParent = new List<string>()
        {
            "坚持不懈", "盆满钵满", "社交大咖"
        };
        public List<string> battleAchievementsParent = new List<string>()
        {
            "Boss达人", "登峰造极"
        };
        public List<string> regionAchievementsParent = new List<string>()
        {
            "格兰达·南部地区", "格兰达·北部地区"
        };
        
        public Dictionary<string, List<string>> CategoryWithAchievementsParent; //成就分类与成就父级名称列表
        public Dictionary<string, List<AchievementConfig>> AchievementsParentAndAchievements; //成就父级名称与具体成就列表
        public AchievementManager AchievementManager;

        private void Awake()
        {
            AchievementManager = AchievementManager.Instance;
            AchievementManager.Init();
        }
    }
}