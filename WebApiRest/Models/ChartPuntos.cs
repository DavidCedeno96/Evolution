namespace WebApiRest.Models
{
    public class ChartPuntos
    {
        public int Puntos { get; set; }
        public int Mes { get; set; }
        public int Año { get; set; }
    }

    public class ChartPuntosList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<ChartPuntos> Lista { get; set; }
    }

    public class DatasetPuntos
    {
        public string Label { get; set; }
        public List<int> Data { get; set; }
        public bool Fill { get; set; }
        public string BorderColor { get; set; }
        public double Tension { get; set; }
    }

    public class DatasetPuntosList
    {
        public string Info { get; set; }
        public int Error { get; set; }
        public List<DatasetPuntos> Lista { get; set; }
    }
}
