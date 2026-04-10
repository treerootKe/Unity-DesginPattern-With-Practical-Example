using System.Collections.Generic;
using System.IO;
using DataTables;
using SimpleJSON;
using UnityEngine;
using UnityEngine.Serialization;

namespace Behavioral_Patterns.Observer_Strategy_Achievement
{
    public class UIAchievement : MonoBehaviour
    {
        private void Awake()
        {
            string gameConfDir = "Assets/DataTablesJson"; // gen.bat中outputDataDir指向的目录
            var tables = new DataTables.Tables(jsonFileName => JSON.Parse(File.ReadAllText($"{gameConfDir}/{jsonFileName}.json")));
            var testDemo = tables.AchievementTable.DataMap[1];
        }
    }
}