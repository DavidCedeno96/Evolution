import { Links } from '../Models/Links';
import { ConfigInicio } from '../Models/Configuracion';
import { Opcion } from '../Models/Pregunta';

/* WIDGETS DEL INICIO */
export const ConfigInicioList: ConfigInicio[] = [
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Resumen general',
    indice: 0,
    estado: 0,
    idRol: 'adm',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Resumen general',
    indice: 0,
    estado: 0,
    idRol: 'jug',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Nivel de Experiencia',
    indice: 0,
    estado: 0,
    idRol: 'jug',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Usuarios más activos',
    indice: 0,
    estado: 0,
    idRol: 'adm',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Usuarios más activos',
    indice: 0,
    estado: 0,
    idRol: 'jug',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Noticias',
    indice: 0,
    estado: 0,
    idRol: 'jug',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Noticias',
    indice: 0,
    estado: 0,
    idRol: 'adm',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Mis medallas',
    indice: 0,
    estado: 0,
    idRol: 'jug',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Retos completados',
    indice: 0,
    estado: 0,
    idRol: 'jug',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Puntos de experiencia',
    indice: 0,
    estado: 0,
    idRol: 'adm',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Mi evolución',
    indice: 0,
    estado: 0,
    idRol: 'jug',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Recompensas más reclamadas',
    indice: 0,
    estado: 0,
    idRol: 'adm',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Mis retos pendientes',
    indice: 0,
    estado: 0,
    idRol: 'jug',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Ranking por puntos',
    indice: 0,
    estado: 0,
    idRol: 'adm',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Ranking por puntos',
    indice: 0,
    estado: 0,
    idRol: 'jug',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Ranking por equipos',
    indice: 0,
    estado: 0,
    idRol: 'adm',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Ranking por equipos',
    indice: 0,
    estado: 0,
    idRol: 'jug',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Retos por calificar',
    indice: 0,
    estado: 0,
    idRol: 'adm',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Retos por calificar',
    indice: 0,
    estado: 0,
    idRol: 'jug',
    color: '',
  },
  {
    idConfigInicio: '7c8c2672-2233-486a-a184-f0b51eb4a331',
    nombre: 'Uso del plan',
    indice: 0,
    estado: 0,
    idRol: 'adm',
    color: '',
  },
];

