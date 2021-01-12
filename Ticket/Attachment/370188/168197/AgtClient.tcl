package provide AgtClient 1.0

#
# AgtClient version history
#  1.0 - N2X support in AgtGetVersion
#  0.2 - 
#  0.1 - Original version
#

global STEP_COMMANDS
if {[info exists env(STEP_INVOKE)]} {
    set STEP_COMMANDS $env(STEP_INVOKE)
} else {
    set STEP_COMMANDS 0
}

##########################################################################
#  Agt Connection Management Commands                                    # 
#  - these commands are used for managing connections to the test system #
##########################################################################

##########################################################################
# Name: AgtConnect
# Description:  
#   Connect to a particular test session
#   Returns a connection ID
#   The client passes a session ID or session label
#   If the session ID or label is not specified the script
#   will attempt to connect to the running session. 
#   An error is returned if there is no open
#   session or multiple open sessions.
#   The new connection becomes the active connection.
proc AgtConnect { {sessionID 0} } {
    global _AgtActiveConnection
    global _AgtConnections

    # Get the list of running sessions
    if [catch {
        set sessions [SmInvoke AgtSessionManager ListOpenSessions] 
    } result] {
        return -code error $result
    }

    if {$sessionID == 0} {
        # Return an error if the number of sessions is 0 or >1
        switch -exact [llength $sessions] {
            0 { 
                return -code error "There are no open sessions" 
            }
            1 { 
                set session [lindex $sessions 0] 
            }
            default { 
                return -code error "There are multiple open sessions" 
            }
        }
    } else {

        # Check whether sessionID is in list
        set found 0
        foreach session $sessions {
            if {$session == $sessionID} {
                set found 1
                break
            }

            if [catch {
                set label [SmInvoke AgtSessionManager GetSessionLabel $session] 
                
            } result] {
                # ignore any failure since $session may no longer exist!?
                set label ""
            }

            if {$label == $sessionID} {
                set found 1
                break
            }
        }
        if {$found == 0} {
            return -code error "Session $sessionID is not running"
        }
    }

    # If we don't have an existing connection to the test session then make one
    if {[info exists _AgtConnections($session)] == 0} {
        
        # Get the listening port of the running session
        if [catch {
            set session_port [SmGetSessionPort $session]
        } ] {
            catch {SmDisconnect}
            return -code error "Unable to connect to server"
        }

        # Get the server hostname
        set hostname [AgtGetServerHostname]

        # Open socket to the session manager 
        if [catch {
            set _AgtConnections($session) [Connect $hostname $session_port]
        } ] {
            return -code error "Unable to connect to session"
        }
    }

    # Make this the active connection
    set _AgtActiveConnection $session
        
    # Return the session ID (which doubles as the connectionID)
    return $session
}

##########################################################################
# Name:  AgtDisconnect
# Description:
#   Disconnect a particular connection
#   Disconnects the active connection if no ID is given
proc AgtDisconnect { {connectionID 0} } {
    global _AgtActiveConnection
    global _AgtConnections

    # Map the connection ID to an open session ID
    set session 0
    if {$connectionID == 0} {
        if {[info exists _AgtActiveConnection]} {
            set session $_AgtActiveConnection
        } else {
            return -code error "There is no active connection."
        }
    } else {
        if {[info exists _AgtConnections($connectionID)]} {
            set session $connectionID
        } else {
            return -code error "Invalid connection identifier"
        }
    }

    # If session is the same as the active connection, unset it
    if {[info exists _AgtActiveConnection]} {
        if {$_AgtActiveConnection == $session} { unset _AgtActiveConnection }
    }

    # Close the connection and unset the variable
    # Don't propogate any errors which occur 
    # Clean up any socket data
    catch {_AgtRemoveSocketData $_AgtConnections($session)}
    catch {close $_AgtConnections($session); unset _AgtConnections($session)}
    return 
}

##########################################################################
# Name:  AgtSetActiveConnection
# Description:
#   Set the active connection
proc AgtSetActiveConnection { connectionID } {
    global _AgtActiveConnection
    global _AgtConnections

    # Check that the connection ID is in the list of connections
    if {[info exists _AgtConnections($connectionID)] == 0} {
        return -code error "Invalid connection ID"
    }
    set _AgtActiveConnection $connectionID
}

##########################################################################
# Name:  AgtGetActiveConnection
# Description:
#   Return the connection ID of the active connection
proc AgtGetActiveConnection { } {
    global _AgtActiveConnection

    if {[info exists _AgtActiveConnection] == 0} {
        return -code error "There is no active connection"
    }
    return $_AgtActiveConnection
}

##########################################################################
# Name:  AgtListConnections
# Description:  
#   Return a list of open connections
#   This will be a subset of the list of active sessions
proc AgtListConnections { } {
    global _AgtConnections

    return [array names _AgtConnections]
}

#########################################################################
# Name:  AgtBreakPoint
# Description:
#   This function causes the next (and subsequent) AgtInvoke commands to
#   be prompted for execution. All other TCL commands will be executed as 
#   normal.
proc AgtBreakPoint { } {
    global STEP_COMMANDS

    set STEP_COMMANDS 1
}

