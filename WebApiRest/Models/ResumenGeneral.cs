namespace WebApiRest.Models
{
    public class ResumenGeneral
    {
        public int RetosCompletados { get; set; }
        public int MedallasConseguidas { get; set; }
        public int RecomensasReclamadas { get; set; }
    }

    public class ResumenGeneralItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public ResumenGeneral ResumenGeneral { get; set; }
    }
}
