; Simple menu system for demonstrating custom UI hooks
; Provides a basic main menu with navigation to a sub menu

mainMenu:
    call getLCDLock
    call getKeypadLock
    call allocScreenBuffer
    call clearBuffer
    ld de, 0
    ld b, 0
    ld hl, menu_main
    rst 0x20
    .dw drawStr
    rst 0x20
    .dw fastCopy
.mainLoop:
    call waitKey
    cp k1
    jr z, subMenu
    cp k2
    jr z, exitMenu
    jr .mainLoop

subMenu:
    call clearBuffer
    ld de, 0
    ld b, 0
    ld hl, menu_sub
    rst 0x20
    .dw drawStr
    rst 0x20
    .dw fastCopy
.subLoop:
    call waitKey
    cp k0
    jr z, redrawMain
    jr .subLoop

redrawMain:
    call clearBuffer
    ld de, 0
    ld b, 0
    ld hl, menu_main
    rst 0x20
    .dw drawStr
    rst 0x20
    .dw fastCopy
    jr .mainLoop

exitMenu:
    call freeScreenBuffer
    call flushkeys
    xor a
    ld (hwLockLCD), a
    ld (hwLockKeypad), a
    ret

menu_main:
    .db "Main Menu\n1) Sub Menu\n2) Continue", 0

menu_sub:
    .db "Sub Menu\n0) Back", 0

