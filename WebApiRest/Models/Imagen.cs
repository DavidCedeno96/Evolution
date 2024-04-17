namespace WebApiRest.Models
{
    public class Imagen
    {
        public IFormFile Img { get; set; }
        public int WidthMax { get; set; }
        public int HeightMax { get; set; }
    }
}
