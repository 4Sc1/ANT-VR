using UnityEngine;
namespace Assets.Helpers.Scripts
{
    public class LaserPointerInitializer : MonoBehaviour
    {
        public LaserPointer LaserPointer;

        // Start is called before the first frame update
        void Start()
        {
            LaserPointer.laserBeamBehavior = LaserPointer.LaserBeamBehavior.OnWhenHitTarget;
        }
    }
}
