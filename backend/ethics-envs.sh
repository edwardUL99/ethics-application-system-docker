function exportIfNotSet() {
  variable="$1"
  value="$2"
  hideValue="$3"

  if [ -z "${!variable}" ]; then
    if [ "$hideValue" == "hideVal" ]; then
      echo "Variable $variable not set, setting it"
    else
      echo "Variable $variable not set, setting it to value $value"
    fi

    eval "export $variable=$value"
  else
    if [ "$hideValue" == "hideVal" ]; then
      echo "Variable $variable already set, not setting it"
    else
      echo "Variable $variable already set with value ${!variable}"
    fi
  fi
}

exportIfNotSet "DATABASE_URL" "jdbc:postgresql://database:5432/ethics"
exportIfNotSet "DATABASE_USER" "ethicsuser"
exportIfNotSet "DATABASE_PASS" "DEFAULT_DB_PASSWORD" "hideVal"
exportIfNotSet "ETHICS_EMAIL_FROM" "DEFAULT_EMAIL"
exportIfNotSet "ETHICS_EMAIL_HOST" "DEFAULT_HOST"
exportIfNotSet "ETHICS_EMAIL_PORT" "DEFAULT_PORT"
exportIfNotSet "ETHICS_EMAIL_PASSWORD" "DEFAULT_PASSWORD" "hideVal"
exportIfNotSet "ETHICS_ANTIVIRUS_HOST" "clamav"
exportIfNotSet "ETHICS_ANTIVIRUS_PORT" "3310"
exportIfNotSet "ETHICS_CHAIR_EMAIL" "DEFAULT_CHAIR_EMAIL"
exportIfNotSet "SPRING_PROFILES_ACTIVE" "prod"