#########################################################################
#  Agt Invoke Command                                                   #
#  - this is the command used to send commands to the test system       #
#      Invoke <interface> <method> <args>                               #
#  - the command will be sent to the active connection                  #
#  If the envorionment variable STEP_INVOKE is set the user will be     #
#  prompted to execute each AgtInvoke Command. All other TCL commands   #
#  will be executed as normal.                                          #
#########################################################################

##########################################################################
# Name:  AgtInvoke
# Description:
#    Invoke a message on the server
#    A message is categorised by its interface and method name
proc AgtInvoke {{interface {}} {method {}} args} {
    global _AgtConnections
    global _AgtActiveConnection
    global env
    global STEP_COMMANDS

    set trace 0

    if {$STEP_COMMANDS} {
        set stopped 1
        # Loop until we get a valid input
        while {$stopped} {
            puts -nonewline "About to perform 'AgtInvoke $interface $method $args' (<CR>,y,n,q,c,t)"
            flush stdout
            set result [gets stdin]
            switch -exact -- $result {
                "y" -
                "Y" -
                "" {
                    set stopped 0
                }
                "C" -
                "c" {
                    puts "Continue Selected"
                    set STEP_COMMANDS 0
                    set stopped 0
                }
                "N" -
                "n" {
                    puts "Not Executing"
                    return
                }
                "q" -
                "Q" {
                    puts "Exiting"
                    exit
                }
                "t" -
                "T" {
                    puts -nonewline "Tracing > "
                    set stopped 0
                    set trace 1
                }
                default {
                    puts "Command not recognised: $result"
                    puts "Select from: <CR> or y : Execute this command. "
                    puts "              c        : Continue, no longer prompt"
                    puts "              n        : Don't execute this command"
                    puts "              q        : Exit this script"
                    puts "              t        : Trace this command"
                }
            }
        }
    }

    #  Testing - scanning for nulls.  THis is required as a means of stopping hang-ups
    #  when an NULL character appears in a string.  While it is valid for a NULL to be
    #  in a TCL string, it casues the system to hang when the command is posted via the
    #  sockets.  See DDTS QTOrd30289.  This problem has been fixed by ensuring that
    #  strings with the NULL character in them are never passed across the interface.
    foreach arg $args {
       if {[string first "\0" $arg] >= 0} {
          return -code error "Illegal characters in parameter string"
       }
    }

    # Check if request is for the session or module manager
    if { $interface == "AgtSessionManager" || 
         $interface == "AgtModuleManager" } {
        # Special eval trick to preserve the list structure ot the
        # variable argument list. See Welch p116.
    if [catch {eval {SmInvoke $interface $method} $args} result] {
            return -code error $result
        }
        return $result
    }
      
    # Check if request is to open a session
    if { $method == "OpenSession" } {
        if { [llength $args] == 2 } {
            # Backwards compatibility fix open the latest session as pre-N2X 
            # scripts can use:
            # AgtInvoke AgtTestSession OpenSession RouterTester900 AGT_SESSION_ONLINE
            set type [lindex $args 0]
            set mode [lindex $args 1]
        
            if [catch {AgtOpenSession $type $mode} result] {
                return -code error $result
            } 
        } else {
            set type [lindex $args 0]
            set version [lindex $args 1]
            set mode [lindex $args 2]
        
            if [catch {AgtOpenSessionByVersion $type $version $mode} result] {
                return -code error $result
            }             
        }
        return $result
    }         
    
    # Check for an active connection
    if {[info exists _AgtActiveConnection] == 0 ||
         [info exists _AgtConnections($_AgtActiveConnection)] == 0} {
         return -code error "There is no active connection to the server"
    } 
    
    # Check if request is to close a session
    if { $method == "CloseSession" } {
       if [catch { AgtCloseSession $_AgtActiveConnection} result] {
          return -code error $result
       }
       return $result
    }

    # Check if request is to force close a session - if so then go via
    # the CloseSessionForce in AgtSessionManager instead of AgtTestSession.
    # Using AgtTestSession::CloseSessionForce kills the TCL parser so
    # AgtInvoke would get an error message.
    if { $method == "CloseSessionForce" } {
       if [catch { AgtCloseSessionForce $_AgtActiveConnection} result] {
          return -code error $result
       }
       return $result
    }
    
    # Send the command to the socket
    if [catch {
        # Special eval trick to preserve the list structure ot the
        # variable argument list. See Welch p116.
        eval {
            Invoke $_AgtConnections($_AgtActiveConnection) $interface $method
        } $args
    } result] {
        return -code error $result
    }

    # If we are tracing the command return the result
    if {$trace} {
        puts " $result"
    }

    # Return the results
    return $result
}
    
##########################################################################
# Name:  AgtGet
# Description:
#    Invoke a message on the server
#    A message is categorised by its interface and method name
proc AgtGet {interface method args} {
    global _AgtConnections
    global _AgtActiveConnection

    # Check for an active connection
    if {[info exists _AgtActiveConnection] == 0 ||
        [info exists _AgtConnections($_AgtActiveConnection)] == 0} {
        return -code error "There is no active connection to the server"
    }

    # Send the command to the socket
    if [catch {
        # Special eval trick to preserve the list structure ot the
        # variable argument list. See Welch p116.
        eval {
            Invoke $_AgtConnections($_AgtActiveConnection) $interface $method
        } $args
    } result] {
        return -code error $result
    }

    # Return the results
    return $result
}

