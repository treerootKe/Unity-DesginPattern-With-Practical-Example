using System.Collections.Generic;
using DataTables;
using GlobalData;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace UI.Achievement
{
    /// <summary>
    /// 成就父类，一组成就的父类
    /// </summary>
    public class AchievementParent : MonoBehaviour
    {
        public Toggle toggleThis; //成就父类Toggle（激活后打开一组成就）
        
        public TextMeshProUGUI txtMeshAchievementParentName; //成就父类名称
        public List<AchievementData> AchievementDataList; //成就列表

        private UIAchievement _uiAchievement;//成就UI组件
        
        /***********************Luban配置表数据***********************/
        private IReadOnlyDictionary<int, AchievementData> _dicAchievementData;
        /***********************Luban配置表数据***********************/

        private void FindComponents()
        {
            toggleThis = transform.GetComponent<Toggle>();
            
            txtMeshAchievementParentName = transform.GetComponentInChildren<TextMeshProUGUI>();

        }
        
        private void Awake()
        {
            FindComponents();
            
            toggleThis.onValueChanged.AddListener(OnToggleValueChanged);
        }
        
        private void Start()
        {
            AchievementDataList = new List<AchievementData>();
            _dicAchievementData = LubanConfigTable.Instance.LubanTables.AchievementTable.DataMap;
            
            _uiAchievement = UIAchievement.Instance;
        }
        
        private void OnToggleValueChanged(bool isOn)
        {
            if (isOn)
            {
                foreach (var achievementData in AchievementDataList)
                {
                    var achievementItem = _uiAchievement.PoolAchievementItem.Get(_uiAchievement.itemsParent);
                    achievementItem.Init(achievementData);
                }
            }
        }
        
        /// <summary>
        /// 初始化成就的父类（一个父类对应一组成就）
        /// </summary>
        /// <param name="parentName"></param>
        public void InitAchievementsParent(string parentName)
        {
            txtMeshAchievementParentName.text = parentName;

            foreach (var achievementItem in _dicAchievementData)
            {
                if (achievementItem.Value.Parents == parentName)
                {
                    AchievementDataList.Add(achievementItem.Value);
                }
            }
        }
    }
}