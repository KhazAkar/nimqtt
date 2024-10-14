## *****************************************************************************
##  Copyright (c) 2017, 2020 IBM Corp. and others
##
##  All rights reserved. This program and the accompanying materials
##  are made available under the terms of the Eclipse Public License v2.0
##  and Eclipse Distribution License v1.0 which accompany this distribution.
##
##  The Eclipse Public License is available at
##     https://www.eclipse.org/legal/epl-2.0/
##  and the Eclipse Distribution License is available at
##    http://www.eclipse.org/org/documents/edl-v10.php.
##
##  Contributors:
##     Ian Craggs - initial API and implementation and/or initial documentation
## *****************************************************************************

when not defined(MQTTREASONCODES_H):
  import
    MQTTExportDeclarations

  ##  The MQTT V5 one byte reason code
  type
    MQTTReasonCodes* {.size: sizeof(cint).} = enum
      MQTTREASONCODE_SUCCESS = 0, MQTTREASONCODE_GRANTED_QOS_1 = 1,
      MQTTREASONCODE_GRANTED_QOS_2 = 2,
      MQTTREASONCODE_DISCONNECT_WITH_WILL_MESSAGE = 4,
      MQTTREASONCODE_NO_MATCHING_SUBSCRIBERS = 16,
      MQTTREASONCODE_NO_SUBSCRIPTION_FOUND = 17,
      MQTTREASONCODE_CONTINUE_AUTHENTICATION = 24,
      MQTTREASONCODE_RE_AUTHENTICATE = 25, MQTTREASONCODE_UNSPECIFIED_ERROR = 128,
      MQTTREASONCODE_MALFORMED_PACKET = 129, MQTTREASONCODE_PROTOCOL_ERROR = 130,
      MQTTREASONCODE_IMPLEMENTATION_SPECIFIC_ERROR = 131,
      MQTTREASONCODE_UNSUPPORTED_PROTOCOL_VERSION = 132,
      MQTTREASONCODE_CLIENT_IDENTIFIER_NOT_VALID = 133,
      MQTTREASONCODE_BAD_USER_NAME_OR_PASSWORD = 134,
      MQTTREASONCODE_NOT_AUTHORIZED = 135, MQTTREASONCODE_SERVER_UNAVAILABLE = 136,
      MQTTREASONCODE_SERVER_BUSY = 137, MQTTREASONCODE_BANNED = 138,
      MQTTREASONCODE_SERVER_SHUTTING_DOWN = 139,
      MQTTREASONCODE_BAD_AUTHENTICATION_METHOD = 140,
      MQTTREASONCODE_KEEP_ALIVE_TIMEOUT = 141,
      MQTTREASONCODE_SESSION_TAKEN_OVER = 142,
      MQTTREASONCODE_TOPIC_FILTER_INVALID = 143,
      MQTTREASONCODE_TOPIC_NAME_INVALID = 144,
      MQTTREASONCODE_PACKET_IDENTIFIER_IN_USE = 145,
      MQTTREASONCODE_PACKET_IDENTIFIER_NOT_FOUND = 146,
      MQTTREASONCODE_RECEIVE_MAXIMUM_EXCEEDED = 147,
      MQTTREASONCODE_TOPIC_ALIAS_INVALID = 148,
      MQTTREASONCODE_PACKET_TOO_LARGE = 149,
      MQTTREASONCODE_MESSAGE_RATE_TOO_HIGH = 150,
      MQTTREASONCODE_QUOTA_EXCEEDED = 151,
      MQTTREASONCODE_ADMINISTRATIVE_ACTION = 152,
      MQTTREASONCODE_PAYLOAD_FORMAT_INVALID = 153,
      MQTTREASONCODE_RETAIN_NOT_SUPPORTED = 154,
      MQTTREASONCODE_QOS_NOT_SUPPORTED = 155,
      MQTTREASONCODE_USE_ANOTHER_SERVER = 156, MQTTREASONCODE_SERVER_MOVED = 157,
      MQTTREASONCODE_SHARED_SUBSCRIPTIONS_NOT_SUPPORTED = 158,
      MQTTREASONCODE_CONNECTION_RATE_EXCEEDED = 159,
      MQTTREASONCODE_MAXIMUM_CONNECT_TIME = 160,
      MQTTREASONCODE_SUBSCRIPTION_IDENTIFIERS_NOT_SUPPORTED = 161,
      MQTTREASONCODE_WILDCARD_SUBSCRIPTIONS_NOT_SUPPORTED = 162
  const
    MQTTREASONCODE_NORMAL_DISCONNECTION = MQTTREASONCODE_SUCCESS
    MQTTREASONCODE_GRANTED_QOS_0 = MQTTREASONCODE_SUCCESS
  ##
  ##  Returns a printable string description of an MQTT V5 reason code.
  ##  @param value an MQTT V5 reason code.
  ##  @return the printable string description of the input reason code.
  ##  NULL if the code was not found.
  ##
  proc MQTTReasonCode_toString*(value: MQTTReasonCodes): cstring {.cdecl,
      importc: "MQTTReasonCode_toString", dynlib: libpahomqtt.}