##########################################################################
# Name:  AgtSet
# Description:
#    Invoke a message on the server
#    A message is categorised by its interface and method name
proc AgtSet {interface method args} {
    global _AgtConnections
    global _AgtActiveConnection

    # Check for an active connection
    if {[info exists _AgtActiveConnection] == 0 ||
        [info exists _AgtConnections($_AgtActiveConnection)] == 0} {
        return -code error "There is no active connection to the server"
    }

    # Send the command to the socket
    if [catch {
        # Special eval trick to preserve the list structure ot the
        # variable argument list. See Welch p116.
        eval {
            Invoke $_AgtConnections($_AgtActiveConnection) $interface $method
        } $args
    } result] {
        return -code error $result
    }

    # Return the results
    return $result
}

#########################################################################
#  Agt Interface Discovery Commands                                     #
#  - these methods provide an interface browsing capability             # 
#########################################################################

#########################################################################
# Name:  AgtListObjects 
# Description:
#   AgtListObjects AGT_ALL
#   - List all the objects available to AgtInvoke
#   AgtListObjects AGT_SAVEABLE
#   - List all the saveable objects available to AgtSaveSession
#   AgtListObjects AGT_SAVED filename
#   - Lists all of the objects saved in the supplied configuration file
proc AgtListObjects { {objectType AGT_ALL} {filename {}} } {
    if { $objectType == "AGT_SAVEABLE" } {
        AgtInvoke AgtTestSession ListSaveableInterfaces
    } elseif { $objectType == "AGT_SAVED" } {
        AgtInvoke AgtTestSession ListSavedInterfaces $filename
    } else {
        AgtInvoke AgtTestSession ListInterfaces
    }
}

#########################################################################
# Name:  AgtListInterfaces
# Description:
#   List all the interfaces available to AgtInvoke
proc AgtListInterfaces { } {
    AgtInvoke AgtTestSession ListInterfaces
}

#########################################################################
# Name: AgtListObjectMethods
# Description:
#   List all of the methods available on a particular interface
proc AgtListMethodsForInterface { interface } {
    return -code error "This command is not yet available"
}

#########################################################################
# Name: AgtListMethodsForInterface
# Description:
#   List all of the methods available on a particular interface
proc AgtListMethodsForInterface { interface } {
    return -code error "This command is not yet available"
}

#########################################################################
# Name: AgtGetMethodParameters
# Description:
#   List the number and types of input and output arguments
#   for the given method on the given interface 
#   Format of details TBD
proc AgtGetMethodParameters { interface method } {
    return -code error "This command is not yet available"
}

#########################################################################
#  Agt Utility Commands                                                 #
#########################################################################

#########################################################################
# Name: AgtSetServerHostname
# Description:
#   Set the hostname of the server
#   This command is require to support remote scripting
#   If not set, the script will assume localhost
#   Any change will take effect the next time a
#   socket is opened. 
proc AgtSetServerHostname { {hostname localhost} } {
    global _AgtServerHostName
    global _AgtSessionMgrSocket
    global _AgtConnections
    global _AgtActiveConnection

    # Check if the hostname has changed
    if {[info exists _AgtServerHostName]} {
        if {$_AgtServerHostName != $hostname} {
            # Close all open sockets
            # Unset the socket variables
            if {[info exists _AgtConnections]} {
                foreach arg [array names _AgtConnections] {
                    _AgtRemoveSocketData $_AgtConnections($arg)
                    close $_AgtConnections($arg)
                    unset _AgtConnections($arg)
                }
            }
            if {[info exists _AgtActiveConnection]} {
                unset _AgtActiveConnection
            }
            if {[info exists _AgtSessionMgrSocket]} {
                _AgtRemoveSocketData $_AgtSessionMgrSocket
                close $_AgtSessionMgrSocket
                unset _AgtSessionMgrSocket
            }
        }
    }
    set _AgtServerHostName $hostname
}

#########################################################################
# Name:  AgtGetServerHostname
proc AgtGetServerHostname {} {
    global _AgtServerHostName

    if {[info exists _AgtServerHostName] == 0} {
        AgtSetServerHostname
    }
    return $_AgtServerHostName
}

#########################################################################
#  Agt Session Management Commands
#  - these commands are used for interacting with the session manager
#########################################################################

#########################################################################
# Name:  AgtListSessionTypes
# Description:
#   List Session Types
#   Returns a list of available session types
proc AgtListSessionTypes { } {
    SmInvoke AgtSessionManager ListSessionTypes
}

