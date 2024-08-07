﻿namespace WebApiRest.Models
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
        public int CriterioMinimo { get; set; }
        public string Imagen { get; set; }
        public Guid IdTipoReto { get; set; }
        public string TipoReto { get; set; }
        public Guid IdTipoEncuesta { get; set; }
        public string TipoEncuesta { get; set; }
        public Guid IdComportamiento { get; set; }
        public string ComportamientoPregunta { get; set; }
        public string TipoArchivo { get; set; }
        public Guid IdTipoArchivo { get; set; }
        public string Extension { get; set; }
        public string TipoValidador { get; set; }
        public Guid IdTipoValidador { get; set; }        
        public int OpsRequeridas { get; set; }
        public int TotalPreguntas { get; set; }
        public int UsuariosAsignados { get; set; }
        public int EquiposAsignados { get; set; }
        public int Validadores { get; set; }
        public int PuedeValidar { get; set; }
        public int EnEquipo { get; set; }
        public int Items { get; set; }             
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class RetoItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Usuario_RetoList UserValidadorLista { get; set; }
        public Reto Reto { get; set; }
    }

    public class RetoList
    {
        public string Info { get; set; }
        public int Error { get; set; }        
        public List<Reto> Lista { get; set; }
    }


    //Equipos
    public class Equipo_Reto
    {
        public Equipo Equipo { get; set; }
        public Reto Reto { get; set; }
        public int TotalUsuarios { get; set; }
    }

    public class Equipo_RetoList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Equipo_Reto> Lista { get; set; }
    }


    // TABLA INTERMEDIA
    public class Usuario_Reto
    {
        public Usuario Usuario { get; set; }
        public Reto Reto { get; set; }
        public int Puntos { get; set; }
        public int Tiempo { get; set; }
        public int Vidas { get; set; }
        public int Posicion { get; set; }
        public int TotalRetos { get; set; }
        public int Completado { get; set; }
        public int TieneEquipo { get; set; }
        public int Validador { get; set; }
        public int TotalOpsValidador { get; set; }
        public int TotalOpsValidaciones { get; set; }
        public int Correctas { get; set; }
        public int Incorrectas { get; set; }
        public List<UsuarioxArchivo> Archivos { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }        
    }    

    public class Usuario_RetoList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<Usuario_Reto> Lista { get; set; }
    }

    public class Usuario_RetoItem
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public Usuario_Reto Ur { get; set; }
    }

    public class UsuarioxArchivo
    {
        public Guid IdReto { get; set; }
        public Guid IdUsuario { get; set; }
        public string Archivo { get; set; }
        public string Url { get; set; }
        public DateTime FechaCreacion { get; set; }
        public DateTime FechaModificacion { get; set; }
    }

    public class UsuarioxArchivoList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public byte[] File { get; set; }
        public List<UsuarioxArchivo> Lista { get; set; }
    }
}