using System.IO;
using DataTables;
using SimpleJSON;
using SingletonPatternExample3;

namespace GlobalData
{
    public class LubanConfigTable:Singleton<LubanConfigTable>
    {
        public Tables LubanTables;

        public LubanConfigTable()
        {
            string gameConfDir = "Assets/DataTablesJson"; // gen.bat中outputDataDir指向的目录
            LubanTables = new DataTables.Tables(jsonFileName => JSON.Parse(File.ReadAllText($"{gameConfDir}/{jsonFileName}.json")));
        }
    }
}