#########################################################################
# Name:  AgtListSessionVersions
# Description:
#   List all available versions of the specified session type
#   Returns a list of available session versions
proc AgtListSessionVersions { sessionType } {

    set sessionTypeList [AgtListSessionTypes]
    if { [lsearch -exact $sessionTypeList $sessionType] == -1 } {
        error "AgtListSessionVersions\n - Invalid session type: '$sessionType'\n - Must be one of: $sessionTypeList"
    }
    if [catch {
        set versions [AgtInvoke AgtSessionManager ListSessionVersions $sessionType]
    } result] {
        return -code error $result
    }
    return $versions
}

#########################################################################
# Name:  AgtGetVersion
# Description:
#   Get the version number of the current test session. If not connected
# to a test session then return the latest version of the RouterTester900
# software. If no RouterTester900 software is installed then return
# version 0.0.0.0.
#   
proc AgtGetVersion { {type RouterTester900} } {
    global _AgtActiveConnection
    set defaultResult "0.0.0.0"

    if {[info exists _AgtActiveConnection]} {
        if [catch {AgtInvoke AgtTestSession GetVersion} result] {
            # This will fail if called on a non-N2X test session.
            # Revert to pre-N2X behaviour.
            set result [SmInvoke AgtHostManager GetVersion]
        }
    } else {
        # Get latest RT900 version - the last version is the latest
        if [catch {set sessionVersions [AgtInvoke AgtSessionManager ListSessionVersions $type]} errMsg] {
            # This will fail if called on a non-N2X test session.
            # Revert to pre-N2X behaviour.
            set result [SmInvoke AgtHostManager GetVersion]
        } else {
            if {[llength $sessionVersions] != 0} {
                set result [lindex $sessionVersions end]
            } else {
                set result $defaultResult
            }
        }
    }
    return $result
}

#########################################################################
# Name:  AgtGetPlatformVersion
# Description:
#   Get the version number of the software running on the server
proc AgtGetPlatformVersion { } {
    SmInvoke AgtHostManager GetPlatformVersion
}

#########################################################################
# Name:  AgtListOpenSessions
# Description:
#   List Open Sessions
#   Returns a list of session identifiers
proc AgtListOpenSessions { } {
    SmInvoke AgtSessionManager ListOpenSessions
}

#########################################################################
# Name:  AgtOpenSession
# Description:
#   Open a test session of the given type
#   Open a connection to the session and make it the active connection
#   Returns a session identifier for the session
proc AgtOpenSession { type {mode AGT_SESSION_ONLINE} } {
    if [catch {
        SmInvoke AgtSessionManager OpenSession $type $mode
    } result] {
        return -code error $result
    }
    AgtConnect $result
}

#########################################################################
# Name:  AgtOpenSessionByVersion
# Description:
#   Open a test session of the given type and version
#   Open a connection to the session and make it the active connection
#   Returns a session identifier for the session
proc AgtOpenSessionByVersion { type version {mode AGT_SESSION_ONLINE} } {

    set sessionTypeList [AgtListSessionTypes]
    if { [lsearch -exact $sessionTypeList $type] == -1 } {
        error "AgtOpenSessionByVersion\n - Invalid session type: '$type'\n - Must be one of: $sessionTypeList"
    }
    set versionList [AgtListSessionVersions $type]
    if { [lsearch -exact $versionList $version] == -1 } {
        error "AgtOpenSessionByVersion\n - Invalid session version ($type): '$version'\n - Must be one of: $versionList"
    }

    
    if [catch {
        SmInvoke AgtSessionManager OpenSessionByVersion $type $version $mode
    } result] {
        return -code error $result
    }
    AgtConnect $result
}

#########################################################################
# Name:  AgtCloseSession
# Description:
#   Close the test session with the given session id
#   This will automatically close any connection with this session
proc AgtCloseSession { sessionID } {
    catch {AgtDisconnect $sessionID}
    SmInvoke AgtSessionManager CloseSession $sessionID
}

#########################################################################
# Name:  AgtCloseSessionForce
# Description:
#   Close the test session with the given session id
#   This will automatically close any connection with this session
#   regardless of whether a GUI is attached or a test is running
proc AgtCloseSessionForce { sessionID } {
    catch {AgtDisconnect $sessionID}
    SmInvoke AgtSessionManager CloseSessionForce $sessionID
}

#########################################################################
# Name:  AgtKillSession
# Description:
#   Kill the test session with the given session id
#   This will automatically close any connection with this session
proc AgtKillSession { sessionID } {
    catch {AgtDisconnect $sessionID}
    SmInvoke AgtSessionManager KillSession $sessionID
}

#########################################################################
# Name:  AgtResetSession
# Description:
#   Reset the current test session configuration
#   All saveable objects will restore their configuration to the default state
#   Optionally pass a list of interfaces to reset
proc AgtResetSession { { interfaces {} } } {
   if { [llength $interfaces] > 0 } {
      if [catch {AgtInvoke AgtTestSession ResetInterfaces $interfaces} result] {
         return -code error $result
      }
   } else {
      if [catch {AgtInvoke AgtTestSession ResetSession} result] {
         return -code error $result
      }
   }
}

