namespace WebApiRest.Models
{
    public class Reto
    {
        public Guid IdReto { get; set; }
        public string Nombre { get; set; }
        public DateTime FechaApertura { get; set; }
        public DateTime FechaCierre { get; set; }
        public int Estado { get; set; }
        public int Vidas { get; set; }
        public int Tiempo_ms { get; set; }
        public int PuntosRecompensa { get; set; }
        public int CreditosObtenidos { get; set; }
        public string Instrucciones { get; set; }
        public string Imagen { get; set; }
        public Guid IdTipoReto { get; set; }
        public string TipoReto { get; set; }
        public Guid IdComportamiento { get; set; }
        public string ComportamientoPregunta { get; set; }        
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class RetoItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Reto Reto { get; set; }
    }

    public class RetoList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Reto> Lista { get; set; }
    }

    // TABLA INTERMEDIA
    public class Usuario_Reto
    {
        public Guid IdUsuario { get; set; }
        public Guid IdReto { get; set; }
        public int Puntos { get; set; }
        public int Tiempo { get; set; }
        public int Vidas { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }
}