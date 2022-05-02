class Paciente {
  String? tipoDocumento;
  String? documento;
  String? nombre;
  String? fechaNacimiento;
  String? sexo;
  String? telefono;
  String? pais;
  String? departamento;
  String? nacionalidad;
  String? estadoCivil;
  String? nivelEducativo;
  String? cursado;
  String? situacionLaboral;

  Paciente(var listadatos) {
    tipoDocumento = listadatos['tipoDocumento'];
    documento = listadatos['documento'];
    nombre = listadatos['nombre'];
    fechaNacimiento = listadatos['fechaNacimiento'];
    sexo = listadatos['sexo'];
    telefono = listadatos['telefono'];
    pais = listadatos['pais'];
    departamento = listadatos['departamento'];
    nacionalidad = listadatos['nacionalidad'];
    estadoCivil = listadatos['estadoCivil'];
    nivelEducativo = listadatos['nivelEducativo'];
    cursado = listadatos['cursado'];
    situacionLaboral = listadatos['situacionLaboral'];
  }
}