#########################################################################
# Name:  AgtSaveSession
# Description:
#   Save the current test session to the given file
#   Optionally supply a list of saveable interfaces
proc AgtSaveSession { filename { interfaces {} } } {
   if { [llength $interfaces] > 0 } {
      if [catch {AgtInvoke AgtTestSession SaveInterfaces $filename $interfaces} result] {
         return -code error $result
      }
   } else {
      if [catch {AgtInvoke AgtTestSession SaveSession $filename} result] {
         return -code error $result
      }
   }
}

#########################################################################
# Name:  AgtRestoreSession
# Description:
#   Restore the test session from the given configuration file
#   If there is a current connection, restore that session
#   Else launch a new test session and make it the active connection
#   Returns a session/connection identifier for the session
proc AgtRestoreSession { filename { interfaces {} } } {
   global _AgtActiveConnection

   # If there is no active connection,
   # open a new session; assume it's IpPerformance
   if {[info exists _AgtActiveConnection] == 0} {
      if [catch {
          AgtOpenSession RouterTester900
      } result] {
          return -code error $result
      }
   }

   # There is an active connection now
   # Attempt to restore that session from the supplied filename
   if { [llength $interfaces] > 0 } {
      if [catch {AgtInvoke AgtTestSession RestoreInterfaces $filename $interfaces} result] {
         return -code error $result
      }
   } else {
      if [catch {AgtInvoke AgtTestSession RestoreSession $filename} result] {
         return -code error $result
      }
   }

   # Return the session/connection id
   return $_AgtActiveConnection
}

#########################################################################
# Name:  AgtSetSessionLabel
# Description:
#    Return the description of an open session
proc AgtSetSessionLabel { sessionID sessionLabel } {
    SmInvoke AgtSessionManager SetSessionLabel $sessionID $sessionLabel
}    

#########################################################################
# Name:  AgtGetSessionLabel
# Description:
#    Return the description of an open session
proc AgtGetSessionLabel { sessionID } {
    SmInvoke AgtSessionManager GetSessionLabel $sessionID
}    

#########################################################################
# Name:  AgtGetSessionPid
# Description:
#    Return the process id for an open session
proc AgtGetSessionPid { sessionID } {
    SmInvoke AgtSessionManager GetSessionPid $sessionID
}    

#########################################################################
# Name:  AgtGetSessionType
# Description:
#    Return the description of an open session
proc AgtGetSessionType { sessionID } {
    SmInvoke AgtSessionManager GetSessionType $sessionID
}    

#########################################################################
# Name:  AgtGetSessionVersion
# Description:
#    Return the version of an open session
proc AgtGetSessionVersion { sessionID } {
    SmInvoke AgtSessionManager GetSessionVersion $sessionID
}    

#########################################################################
#  Session Manager Utility Commands                                     #
#  - these are intended for internal use only                           #
#  - clients should use the set of Agt commands associated with         #
#  session management rather than use these functiuons directly         #
#########################################################################

#########################################################################
# Name:  SmConnect
# Description:
#   Connect to the session manager
proc SmConnect { } {
    global _AgtSessionMgrSocket

    # If the connection is already open, return 
    if {[info exists _AgtSessionMgrSocket]} {
        return $_AgtSessionMgrSocket
    }

    # Get the server hostname
    set hostname [AgtGetServerHostname]

    # Get well known server socket port from registry/env
    # REVISIT - For now we will hard code it
    set sessmgr_port 9001

    # Open socket to the session manager 
    if [catch {
        set _AgtSessionMgrSocket [Connect $hostname $sessmgr_port]
    } ] {
        return -code error "Unable to connect to the session manager. Check resource manager service."
    }
    fconfigure $_AgtSessionMgrSocket -blocking 0 -buffering line
}

#########################################################################
# Name:  SmDisconnect
# Description:
#   Disconnect from the session manager
proc SmDisconnect { } {
    global _AgtSessionMgrSocket

    # Ignore any errors when closing the socket
    catch {_AgtRemoveSocketData $_AgtSessionMgrSocket}
    catch {close $_AgtSessionMgrSocket; unset _AgtSessionMgrSocket}
    
    return
}

#########################################################################
# Name:  SmInvoke
# Description:
#   Send a message to the session manager
#   These messages are sent on a different socket to the 
#   other messages (as sent using AgtInvoke)
proc SmInvoke {{interface {}} {method {}} args} {
    global _AgtSessionMgrSocket

    # Check if the session manager socket has been opened
    if {[info exists _AgtSessionMgrSocket] == 0} { 
       if [catch {SmConnect} result] {
          return -code error $result
       }
    }

    # Send the command to the socket
    if [catch {
        # Special eval trick to preserve the list structure ot the
        # variable argument list. See Welch p116.
        eval {
            Invoke $_AgtSessionMgrSocket $interface $method
        } $args
    } result] {
        return -code error $result
    }
    return $result
}

#########################################################################
# Name:  SmGetSessionPort
# Description:
#   Return the listening socket port of an open session
#   This is used by AgtConnect to get the socket port
#   corresponding to a particular session ID
proc SmGetSessionPort { sessionID } {
    SmInvoke AgtSessionManager GetSessionPort $sessionID
}    


#########################################################################
#  General Utility Commands                                             #
#  - these are intended for internal use only                           #
#########################################################################

