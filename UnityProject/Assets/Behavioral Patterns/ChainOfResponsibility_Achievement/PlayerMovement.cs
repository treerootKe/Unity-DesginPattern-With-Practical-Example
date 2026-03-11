using UnityEngine;

namespace Behavioral_Patterns.ChainOfResponsibility_Achievement
{
    #region 玩家移动脚本（示例）

    /// <summary>
    /// 挂载在玩家身上的移动脚本
    /// </summary>
    public class PlayerMovement : MonoBehaviour
    {
        private Vector3 _lastPosition;
        private TerrainType _currentTerrain = TerrainType.Land;

        private void Start()
        {
            _lastPosition = transform.position;
        }

        private void Update()
        {
            Vector3 currentPos = transform.position;

            // 检测地形（简化示例）
            _currentTerrain = DetectTerrain(currentPos);

            // 记录移动（轻量级，不触发检查）
            if (currentPos != _lastPosition)
            {
                // AchievementManager.Instance?.RecordMovement(_lastPosition, currentPos, _currentTerrain);
                _lastPosition = currentPos;
            }
        }

        private TerrainType DetectTerrain(Vector3 position)
        {
            // 实际游戏中根据地形系统判断
            // 这里简化为根据高度判断
            if (position.y < 0) return TerrainType.Water;
            return TerrainType.Land;
        }
    }

    #endregion
}