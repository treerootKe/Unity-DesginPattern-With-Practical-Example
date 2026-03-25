using System.Collections.Generic;
using UnityEngine;

namespace Tools
{
    /// <summary>
    /// unity组件对象池
    /// </summary>
    /// <typeparam name="T">限定参数类型：MonoBehaviour</typeparam>
    public class ObjectPool<T> where T : MonoBehaviour
    {
        private readonly Queue<T> _elementsQueue;//元素存放的队列
        private readonly List<T> _elementsHasDequeued;//已经出队的元素
        
        private readonly T _initialElement;//初始元素
        
        public int ElementsCount => _elementsQueue.Count;

        public ObjectPool(T element)
        {
            _elementsQueue = new Queue<T>();
            _elementsHasDequeued = new List<T>();
            _initialElement = element;
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
                Debug.LogError("Object pool has a fatal error. Please check the relevant logic code");
                AddOneElementToPool();
                oneElement = _elementsQueue.Dequeue();
            }
            
            oneElement.gameObject.SetActive(true);
            return oneElement;
        }

        /// <summary>
        /// 获取一个元素
        /// </summary>
        /// <returns></returns>
        public T Get()
        {
            var oneElement = GetElementsCommonBehaviour();
            

            _elementsHasDequeued.Add(oneElement);
            return oneElement;
        }
        
        /// <summary>
        /// 获取一个元素（设置父物体）
        /// </summary>
        /// <param name="parent">父物体</param>
        /// <returns></returns>
        public T Get(Transform parent)
        {
            var oneElement = GetElementsCommonBehaviour();
            
            oneElement.transform.SetParent(parent);
            oneElement.transform.localScale = Vector3.one;
            oneElement.transform.localPosition = Vector3.zero;
            _elementsHasDequeued.Add(oneElement);
            return oneElement;
        }

        /// <summary>
        /// 回收一个元素
        /// </summary>
        /// <param name="element">被回收的元素</param>
        /// <param name="parent">元素的父物体</param>
        public void Recycle(T element,Transform parent = null)
        {
            if (parent != null)
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
            foreach (var element in _elementsHasDequeued)
            {
                Recycle(element, parent);
            }
            _elementsHasDequeued.Clear();
        }
    }
}