using UnityEngine;

namespace Behavioral_Patterns.Observer_Strategy_Achievement
{
    public class UIAchievement:MonoBehaviour
    {
        public AchievementManager AchievementManager;

        private void Awake()
        {
            AchievementManager = AchievementManager.Instance;
            AchievementManager.Init();
        }
    }
}