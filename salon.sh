#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

echo -e "\n~~~~~ Beauty Salon FreeCodeCamp ~~~~~\n"
echo -e "Welcome to Beuty Sanlon FreeCodeCamp, how can I help you?\n"

MAIN_MENU() {

  if [[ $1 ]]
  then
    echo -e "\n$1"
  fi
  
  echo -e "1) Cut\n2) Hydration\n3) Drying\n4) Exit"
  read SERVICE_ID_SELECTED

  case $SERVICE_ID_SELECTED in
    1) CUT_MENU ;;
    2) HYDRATION_MENU ;;
    3) DRYING_MENU ;;
    4) EXIT ;;
    *) MAIN_MENU "I could not find that service. What would you like today?" ;;
  esac
}

CUT_MENU() {
  
  # get service_name
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  # get customer phone number
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  #searching for customer in database
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, What's your name?"
    read CUSTOMER_NAME
    INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')") 
  fi

 # Creating appointment
  echo -e "\nWhat time would you like your $(echo $SERVICE_NAME | sed 's/^ *| *$//g'), $(echo $CUSTOMER_NAME? | sed 's/^ *| *$//g')"
  read SERVICE_TIME
  
  echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME. | sed 's/^ *| *$//g')"
  
  # get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  # Storing the appointment
  APPOINTMERT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")

}

HYDRATION_MENU() {

  # get service_name
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  # get customer phone number
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  #searching for customer in database
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, What's your name?"
    read CUSTOMER_NAME
    INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')") 
  fi

 # Creating appointment
  echo -e "\nWhat time would you like your $(echo $SERVICE_NAME | sed 's/^ *| *$//g'), $(echo $CUSTOMER_NAME? | sed 's/^ *| *$//g')"
  read SERVICE_TIME
  
  echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME. | sed 's/^ *| *$//g')"
  
  # get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  # Storing the appointment
  APPOINTMERT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
}

DRYING_MENU() {
    # get service_name
  SERVICE_NAME=$($PSQL "SELECT name FROM services WHERE service_id = $SERVICE_ID_SELECTED")

  # get customer phone number
  echo -e "\nWhat's your phone number?"
  read CUSTOMER_PHONE

  #searching for customer in database
  CUSTOMER_NAME=$($PSQL "SELECT name FROM customers WHERE phone = '$CUSTOMER_PHONE'")

  # if customer doesn't exist
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nI don't have a record for that phone number, What's your name?"
    read CUSTOMER_NAME
    INSERT_NEW_CUSTOMER=$($PSQL "INSERT INTO customers(phone, name) VALUES('$CUSTOMER_PHONE', '$CUSTOMER_NAME')") 
  fi
  
  # Creating appointment
  echo -e "\nWhat time would you like your $(echo $SERVICE_NAME | sed 's/^ *| *$//g'), $(echo $CUSTOMER_NAME? | sed 's/^ *| *$//g')"
  read SERVICE_TIME
  
  echo -e "\nI have put you down for a $(echo $SERVICE_NAME | sed 's/^ *| *$//g') at $SERVICE_TIME, $(echo $CUSTOMER_NAME. | sed 's/^ *| *$//g')"
  
  # get customer_id
  CUSTOMER_ID=$($PSQL "SELECT customer_id FROM customers WHERE phone = '$CUSTOMER_PHONE'")
  # Storing the appointment
  APPOINTMERT=$($PSQL "INSERT INTO appointments(customer_id, service_id, time) VALUES($CUSTOMER_ID, $SERVICE_ID_SELECTED, '$SERVICE_TIME')")
}

EXIT() {
  echo -e "\nThank for stopping in.\n"
}

MAIN_MENU
