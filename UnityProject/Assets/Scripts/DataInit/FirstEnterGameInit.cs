using GlobalData;
using UnityEngine;

namespace DataInit
{
    /// <summary>
    /// 登陆成功后，进入游戏，数据初始化
    /// </summary>
    public class FirstEnterGameInit:MonoBehaviour
    {
        private void Awake()
        {
            var lubanConfigTable = new LubanConfigTable();
            
            /*测试成就：加载配置表数据*/
            
        }
    }
}