#########################################################################
# Name:  Connect
# Description:
#   Connect to a particular server port
#   Client passes the hostname and port number
#   The socket is set up for line buffering and no blocking
#   The open socket is returned to the caller
proc Connect { {hostname localhost} {port 9001} } {

    # Open socket to the given port on the given hostname
    if [catch {
        set sock [socket $hostname $port]
        fconfigure $sock -blocking 0 -buffering line
    } ] {
        return -code error "Unable to connect to the server"
    }

    return $sock
}

#########################################################################
# Name:  _AgtInitSocketData
# Description
#    Initialize a Socket data structure
#
proc _AgtInitSocketData { Sock } {
    upvar \#0 _AgtSocketData_$Sock  agtSock

    set agtSock(WInProgress) 0
    set agtSock(RInProgress) 0
    set agtSock(RBuffer)     ""
    set agtSock(RBufferIdx)  0
}

#########################################################################
# Name:  _AgtRemoveSocketData
# Description
#    Remove all structures events possibly associated with a socket
#
proc _AgtRemoveSocketData { Sock } {
    upvar \#0 _AgtSocketData_$Sock agtSock

    if { [info exists agtSock(WTimer)] } {
        after cancel $agtSock(WTimer)
    }
    if { [info exists agtSock(RTimer)] } {
        after cancel $agtSock(RTimer)
    }
    catch {fileevent $Sock readable ""}
    catch {fileevent $Sock writable ""}
    if { [info exists agtSock] } {
        unset agtSock
    }
}

#########################################################################
# Name:  _AgtSetSocketTimeout
# Description
#    Change the timeout duration for socket reads and writes
#
proc _AgtSetSocketTimeout { Secs } {
    global _AgtSocketTimeoutValue

    set _AgtSocketTimeoutValue $Secs

}

#########################################################################
# Name:  _AgtTriggerTimeout
# Description
#    Fire a read or write timeout
#
proc _AgtTriggerTimeout { Notifier } {
    upvar \#0 $Notifier  flag

    if { ![info exists flag] } {
        #
        # Incase the socket has gone away, do nothing
        #
        return
    }
    if { $flag == 0 } {
        #
        # flag has not been modified, we can force a timeout event
        #
        set flag 2
    }
}

#########################################################################
# Name: _AgtSocketReader
# Description:
#   This is the non-blocking read routine for fileevent
#
proc _AgtSocketReader  { Sock } {
    upvar \#0 _AgtSocketData_$Sock agtSock
    global tcl_version
    global DEBUG_SOCKET

    if { [eof $Sock] } {
        #
        # The Socket has closed
        #
        after cancel $agtSock(RTimer)
        fileevent $Sock readable ""
        set agtSock(RNotification) 3
    } else {
        set tmp_buf [read $Sock]
        #
        # Append new data to the buffer
        #
        append agtSock(RBuffer) $tmp_buf
        #
        # Search for EOL
        #
        if { $tcl_version < 8.2 } {
            set crLocation \
                [string first "\n" $agtSock(RBuffer)]
        } else {
            #
            # Version >= 8.2 supports a startindex, use this parameter
            # for performance
            #
            set crLocation \
                [string first "\n" $agtSock(RBuffer) $agtSock(RBufferIdx)]
        }
        if { $crLocation != -1 } {
            # 
            # Found EOL
            #
            after cancel $agtSock(RTimer)
            fileevent $Sock readable ""
            #
            # Extract the EOL delimited data and remove from buffer
            #
            set agtSock(RData) \
                [string range $agtSock(RBuffer) 0 $crLocation]
            set agtSock(RBuffer) \
                [string range $agtSock(RBuffer) [incr crLocation] end]
            set agtSock(RBufferIdx) 0
            # DEBUG
            if {[info exists DEBUG_SOCKET]} {
                puts "> \\n found on read"
            }
 
            set agtSock(RNotification) 1
        } else {
            # 
            # Need to get more data from the socket
            # Update the buffer index and fall through
            #
            # DEBUG
            if {[info exists DEBUG_SOCKET]} {
                puts "> partial read performed, no \\n found yet"
            }
            set agtSock(RBufferIdx) [string length $agtSock(RBuffer)]
        }
    }
}

