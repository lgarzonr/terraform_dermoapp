resource "aws_cognito_user_pool" "dermoapp_patients_tf3" {
  name = "dermoapp_patients_tf"
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
  # schema {
  #   name = "city"
  #   attribute_data_type = "String"
  #   string_attribute_constraints {
  #     min_length = 0
  #     max_length = 0
  #   }
  # }
}