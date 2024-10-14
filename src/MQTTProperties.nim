## *****************************************************************************
##  Copyright (c) 2017, 2023 IBM Corp. and others
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

when not defined(MQTTPROPERTIES_H):
  import
    MQTTExportDeclarations

  const
    MQTT_INVALID_PROPERTY_ID* = -2
  ##  The one byte MQTT V5 property indicator
  type
    MQTTPropertyCodes* {.size: sizeof(cint).} = enum
      MQTTPROPERTY_CODE_PAYLOAD_FORMAT_INDICATOR = 1, ## < The value is 1
      MQTTPROPERTY_CODE_MESSAGE_EXPIRY_INTERVAL = 2, ## < The value is 2
      MQTTPROPERTY_CODE_CONTENT_TYPE = 3, ## < The value is 3
      MQTTPROPERTY_CODE_RESPONSE_TOPIC = 8, ## < The value is 8
      MQTTPROPERTY_CODE_CORRELATION_DATA = 9, ## < The value is 9
      MQTTPROPERTY_CODE_SUBSCRIPTION_IDENTIFIER = 11, ## < The value is 11
      MQTTPROPERTY_CODE_SESSION_EXPIRY_INTERVAL = 17, ## < The value is 17
      MQTTPROPERTY_CODE_ASSIGNED_CLIENT_IDENTIFER = 18, ## < The value is 18
      MQTTPROPERTY_CODE_SERVER_KEEP_ALIVE = 19, ## < The value is 19
      MQTTPROPERTY_CODE_AUTHENTICATION_METHOD = 21, ## < The value is 21
      MQTTPROPERTY_CODE_AUTHENTICATION_DATA = 22, ## < The value is 22
      MQTTPROPERTY_CODE_REQUEST_PROBLEM_INFORMATION = 23, ## < The value is 23
      MQTTPROPERTY_CODE_WILL_DELAY_INTERVAL = 24, ## < The value is 24
      MQTTPROPERTY_CODE_REQUEST_RESPONSE_INFORMATION = 25, ## < The value is 25
      MQTTPROPERTY_CODE_RESPONSE_INFORMATION = 26, ## < The value is 26
      MQTTPROPERTY_CODE_SERVER_REFERENCE = 28, ## < The value is 28
      MQTTPROPERTY_CODE_REASON_STRING = 31, ## < The value is 31
      MQTTPROPERTY_CODE_RECEIVE_MAXIMUM = 33, ## < The value is 33
      MQTTPROPERTY_CODE_TOPIC_ALIAS_MAXIMUM = 34, ## < The value is 34
      MQTTPROPERTY_CODE_TOPIC_ALIAS = 35, ## < The value is 35
      MQTTPROPERTY_CODE_MAXIMUM_QOS = 36, ## < The value is 36
      MQTTPROPERTY_CODE_RETAIN_AVAILABLE = 37, ## < The value is 37
      MQTTPROPERTY_CODE_USER_PROPERTY = 38, ## < The value is 38
      MQTTPROPERTY_CODE_MAXIMUM_PACKET_SIZE = 39, ## < The value is 39
      MQTTPROPERTY_CODE_WILDCARD_SUBSCRIPTION_AVAILABLE = 40, ## < The value is 40
      MQTTPROPERTY_CODE_SUBSCRIPTION_IDENTIFIERS_AVAILABLE = 41, ## < The value is 41
      MQTTPROPERTY_CODE_SHARED_SUBSCRIPTION_AVAILABLE = 42 ## < The value is 241
  ##
  ##  Returns a printable string description of an MQTT V5 property code.
  ##  @param value an MQTT V5 property code.
  ##  @return the printable string description of the input property code.
  ##  NULL if the code was not found.
  ##
  proc MQTTPropertyName*(value: MQTTPropertyCodes): cstring {.cdecl,
      importc: "MQTTPropertyName", dynlib: libpahomqtt.}
  ##  The one byte MQTT V5 property type
  type
    MQTTPropertyTypes* {.size: sizeof(cint).} = enum
      MQTTPROPERTY_TYPE_BYTE, MQTTPROPERTY_TYPE_TWO_BYTE_INTEGER,
      MQTTPROPERTY_TYPE_FOUR_BYTE_INTEGER,
      MQTTPROPERTY_TYPE_VARIABLE_BYTE_INTEGER, MQTTPROPERTY_TYPE_BINARY_DATA,
      MQTTPROPERTY_TYPE_UTF_8_ENCODED_STRING, MQTTPROPERTY_TYPE_UTF_8_STRING_PAIR
  ##
  ##  Returns the MQTT V5 type code of an MQTT V5 property.
  ##  @param value an MQTT V5 property code.
  ##  @return the MQTT V5 type code of the input property. -1 if the code was not found.
  ##
  proc MQTTProperty_getType*(value: MQTTPropertyCodes): cint {.cdecl,
      importc: "MQTTProperty_getType", dynlib: libpahomqtt.}
  ##
  ##  The data for a length delimited string
  ##
  type
    MQTTLenString* {.bycopy.} = object
      len*: cint
      ## < the length of the string
      data*: cstring
      ## < pointer to the string data

  ##
  ##  Structure to hold an MQTT version 5 property of any type
  ##
  type
    INNER_C_STRUCT_MQTTProperties_4* {.bycopy.} = object
      data*: MQTTLenString
      ## < The value of a string property, or the name of a user property.
      value*: MQTTLenString
      ## < The value of a user property.

  type
    INNER_C_UNION_MQTTProperties_3* {.bycopy, union.} = object
      byte*: cuchar
      ## < holds the value of a byte property type
      integer2*: cushort
      ## < holds the value of a 2 byte integer property type
      integer4*: cuint
      ## < holds the value of a 4 byte integer property type
      ano_MQTTProperties_5*: INNER_C_STRUCT_MQTTProperties_4

  type
    MQTTProperty* {.bycopy.} = object
      identifier*: MQTTPropertyCodes
      ## <  The MQTT V5 property id. A multi-byte integer.
      ##  The value of the property, as a union of the different possible types.
      value*: INNER_C_UNION_MQTTProperties_3

  ##
  ##  MQTT version 5 property list
  ##
  type
    MQTTProperties* {.bycopy.} = object
      count*: cint
      ## < number of property entries in the array
      max_count*: cint
      ## < max number of properties that the currently allocated array can store
      length*: cint
      ## < mbi: byte length of all properties
      array*: ptr MQTTProperty
      ## < array of properties

  const
    MQTTProperties_initializer* = (0, 0, 0, nil)
  ##
  ##  Returns the length of the properties structure when serialized ready for network transmission.
  ##  @param props an MQTT V5 property structure.
  ##  @return the length in bytes of the properties when serialized.
  ##
  proc MQTTProperties_len*(props: ptr MQTTProperties): cint {.cdecl,
      importc: "MQTTProperties_len", dynlib: libpahomqtt.}
  ##
  ##  Add a property pointer to the property array. Memory is allocated in this function,
  ##  so MQTTClient_create or MQTTAsync_create must be called first to initialize the
  ##  internal heap tracking. Alternatively MQTTAsync_global_init() can be called first
  ##  or build with the HIGH_PERFORMANCE option which disables the heap tracking.
  ##  @param props The property list to add the property to.
  ##  @param prop The property to add to the list.
  ##  @return 0 on success, -1 on failure.
  ##
  proc MQTTProperties_add*(props: ptr MQTTProperties; prop: ptr MQTTProperty): cint {.
      cdecl, importc: "MQTTProperties_add", dynlib: libpahomqtt.}
  ##
  ##  Serialize the given property list to a character buffer, e.g. for writing to the network.
  ##  @param pptr pointer to the buffer - move the pointer as we add data
  ##  @param properties pointer to the property list, can be NULL
  ##  @return whether the write succeeded or not: number of bytes written, or < 0 on failure.
  ##
  proc MQTTProperties_write*(pptr: cstringArray; properties: ptr MQTTProperties): cint {.
      cdecl, importc: "MQTTProperties_write", dynlib: libpahomqtt.}
  ##
  ##  Reads a property list from a character buffer into an array.
  ##  @param properties pointer to the property list to be filled. Should be initalized but empty.
  ##  @param pptr pointer to the character buffer.
  ##  @param enddata pointer to the end of the character buffer so we don't read beyond.
  ##  @return 1 if the properties were read successfully.
  ##
  proc MQTTProperties_read*(properties: ptr MQTTProperties; pptr: cstringArray;
                           enddata: cstring): cint {.cdecl,
      importc: "MQTTProperties_read", dynlib: libpahomqtt.}
  ##
  ##  Free all memory allocated to the property list, including any to individual properties.
  ##  @param properties pointer to the property list.
  ##
  proc MQTTProperties_free*(properties: ptr MQTTProperties) {.cdecl,
      importc: "MQTTProperties_free", dynlib: libpahomqtt.}
  ##
  ##  Copy the contents of a property list, allocating additional memory if needed.
  ##  @param props pointer to the property list.
  ##  @return the duplicated property list.
  ##
  proc MQTTProperties_copy*(props: ptr MQTTProperties): MQTTProperties {.cdecl,
      importc: "MQTTProperties_copy", dynlib: libpahomqtt.}
  ##
  ##  Checks if property list contains a specific property.
  ##  @param props pointer to the property list.
  ##  @param propid the property id to check for.
  ##  @return 1 if found, 0 if not.
  ##
  proc MQTTProperties_hasProperty*(props: ptr MQTTProperties;
                                  propid: MQTTPropertyCodes): cint {.cdecl,
      importc: "MQTTProperties_hasProperty", dynlib: libpahomqtt.}
  ##
  ##  Returns the number of instances of a property id. Most properties can exist only once.
  ##  User properties and subscription ids can exist more than once.
  ##  @param props pointer to the property list.
  ##  @param propid the property id to check for.
  ##  @return the number of times found.  Can be 0.
  ##
  proc MQTTProperties_propertyCount*(props: ptr MQTTProperties;
                                    propid: MQTTPropertyCodes): cint {.cdecl,
      importc: "MQTTProperties_propertyCount", dynlib: libpahomqtt.}
  ##
  ##  Returns the integer value of a specific property.  The property given must be a numeric type.
  ##  @param props pointer to the property list.
  ##  @param propid the property id to check for.
  ##  @return the integer value of the property. -9999999 on failure.
  ##
  proc MQTTProperties_getNumericValue*(props: ptr MQTTProperties;
                                      propid: MQTTPropertyCodes): cint {.cdecl,
      importc: "MQTTProperties_getNumericValue", dynlib: libpahomqtt.}
  ##
  ##  Returns the integer value of a specific property when it's not the only instance.
  ##  The property given must be a numeric type.
  ##  @param props pointer to the property list.
  ##  @param propid the property id to check for.
  ##  @param index the instance number, starting at 0.
  ##  @return the integer value of the property. -9999999 on failure.
  ##
  proc MQTTProperties_getNumericValueAt*(props: ptr MQTTProperties;
                                        propid: MQTTPropertyCodes; index: cint): cint {.
      cdecl, importc: "MQTTProperties_getNumericValueAt", dynlib: libpahomqtt.}
  ##
  ##  Returns a pointer to the property structure for a specific property.
  ##  @param props pointer to the property list.
  ##  @param propid the property id to check for.
  ##  @return the pointer to the property structure if found.  NULL if not found.
  ##
  proc MQTTProperties_getProperty*(props: ptr MQTTProperties;
                                  propid: MQTTPropertyCodes): ptr MQTTProperty {.
      cdecl, importc: "MQTTProperties_getProperty", dynlib: libpahomqtt.}
  ##
  ##  Returns a pointer to the property structure for a specific property when it's not the only instance.
  ##  @param props pointer to the property list.
  ##  @param propid the property id to check for.
  ##  @param index the instance number, starting at 0.
  ##  @return the pointer to the property structure if found.  NULL if not found.
  ##
  proc MQTTProperties_getPropertyAt*(props: ptr MQTTProperties;
                                    propid: MQTTPropertyCodes; index: cint): ptr MQTTProperty {.
      cdecl, importc: "MQTTProperties_getPropertyAt", dynlib: libpahomqtt.}