/* RUTA DE NAVEGACIÓN (Migaja de pan) */
export const GetBreadcrumb = () => {
  return (url: string, idRol: string): Links[] => {
    let lista: Links[] = [];
    let auxUrl: string = url.split('?')[0];
    let auxUrlType: string = url.split('?')[1] || 'N/A';

    switch (auxUrl) {
      case '/profile-user': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/profile-user',
            nombre: 'Perfil de usuario',
            estado: 1,
          },
        ];

        break;
      }

      case '/profile-user/edit': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/profile-user',
            nombre: 'Perfil de usuario',
            estado: 1,
          },
          {
            url: '/profile-user/edit',
            nombre: 'Editar',
            estado: 0,
          },
        ];

        break;
      }

      case '/ranking-teams':
      case '/ranking-users': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/home',
            nombre: 'Ranking',
            estado: -1,
          },
        ];
        break;
      }

      case '/view-equipo': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-equipo',
            nombre: 'Equipos',
            estado: 0,
          },
        ];
        break;
      }

      case '/upsert-equipo': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-equipo',
            nombre: 'Equipos',
            estado: 1,
          },
        ];
        break;
      }

      case '/asig-user-equipo': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-equipo',
            nombre: 'Equipos',
            estado: 1,
          },
          {
            url: '/asig-user-equipo',
            nombre: 'Asignar usuario',
            estado: 0,
          },
        ];
        break;
      }

      case '/mass-actions-asig-user-equipo': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-equipo',
            nombre: 'Equipos',
            estado: 1,
          },
          {
            url: '/asig-user-equipo',
            nombre: 'Asignar usuario',
            estado: 0,
          },
          {
            url: '/mass-actions-asig-user-equipo',
            nombre: 'Acciones masivas',
            estado: 0,
          },
        ];
        break;
      }

      case '/upsert-user':
      case '/view-user': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-user',
            nombre: 'Usuarios',
            estado: 1,
          },
        ];
        break;
      }

      case '/mass-actions-user': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-user',
            nombre: 'Usuarios',
            estado: 1,
          },
          {
            url: '/mass-actions-user',
            nombre: 'Acciones masivas',
            estado: 1,
          },
        ];
        break;
      }

      case '/user-reto': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/user-reto',
            nombre: 'Retos',
            estado: 1,
          },
        ];
        break;
      }

      case '/validaciones': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/user-reto',
            nombre: 'Retos',
            estado: 1,
          },
          {
            url: '/validaciones',
            nombre: 'Verificar reto',
            estado: 1,
          },
        ];
        break;
      }

      case '/validaciones/users': {
        if (idRol === 'jug') {
          lista = [
            {
              url: '/home',
              nombre: 'Inicio',
              estado: 1,
            },
            {
              url: '/user-reto',
              nombre: 'Retos',
              estado: 1,
            },
            {
              url: '/validaciones',
              nombre: 'Verificar reto',
              estado: 1,
            },
            {
              url: '/validaciones/users',
              nombre: 'Usuarios',
              estado: 0,
            },
          ];
        } else if (idRol === 'adm' || idRol === 'sadm') {
          lista = [
            {
              url: '/home',
              nombre: 'Inicio',
              estado: 1,
            },
            {
              url: '/view-reto',
              nombre: 'Retos',
              estado: 1,
            },
            {
              url: '/validaciones/users',
              nombre: 'Usuarios',
              estado: 0,
            },
          ];
        }
        break;
      }

      case '/fin-reto': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/user-reto',
            nombre: 'Retos',
            estado: 1,
          },
          {
            url: '/fin-reto',
            nombre: 'Reto Finalizado',
            estado: 0,
          },
        ];
        break;
      }

      case '/entrada-reto': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/user-reto',
            nombre: 'Retos',
            estado: 1,
          },
          {
            url: '/entrada-reto',
            nombre: 'Comenzar Reto',
            estado: 0,
          },
        ];
        break;
      }

      case '/upsert-reto':
      case '/view-reto': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-reto',
            nombre: 'Retos',
            estado: 1,
          },
        ];
        break;
      }

      case '/asig-user-reto': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-reto',
            nombre: 'Retos',
            estado: 1,
          },
          {
            url: '/asig-user-reto',
            nombre: 'Asignar usuario',
            estado: 0,
          },
        ];
        break;
      }

      case '/asig-equipo-reto': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-reto',
            nombre: 'Retos',
            estado: 1,
          },
          {
            url: '/asig-equipo-reto',
            nombre: 'Asignar equipo',
            estado: 0,
          },
        ];
        break;
      }

      case '/mass-actions-asig-user-reto': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-reto',
            nombre: 'Retos',
            estado: 1,
          },
          {
            url: '/asig-user-reto',
            nombre: 'Asignar usuario',
            estado: 0,
          },
          {
            url: '/mass-actions-asig-user-reto',
            nombre: 'Acciones masivas',
            estado: 0,
          },
        ];
        break;
      }

      case '/upsert-pregunta/trivia':
      case '/upsert-pregunta/encuesta/voto':
      case '/upsert-pregunta/encuesta/satisfaccion':
      case '/upsert-pregunta/seguimiento-evaluacion':
      case '/view-pregunta': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-reto',
            nombre: 'Retos',
            estado: 1,
          },
          {
            url: '/view-pregunta',
            nombre: 'Preguntas',
            estado: 0,
          },
        ];
        break;
      }

      case '/results': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-reto',
            nombre: 'Retos',
            estado: 1,
          },
          {
            url: '/view-pregunta',
            nombre: 'Preguntas',
            estado: 0,
          },
          {
            url: '/results',
            nombre: 'Resultados',
            estado: 0,
          },
        ];
        break;
      }

      case '/user-noticia': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/user-noticia',
            nombre: 'Noticias',
            estado: 1,
          },
        ];
        break;
      }

      case '/upsert-noticia':
      case '/view-noticia': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-noticia',
            nombre: 'Noticias',
            estado: 1,
          },
        ];
        break;
      }

      case '/upsert-categoria-noticia':
      case '/view-categoria-noticia': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-noticia',
            nombre: 'Noticias',
            estado: 1,
          },
          {
            url: '/view-categoria-noticia',
            nombre: 'Categoría',
            estado: 1,
          },
        ];
        break;
      }

      case '/user-recompensa': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/user-recompensa',
            nombre: 'Recompensas',
            estado: 1,
          },
        ];
        break;
      }

      case '/upsert-recompensa':
      case '/view-recompensa': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-recompensa',
            nombre: 'Recompensas',
            estado: 1,
          },
        ];
        break;
      }

      case '/upsert-categoria-recompensa':
      case '/view-categoria-recompensa': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-recompensa',
            nombre: 'Recompensas',
            estado: 1,
          },
          {
            url: '/view-categoria-recompensa',
            nombre: 'Categoría',
            estado: 1,
          },
        ];
        break;
      }

      case '/user-nivel': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/user-nivel',
            nombre: 'Niveles',
            estado: 1,
          },
        ];
        break;
      }

      case '/upsert-nivel':
      case '/view-nivel': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-nivel',
            nombre: 'Niveles',
            estado: 1,
          },
        ];
        break;
      }

      case '/user-medalla': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/user-medalla',
            nombre: 'Medallas',
            estado: 1,
          },
        ];
        break;
      }

      case '/upsert-medalla':
      case '/view-medalla': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/view-medalla',
            nombre: 'Medallas',
            estado: 1,
          },
        ];
        break;
      }

      case '/red-social': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/red-social',
            nombre: 'Red Social',
            estado: 1,
          },
        ];
        break;
      }

      case '/red-social-perfil': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/red-social',
            nombre: 'Red Social',
            estado: 1,
          },
          {
            url: '/red-social-perfil',
            nombre: 'Perfil',
            estado: 1,
          },
        ];
        break;
      }

      case '/red-user': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/red-social',
            nombre: 'Red Social',
            estado: 1,
          },
          {
            url: '/red-user',
            nombre: 'Perfil',
            estado: 0,
          },
        ];
        break;
      }

      case '/config': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/config',
            nombre: 'Configuración',
            estado: 1,
          },
        ];
        break;
      }

      case '/config/inicio': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/config/inicio',
            nombre: 'Configuración',
            estado: -1,
          },
          {
            url: '/config/inicio',
            nombre: 'Widgets',
            estado: 1,
          },
        ];
        break;
      }

      case '/config/notification': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/config/inicio',
            nombre: 'Configuración',
            estado: -1,
          },
          {
            url: '/config/notification',
            nombre: 'Notificaciones',
            estado: 1,
          },
        ];
        break;
      }

      case '/config/upsert-notificacion': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/config/inicio',
            nombre: 'Configuración',
            estado: -1,
          },
          {
            url: '/config/notification',
            nombre: 'Notificaciones',
            estado: 1,
          },
          {
            url: '/config/upsert-notificacion',
            nombre: 'Editar',
            estado: 0,
          },
        ];
        break;
      }

      case '/config/marca': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/config/inicio',
            nombre: 'Configuración',
            estado: -1,
          },
          {
            url: '/config/marca',
            nombre: 'Marca',
            estado: 1,
          },
        ];
        break;
      }

      case '/config/campos': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/config/inicio',
            nombre: 'Configuración',
            estado: -1,
          },
          {
            url: '/config/campos',
            nombre: 'Campos Personalizados',
            estado: 1,
          },
        ];
        break;
      }

      case '/config/registro': {
        lista = [
          {
            url: '/home',
            nombre: 'Inicio',
            estado: 1,
          },
          {
            url: '/config/inicio',
            nombre: 'Configuración',
            estado: -1,
          },
          {
            url: '/config/registro',
            nombre: 'Registro',
            estado: 1,
          },
        ];
        break;
      }
    }

    if (auxUrlType.includes('crear')) {
      lista.push({ url: '/home', nombre: 'Crear', estado: -1 });
    } else if (auxUrlType.includes('editar')) {
      lista.push({ url: '/home', nombre: 'Editar', estado: -1 });
    }

    return lista;
  };
};

