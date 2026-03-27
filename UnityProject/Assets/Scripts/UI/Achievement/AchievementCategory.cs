using System.Collections.Generic;
using DataTables;
using GlobalData;
using TMPro;
using Tools;
using UnityEngine;
using UnityEngine.Serialization;
using UnityEngine.UI;

namespace UI.Achievement
{
    /// <summary>
    /// 成就大类（生涯成就、战斗成就......），一组成就父类对应的大类
    /// </summary>
    public class AchievementCategory : MonoBehaviour
    {
        public Toggle toggleThis; //成就大类Toggle（激活后打开一组成就父类）

        public TextMeshProUGUI txtMeshCategoryName; //成就大类名称
        public List<string> achievementParents; //成就大类下的成就父类列表

        private UIAchievement _uiAchievement;//成就UI组件

        /***********************Luban配置表数据***********************/
        private IReadOnlyDictionary<int, AchievementData> _dicAchievementData;
        /***********************Luban配置表数据***********************/

        private void FindComponents()
        {
            txtMeshCategoryName = transform.GetComponentInChildren<TextMeshProUGUI>();
            toggleThis = transform.GetComponent<Toggle>();
        }

        private void Awake()
        {
            FindComponents();
        }

        private void Start()
        {
            achievementParents = new List<string>();
            _dicAchievementData = LubanConfigTable.Instance.LubanTables.AchievementTable.DataMap;

            _uiAchievement = UIAchievement.Instance;

            toggleThis.onValueChanged.AddListener(OnToggleValueChanged);
        }

        /// <summary>
        /// Toggle值改变，打开一组成就父类
        /// </summary>
        /// <param name="isOn"></param>
        private void OnToggleValueChanged(bool isOn)
        {
            if (isOn)
            {
                foreach (var parentName in achievementParents)
                {
                    var parentItem = _uiAchievement.PoolAchievementParent.Get(_uiAchievement.parentsParent);
                    parentItem.InitAchievementsParent(parentName);
                }
            }
        }


        /// <summary>
        /// 初始化成就大类（一个成绩大类，对应一组成就父类）
        /// </summary>
        /// <param name="categoryName">父类名</param>
        public void InitCategory(string categoryName)
        {
            txtMeshCategoryName.text = categoryName;
            foreach (var achievementItem in _dicAchievementData)
            {
                if (achievementItem.Value.Category == categoryName)
                {
                    achievementParents.Add(achievementItem.Value.Parents);
                }
            }
        }
    }
}