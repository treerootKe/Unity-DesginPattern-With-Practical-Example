using System.Collections.Generic;
using UnityEngine;

namespace Tools
{
    /// <summary>
    /// unity组件对象池
    /// </summary>
    /// <typeparam name="T">限定参数类型：MonoBehaviour</typeparam>
    public class ObjectPoolMono<T> where T : MonoBehaviour
    {
        private readonly Queue<T> _elementsQueue; //元素存放的队列
        private readonly HashSet<T> _elementsHasDequeued; //已经出队的元素

        private readonly T _initialElement; //初始元素

        private readonly int _capacity; //对象池容量

        public int ElementsCount => _elementsQueue.Count; //属性，元素个数

        /// <summary>
        /// 构造函数
        /// 初始化对象池
        /// 设置初始元素
        /// 设置初始元素个数
        /// </summary>
        /// <param name="element">初始元素</param>
        /// <param name="initialCount">初始元素个数</param>
        /// <param name="capacity">对象池容量</param>
        public ObjectPoolMono(T element, int initialCount, int capacity)
        {
            _elementsQueue = new Queue<T>();
            _elementsHasDequeued = new HashSet<T>();
            _initialElement = element;
            _capacity = Mathf.Max(1, capacity);

            // 预加载，确保初始元素个数不超过对象池容量
            var initialCountValue = Mathf.Min(initialCount, capacity);
            for (int i = 0; i < initialCountValue; i++)
            {
                AddOneElementToPool();
            }
        }

        /// <summary>
        /// 添加一个元素到对象池中
        /// </summary>
        private void AddOneElementToPool()
        {
            var objItem = Object.Instantiate(_initialElement.gameObject);
            var elementItem = objItem.GetComponent<T>();
            _elementsQueue.Enqueue(elementItem);
        }

        /// <summary>
        /// 获取元素的公共行为
        /// </summary>
        /// <returns></returns>
        private T GetElementsCommonBehaviour()
        {
            if (_elementsQueue.Count == 0)
            {
                AddOneElementToPool();
            }

            var oneElement = _elementsQueue.Dequeue();
            while (!oneElement && _elementsQueue.Count > 0)
            {
                oneElement = _elementsQueue.Dequeue();
            }

            if (!oneElement)
            {
                Debug.LogError("An external operation encountered a fatal error, resulting in empty elements appearing in the object pool. Please check the relevant logic code.");
                AddOneElementToPool();
                oneElement = _elementsQueue.Dequeue();
            }

            oneElement.gameObject.SetActive(true);
            return oneElement;
        }

        /// <summary>
        /// 获取一个元素（同时设置父物体）
        /// </summary>
        /// <param name="parent">父物体</param>
        /// <returns></returns>
        public T Get(Transform parent = null)
        {
            var oneElement = GetElementsCommonBehaviour();

            if (parent)
            {
                oneElement.transform.SetParent(parent);
                oneElement.transform.localPosition = Vector3.zero;
                oneElement.transform.localRotation = Quaternion.identity;
                oneElement.transform.localScale = Vector3.one;
            }

            _elementsHasDequeued.Add(oneElement);
            return oneElement;
        }

        /// <summary>
        /// 回收一个元素
        /// </summary>
        /// <param name="element">被回收的元素</param>
        /// <param name="parent">元素的父物体</param>
        public void Recycle(T element, Transform parent = null)
        {
            if (ElementsCount >= _capacity)
            {
                Object.Destroy(element.gameObject);
                return;
            }

            if (parent)
            {
                element.transform.SetParent(parent);
            }

            element.gameObject.SetActive(false);
            _elementsQueue.Enqueue(element);
            _elementsHasDequeued.Remove(element);
        }

        /// <summary>
        /// 回收所有已出队的元素
        /// </summary>
        /// <param name="parent">元素的父物体</param>
        public void RecycleAllHasDequeued(Transform parent = null)
        {
            var elementsToRecycle = new List<T>(_elementsHasDequeued);

            foreach (var element in elementsToRecycle)
            {
                Recycle(element, parent);
            }

            elementsToRecycle.Clear();
        }
    }
}