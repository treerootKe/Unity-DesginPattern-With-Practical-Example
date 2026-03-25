using System.Collections.Generic;
using Behavioral_Patterns.Observer_Strategy_Achievement;
using DataTables;
using GlobalData;
using UnityEngine;

namespace DataInit
{
    /// <summary>
    /// 登陆成功后，进入游戏，数据初始化
    /// </summary>
    public class FirstEnterGameInit : MonoBehaviour
    {
        public IReadOnlyDictionary<int, AchievementData> achievementDatas;
        public Dictionary<int, AchievementConfig> achievementConfigs;

        private void Awake()
        {
            var lubanConfigTable = new LubanConfigTable();

            /*测试成就：加载配置表数据*/
            achievementDatas = lubanConfigTable.LubanTables.AchievementTable.DataMap;
        }

        private void OnEnable()
        {
            foreach (var achievementItem in achievementDatas)
            {
            }
        }
    }
}