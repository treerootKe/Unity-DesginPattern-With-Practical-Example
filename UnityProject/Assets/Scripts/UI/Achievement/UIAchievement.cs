using System;
using System.Collections;
using System.Collections.Generic;
using DataTables;
using GlobalData;
using Tools;
using UnityEngine;
using UnityEngine.Serialization;
using YooAsset;
using Object = UnityEngine.Object;

namespace UI.Achievement
{
    /// <summary>
    /// 成就管理UI
    /// </summary>
    public class UIAchievement:SingletonMono<UIAchievement>
    {
        public ObjectPoolMono<AchievementCategory> PoolAchievementCategory;//大类对象池
        public AchievementCategory defaultCategory;//大类的初始元素
        public Transform categoryParent;//大类的父物体
        
        public ObjectPoolMono<AchievementParent> PoolAchievementParent;//父类对象池
        public AchievementParent defaultParent;//父类的初始元素
        public Transform parentsParent;//父类的父物体
        
        public ObjectPoolMono<AchievementItem> PoolAchievementItem;//成就对象池
        public AchievementItem defaultItem;//成就的初始元素
        public Transform itemsParent;//成就的父物体
        
        /***********************Luban配置表数据***********************/
        private IReadOnlyDictionary<int, AchievementData> _dicAchievementData;
        /***********************Luban配置表数据***********************/
        
        private void FindComponent()
        {
            defaultCategory = transform.GetComponentInChildren<AchievementCategory>();
            categoryParent = transform.Find("Category Parent");
            defaultParent = transform.GetComponentInChildren<AchievementParent>();
            parentsParent = transform.Find("Parents Parent");
            defaultItem = transform.GetComponentInChildren<AchievementItem>();
            itemsParent = transform.Find("Items Parent");
        }
        
        private void Awake()
        {
            // FindComponent();
            // 初始化资源系统
            YooAssets.Initialize();

// 创建默认的资源包
            // var package = YooAssets.CreatePackage("DefaultPackage");

// 获取指定的资源包，如果没有找到会报错
            // var package = YooAssets.GetPackage("DefaultPackage");

// 获取指定的资源包，如果没有找到不会报错
            var package = YooAssets.TryGetPackage("DefaultPackage");

// 设置该资源包为默认的资源包，可以使用YooAssets相关加载接口加载该资源包内容。
            YooAssets.SetDefaultPackage(package);
            StartCoroutine(InitYooPack(package));
        }

        private IEnumerator InitYooPack(ResourcePackage package)
        {
            var buildResult = EditorSimulateModeHelper.SimulateBuild("DefaultPackage");    
            var packageRoot = buildResult.PackageRootDirectory;
            var fileSystemParams = FileSystemParameters.CreateDefaultEditorFileSystemParameters(packageRoot);
    
            var createParameters = new EditorSimulateModeParameters();
            createParameters.EditorFileSystemParameters = fileSystemParams;
            
            var initOperation = package.InitializeAsync(createParameters);
            yield return initOperation;
    
            if(initOperation.Status == EOperationStatus.Succeed)
                Debug.Log("资源包初始化成功！");
            else 
                Debug.LogError($"资源包初始化失败：{initOperation.Error}");
            
            yield return RequestPackageVersion();
            // yield return UpdatePackageManifest();
            
            var objItem = YooAssets.LoadAssetSync<GameObject>("engines_player");
            var obj = objItem.AssetObject as GameObject;
            var initObj = Object.Instantiate(obj, this.transform, true);
            initObj.transform.localPosition = Vector3.zero;
            initObj.transform.localRotation = Quaternion.identity;
            initObj.transform.localScale = Vector3.one;
        }
        
        private IEnumerator RequestPackageVersion()
        {
            var package = YooAssets.GetPackage("DefaultPackage");
            var operation = package.RequestPackageVersionAsync();
            yield return operation;

            if (operation.Status == EOperationStatus.Succeed)
            {
                //更新成功
                string packageVersion = operation.PackageVersion;
                Debug.Log($"Request package Version : {packageVersion}");
                
                
                var operation1 = package.UpdatePackageManifestAsync(packageVersion);
                yield return operation1;

                if (operation1.Status == EOperationStatus.Succeed)
                {
                    //更新成功
                }
                else
                {
                    //更新失败
                    Debug.LogError(operation.Error);
                }
            }
            else
            {
                //更新失败
                Debug.LogError(operation.Error);
            }
        }
        
        // private IEnumerator UpdatePackageManifest()
        // {
        //
        // }

        private IEnumerator DestroyPackage()
        {
            // 先销毁资源包
            var package = YooAssets.GetPackage("DefaultPackage");
            DestroyOperation operation = package.DestroyAsync();
            yield return operation;
    
            // 然后移除资源包
            if (YooAssets.RemovePackage(package))
            {
                Debug.Log("移除成功！");
            }
        }
        
        private void OnDisable()
        {
            StartCoroutine(DestroyPackage());
        }
        
        private void Start()
        {
            // _dicAchievementData = LubanConfigTable.Instance.LubanTables.AchievementTable.DataMap;
            //
            // PoolAchievementCategory = new ObjectPoolMono<AchievementCategory>(defaultCategory, 2, 10);
            // PoolAchievementParent = new ObjectPoolMono<AchievementParent>(defaultParent, 3, 10);
            // PoolAchievementItem = new ObjectPoolMono<AchievementItem>(defaultItem, 5, 50);
            
        }

        /// <summary>
        /// 初始化成就大类
        /// </summary>
        public void InitAchievementCategories()
        {
            foreach (var achievementItem in _dicAchievementData)
            {
                var categoryItem = PoolAchievementCategory.Get(categoryParent);
                categoryItem.InitCategory(achievementItem.Value.Category);
            }
        }
    }
}