/* BOTONES DE NAVEGACIÓN PILLS */
export const GetNavItemPills = () => {
  return (url: string): Links[] => {
    let lista: Links[] = [];
    let auxUrl: string = url.split('?')[0];

    switch (auxUrl) {
      case '/config/registro':
      case '/config/campos':
      case '/config/marca':
      case '/config/upsert-notificacion':
      case '/config/notification':
      case '/config/inicio': {
        lista = [
          {
            url: '/config/inicio',
            nombre: 'Widgets',
            estado: 1,
          },
          {
            url: '/config/marca',
            nombre: 'Marca',
            estado: 1,
          },
          {
            url: '/config/campos',
            nombre: 'Campos Personalizados',
            estado: 1,
          },
          {
            url: '/config/registro',
            nombre: 'Registro',
            estado: 1,
          },
          {
            url: '/config/notification',
            nombre: 'Notificaciones',
            estado: 1,
          },
        ];
        break;
      }

      case '/validaciones':
      case '/user-reto': {
        lista = [
          {
            url: '/user-reto',
            nombre: 'Mis Retos',
            estado: 1,
          },
          {
            url: '/validaciones',
            nombre: 'Retos por verificar',
            estado: 1,
          },
        ];
        break;
      }
    }

    return lista;
  };
};

/* OPCIONES DEL RETO DE TIPO ENCUESTA SATISFACCION */
export const OptionsList: Opcion[] = [
  {
    idOpcion: '',
    idPregunta: '',
    idTipoEntrada: '',
    tipoEntrada: '',
    nombre: 'Totalmente en desacuerdo',
    correcta: 0,
    cantVotos: 0,
    valor: 1,
  },
  {
    idOpcion: '',
    idPregunta: '',
    idTipoEntrada: '',
    tipoEntrada: '',
    nombre: 'En desacuerdo',
    correcta: 0,
    cantVotos: 0,
    valor: 2,
  },
  {
    idOpcion: '',
    idPregunta: '',
    idTipoEntrada: '',
    tipoEntrada: '',
    nombre: 'Neutral',
    correcta: 0,
    cantVotos: 0,
    valor: 3,
  },
  {
    idOpcion: '',
    idPregunta: '',
    idTipoEntrada: '',
    tipoEntrada: '',
    nombre: 'De acuerdo',
    correcta: 0,
    cantVotos: 0,
    valor: 4,
  },
  {
    idOpcion: '',
    idPregunta: '',
    idTipoEntrada: '',
    tipoEntrada: '',
    nombre: 'Totalmente de acuerdo',
    correcta: 0,
    cantVotos: 0,
    valor: 5,
  },
];
