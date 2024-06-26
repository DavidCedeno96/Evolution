﻿namespace WebApiRest.Models
{
    public class Recompensa
    {
        public Guid IdRecompensa { get; set; }
        public string Nombre { get; set; }        
        public string Descripcion { get; set; }
        public string Imagen { get; set; }
        public int CantDisponible { get; set; }
        public int CantCanje { get; set; }
        public int Estado { get; set; }
        public int TotalUsuarios { get; set; }
        public Guid IdCategoria { get; set; }
        public string Categoria { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class RecompensaItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Recompensa Recompensa { get; set; } 
    }

    public class RecompensaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Recompensa> Lista { get; set; }
    }

    // TABLA INTERMEDIA
    public class Usuario_Recompensa
    {
        public Guid IdRecompensa { get; set; }
        public Guid IdUsuario { get; set; }
        public string Nombre { get; set; }
        public string Imagen { get; set; }
        public int TotalUsuarios { get; set; }
    }

    public class Usuario_RecompensalList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Usuario_Recompensa> Lista { get; set; }
    }
}
