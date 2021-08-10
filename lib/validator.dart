import 'package:form_field_validator/form_field_validator.dart';

final kPasswordValidator = MultiValidator([
  RequiredValidator(errorText: 'password is required'),
  MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
  PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character')
]);

final kRequiredValidator = RequiredValidator(errorText: 'this field is required');
final kEmailValidator = MultiValidator([
  EmailValidator(errorText: 'enter a valid email address'),
  RequiredValidator(errorText: 'email is required'),
]);