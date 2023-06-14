import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'expiry_date_validator.dart';
import 'luhn_check.dart';
import 'format_extensions.dart';

// VALIDATORS
RequiredValidator isRequired(String error) {
  return RequiredValidator(errorText: error);
}

MultiValidator passwordCheck({required String passwordToCheck}) {
  return MultiValidator(<TextFieldValidator>[
    RequiredValidator(errorText: 'Passwords must match'),
    PasswordMatch(toCheck: passwordToCheck, errorText: 'Passwords must match')
  ]);
}

MultiValidator noAction() {
  return MultiValidator(<TextFieldValidator>[
    MinLengthValidator(0, errorText: ''),
  ]);
}

MultiValidator justNumberAndLength({required String error, required int lenth}) {
  return MultiValidator(<TextFieldValidator>[
    RequiredValidator(errorText: error),
    MinLengthValidator(lenth, errorText: error),
    PatternValidator('[0-9]', errorText: error),
  ]);
}

MultiValidator requiredAndLength({required String error, required int length}) {
  return MultiValidator(<TextFieldValidator>[
    RequiredValidator(errorText: error),
    MinLengthValidator(length, errorText: error),
  ]);
}

MultiValidator debitCardValidation({required String error, required int length}) {
  return MultiValidator(<TextFieldValidator>[
    PatternValidator('4[0-9]{3}[ ][0-9]{4}[ ][0-9]{4}[0-9]{4}', errorText: error),
    RequiredValidator(errorText: error),
    LunhCheckValidator(errorText: error),
    MinLengthValidator(length, errorText: error),
  ]);
}

MultiValidator expiryDateValidation({required String error}) {
  return MultiValidator(<TextFieldValidator>[
    RequiredValidator(errorText: error),
    ExpiryDateValidator(errorText: error),
  ]);
}

MultiValidator cvvValidation({required String error, required int length}) {
  return MultiValidator(<TextFieldValidator>[
    LengthRangeValidator(
      min: 3,
      max: 3,
      errorText: error,
    ),
    RequiredValidator(errorText: error),
    MinLengthValidator(length, errorText: error),
    PatternValidator('[0-9]', errorText: error),
  ]);
}

MultiValidator get firstNameValidator => MultiValidator(<TextFieldValidator>[
      RequiredValidator(errorText: 'First name is required'),
      MinLengthValidator(2, errorText: 'First name must be at least 2 characters long'),
    ]);

MultiValidator get lastNameValidator => MultiValidator(<TextFieldValidator>[
      RequiredValidator(errorText: 'Last name is required'),
      MinLengthValidator(2, errorText: 'Last name must be at least 2 characters long'),
    ]);
MultiValidator get billReferenceValidator => MultiValidator(<TextFieldValidator>[
      RequiredValidator(errorText: 'Bill Reference is Required'),
      MinLengthValidator(5, errorText: 'Bill reference must be at least 5 characters long'),
    ]);
MultiValidator get oneTimeCodeValidator => MultiValidator(<TextFieldValidator>[
      PatternValidator('[0-9])', errorText: 'Code is 6 numeric digits'),
    ]);
MultiValidator get emailValidator => MultiValidator(<TextFieldValidator>[
      RequiredValidator(errorText: 'Email is required'),
      EmailValidator(errorText: 'Enter a valid email address'),
    ]);

MultiValidator get mobileNumberValidator => MultiValidator(<TextFieldValidator>[
      LengthRangeValidator(
        min: 6,
        max: 6,
        errorText: 'Please enter a valid one time code',
      ),
    ]);
MultiValidator get mobileValidator => MultiValidator(<TextFieldValidator>[
      LengthRangeValidator(
        min: 6,
        max: 16,
        errorText: '"Please enter a valid mobile number"',
      ),
    ]);
MultiValidator get billIDValidator => MultiValidator(<TextFieldValidator>[
      PatternValidator(r'^\d{10}', errorText: 'Code is numeric digits'),
      RequiredValidator(errorText: 'Bill ID is required'),
      LengthRangeValidator(min: 10, max: 10, errorText: 'Bill ID is 10 digits')
    ]);
MultiValidator get passwordValidator => MultiValidator(<TextFieldValidator>[
      RequiredValidator(errorText: 'Password is required'),
      LengthRangeValidator(
        min: 8,
        max: 16,
        errorText: 'Password must be at between 8 and 16 characters long',
      ),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])', errorText: 'passwords must have at least one special character'),
      PatternValidator(r'(?=.*?[A-Z])', errorText: 'passwords must have at least one upper case letter'),
      PatternValidator(r'(?=.*?[a-z])', errorText: 'passwords must have at least one lower case letter'),
    ]);
MultiValidator get otpValidator => MultiValidator(<TextFieldValidator>[
      LengthRangeValidator(
        min: 6,
        max: 6,
        errorText: '"Please enter a valid one time code"',
      ),
    ]);
// FORMATTERS
List<TextInputFormatter> get nameFormatter => <TextInputFormatter>[
      LengthLimitingTextInputFormatter(25),
      FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9 ]')),
    ];

List<TextInputFormatter> get justLength36 => <TextInputFormatter>[
      LengthLimitingTextInputFormatter(36),
    ];

List<TextInputFormatter> get mobileNumberFormatter => <TextInputFormatter>[
      LengthLimitingTextInputFormatter(16),
      FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
    ];

List<TextInputFormatter> get oneTimeCodeFormatter => <TextInputFormatter>[
      LengthLimitingTextInputFormatter(6),
      FilteringTextInputFormatter.allow(RegExp('[0-9+]')),
    ];

List<TextInputFormatter> get pinFormatter => <TextInputFormatter>[
      LengthLimitingTextInputFormatter(6),
    ];

List<TextInputFormatter> get emailVerificationCodeFormatter => <TextInputFormatter>[
      LengthLimitingTextInputFormatter(6),
      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
    ];
// List<TextInputFormatter> justNumberFormatter({required int numberCount}) => <TextInputFormatter>[
//       LengthLimitingTextInputFormatter(numberCount),
//       FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//     ];
List<TextInputFormatter> expiryDateFormatter() => <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp('[0-1]')),
    ];
List<TextInputFormatter> debitCardFormatter() => <TextInputFormatter>[
      MaskedTextInputFormatter(mask: 'XXXX XXXX XXXX XXXX', separator: ' '),
      FilteringTextInputFormatter.allow(RegExp('[0-9 ]+')),
    ];
List<TextInputFormatter> expiryDateInputFormatter() => <TextInputFormatter>[
      ExpiryDateFormatter(),
    ];
List<TextInputFormatter> get justNumberFormatter => <TextInputFormatter>[
      FilteringTextInputFormatter.allow(
        RegExp('[0-9.]'),
      ),
      TwoDecimalPlacesInputFormatter(),
    ];
List<TextInputFormatter> justIntegerFormatter() => <TextInputFormatter>[
      FilteringTextInputFormatter.allow(
        RegExp('[0-9]'),
      ),
    ];
