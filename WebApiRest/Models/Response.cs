namespace WebApiRest.Models
{
    public class Response
    {
        public int Error { get; set; }
        public string Info { get; set; }
        public string Id { get; set; }
        public string Campo { get; set; }
    }

    public class ResponseObjects
    {
        public int Error { get; set; }
        public string Info { get; set; }
        public string Id { get; set; }
        public List<object> Lista { get; set; }
    }
}
