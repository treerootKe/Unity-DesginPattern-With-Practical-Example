using DataTables;
using TMPro;
using UnityEngine;
using UnityEngine.UIElements;

namespace UI.Achievement
{
    /// <summary>
    /// 单个成就
    /// </summary>
    public class AchievementItem:MonoBehaviour
    {
        public TextMeshProUGUI achievementName; //成就名称
        public TextMeshProUGUI achievementDescription; //成就描述
        public TextMeshProUGUI achievementProgress; //成就进度

        public Slider AchievementSlider; //成就进度条


        /// <summary>
        /// 单个成就初始化
        /// </summary>
        /// <param name="achievementData"></param>
        public void Init(AchievementData achievementData)
        {
            
        }
    }
}