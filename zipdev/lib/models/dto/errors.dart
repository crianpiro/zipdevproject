class Errors {
  static Map<int,dynamic> _errors = {
    400: "Algo salió mal.",
    401: "Algo salió mal.",
    201: "Usuario no autorizado.",
    202: "Usuario o contraseña erroneos.",
    203: "El nombre de usuario ya se encuentra registrado.",
    204: "Ya hay un área registrada con el mismo nombre.",
    205: "Aún no hay áreas registradas.",
    206: "Ya hay una norma registrada con el mismo nombre.",
    207: "Aún no tienes normas personalizadas registradas en tu empresa, agrega una haciendo click en el '+'.",
    208: "Ya hay un empleado registrado con el mismo nombre.",
    209: "Aún no hay empleados registrados.",
    210: "Ya existe un empleado registrado con el mismo numero de telefono.",
    211: "Has llegado al tope de tu cuenta, para poder seguir con las funcionalidades obten premium.",
    212: "No hay más normas por cumplir hoy.",
    213: "El número de telefono ingresado no se encuentra registrado en una organización.",
    220: "Usuario no encontrado"
  };

   String getText(int key){
    var text = _errors.containsKey(key)
    ? _errors[key]
    : _errors[key];

    return text != null ? text : 'Error inesperado';
  }

  String getErrorMessage(int errorCode){
    return getText(errorCode);  
  }

  bool containsError(int errorCode){
    return _errors.containsKey(errorCode);  
  }
}