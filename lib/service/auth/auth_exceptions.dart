// login exceptions
class UserNotFoundAuthException implements Exception{

}
class WrongPasswordAuthException implements Exception{

}
class InvalidEmailAuthException implements Exception{
  
}

// register exceptions
class WeakPasswordAuthException implements Exception{
  
}
class EmailAlreadyInUseAuthException implements Exception{
  
}

// generic exceptions
class GenericAuthException implements Exception{

}

class UserNotLoggedInAuthException implements Exception{

}