#########################################################################
# Name:  _AgtReaderWrapper
# Description:
#   This socket reader uses non-blocking I/O
#
proc _AgtReadWrapper { Sock  Output } {
    upvar \#0 _AgtSocketData_$Sock  agtSock
    upvar $Output result
    global _AgtSocketTimeoutValue

    if { [info exists _AgtSocketTimeoutValue] } {
        set toSec $_AgtSocketTimeoutValue
    } else {
    if { [info exists env(AGTSOCKETTIMEOUT)] } {
        set toSec $env(AGTSOCKETTIMEOUT)
    } else {
            set toSec 900  ;# 15 minutes (full capture save takes ~10 mins)
    }
    }

    if { ![info exists agtSock] } {
        _AgtInitSocketData $Sock
    }

    if { $agtSock(RInProgress) == 1 } {
        #
        # A Read operation is already in progress
        #
        set result ""
        return -code -1 "Read operation already in progress"
    }
    #
    # Prepare for a read operation
    #
    set agtSock(RInProgress) 1
    set agtSock(RData) ""
    set agtSock(RNotification) 0
    #
    # Start a read timer
    #
    set agtSock(RTimer) [after [expr $toSec * 1000] _AgtTriggerTimeout \
        [subst _AgtSocketData_$Sock](RNotification)]

    fileevent $Sock readable [list _AgtSocketReader $Sock]

    vwait [subst _AgtSocketData_$Sock](RNotification)
    set readResult $agtSock(RNotification)

    switch -exact $readResult {
        1 {   
            #
            # Completed read
            #
            set result $agtSock(RData) 
            set agtSock(RInProgress) 0

            return ""
        }
        2 {   
            #
            # Timeout occured, Fatal error
            #
            _AgtRemoveSocketData $Sock

            return -code error "\nConnection has timed out on read operation" 
        }
        3   {
            #
            # Socket has closed on us, Fatal error
            #
            _AgtRemoveSocketData $Sock

            return -code error \
                "\nConnection has closed unexpectedly on read operation"
        }
        default {
            return -code error \
                "\nConnection has unknown state on read operation"
        }
    }
}

#########################################################################
# Name: _AgtSocketWriter
# Description:
#   This is a non-blocking write routine for fileevent
#   Output will be buffered by Tcl and Opsys
#
proc _AgtSocketWriter  { Sock Data } {
    upvar \#0 _AgtSocketData_$Sock agtSock

    after cancel $agtSock(WTimer)

    if { [eof $Sock] } {
        #
        # The Socket has closed
        #
        set agtSock(WNotification) 3 
    } else {
        #
        # Complete write for the puts is guaranteed as Tcl will buffer
        # the data for us.  No need to address partial writes.
        #
        puts $Sock $Data

        set agtSock(WNotification) 1 
    }

    fileevent $Sock writable ""
}

#########################################################################
# Name:  _AgtWriteWrapper
# Description:
#   This socket writer used non-blocking I/O
#
proc _AgtWriteWrapper { Sock  Data } {
    upvar \#0 _AgtSocketData_$Sock  agtSock
    global _AgtSocketTimeoutValue

    if { [info exists _AgtSocketTimeoutValue] } {
        set toSec $_AgtSocketTimeoutValue
    } elseif { [info exists env(AGTSOCKETTIMEOUT)] } {
        set toSec $env(AGTSOCKETTIMEOUT)
    } else {
        set toSec 120
    }
    
    if { ![info exists agtSock] } {
        _AgtInitSocketData $Sock
    }

    if { $agtSock(WInProgress) == 1 } {
        #
        # A Write operation is already in progress
        #
        return -code -1 "Write operation already in progress"
    }
    #
    # Prepare for a write operation
    #
    set agtSock(WInProgress) 1
    set agtSock(WNotification) 0
    #
    # Start a write timer
    #
    set agtSock(WTimer) [after [expr $toSec * 1000] _AgtTriggerTimeout \
        [subst _AgtSocketData_$Sock](WNotification)]

    fileevent $Sock writable [list _AgtSocketWriter $Sock $Data]

    vwait [subst _AgtSocketData_$Sock](WNotification)
    set writeResult $agtSock(WNotification)

    switch -exact $writeResult {
        1 {   
            #
            # Complete write
            #
            set agtSock(WInProgress) 0

            return ""
        }
        2 {   
            #
            # Timeout occured, Fatal error
            #
            _AgtRemoveSocketData $Sock

            return -code error "\nConnection has timed out on write operation" 
        }
        3   {
            #
            # Socket has closed on us, Fatal error
            #
            _AgtRemoveSocketData $Sock

            return -code error \
                "\nConnection has closed unexpectedly on write operation"
    }
    default {
        return -code error \
            "\nConnection has unknown state on write operation"
    }
    }
}

