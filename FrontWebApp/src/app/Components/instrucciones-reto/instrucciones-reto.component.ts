import { Component, Input, OnInit } from '@angular/core';
import { Reto } from 'src/app/Models/Reto';
import { FormatTiempo, GetTypeTime } from 'src/app/Utils/Constants';

@Component({
  selector: 'app-instrucciones-reto',
  templateUrl: './instrucciones-reto.component.html',
  styleUrls: ['./instrucciones-reto.component.css'],
})
export class InstruccionesRetoComponent {
  getTypeTime = GetTypeTime();
  formatTiempo = FormatTiempo();

  @Input() formatTiempo_ms: string = '';

  @Input() reto: Reto = {
    idReto: '',
    nombre: '',
    fechaApertura: new Date(),
    fechaCierre: new Date(),
    vidas: 0,
    tiempo_ms: 0,
    puntosRecompensa: 0,
    creditosObtenidos: 0,
    instrucciones: '',
    criterioMinimo: 0,
    imagen: '',
    idTipoReto: '',
    tipoReto: '',
    idTipoEncuesta: '',
    tipoEncuesta: '',
    idComportamiento: '',
    comportamientoPregunta: '',
    idTipoArchivo: '',
    tipoArchivo: '',
    idTipoValidador: '',
    tipoValidador: '',
    totalPreguntas: 0,
    usuariosAsignados: 0,
    equiposAsignados: 0,
    opsRequeridas: 0,
    validadores: 0,
    puedeValidar: 0,
    enEquipo: 0,
    items: 0,
    estado: 0,
  };
}
