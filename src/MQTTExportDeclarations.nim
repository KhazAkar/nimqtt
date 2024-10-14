## *****************************************************************************
##  Copyright (c) 2020, 2020 Andreas Walter
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
##     Andreas Walter - initially moved export declarations into separate fle
## *****************************************************************************

when not defined(EXPORTDECLARATIONS_H):
  when defined(_WIN32) or defined(_WIN64):
    when defined(PAHO_MQTT_EXPORTS):
      discard
    elif defined(PAHO_MQTT_IMPORTS):
      const
        __declspec* = cast[dllexport](__declspec(dllimport))
    else:
      const
        __declspec* = (dllexport)
  else:
    when defined(PAHO_MQTT_EXPORTS):
      const
        __declspec* = cast[dllexport](__attribute__((visibility("default"))))
    else:
      const
        __declspec* = cast[dllexport](extern)