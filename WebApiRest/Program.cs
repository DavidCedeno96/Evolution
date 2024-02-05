using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;
using WebApiRest.Utilities;

var builder = WebApplication.CreateBuilder(args);

var settings = builder.Configuration.GetSection("settings").Get<Settings>();

//CORS
var misReglasCors = "ReglasCors";
builder.Services.AddCors(p => p.AddPolicy(misReglasCors, build => {
    build.WithOrigins(settings.Origin.Split(','))
    .AllowAnyHeader()
    .WithMethods("GET","POST", "PUT", "DELETE");
    //.AllowAnyMethod();
}));

//JWT
var keyBytes = Encoding.UTF8.GetBytes(settings.SecretKey);
builder.Services.AddAuthentication(config =>
{
    config.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    config.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
}).AddJwtBearer(config =>
{
    config.RequireHttpsMetadata = settings.HttpsClient; // es para https
    config.SaveToken = false;
    config.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuerSigningKey = true,
        IssuerSigningKey = new SymmetricSecurityKey(keyBytes),
        ValidateIssuer = false,
        ValidateAudience = false
    };
});

// Add services to the container.
builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

//Este es para acceder al index.html de wwwroot
app.UseDefaultFiles();

//ARCHIVOS  |  Crear una nueva carpeta llamada wwwroot Guardar una nueva imagen default.png => propiedades => Copiar en el directorio de salida => Copiar siempre
app.UseStaticFiles();

//CORS
app.UseCors(misReglasCors);

//JWT
app.UseAuthentication();

app.UseAuthorization();

app.MapControllers();

app.Run();