#########################################################################
# Name:  Invoke
# Description:
#   Send an invoke message on the given socket
#   Commands are sent in the form
#     "invoke $interface $method $args"
#   Results are returned over the socket in the form
#     "return_code out_args"
#   This method strips the return code from the result
#   If the return code is zero, the remainder of the result
#   contains the output arguments and are returned to the caller
#   If the return code is greater than zero, an error is raised 
#   and the remainder of the result is returned as an error string
proc Invoke {sock interface method args} {
    global DEBUG_SOCKET
    global _AgtSessionMgrSocket

    # DEBUG
    if {[info exists DEBUG_SOCKET]} {
        puts "< invoke $interface $method $args"
    }

    # Send the command to the socket
    set catch_status [catch \
        { _AgtWriteWrapper $sock "invoke $interface $method $args" } result]
    if { $catch_status != 0 } {
        set errmsg $result
        if { $catch_status > 0 } {
            catch {
                if { $sock == $_AgtSessionMgrSocket} {
                    set errmsg "Check resource manager service. $errmsg" 
                    SmDisconnect
                } else {
                    AgtDisconnect
                }
            }
            return -code error \
               "Unable to obtain response. Disconnecting... $errmsg"
        } else {
            return -code error \
                "Unable to obtain response. $errmsg"
        }
    }

    if { [string length $result] != 0 } {
        return $result
    }

    # Fetch the return parameters
    set catch_status [catch { _AgtReadWrapper $sock output } result]
    if { $catch_status != 0 } {
    set errmsg $result
        if { $catch_status > 0 } {
            catch {
                if { $sock == $_AgtSessionMgrSocket} {
                    set errmsg "Check resource manager service. $errmsg" 
                    SmDisconnect
                } else {
                    AgtDisconnect
                }
            }
            return -code error \
                "Unable to obtain response. Disconnecting... $errmsg"
        } else {
            return -code error \
                "Unable to obtain response. $errmsg"
        }
    }

    # DEBUG
    if {[info exists DEBUG_SOCKET]} {
        puts "> $output"
    }

    # Process the return parameters
    # Read the error code from the start of the string
    set code 0
    if {[scan $output "%i" code] == 0} {
        set errmsg "" 
        catch {
            if {$sock == $_AgtSessionMgrSocket} {
                set errmsg "Check resource manager service." 
                SmDisconnect
            } else {
                AgtDisconnect
            }
        }
        return -code error \
            "Invalid response received from server. Disconnecting... $errmsg"
    }

    # Trim the error code and leading space from the front of the output
    set trimchars [format "%i" $code]
    set out [string trimleft $output $trimchars]
    set out [string trimleft $out]
    if {$code > 0} {
        return -code error -errorcode $code \
        "Error: $out while executing command: Invoke $interface $method $args"
    }

    # Return the results
    # Check if the output is a list of one item
    # and if so strip off the curly braces
    # This should not have any effect on single non-list parameters
    # It will mean that string parameters with embedded spaces will 
    # not be supported
    if {[llength $out] == 1} {
        return [lindex $out 0]
    }
    return $out
}

#########################################################################
# Name:  Send
# Description:
#   Send an arbitrary command to the server
#   Command and return format is the same as the Invoke command
proc Send {sock cmd} {
    global DEBUG_SOCKET

    # DEBUG
    if {[info exists DEBUG_SOCKET]} {
        puts "< $cmd"
    }

    # Send the command to the socket
    if [catch {
        _AgtWriteWrapper $sock "$cmd"
    } result] {
        return -code error "Unable to send command to server--$result"
    }

    # Fetch the return parameters
    if [catch {
        _AgtReadWrapper $sock output
    } result] {
        return -code error "Unable to obtain results from server--$result"
    }

    # DEBUG
    if {[info exists DEBUG_SOCKET]} {
        puts "> $output"
    }

    # Process the return parameters
    # Strip off the error code
    scan $output "%i" code
    set trimchars [format "%i " $code]
    set out [string trimleft $output $trimchars]
    if {$code > 0} {
        return -code error -errorcode $code $out
    } 

    # Return the results
    return $out
}

#########################################################################
# Name:  AgtFormatTime
# Description:
#    Take system time as the number of seconds since epoch and return
#    a formatted string in the form of:
#       DayName MonthName DayOfMonth Hour:Minute:Second YearWithCentury
proc AgtFormatTime { systemTimeSec } {
    # check for overflow or negative value
    if { $systemTimeSec < 0 } {
       return -code error "Error:  overflow or negative value\nwhile executing AgtFormatTime $systemTimeSec"
    }

    # Format time since epoch
    set formattedTime [clock format $systemTimeSec -format "%a %b %d %H:%M:%S %Y"]

    return $formattedTime
}

##########################################################################
# Name:  AgtLoadTclExtension
# Description:
#   Load the named dll into the current Tcl shell for the named
#   application and version. If no version is provided then assume
#   the latest installed version of the application
proc AgtLoadTclExtension { type dllname {version "latest"} } {

    if { $type == "Platform" } {
        # version parameter gets ignored
    } else {
        # Check for valid session type
        set sessionTypeList [AgtListSessionTypes]
        if { [lsearch -exact $sessionTypeList $type] == -1 } {
            error "AgtLoadTclExtension\n - Invalid session type: '$type'\n - Must be one of: $sessionTypeList"
        }

        if { $version == "latest" } {
            # If connected to a session, use that version if the session type matches
            # otherwise use the latest version of the specified type
            if [info exists _AgtActiveConnection] {
                set currentType [AgtGetSessionType _AgtActiveConnection]
                if { $currentType == $type } {
                    set version [AgtGetVersion $type]
                }
            }
            if { $version == "latest" } {   
                # Not currently connected to the specified session type
                set version [lindex [AgtListSessionVersions $type] end] ;# get the latest version
            }
        }

        # Check for valid version
        set versionList [AgtListSessionVersions $type]
        if { [lsearch -exact $versionList $version] == -1 } {
            error "AgtLoadTclExtension\n - Invalid session version ($type): '$version'\n - Must be one of: $versionList"
        }
    }

    # Get App/Version bin directory
    set rootDir [AgtInvoke AgtSessionManager GetSessionStringAttribute $type $version BinDirectory]

    # Save the current dir, swap to the bin dir, load the dll, initialise it and then swap back to the current dir
    set currentDir [pwd]
    cd $rootDir
    load $dllname
    cd $currentDir
}
