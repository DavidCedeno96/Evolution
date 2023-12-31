﻿namespace WebApiRest.Models
{
    public class Medalla
    {
        public Guid IdMedalla { get; set; }
        public string Nombre { get; set; }
        public string Descripcion { get; set; }
        public string Imagen { get; set; }
        public int Estado { get; set; }
        public int TotalUsuarios { get; set; }
        public Guid IdCondicion { get; set; }
        public string Condicion { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class MedallaList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Medalla> Lista { get; set; }
    }

    // TABLA INTERMEDIA
    public class Usuario_Medalla
    {
        public Guid IdUsuario { get; set; }        
        public Guid IdMedalla { get; set; }        
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }
}
