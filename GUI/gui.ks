set terminal:charheight to 20.
set terminal:height to 20.
set terminal:width to 42.
set config:obeyhideui to false.

// draw the GUI

set lastErrorTime to kuniverse:realtime.
set lastProgErrorTime to kuniverse:realtime.
set lastCompActyTime to kuniverse:realtime.
set currentFlashTime to aliveTime.
set currentTypeTime to aliveTime.

set flash to true.
set UPDATE_ONCE to false.
set GUI_MEM to list().

declare function agcGui {
    agcStatic().
    dataLights().
    special_functions(). // for all things VN related.
    REG_DISPLAYS(globalRegvals[0], globalRegvals[1], globalRegvals[2]).
    // this handles the itty bitty lights and etc
}

declare function dataLights {
    // IMU_GC().
    // ATT_LIGHT().
    // restartLightLogic(RESTARTBIT).
    UPLK_ACTY().
    COMP_ACTY().
    OPR_ERR().
    PROG().
    STBY().
    VN_INPUT().
    VN_FLASH().
}


declare local function agcStatic { // Static items in the display.
                                                print "┏━━━━━━━━━━━━━━━━━┓ " at (0.5,4).                                                                                                print "┏━━━━━━━━━━━━━━━━━━┓" at (20,4).                                          
    print "┃" at (.5, 5).                                                                                   print "┃" at (17.5, 5).   print "┃" at (20.5, 5).                           print " " at (30,5). print "PROG" at (32,5).                                          print "┃" at (39, 5).                 
    print "┃" at (.5, 6).                                                                                   print "┃" at (17.5, 6).   print "┃" at (20.5, 6).                           print " " at (30,6).                                                                  print "┃" at (39, 6).             
    print "┃" at (.5, 7).                                                                                   print "┃" at (17.5, 7).   print "┃" at (20.5, 7).                           print "VERB" at (22,8). print " " at (30,8). print "NOUN" at (32,8).                  print "┃" at (39, 7).             
    print "┃" at (.5, 8).                                                                                   print "┃" at (17.5, 8).   print "┃" at (20.5, 8).                                                                                                                 print "┃" at (39, 8).             
    print "┃" at (.5, 9).                                                                                   print "┃" at (17.5, 9).   print "┃" at (20.5, 9).                           print "───────────────" at (22,10).                                                   print "┃" at (39, 9).             
    print "┃" at (.5, 10).                                                                                  print "┃" at (17.5, 10).  print "┃" at (20.5, 10).                                                                                                                print "┃" at (39, 10).            
    print "┃" at (.5, 11).                                                                                  print "┃" at (17.5, 11).  print "┃" at (20.5, 11).                          print "───────────────" at (22,12).                                                   print "┃" at (39, 11).            
    print "┃" at (.5, 12).                      print "┗━━━━━━━━━━━━━━━━━┛" at (.5,16).                     print "┃" at (17.5, 12).  print "┃" at (20.5, 12).                                                                                                                print "┃" at (39, 12).
    print "┃" at (.5, 13).                                                                                  print "┃" at (17.5, 13).  print "┃" at (20.5, 13).                          print "───────────────" at (22,14).                                                   print "┃" at (39, 13).
    print "┃" at (.5, 14).                                                                                  print "┃" at (17.5, 14).  print "┃" at (20.5, 14).                                                                                                                print "┃" at (39, 14).
    print "┃" at (.5, 15).                                                                                  print "┃" at (17.5, 15).  print "┃" at (20.5, 15).                          print "┗━━━━━━━━━━━━━━━━━━┛" at (20,16).                                              print "┃" at (39, 15).

    print " " at (8,5).   print "TEMP" at (10,5).                                                                         
    print " " at (8,6).                                                                                      print currentProgram + " " at (32, 6).          
    print " " at (8,8).                              
    print "   " at (2,9).      print " " at (8,9).
    print " " at (8,11).                                                            
    print "" at (8,13).                                                          
    print "" at (8,15).   print "TRACKER" at (10,15).                                                       

}

declare function REG_DISPLAYS {
    parameter R1, R2, R3.
    set REGVALS to DIGSYN(R1, R2, R3).

    print REGVALS[0]:padleft(7) at (31,11).
    print REGVALS[1]:padleft(7) at (31,13).
    print REGVALS[2]:padleft(7) at (31,15).
}

