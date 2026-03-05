using UnityEngine;

namespace Behavioral_Patterns.Observer_Strategy_Achievement
{
    public class PlayerController:MonoBehaviour
    {
        public Vector3 lastMovePosition;// 上一个位置

        private void Update()
        {
            var currentPosition = transform.position;

            // 移动距离统计，注意，此处需要向服务器进行同步，让服务器记录总移动距离
            if (currentPosition != lastMovePosition)
            {
                // PlayerAchievementData.MoveDistance += Vector3.Distance(lastMovePosition, currentPosition);
                lastMovePosition = currentPosition;
            }
        }
    }
}