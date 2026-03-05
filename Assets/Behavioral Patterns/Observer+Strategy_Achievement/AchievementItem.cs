using UnityEngine;
using UnityEngine.UI;

namespace Behavioral_Patterns.Observer_Strategy_Achievement
{
    /// <summary>
    /// 成就实例
    /// </summary>
    public class AchievementItem:MonoBehaviour
    {
        public AchievementConfig AchievementConfig;//成就配置
        
        public Text achievementName;//成就名称
        public Text achievementDescription;//成就描述
        public Text achievementProgress;//成就进度
        
        public Slider achievementSlider;//成就进度条
        

        public void Init(AchievementConfig achievementConfig)
        {
            AchievementConfig = achievementConfig;
            
        }
    }
}