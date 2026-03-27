using UnityEngine;

namespace Tools
{
    /// <summary>
    /// unity组件单例
    /// </summary>
    /// <typeparam name="T"></typeparam>
    public class SingletonMono<T> : MonoBehaviour where T : MonoBehaviour
    {
        public static T Instance { get; private set; }
        private void Awake()
        {
            if (Instance == null)
            {
                Instance = transform.GetComponent<T>();
                DontDestroyOnLoad(gameObject);
            }
            else
            {
                Destroy(gameObject);
            }
        }
    }
}