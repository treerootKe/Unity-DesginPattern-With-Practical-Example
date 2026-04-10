using UnityEngine;

namespace DefaultNamespace
{
    public class TestUIScripts:MonoBehaviour
    {
        public Canvas canvas; 
            
        public Camera cam;

        public Transform target;

        public Transform canvasLeft;
        public Transform canvasRight;
        public Transform canvasTop;
        public Transform canvasBottom;
        
        public float canvasWidth;
        public float canvasHeight;
        
        
        private void OnEnable()
        {

        }

        private void Start()
        {
            canvasWidth = canvasRight.localPosition.x - canvasLeft.localPosition.x;
            canvasHeight = canvasTop.localPosition.y - canvasBottom.localPosition.y;
        }


        private void Update()
        {
            if (Input.GetMouseButtonDown(0))
            {
                var mousePosition = Input.mousePosition;
                Debug.Log("Get Mouse In Screen's Position" + mousePosition);
                var worldPosition = cam.ScreenToWorldPoint(mousePosition);
                Debug.Log("Get Mouse In World's Position" + worldPosition);
                var viewPosition = cam.ScreenToViewportPoint(mousePosition);
                Debug.Log("Get Mouse In View's Position" + viewPosition);
                var uiPos = new Vector2(viewPosition.x * canvasWidth, viewPosition.y * canvasHeight);
                Debug.Log("Get Mouse In UI's Position" + uiPos);
            }
        }
    }
}