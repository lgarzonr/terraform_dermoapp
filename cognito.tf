resource "aws_cognito_user_pool" "dermoapp_patients_tf4" {
  name = "dermoapp_patients_tf5"
  username_attributes      = ["email"]
  auto_verified_attributes = ["email"]
  password_policy {
    minimum_length = 8
    require_numbers = true
    require_uppercase = true
  }

  account_recovery_setting {
    recovery_mechanism {
      name = "verified_email"
      priority = 1
    }
  }

  schema {
    attribute_data_type      = "String"
    name                     = "email"
    required = true
    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }
  schema {
    attribute_data_type      = "String"
    name                     = "name"
    required = true
    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }
  schema {
    attribute_data_type      = "String"
    name                     = "birthdate"
    required = true
    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }
  schema {
    name = "city"
    attribute_data_type = "String"
    string_attribute_constraints {
      min_length = 1
      max_length = 2048
    }
  }

  verification_message_template {
    default_email_option = "CONFIRM_WITH_LINK"
    email_subject_by_link = "Bienvenido a dermoApp, por favor valide su correo"
    email_message_by_link = "Bienvenido a dermoApp, Gracias por ser un usuario de dermoApp, para poder continuar es necesario validar su correo electrónico. {##validar correo##} "
  }
}

resource "aws_cognito_user_pool_client" "client_patients_tf" {
  name = "client_patients_tf"

  user_pool_id = aws_cognito_user_pool.dermoapp_patients_tf4.id
}