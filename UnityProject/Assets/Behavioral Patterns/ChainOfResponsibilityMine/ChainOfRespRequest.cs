using UnityEngine;

namespace Behavioral_Patterns.ChainOfResponsibilityMine
{
    public class ChainOfRespRequest:MonoBehaviour
    {
        private AbstractDamageHandler _dodgeHandler;
        private AbstractDamageHandler _shieldHandler;
        private AbstractDamageHandler _defenseHandler;
        private AbstractDamageHandler _healthPoolHandler;
        private AbstractDamageHandler _damageReboundHandler;
        public void OnEnable()
        {
            _dodgeHandler = new DodgeHandler();
            _shieldHandler = new ShieldHandler();
            _defenseHandler = new DefenseHandler();
            _healthPoolHandler = new HealthPoolHandler();
            _damageReboundHandler = new DamageReboundHandler();
            _dodgeHandler.SetSuccessor(_shieldHandler);
            _shieldHandler.SetSuccessor(_defenseHandler);
            _defenseHandler.SetSuccessor(_healthPoolHandler);
            _healthPoolHandler.SetSuccessor(_damageReboundHandler);
            
            _dodgeHandler.HandleDamage(new DamageInfo(100, new CharactersInfo(), new GameObject()));
        }
    }
}