namespace Behavioral_Patterns.ChainOfResponsibilityMine
{
    public class CharactersInfo
    {
        public float MaxHealthPool = 100f;
        public float CurrentHealth = 100f;
        public float MaxShield = 50f;
        public float CurrentShield = 50f;
        public float Defense = 5f;
        public float DodgeChance = 0.2f;

        public bool IsDead => CurrentHealth <= 0;
    }
}