declare local function DIGSYN {
    parameter R1 to "".
    parameter R2 to "".
    parameter R3 to "".

    local R1O to "".
    local R2O to "".
    local R3O to "".

    if not inputInterrupt {
        // RX Input
        local R1I to choose R1:tostring() if R1 <> "" else "0".
        local R2I to choose R2:tostring() if R2 <> "" else "0".
        local R3I to choose R3:tostring() if R3 <> "" else "0".

        // RX Sign
        set R1S to choose "+" if R1I:tonumber() >= 0 else "-".  
        set R1S to choose "+" if R1I:tonumber() >= 0 else "-".  
        set R1S to choose "+" if R1I:tonumber() >= 0 else "-".  
        set R2S to choose "+" if R2I:tonumber() >= 0 else "-".  
        set R2S to choose "+" if R2I:tonumber() >= 0 else "-".  
        set R2S to choose "+" if R2I:tonumber() >= 0 else "-".  
        set R3S to choose "+" if R3I:tonumber() >= 0 else "-".
        
        // RX Negative
        set R1N to choose R1I:remove(0, 1) if R1S = "-" else R1I.
        set R2N to choose R2I:remove(0, 1) if R2S = "-" else R2I.
        set R3N to choose R3I:remove(0, 1) if R3S = "-" else R3I.
    
        // RX Output
        set R1O to choose "" if R1N:length > 5 else R1S + R1N:padleft(5):replace(" ", "0"). 
        set R2O to choose "" if R2N:length > 5 else R2S + R2N:padleft(5):replace(" ", "0"). 
        set R3O to choose "" if R3N:length > 5 else R3S + R3N:padleft(5):replace(" ", "0"). 
    }
    return list(R1O, R2O, R3O).
}

declare local function UPLK_ACTY {
    if homeConnection:isconnected { //check for uplink status
        print "UPLINK" at (2,5).
        print "ACTY" at (2,6).  
    }
    else {
        print "      " at (2,5).
        print "    " at (2,6).         
    }
}

declare function COMP_ACTY {
    if CMPACTY {
        if kuniverse:realtime - lastCompActyTime >= 0.1 {
            toggle CMPACTY.
        }
        print "COMP" at (22,5).
        print "ACTY" at (22,6).
    }
    else {
        print "    " at (22,5).
        print "    " at (22,6).    
        set lastCompActyTime to kuniverse:realtime.   
    }
}

declare local function OPR_ERR {
    if OEBIT {
        print "OPR ERR" at (2,15).
        set OEBIT to abs(kuniverse:realtime - lastErrorTime) <= 1.5.
        // this should ensure OP_ERR light does not stay on
    }
    else {
        print "       " at (2,15).
        set lastErrorTime to kuniverse:realtime.
    }
}

declare local function PROG {
    if PROGBIT {
        print "PROG" at (10,11).
        set PROGBIT to abs(kuniverse:realtime - lastProgErrorTime) <= 1.5. 
    } else {
        print "    " at (10,11).
        set lastProgErrorTime to kuniverse:realtime.
    }
}

declare local function STBY {
    if IDLEBIT {
        print "STBY" at (2,11).
    }
    else {
        print "    " at (2,11).
    }
}

declare function VN_INPUT { 
    if not inputInterrupt {
        print currentVerb:tostring:padright(2) at (22, 9). 
        print currentNoun:tostring:padright(2) at (32, 9).
    } else {
        print inpStr:padright(2) at (xc, yc).
    }
}

declare local function VN_FLASH { 
    // VN-FLASH is only supposed to happen
    // when we need astronaut input(PRO, enter data, etc..)
    // flash at 1.5Hz --> 0.33 sec I/O
    if NEED_ASTRO_INPUT and not inputInterrupt {
        if abs(currentFlashTime - aliveTime) > 0.33 {
            toggle flash.
            set currentFlashTime to aliveTime.
        }
        if flash {
            print currentVerb:tostring:padright(2) at (22, 9).
            print currentNoun:tostring:padright(2) at (32, 9).
        } else {
            print "  " at (22, 9).
            print "  " at (32, 9).
        }
    }
}