INCLUDE Irvine32.inc

; External Windows API for playing sounds
INCLUDELIB winmm.lib
PlaySoundA PROTO, :DWORD, :DWORD, :DWORD
mciSendStringA PROTO, :DWORD, :DWORD, :DWORD, :DWORD

SND_FILENAME EQU 00020000h
SND_ASYNC EQU 00000001h
SND_LOOP EQU 00000008h
SND_SYNC EQU 00000000h

; ---- Centering constants ----
TITLE_COL EQU 31
ROLL_COL EQU 33
MENU1_COL EQU 33
MENU2_COL EQU 31
MENU3_COL EQU 32
MENU4_COL EQU 36
MENU5_COL EQU 34
PROMPT_COL EQU 29
PAUSE_COL EQU 37
PAUSEOPT_COL EQU 25
INVALID_COL EQU 27
HSCORE_COL EQU 21
INSTR_COL EQU 20

; Platform constants
MAX_PLATFORMS EQU 5
MAX_CLOUDS EQU 4
MAX_PIPES EQU 3
MAX_QBLOCKS EQU 5

; Enemy constants
MAX_ENEMIES EQU 4

; Boss level constants
MAX_FIRE_OBSTACLES EQU 4
MAX_BOSS_PLATFORMS EQU 3
MAX_BOWSER_FIREBALLS EQU 3
MAX_BRIDGE_GAPS EQU 4
MAX_BOSS_COINS EQU 7
MAX_BOSS_QBLOCKS EQU 4

; Death and secret area constants
DEATH_Y EQU 28
BOSS_LAVA_Y EQU 24
SECRET_AREA EQU 0
NORMAL_AREA EQU 1
BOSS_AREA EQU 2

; *** PORTAL CONSTANTS ***
MAX_PORTAL_PAIRS EQU 3

.data
titleMsg BYTE "SUPER MARIO BROS",0
rollMsg BYTE "Roll No: 0601",0
menu1 BYTE "1. Start Game",0
menu2 BYTE "2. High Scores",0
menu3 BYTE "3. Instructions",0
menu4 BYTE "4. Boss Level",0
menu5 BYTE "5. Exit",0
inputPrompt BYTE "Select option (1-5): ",0
invalidMsg BYTE "Invalid choice. Try again.",0
highScoresMsg BYTE "HIGH SCORE",0
instructionsMsg BYTE "Use WASD to move. W to Jump. P to Pause, X to Exit. DOWN (S) to enter pipe.",0
pauseMsg BYTE "PAUSED",0
pauseOptionsMsg BYTE "Press R to Resume or E to Exit",0

ground BYTE "????????????????????????????????????????????????????????????????????????",0
topDecor BYTE "================================================================================",0
bottomGround BYTE "????????????????????????????????????????????????????????????????????????????????????",0
pressAnyKey BYTE "Press any key to continue...",0

marioLabel BYTE "MARIO",0
coinsLabel BYTE "COINS",0
worldLabel BYTE "WORLD 1-1",0
bossWorldLabel BYTE "BOSS LEVEL",0
timeLabel BYTE "TIME",0
livesLabel BYTE "MARIO",0
livesX BYTE "x",0
timeUpMsg BYTE "TIME UP!",0

platformStr BYTE "================",0
bossPlatformStr BYTE "##########",0
bridgeStr BYTE "====",0

; Box frame
boxTop BYTE    "+---------------------------+",0
boxMid1 BYTE   "|                           |",0
boxMid2 BYTE   "|                           |",0
boxMid3 BYTE   "|                           |",0
boxBottom BYTE "+---------------------------+",0

devBy BYTE "Developed By:",0
ahmedName BYTE "  AHMED CHEEMA  ",0
roll0601 BYTE "  Roll No: 0601  ",0
clearPrompt BYTE "                              ",0




; ---- Cloud sprites ----
cloudStr1 BYTE "  ___ ",0
cloudStr2 BYTE "  ( ) ",0
cloudStr3 BYTE "(_____)",0

; ---- Pipe sprites ----
pipeTop BYTE " _____ ",0
pipeTopMid BYTE "| |",0
pipeBody BYTE "| | | |",0

; ---- Question block ----
qBlockStr BYTE "[?]",0
emptyBlockStr BYTE "[ ]",0

; ---- Enemy sprite (Goomba) ----
goombaSprite BYTE "G",0

; ---- Boss level sprites ----
bowserSprite BYTE "B",0
fireballSprite BYTE "*",0
lavaStr BYTE "^^^^",0
axeSprite BYTE "X",0
castleWall BYTE "####",0
fireObstacleStr BYTE "o",0

; ---- Secret area messages ----
secretMsg BYTE "SECRET UNDERGROUND AREA!",0
bonusCoinsMsg BYTE "Collect Bonus Coins! Stand on EXIT pipe and press S.",0
deathMsg BYTE "MARIO FELL!",0
gameOverMsg BYTE "GAME OVER",0
bossUnlockedMsg BYTE "BOSS LEVEL UNLOCKED! Press any key...",0
youWinMsg BYTE "YOU WIN!",0
bossDefeatedMsg BYTE "BOWSER DEFEATED!",0
lavaDeathMsg BYTE "BURNED IN LAVA!",0

; *** PORTAL MESSAGES ***
teleportMsg BYTE "TELEPORTING...",0

; ---- Player name and high score ----
playerName BYTE 50 DUP(0)
playerNamePrompt BYTE "Enter your name (max 20 characters): ",0
nameLabel BYTE "Player: ",0
highScoreFile BYTE "scores.txt",0
fileHandle DWORD ?
scoreBuffer BYTE 200 DUP(0)
finalScoreMsg BYTE "Score: ",0
noScoresMsg BYTE "No scores yet. Play to set a high score!",0

; Sound file paths
backgroundSound BYTE "background.wav",0
coinSound BYTE "coin.wav",0
jumpSound BYTE "jump.wav",0

; MCI command strings
mciOpenBg BYTE "open background.wav type waveaudio alias bg",0
mciPlayBg BYTE "play bg repeat",0
mciCloseBg BYTE "close bg",0
mciOpenCoin BYTE "open coin.wav type waveaudio alias coin",0
mciPlayCoin BYTE "play coin from 0",0
mciCloseCoin BYTE "close coin",0
mciOpenJump BYTE "open jump.wav type waveaudio alias jump",0
mciPlayJump BYTE "play jump from 0",0
mciCloseJump BYTE "close jump",0
mciStopAll BYTE "close all",0
mciReturnString BYTE 128 DUP(0)

QBLOCK_WIDTH EQU 3
BOSS_COINS_NEEDED EQU 5

score BYTE 0
coins BYTE 0
lives BYTE 5
time WORD 180
timerCounter WORD 0
xPos BYTE 20
yPos BYTE 23
xCoinPos BYTE ?
yCoinPos BYTE ?
inputChar BYTE ?
userChoice BYTE ?
moveDir BYTE 0
currentArea BYTE NORMAL_AREA
bossUnlocked BYTE 0
currentHighScore WORD 0
tempScore WORD 0

; Platform data
platformX BYTE 10, 40, 5, 15, 60
platformY BYTE 15, 12, 18, 10, 14
platformW BYTE 16, 16, 16, 20, 16

; Cloud positions
cloudX BYTE 10, 50, 25, 65
cloudY BYTE 4, 5, 7, 6

; Pipe data
pipeX BYTE 35, 60, 75
pipeH BYTE 4, 5, 3
pipeCanEnter BYTE 1, 0, 0
PIPE_WIDTH EQU 7

; Secret area exit pipe
secretExitX BYTE 65
secretExitH BYTE 4

; Secret area coins
secretCoinX BYTE 15, 20, 25, 30, 35, 40, 45, 50
secretCoinY BYTE 22, 22, 22, 22, 22, 22, 22, 22
secretCoinCollected BYTE 0, 0, 0, 0, 0, 0, 0, 0

; Question block data
qBlockX BYTE 25, 30, 35, 50, 55
qBlockY BYTE 18, 18, 18, 16, 16
qBlockHit BYTE 0, 0, 0, 0, 0

; *** BOSS LEVEL QUESTION BLOCKS ***
bossQBlockX BYTE 25, 40, 55, 68
bossQBlockY BYTE 10, 8, 12, 9
bossQBlockHit BYTE 0, 0, 0, 0

; Enemy data
enemyActive BYTE 1, 1, 1, 1
enemyX BYTE 15, 50, 65, 25
enemyY BYTE 23, 23, 23, 23
enemyDir BYTE 0, 1, 0, 1
enemyLeftBound BYTE 5, 43, 55, 15
enemyRightBound BYTE 32, 58, 73, 40

; Boss level data
bossPlatformX BYTE 20, 45, 65
bossPlatformY BYTE 18, 15, 18
bossPlatformW BYTE 10, 10, 10

; Fire obstacles
fireObstacleX BYTE 15, 35, 55, 70
fireObstacleY BYTE 20, 18, 20, 19
fireObstacleActive BYTE 1, 1, 1, 1
fireObstaclePhase BYTE 0, 1, 2, 3

; Bowser data
bowserActive BYTE 1
bowserX BYTE 70
bowserY BYTE 23
bowserDir BYTE 0
bowserHealth BYTE 1
bowserLeftBound BYTE 50
bowserRightBound BYTE 75
bowserFireballCounter BYTE 0

; Bowser fireballs
bowserFireballActive BYTE 0, 0, 0
bowserFireballX BYTE 0, 0, 0
bowserFireballY BYTE 0, 0, 0
bowserFireballDir BYTE 0, 0, 0

; Axe position
axeX BYTE 78
axeY BYTE 23

; Lava positions
lavaY BYTE 24

; Bridge gap data
bridgeGapX BYTE 15, 30, 45, 60
bridgeGapW BYTE 3, 4, 3, 5

; Boss level coins
bossCoinX BYTE 20, 35, 50, 65, 25, 40, 55
bossCoinY BYTE 15, 12, 15, 10, 20, 18, 13
bossCoinCollected BYTE 0, 0, 0, 0, 0, 0, 0

; *** PORTAL DATA (EASY ACCESSIBLE POSITIONS) ***
portalBlueX BYTE 8, 30, 7
portalBlueY BYTE 23, 23, 18
portalOrangeX BYTE 42, 62, 17
portalOrangeY BYTE 12, 14, 10

; *** BOSS LEVEL PORTALS (EASY ACCESS ON BRIDGE/PLATFORMS) ***
bossPortalBlueX BYTE 12, 35, 58
bossPortalBlueY BYTE 23, 23, 23
bossPortalOrangeX BYTE 22, 47, 67
bossPortalOrangeY BYTE 17, 14, 17
portalCooldown BYTE 0

onPlatform BYTE 0
isInAir BYTE 1
frameCounter BYTE 0
bossFrameCounter BYTE 0

.code

;============ SOUND PROCEDURES ============

PlayBackgroundMusic PROC
    push eax
    push ebx
    push ecx
    push edx
    
    INVOKE PlaySoundA, OFFSET backgroundSound, 0, SND_FILENAME OR SND_ASYNC OR SND_LOOP
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
PlayBackgroundMusic ENDP

PlayCoinSound PROC
    push eax
    push ebx
    push ecx
    push edx
    
    INVOKE mciSendStringA, OFFSET mciCloseCoin, 0, 0, 0
    INVOKE mciSendStringA, OFFSET mciOpenCoin, 0, 0, 0
    INVOKE mciSendStringA, OFFSET mciPlayCoin, 0, 0, 0
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
PlayCoinSound ENDP

PlayJumpSound PROC
    push eax
    push ebx
    push ecx
    push edx
    
    INVOKE mciSendStringA, OFFSET mciCloseJump, 0, 0, 0
    INVOKE mciSendStringA, OFFSET mciOpenJump, 0, 0, 0
    INVOKE mciSendStringA, OFFSET mciPlayJump, 0, 0, 0
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
PlayJumpSound ENDP

StopAllSounds PROC
    push eax
    push ebx
    push ecx
    push edx
    
    INVOKE mciSendStringA, OFFSET mciStopAll, 0, 0, 0
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
StopAllSounds ENDP

;============ PORTAL PROCEDURES (BIDIRECTIONAL - WORKS IN BOTH LEVELS) ============

DrawPortals PROC
    push eax
    push ebx
    push ecx
    push edx
    
    cmp currentArea, NORMAL_AREA
    je DrawNormalPortals
    cmp currentArea, BOSS_AREA
    je DrawBossPortals
    jmp NoPortalsDraw
    
DrawNormalPortals:
    ; Draw Blue Portals (Cyan color) - Entry points
    mov eax, cyan + (blue * 16)
    call SetTextColor
    
    mov ecx, MAX_PORTAL_PAIRS
    mov ebx, 0
    
DrawNormalBlueLoop:
    mov dl, portalBlueX[ebx]
    mov dh, portalBlueY[ebx]
    call Gotoxy
    mov al, 'O'
    call WriteChar
    inc ebx
    dec ecx
    cmp ecx, 0
    jne DrawNormalBlueLoop
    
    ; Draw Orange Portals (Light Red color) - Destination points
    mov eax, lightRed + (blue * 16)
    call SetTextColor
    
    mov ecx, MAX_PORTAL_PAIRS
    mov ebx, 0
    
DrawNormalOrangeLoop:
    mov dl, portalOrangeX[ebx]
    mov dh, portalOrangeY[ebx]
    call Gotoxy
    mov al, 'O'
    call WriteChar
    inc ebx
    dec ecx
    cmp ecx, 0
    jne DrawNormalOrangeLoop
    jmp NoPortalsDraw
    
DrawBossPortals:
    ; *** BOSS LEVEL PORTALS ***
    mov eax, cyan + (blue * 16)
    call SetTextColor
    
    mov ecx, MAX_PORTAL_PAIRS
    mov ebx, 0
    
DrawBossBlueLoop:
    mov dl, bossPortalBlueX[ebx]
    mov dh, bossPortalBlueY[ebx]
    call Gotoxy
    mov al, 'O'
    call WriteChar
    inc ebx
    dec ecx
    cmp ecx, 0
    jne DrawBossBlueLoop
    
    mov eax, lightRed + (blue * 16)
    call SetTextColor
    
    mov ecx, MAX_PORTAL_PAIRS
    mov ebx, 0
    
DrawBossOrangeLoop:
    mov dl, bossPortalOrangeX[ebx]
    mov dh, bossPortalOrangeY[ebx]
    call Gotoxy
    mov al, 'O'
    call WriteChar
    inc ebx
    dec ecx
    cmp ecx, 0
    jne DrawBossOrangeLoop
    
NoPortalsDraw:
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
DrawPortals ENDP

ShowTeleportAnimation PROC
    push eax
    push edx
    
    mov dl, xPos
    mov dh, yPos
    
    ; Frame 1: *
    call Gotoxy
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov al, '*'
    call WriteChar
    mov eax, 100
    call Delay
    
    ; Frame 2: +
    call Gotoxy
    mov eax, white + (blue * 16)
    call SetTextColor
    mov al, '+'
    call WriteChar
    mov eax, 100
    call Delay
    
    ; Frame 3: @
    call Gotoxy
    mov eax, cyan + (blue * 16)
    call SetTextColor
    mov al, '@'
    call WriteChar
    mov eax, 100
    call Delay
    
    ; Clear
    call Gotoxy
    mov al, ' '
    call WriteChar
    
    ; Show message
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, 30
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET teleportMsg
    call WriteString
    mov eax, 300
    call Delay
    
    ; Clear message
    mov dl, 30
    mov dh, 10
    call Gotoxy
    mov ecx, 15
ClearMsg:
    mov al, ' '
    call WriteChar
    loop ClearMsg
    
    pop edx
    pop eax
    ret
ShowTeleportAnimation ENDP

; *** BIDIRECTIONAL PORTAL ACTIVATION (WORKS IN BOTH NORMAL & BOSS LEVELS) ***
CheckPortalTeleport PROC
    push eax
    push ebx
    push ecx
    push edx
    push esi
    
    cmp currentArea, NORMAL_AREA
    je CheckNormalPortals
    cmp currentArea, BOSS_AREA
    je CheckBossPortals
    jmp NoPortalCheck
    
CheckNormalPortals:
    ; Check cooldown
    cmp portalCooldown, 0
    jne DecrementCooldown
    
    ; Check each portal pair
    mov ecx, MAX_PORTAL_PAIRS
    mov ebx, 0
    
CheckNormalBluePortals:
    ; Check 2-tile radius around portal
    mov al, xPos
    mov dl, portalBlueX[ebx]
    
    sub al, dl
    jns XPosBlue
    neg al
XPosBlue:
    cmp al, 2
    jg CheckNormalOrangePortal
    
    mov al, yPos
    mov dl, portalBlueY[ebx]
    sub al, dl
    jns YPosBlue
    neg al
YPosBlue:
    cmp al, 2
    jg CheckNormalOrangePortal
    
    ; On Blue Portal! Teleport to Orange
    push ebx
    push ecx
    call ShowTeleportAnimation
    pop ecx
    pop ebx
    
    mov al, portalOrangeX[ebx]
    mov xPos, al
    mov al, portalOrangeY[ebx]
    mov yPos, al
    mov portalCooldown, 30
    add score, 10
    jmp NormalPortalUsed
    
CheckNormalOrangePortal:
    mov al, xPos
    mov dl, portalOrangeX[ebx]
    
    sub al, dl
    jns XPosOrange
    neg al
XPosOrange:
    cmp al, 2
    jg NextNormalPortalPair
    
    mov al, yPos
    mov dl, portalOrangeY[ebx]
    sub al, dl
    jns YPosOrange
    neg al
YPosOrange:
    cmp al, 2
    jg NextNormalPortalPair
    
    ; On Orange Portal! Teleport to Blue
    push ebx
    push ecx
    call ShowTeleportAnimation
    pop ecx
    pop ebx
    
    mov al, portalBlueX[ebx]
    mov xPos, al
    mov al, portalBlueY[ebx]
    mov yPos, al
    mov portalCooldown, 30
    add score, 10
    jmp NormalPortalUsed
    
NextNormalPortalPair:
    inc ebx
    dec ecx
    cmp ecx, 0
    jne CheckNormalBluePortals
    jmp NoPortalCheck
    
NormalPortalUsed:
    ; Redraw everything after teleport
    call Clrscr
    call DrawHUD
    call DrawGround
    call DrawClouds
    call DrawPlatforms
    call DrawPipes
    call DrawQuestionBlocks
    call DrawPortals
    call DrawEnemies
    call DrawCoin
    call DrawPlayerAtPos
    jmp NoPortalCheck
    
CheckBossPortals:
    ; *** BOSS LEVEL PORTAL CHECKING ***
    cmp portalCooldown, 0
    jne DecrementCooldown
    
    mov ecx, MAX_PORTAL_PAIRS
    mov ebx, 0
    
CheckBossBluePortals:
    mov al, xPos
    mov dl, bossPortalBlueX[ebx]
    
    sub al, dl
    jns XPosBossBlue
    neg al
XPosBossBlue:
    cmp al, 2
    jg CheckBossOrangePortal
    
    mov al, yPos
    mov dl, bossPortalBlueY[ebx]
    sub al, dl
    jns YPosBossBlue
    neg al
YPosBossBlue:
    cmp al, 2
    jg CheckBossOrangePortal
    
    push ebx
    push ecx
    call ShowTeleportAnimation
    pop ecx
    pop ebx
    
    mov al, bossPortalOrangeX[ebx]
    mov xPos, al
    mov al, bossPortalOrangeY[ebx]
    mov yPos, al
    mov portalCooldown, 30
    add score, 15  ; Boss portals worth more!
    jmp BossPortalUsed
    
CheckBossOrangePortal:
    mov al, xPos
    mov dl, bossPortalOrangeX[ebx]
    
    sub al, dl
    jns XPosBossOrange
    neg al
XPosBossOrange:
    cmp al, 2
    jg NextBossPortalPair
    
    mov al, yPos
    mov dl, bossPortalOrangeY[ebx]
    sub al, dl
    jns YPosBossOrange
    neg al
YPosBossOrange:
    cmp al, 2
    jg NextBossPortalPair
    
    push ebx
    push ecx
    call ShowTeleportAnimation
    pop ecx
    pop ebx
    
    mov al, bossPortalBlueX[ebx]
    mov xPos, al
    mov al, bossPortalBlueY[ebx]
    mov yPos, al
    mov portalCooldown, 30
    add score, 15
    jmp BossPortalUsed
    
NextBossPortalPair:
    inc ebx
    dec ecx
    cmp ecx, 0
    jne CheckBossBluePortals
    jmp NoPortalCheck
    
BossPortalUsed:
    call Clrscr
    call DrawHUD
    call DrawBossLevel
    call DrawBowser
    call DrawBowserFireballs
    call DrawFireObstacles
    call DrawPlayerAtPos
    jmp NoPortalCheck
    
DecrementCooldown:
    dec portalCooldown
    
NoPortalCheck:
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
CheckPortalTeleport ENDP

;============ MAIN PROCEDURES ============

main PROC
    call ShowTitleScreen
MenuRestart:
    call ShowMainMenu
    cmp al, '1'
    je StartGame
    cmp al, '2'
    je ShowHighScores
    cmp al, '3'
    je ShowInstructions
    cmp al, '4'
    je StartBossLevel
    cmp al, '5'
    je ExitProgram
    jmp MenuRestart
main ENDP

GetPlayerName PROC
    call Clrscr
    mov eax, yellow + (blue * 16)
    call SetTextColor
    
    mov dl, 18
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET playerNamePrompt
    call WriteString
    
    mov edx, OFFSET playerName
    mov ecx, 20
    call ReadString
    
    ret
GetPlayerName ENDP

ParseHighScore PROC
    push ebx
    push ecx
    push edx
    push esi
    
    mov esi, OFFSET scoreBuffer
    mov eax, 0
    mov ebx, 10
    
FindColon:
    mov cl, [esi]
    cmp cl, 0
    je ParseDone
    cmp cl, ':'
    je FoundColon
    inc esi
    jmp FindColon
    
FoundColon:
    inc esi
    mov cl, [esi]
    cmp cl, ' '
    jne ParseDigits
    inc esi
    
ParseDigits:
    mov cl, [esi]
    cmp cl, '0'
    jl ParseDone
    cmp cl, '9'
    jg ParseDone
    
    mul ebx
    
    movzx edx, cl
    sub edx, '0'
    add eax, edx
    
    inc esi
    jmp ParseDigits
    
ParseDone:
    pop esi
    pop edx
    pop ecx
    pop ebx
    ret
ParseHighScore ENDP

SaveHighScore PROC
    push eax
    push edx
    push ebx
    push ecx
    push esi
    push edi
    
    mov edx, OFFSET highScoreFile
    call OpenInputFile
    mov fileHandle, eax
    
    cmp eax, INVALID_HANDLE_VALUE
    je NoExistingScore
    
    mov eax, fileHandle
    mov edx, OFFSET scoreBuffer
    mov ecx, 200
    call ReadFromFile
    mov ebx, eax
    
    mov eax, fileHandle
    call CloseFile
    
    cmp ebx, 0
    je NoExistingScore
    
    call ParseHighScore
    mov currentHighScore, ax
    
    movzx eax, score
    cmp ax, currentHighScore
    jle NotHighScore
    
NoExistingScore:
    mov edx, OFFSET highScoreFile
    call CreateOutputFile
    mov fileHandle, eax
    
    cmp eax, INVALID_HANDLE_VALUE
    je SaveError
    
    mov esi, OFFSET scoreBuffer
    mov edi, OFFSET playerName
    mov ecx, 0
CopyName:
    mov al, [edi]
    cmp al, 0
    je NameDone
    mov [esi], al
    inc esi
    inc edi
    inc ecx
    cmp ecx, 20
    jl CopyName
    
NameDone:
    mov BYTE PTR [esi], ':'
    inc esi
    mov BYTE PTR [esi], ' '
    inc esi
    
    movzx eax, score
    mov ebx, 10
    mov ecx, 0
    
    cmp eax, 0
    jne ConvertScore
    mov BYTE PTR [esi], '0'
    inc esi
    jmp ScoreDone
    
ConvertScore:
    cmp eax, 0
    je PopDigits
    xor edx, edx
    div ebx
    push edx
    inc ecx
    jmp ConvertScore
    
PopDigits:
    cmp ecx, 0
    je ScoreDone
    pop eax
    add al, '0'
    mov [esi], al
    inc esi
    dec ecx
    jmp PopDigits
    
ScoreDone:
    mov BYTE PTR [esi], 0Dh
    inc esi
    mov BYTE PTR [esi], 0Ah
    inc esi
    mov BYTE PTR [esi], 0
    
    mov eax, esi
    sub eax, OFFSET scoreBuffer
    mov ecx, eax
    
    mov eax, fileHandle
    mov edx, OFFSET scoreBuffer
    call WriteToFile
    
    mov eax, fileHandle
    call CloseFile
    jmp SaveError
    
NotHighScore:
    
SaveError:
    pop edi
    pop esi
    pop ecx
    pop ebx
    pop edx
    pop eax
    ret
SaveHighScore ENDP

DisplayHighScoresFromFile PROC
    push eax
    push edx
    push ebx
    push ecx
    
    call Clrscr
    mov eax, yellow + (blue * 16)
    call SetTextColor
    
    mov dl, 32
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET highScoresMsg
    call WriteString
    
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 4
    call Gotoxy
    mov ecx, 30
DrawLine:
    mov al, '-'
    call WriteChar
    loop DrawLine
    
    mov edx, OFFSET highScoreFile
    call OpenInputFile
    mov fileHandle, eax
    
    cmp eax, INVALID_HANDLE_VALUE
    je NoScoresFile
    
    mov eax, fileHandle
    mov edx, OFFSET scoreBuffer
    mov ecx, 200
    call ReadFromFile
    mov ebx, eax
    
    cmp ebx, 0
    je NoScoresFile
    
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 6
    call Gotoxy
    mov edx, OFFSET scoreBuffer
    call WriteString
    
    mov eax, fileHandle
    call CloseFile
    jmp DisplayDone
    
NoScoresFile:
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, 20
    mov dh, 8
    call Gotoxy
    mov edx, OFFSET noScoresMsg
    call WriteString
    
DisplayDone:
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET pressAnyKey
    call WriteString
    
    call ReadChar
    
    pop ecx
    pop ebx
    pop edx
    pop eax
    ret
DisplayHighScoresFromFile ENDP

ShowTitleScreen PROC
    call Clrscr
    
    ; Draw top decoration stars
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, 15
    mov dh, 2
    call Gotoxy
    mov ecx, 50
DrawStars:
    mov al, '*'
    call WriteChar
    loop DrawStars
    
    ; ===== SUPER (Red, Big Letters) =====
    mov eax, red + (blue * 16)
    call SetTextColor
    mov dl, 32
    mov dh, 5
    call Gotoxy
    mov al, 'S'
    call WriteChar
    mov al, 'U'
    call WriteChar
    mov al, 'P'
    call WriteChar
    mov al, 'E'
    call WriteChar
    mov al, 'R'
    call WriteChar
    
    mov eax, 200
    call Delay
    
    ; ===== MARIO (Yellow, Big Letters) =====
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, 31
    mov dh, 7
    call Gotoxy
    mov al, 'M'
    call WriteChar
    mov al, 'A'
    call WriteChar
    mov al, 'R'
    call WriteChar
    mov al, 'I'
    call WriteChar
    mov al, 'O'
    call WriteChar
    
    mov eax, 200
    call Delay
    
    ; ===== BROS (Red, Big Letters) =====
    mov eax, red + (blue * 16)
    call SetTextColor
    mov dl, 32
    mov dh, 9
    call Gotoxy
    mov al, 'B'
    call WriteChar
    mov al, 'R'
    call WriteChar
    mov al, 'O'
    call WriteChar
    mov al, 'S'
    call WriteChar
    
    mov eax, 300
    call Delay
    
    ; ===== DRAW COIN ANIMATION =====
    mov eax, yellow + (blue * 16)
    call SetTextColor
    
    ; Left coins
    mov dl, 25
    mov dh, 7
    call Gotoxy
    mov al, 'O'
    call WriteChar
    
    mov dl, 27
    mov dh, 7
    call Gotoxy
    mov al, 'O'
    call WriteChar
    
    ; Right coins
    mov dl, 45
    mov dh, 7
    call Gotoxy
    mov al, 'O'
    call WriteChar
    
    mov dl, 47
    mov dh, 7
    call Gotoxy
    mov al, 'O'
    call WriteChar
    
    ; ===== BOX FRAME AROUND INFO =====
    mov eax, cyan + (blue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET boxTop
    call WriteString
    
    mov dl, 25
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET boxMid1
    call WriteString
    
    mov dl, 25
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET boxMid2
    call WriteString
    
    mov dl, 25
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET boxMid3
    call WriteString
    
    mov dl, 25
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET boxBottom
    call WriteString
    
    ; ===== YOUR NAME (HIGHLIGHTED) =====
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, 30
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET devBy
    call WriteString
    
    mov eax, white + (lightGreen * 16)
    call SetTextColor
    mov dl, 28
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET ahmedName
    call WriteString
    
    mov eax, cyan + (blue * 16)
    call SetTextColor
    mov dl, 29
    mov dh, 15
    call Gotoxy
    mov edx, OFFSET roll0601
    call WriteString
    
    ; ===== GROUND =====
    mov eax, green + (blue * 16)
    call SetTextColor
    mov dl, 0
    mov dh, 24
    call Gotoxy
    mov edx, OFFSET bottomGround
    call WriteString
    
    ; ===== FLASHING PRESS KEY =====
    mov ecx, 3
FlashLoop2:
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, 24
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET pressAnyKey
    call WriteString
    
    mov eax, 500
    call Delay
    
    mov dl, 24
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET clearPrompt
    call WriteString
    
    mov eax, 500
    call Delay
    loop FlashLoop2
    
    ; Show final prompt
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, 24
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET pressAnyKey
    call WriteString
    
    call ReadChar
    ret
ShowTitleScreen ENDP

DrawHUD PROC
    mov eax, white + (blue * 16)
    call SetTextColor
    
    mov dl, 1
    mov dh, 0
    call Gotoxy
    mov edx, OFFSET marioLabel
    call WriteString
    
    mov dl, 8
    mov dh, 0
    call Gotoxy
    movzx eax, score
    call WriteDec
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    
    mov dl, 30
    mov dh, 0
    call Gotoxy
    mov edx, OFFSET coinsLabel
    call WriteString
    
    mov dl, 37
    mov dh, 0
    call Gotoxy
    movzx eax, coins
    call WriteDec
    
    mov dl, 50
    mov dh, 0
    call Gotoxy
    
    cmp currentArea, BOSS_AREA
    je ShowBossWorld
    mov edx, OFFSET worldLabel
    call WriteString
    jmp ShowTime
    
ShowBossWorld:
    mov edx, OFFSET bossWorldLabel
    call WriteString
    
ShowTime:
    mov dl, 71
    mov dh, 0
    call Gotoxy
    mov edx, OFFSET timeLabel
    call WriteString
    
    mov dl, 76
    mov dh, 0
    call Gotoxy
    movzx eax, time
    call WriteDec
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    
    mov dl, 1
    mov dh, 1
    call Gotoxy
    mov edx, OFFSET livesLabel
    call WriteString
    
    mov dl, 7
    mov dh, 1
    call Gotoxy
    mov edx, OFFSET livesX
    call WriteString
    
    mov dl, 9
    mov dh, 1
    call Gotoxy
    movzx eax, lives
    call WriteDec
    
    ret
DrawHUD ENDP

UpdateTimer PROC
    push eax
    push edx
    
    inc timerCounter
    cmp timerCounter, 10
    jl NoTimerUpdate
    
    mov timerCounter, 0
    cmp time, 0
    je TimeIsUp
    dec time
    
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, 76
    mov dh, 0
    call Gotoxy
    movzx eax, time
    call WriteDec
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    
NoTimerUpdate:
    pop edx
    pop eax
    ret
    
TimeIsUp:
    pop edx
    pop eax
    
    call SaveHighScore
    call ShowTimeUpMessage
    
    call Clrscr
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, 30
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET nameLabel
    call WriteString
    mov edx, OFFSET playerName
    call WriteString
    
    mov dl, 30
    mov dh, 11
    call Gotoxy
    mov edx, OFFSET finalScoreMsg
    call WriteString
    movzx eax, score
    call WriteDec
    
    mov eax, 2000
    call Delay
    jmp main
    
UpdateTimer ENDP

ShowTimeUpMessage PROC
    push eax
    push edx
    
    call Clrscr
    mov eax, red + (blue * 16)
    call SetTextColor
    mov dl, 35
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET timeUpMsg
    call WriteString
    mov eax, 2000
    call Delay
    
    pop edx
    pop eax
    ret
ShowTimeUpMessage ENDP

; *** FIXED: Boss Level Lava Death Now Works! ***
CheckDeathPit PROC
    ; Check for Boss Level Lava (Y >= 24)
    cmp currentArea, BOSS_AREA
    je CheckBossLavaDeath
    
    ; Normal level death pit check (Y >= 28)
    cmp yPos, DEATH_Y
    jl NoDeath
    
    call ShowDeathMessage
    dec lives
    
    cmp lives, 0
    jle GameOverScreen
    
    mov xPos, 20
    mov yPos, 23
    mov currentArea, NORMAL_AREA
    ret
    
CheckBossLavaDeath:
    ; *** BOSS LEVEL: Check if fell in lava (Y >= 24) ***
    cmp yPos, BOSS_LAVA_Y
    jl NoDeath
    
    ; Show lava death message
    call Clrscr
    mov eax, red + (blue * 16)
    call SetTextColor
    mov dl, 32
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET lavaDeathMsg
    call WriteString
    mov eax, 1500
    call Delay
    
    dec lives
    cmp lives, 0
    jle GameOverScreen
    
    ; Respawn in boss level at start
    mov xPos, 10
    mov yPos, 23
    ret
    
GameOverScreen:
    call SaveHighScore
    
    call Clrscr
    mov eax, red + (blue * 16)
    call SetTextColor
    mov dl, 35
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET gameOverMsg
    call WriteString
    
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, 30
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET nameLabel
    call WriteString
    mov edx, OFFSET playerName
    call WriteString
    
    mov dl, 30
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET finalScoreMsg
    call WriteString
    movzx eax, score
    call WriteDec
    
    mov eax, 3000
    call Delay
    jmp main
    
NoDeath:
    ret
CheckDeathPit ENDP

ShowDeathMessage PROC
    push eax
    push edx
    
    mov eax, red + (blue * 16)
    call SetTextColor
    mov dl, 35
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET deathMsg
    call WriteString
    mov eax, 1500
    call Delay
    
    pop edx
    pop eax
    ret
ShowDeathMessage ENDP

;============ PIPE AND SECRET AREA ============

CheckPipeEntry PROC
    cmp inputChar, 's'
    jne NoPipeEntry
    
    cmp currentArea, SECRET_AREA
    je CheckExitPipe
    
    mov esi, 0
CheckPipeEntryLoop:
    cmp esi, MAX_PIPES
    jge NoPipeEntry
    
    mov al, pipeCanEnter[esi]
    cmp al, 1
    jne NextPipeEntry
    
    movzx eax, pipeX[esi]
    mov cl, al
    add al, PIPE_WIDTH
    mov ch, al
    
    mov al, xPos
    cmp al, cl
    jl NextPipeEntry
    cmp al, ch
    jge NextPipeEntry
    
    mov al, 24
    sub al, pipeH[esi]
    dec al
    cmp yPos, al
    jne NextPipeEntry
    
    call EnterSecretArea
    ret
    
NextPipeEntry:
    inc esi
    jmp CheckPipeEntryLoop
    
CheckExitPipe:
    movzx eax, secretExitX
    mov bl, al
    add al, PIPE_WIDTH
    mov bh, al
    
    mov al, xPos
    cmp al, bl
    jl NoPipeEntry
    cmp al, bh
    jge NoPipeEntry
    
    mov al, 24
    sub al, secretExitH
    dec al
    cmp yPos, al
    jne NoPipeEntry
    
    call ExitSecret
    ret
    
NoPipeEntry:
    ret
CheckPipeEntry ENDP

EnterSecretArea PROC
    call Clrscr
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, 28
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET secretMsg
    call WriteString
    mov eax, 1500
    call Delay
    
    mov currentArea, SECRET_AREA
    mov xPos, 15
    mov yPos, 23
    
    mov ecx, 8
    mov ebx, 0
ResetSecretCoins:
    mov secretCoinCollected[ebx], 0
    inc ebx
    loop ResetSecretCoins
    
    call Clrscr
    ret
EnterSecretArea ENDP

ExitSecret PROC
    call Clrscr
    mov eax, green + (blue * 16)
    call SetTextColor
    mov dl, 22
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET bonusCoinsMsg
    call WriteString
    mov eax, 1500
    call Delay
    
    mov currentArea, NORMAL_AREA
    mov xPos, 40
    mov yPos, 23
    
    call Clrscr
    ret
ExitSecret ENDP

DrawSecretArea PROC
    mov eax, brown + (blue * 16)
    call SetTextColor
    mov dl, 0
    mov dh, 24
    call Gotoxy
    mov edx, OFFSET ground
    call WriteString
    
    mov eax, yellow + (blue * 16)
    call SetTextColor
    movzx eax, secretExitX
    add al, 1
    mov dl, al
    mov dh, 18
    call Gotoxy
    mov al, 'E'
    call WriteChar
    mov al, 'X'
    call WriteChar
    mov al, 'I'
    call WriteChar
    mov al, 'T'
    call WriteChar
    
    mov eax, green + (blue * 16)
    call SetTextColor
    
    movzx eax, secretExitH
    mov bl, 24
    sub bl, al
    
    movzx edx, secretExitX
    mov cl, dl
    
    mov dl, cl
    mov dh, bl
    call Gotoxy
    push edx
    mov edx, OFFSET pipeTop
    call WriteString
    pop edx
    
    inc dh
    mov dl, cl
    call Gotoxy
    push edx
    mov edx, OFFSET pipeTopMid
    call WriteString
    pop edx
    
    movzx eax, secretExitH
    sub eax, 2
    mov ecx, eax
    
SecretPipeBodyLoop:
    cmp ecx, 0
    jle SecretPipeBodyDone
    inc dh
    mov dl, cl
    call Gotoxy
    push ecx
    push edx
    mov edx, OFFSET pipeBody
    call WriteString
    pop edx
    pop ecx
    dec ecx
    jmp SecretPipeBodyLoop
    
SecretPipeBodyDone:
    call DrawSecretCoins
    
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, 15
    mov dh, 3
    call Gotoxy
    mov edx, OFFSET bonusCoinsMsg
    call WriteString
    
    ret
DrawSecretArea ENDP

DrawSecretCoins PROC
    mov ecx, 8
    mov ebx, 0
SecretCoinLoop:
    mov al, secretCoinCollected[ebx]
    cmp al, 1
    je SkipSecretCoin
    
    mov al, secretCoinX[ebx]
    mov dl, al
    mov al, secretCoinY[ebx]
    mov dh, al
    call Gotoxy
    
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov al, 'O'
    call WriteChar
    
SkipSecretCoin:
    inc ebx
    loop SecretCoinLoop
    ret
DrawSecretCoins ENDP

CheckSecretCoinCollection PROC
    cmp currentArea, SECRET_AREA
    jne NoSecretCoinCheck
    
    mov ecx, 8
    mov ebx, 0
SecretCoinCheckLoop:
    mov al, secretCoinCollected[ebx]
    cmp al, 1
    je NextSecretCoin
    
    mov al, secretCoinX[ebx]
    cmp al, xPos
    jne NextSecretCoin
    
    mov al, secretCoinY[ebx]
    cmp al, yPos
    jne NextSecretCoin
    
    mov secretCoinCollected[ebx], 1
    inc coins
    call PlayCoinSound
    add score, 20
    
    push ebx
    push ecx
    
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, 37
    mov dh, 0
    call Gotoxy
    movzx eax, coins
    call WriteDec
    mov al, ' '
    call WriteChar
    
    mov dl, 8
    mov dh, 0
    call Gotoxy
    movzx eax, score
    call WriteDec
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    
    pop ecx
    pop ebx
    ret
    
NextSecretCoin:
    inc ebx
    dec ecx
    cmp ecx, 0
    jne SecretCoinCheckLoop
    
NoSecretCoinCheck:
    ret
CheckSecretCoinCollection ENDP

;============ ENEMIES ============

DrawEnemies PROC
    cmp currentArea, SECRET_AREA
    je NoEnemies
    cmp currentArea, BOSS_AREA
    je NoEnemies
    
    mov eax, brown + (blue * 16)
    call SetTextColor
    
    mov ecx, MAX_ENEMIES
    mov ebx, 0
DrawEnemyLoop:
    mov al, enemyActive[ebx]
    cmp al, 1
    jne SkipEnemy
    
    push ebx
    push ecx
    
    mov dl, enemyX[ebx]
    mov dh, enemyY[ebx]
    call Gotoxy
    mov al, 'G'
    call WriteChar
    
    pop ecx
    pop ebx
    
SkipEnemy:
    inc ebx
    dec ecx
    jnz DrawEnemyLoop
    
NoEnemies:
    ret
DrawEnemies ENDP

CheckEnemyPipeCollision PROC
    push ebx
    push ecx
    push edx
    
    mov bl, al
    mov esi, 0
    
CheckEnemyPipeLoop:
    cmp esi, MAX_PIPES
    jge NoEnemyPipeCollision
    
    movzx eax, pipeX[esi]
    mov cl, al
    add al, PIPE_WIDTH
    mov ch, al
    
    mov al, bl
    cmp al, cl
    jl NextEnemyPipeCheck
    cmp al, ch
    jge NextEnemyPipeCheck
    
    pop edx
    pop ecx
    pop ebx
    mov al, 1
    ret
    
NextEnemyPipeCheck:
    inc esi
    jmp CheckEnemyPipeLoop
    
NoEnemyPipeCollision:
    pop edx
    pop ecx
    pop ebx
    mov al, 0
    ret
CheckEnemyPipeCollision ENDP

MoveEnemies PROC
    cmp currentArea, SECRET_AREA
    je NoEnemyMove
    cmp currentArea, BOSS_AREA
    je NoEnemyMove
    
    mov ecx, MAX_ENEMIES
    mov ebx, 0
MoveEnemyLoop:
    mov al, enemyActive[ebx]
    cmp al, 1
    jne SkipEnemyMove
    
    push ebx
    push ecx
    
    mov dl, enemyX[ebx]
    mov dh, enemyY[ebx]
    call Gotoxy
    mov al, ' '
    call WriteChar
    
    pop ecx
    pop ebx
    
    mov al, enemyDir[ebx]
    cmp al, 1
    je MoveEnemyRight
    
MoveEnemyLeft:
    mov al, enemyX[ebx]
    cmp al, enemyLeftBound[ebx]
    jle ChangeToRight
    
    dec al
    push ebx
    push ecx
    call CheckEnemyPipeCollision
    pop ecx
    pop ebx
    cmp al, 1
    je ChangeToRight
    
    dec enemyX[ebx]
    jmp SkipEnemyMove
    
ChangeToRight:
    mov enemyDir[ebx], 1
    jmp SkipEnemyMove
    
MoveEnemyRight:
    mov al, enemyX[ebx]
    cmp al, enemyRightBound[ebx]
    jge ChangeToLeft
    
    inc al
    push ebx
    push ecx
    call CheckEnemyPipeCollision
    pop ecx
    pop ebx
    cmp al, 1
    je ChangeToLeft
    
    inc enemyX[ebx]
    jmp SkipEnemyMove
    
ChangeToLeft:
    mov enemyDir[ebx], 0
    
SkipEnemyMove:
    inc ebx
    dec ecx
    jnz MoveEnemyLoop
    
NoEnemyMove:
    ret
MoveEnemies ENDP

CheckEnemyCollision PROC
    cmp currentArea, SECRET_AREA
    jne ContinueEnemyCheck
    ret
    
ContinueEnemyCheck:
    cmp currentArea, BOSS_AREA
    je NormalEnemyCheckDone
    
    mov ecx, MAX_ENEMIES
    mov ebx, 0
CheckEnemyLoop:
    mov al, enemyActive[ebx]
    cmp al, 1
    jne NextEnemyJump
    
    mov al, xPos
    mov dl, enemyX[ebx]
    sub al, dl
    
    cmp al, 0
    je XMatch
    cmp al, 1
    je XMatch
    cmp al, 2
    je XMatch
    cmp al, -1
    je XMatch
    cmp al, -2
    je XMatch
    jmp NextEnemyJump
    
XMatch:
    mov al, yPos
    mov dl, enemyY[ebx]
    
    cmp al, dl
    jge NotStompingEnemy
    
    mov al, dl
    sub al, yPos
    cmp al, 1
    jl NotStompingEnemy
    cmp al, 5
    jle DestroyEnemy
    jmp NextEnemyJump
    
DestroyEnemy:
    push ebx
    push ecx
    
    mov enemyActive[ebx], 0
    add score, 100
    
    mov dl, enemyX[ebx]
    mov dh, enemyY[ebx]
    call Gotoxy
    mov al, ' '
    call WriteChar
    
    mov dl, enemyX[ebx]
    mov dh, enemyY[ebx]
    dec dh
    call Gotoxy
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov al, '+'
    call WriteChar
    mov al, '1'
    call WriteChar
    mov al, '0'
    call WriteChar
    mov al, '0'
    call WriteChar
    
    mov eax, 400
    call Delay
    
    mov dl, enemyX[ebx]
    mov dh, enemyY[ebx]
    dec dh
    call Gotoxy
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    
    pop ecx
    pop ebx
    
    cmp yPos, 5
    jle SkipBounce
    dec yPos
    
SkipBounce:
    jmp NextEnemyJump
    
NotStompingEnemy:
    push ebx
    push ecx
    
    call ShowDeathMessage
    dec lives
    
    pop ecx
    pop ebx
    
    cmp lives, 0
    je EnemyGameOver
    
    mov xPos, 20
    mov yPos, 23
    jmp NextEnemyJump
    
EnemyGameOver:
    push ebx
    push ecx
    
    call SaveHighScore
    
    call Clrscr
    mov eax, red + (blue * 16)
    call SetTextColor
    mov dl, 35
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET gameOverMsg
    call WriteString
    
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, 30
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET nameLabel
    call WriteString
    mov edx, OFFSET playerName
    call WriteString
    
    mov dl, 30
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET finalScoreMsg
    call WriteString
    movzx eax, score
    call WriteDec
    
    mov eax, 3000
    call Delay
    
    pop ecx
    pop ebx
    jmp main
    
NextEnemyJump:
    inc ebx
    dec ecx
    cmp ecx, 0
    je NormalEnemyCheckDone
    jmp CheckEnemyLoop
    
NormalEnemyCheckDone:
    ret
CheckEnemyCollision ENDP

;============ DRAW LEVEL ELEMENTS ============

DrawClouds PROC
    cmp currentArea, BOSS_AREA
    je NoClouds
    
    mov eax, white + (blue * 16)
    call SetTextColor
    
    mov ecx, MAX_CLOUDS
    mov ebx, 0
CloudLoop:
    mov al, cloudX[ebx]
    mov dl, al
    mov al, cloudY[ebx]
    mov dh, al
    call Gotoxy
    mov edx, OFFSET cloudStr1
    call WriteString
    
    mov al, cloudX[ebx]
    mov dl, al
    mov al, cloudY[ebx]
    inc al
    mov dh, al
    call Gotoxy
    mov edx, OFFSET cloudStr2
    call WriteString
    
    mov al, cloudX[ebx]
    mov dl, al
    mov al, cloudY[ebx]
    add al, 2
    mov dh, al
    call Gotoxy
    mov edx, OFFSET cloudStr3
    call WriteString
    
    inc ebx
    loop CloudLoop
    
NoClouds:
    ret
DrawClouds ENDP

DrawPipes PROC
    cmp currentArea, BOSS_AREA
    je NoPipes
    
    mov eax, green + (blue * 16)
    call SetTextColor
    
    mov esi, 0
PipeLoop:
    cmp esi, MAX_PIPES
    jge PipesDone
    
    movzx eax, pipeX[esi]
    mov bl, al
    
    movzx ecx, pipeH[esi]
    mov bh, 24
    sub bh, cl
    
    mov dl, bl
    mov dh, bh
    call Gotoxy
    push edx
    mov edx, OFFSET pipeTop
    call WriteString
    pop edx
    
    inc dh
    mov dl, bl
    call Gotoxy
    push edx
    mov edx, OFFSET pipeTopMid
    call WriteString
    pop edx
    
    movzx ecx, pipeH[esi]
    sub ecx, 2
PipeBodyLoop:
    cmp ecx, 0
    jle PipeBodyDone
    inc dh
    mov dl, bl
    call Gotoxy
    push ecx
    push edx
    mov edx, OFFSET pipeBody
    call WriteString
    pop edx
    pop ecx
    dec ecx
    jmp PipeBodyLoop
    
PipeBodyDone:
    inc esi
    jmp PipeLoop
    
PipesDone:
NoPipes:
    ret
DrawPipes ENDP

CheckPipeCollisionHorizontal PROC
    push ebx
    push ecx
    push edx
    
    mov bl, al
    mov esi, 0
CheckPipeLoop:
    cmp esi, MAX_PIPES
    jge NoPipeCollision
    
    movzx eax, pipeX[esi]
    mov cl, al
    add al, PIPE_WIDTH
    mov ch, al
    
    mov al, 24
    sub al, pipeH[esi]
    mov dl, al
    
    mov al, bl
    cmp al, cl
    jl NextPipeCheck
    cmp al, ch
    jge NextPipeCheck
    
    mov al, yPos
    cmp al, dl
    jl NextPipeCheck
    cmp al, 23
    jg NextPipeCheck
    
    pop edx
    pop ecx
    pop ebx
    mov al, 1
    ret
    
NextPipeCheck:
    inc esi
    jmp CheckPipeLoop
    
NoPipeCollision:
    pop edx
    pop ecx
    pop ebx
    mov al, 0
    ret
CheckPipeCollisionHorizontal ENDP

CheckPipeTopCollision PROC
    mov esi, 0
CheckPipeTopLoop:
    cmp esi, MAX_PIPES
    jge NoPipeTopCollision
    
    movzx eax, pipeX[esi]
    mov cl, al
    add al, PIPE_WIDTH
    mov ch, al
    
    mov al, 24
    sub al, pipeH[esi]
    mov dl, al
    
    mov al, xPos
    cmp al, cl
    jl NextPipeTop
    cmp al, ch
    jge NextPipeTop
    
    mov al, yPos
    inc al
    cmp al, dl
    jne NextPipeTop
    
    mov al, dl
    dec al
    mov yPos, al
    mov onPlatform, 1
    mov isInAir, 0
    ret
    
NextPipeTop:
    inc esi
    jmp CheckPipeTopLoop
    
NoPipeTopCollision:
    ret
CheckPipeTopCollision ENDP

CheckSecretPipeTopCollision PROC
    cmp currentArea, SECRET_AREA
    jne NoSecretPipeTop
    
    movzx eax, secretExitX
    mov cl, al
    add al, PIPE_WIDTH
    mov ch, al
    
    mov al, 24
    sub al, secretExitH
    mov dl, al
    
    mov al, xPos
    cmp al, cl
    jl NoSecretPipeTop
    cmp al, ch
    jge NoSecretPipeTop
    
    mov al, yPos
    inc al
    cmp al, dl
    jne NoSecretPipeTop
    
    mov al, dl
    dec al
    mov yPos, al
    mov onPlatform, 1
    mov isInAir, 0
    ret
    
NoSecretPipeTop:
    ret
CheckSecretPipeTopCollision ENDP

CheckQBlockTopCollision PROC
    mov esi, 0
CheckQBlockTopLoop:
    cmp esi, MAX_QBLOCKS
    jge NoQBlockTopCollision
    
    movzx eax, qBlockX[esi]
    mov cl, al
    add al, QBLOCK_WIDTH
    mov ch, al
    
    movzx eax, qBlockY[esi]
    mov dl, al
    
    mov al, xPos
    cmp al, cl
    jl NextQBlockTop
    cmp al, ch
    jge NextQBlockTop
    
    mov al, yPos
    inc al
    cmp al, dl
    jne NextQBlockTop
    
    mov al, dl
    dec al
    mov yPos, al
    mov onPlatform, 1
    mov isInAir, 0
    ret
    
NextQBlockTop:
    inc esi
    jmp CheckQBlockTopLoop
    
NoQBlockTopCollision:
    ret
CheckQBlockTopCollision ENDP

DrawQuestionBlocks PROC
    cmp currentArea, BOSS_AREA
    je DrawBossQBlocks
    
    mov ecx, MAX_QBLOCKS
    mov ebx, 0
QBlockLoop:
    mov al, qBlockX[ebx]
    mov dl, al
    mov al, qBlockY[ebx]
    mov dh, al
    call Gotoxy
    
    mov al, qBlockHit[ebx]
    cmp al, 0
    jne DrawEmptyBlock
    
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov edx, OFFSET qBlockStr
    call WriteString
    jmp NextQBlock
    
DrawEmptyBlock:
    mov eax, brown + (blue * 16)
    call SetTextColor
    mov edx, OFFSET emptyBlockStr
    call WriteString
    
NextQBlock:
    inc ebx
    loop QBlockLoop
    ret
    
DrawBossQBlocks:
    mov ecx, MAX_BOSS_QBLOCKS
    mov ebx, 0
BossQBlockLoop:
    mov al, bossQBlockX[ebx]
    mov dl, al
    mov al, bossQBlockY[ebx]
    mov dh, al
    call Gotoxy
    
    mov al, bossQBlockHit[ebx]
    cmp al, 0
    jne DrawBossEmptyBlock
    
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov edx, OFFSET qBlockStr
    call WriteString
    jmp NextBossQBlock
    
DrawBossEmptyBlock:
    mov eax, brown + (blue * 16)
    call SetTextColor
    mov edx, OFFSET emptyBlockStr
    call WriteString
    
NextBossQBlock:
    inc ebx
    loop BossQBlockLoop
    ret
DrawQuestionBlocks ENDP

CheckBossQBlockTopCollision PROC
    mov esi, 0
CheckBossQBlockTopLoop:
    cmp esi, MAX_BOSS_QBLOCKS
    jge NoBossQBlockTopCollision
    
    movzx eax, bossQBlockX[esi]
    mov cl, al
    add al, QBLOCK_WIDTH
    mov ch, al
    
    movzx eax, bossQBlockY[esi]
    mov dl, al
    
    mov al, xPos
    cmp al, cl
    jl NextBossQBlockTop
    cmp al, ch
    jge NextBossQBlockTop
    
    mov al, yPos
    inc al
    cmp al, dl
    jne NextBossQBlockTop
    
    mov al, dl
    dec al
    mov yPos, al
    mov onPlatform, 1
    mov isInAir, 0
    ret
    
NextBossQBlockTop:
    inc esi
    jmp CheckBossQBlockTopLoop
    
NoBossQBlockTopCollision:
    ret
CheckBossQBlockTopCollision ENDP

CheckBlockHit PROC
    push ebx
    push ecx
    push edx
    
    cmp currentArea, BOSS_AREA
    je CheckBossBlockHit
    
    mov ecx, MAX_QBLOCKS
    mov ebx, 0
BlockHitLoop:
    mov al, qBlockHit[ebx]
    cmp al, 1
    je SkipThisBlock
    
    movzx eax, qBlockX[ebx]
    mov cl, al
    
    movzx eax, qBlockY[ebx]
    mov dl, al
    
    mov al, xPos
    cmp al, cl
    jl SkipThisBlock
    add cl, QBLOCK_WIDTH
    cmp al, cl
    jge SkipThisBlock
    
    mov al, yPos
    dec al
    cmp al, dl
    jne SkipThisBlock
    
    mov qBlockHit[ebx], 1
    inc coins
    call PlayCoinSound
    add score, 10
    
    cmp coins, BOSS_COINS_NEEDED
    jne NoUnlock
    cmp bossUnlocked, 1
    je NoUnlock
    mov bossUnlocked, 1
    call ShowBossUnlockedMessage
    
NoUnlock:
    pop edx
    pop ecx
    pop ebx
    ret
    
SkipThisBlock:
    inc ebx
    cmp ebx, MAX_QBLOCKS
    jl BlockHitLoop
    
    pop edx
    pop ecx
    pop ebx
    ret
    
CheckBossBlockHit:
    mov ecx, MAX_BOSS_QBLOCKS
    mov ebx, 0
BossBlockHitLoop:
    mov al, bossQBlockHit[ebx]
    cmp al, 1
    je SkipThisBossBlock
    
    movzx eax, bossQBlockX[ebx]
    mov cl, al
    
    movzx eax, bossQBlockY[ebx]
    mov dl, al
    
    mov al, xPos
    cmp al, cl
    jl SkipThisBossBlock
    add cl, QBLOCK_WIDTH
    cmp al, cl
    jge SkipThisBossBlock
    
    mov al, yPos
    dec al
    cmp al, dl
    jne SkipThisBossBlock
    
    mov bossQBlockHit[ebx], 1
    inc coins
    call PlayCoinSound
    add score, 15
    
    pop edx
    pop ecx
    pop ebx
    ret
    
SkipThisBossBlock:
    inc ebx
    cmp ebx, MAX_BOSS_QBLOCKS
    jl BossBlockHitLoop
    
    pop edx
    pop ecx
    pop ebx
    ret
CheckBlockHit ENDP

ShowBossUnlockedMessage PROC
    push eax
    push edx
    
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, 25
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET bossUnlockedMsg
    call WriteString
    mov eax, 2000
    call Delay
    
    pop edx
    pop eax
    ret
ShowBossUnlockedMessage ENDP

CheckQBlockBottomCollision PROC
    push ebx
    push ecx
    push edx
    
    cmp currentArea, BOSS_AREA
    je CheckBossQBlockBottom
    
    mov esi, 0
CheckQBlockBottomLoop:
    cmp esi, MAX_QBLOCKS
    jge NoQBlockBottomCollision
    
    movzx eax, qBlockX[esi]
    mov cl, al
    add al, QBLOCK_WIDTH
    mov ch, al
    
    movzx eax, qBlockY[esi]
    mov dl, al
    
    mov al, xPos
    cmp al, cl
    jl NextQBlockBottom
    cmp al, ch
    jge NextQBlockBottom
    
    mov al, yPos
    dec al
    mov ah, dl
    inc ah
    cmp al, ah
    jne NextQBlockBottom
    
    call CheckBlockHit
    pop edx
    pop ecx
    pop ebx
    mov al, 1
    ret
    
NextQBlockBottom:
    inc esi
    jmp CheckQBlockBottomLoop
    
NoQBlockBottomCollision:
    pop edx
    pop ecx
    pop ebx
    mov al, 0
    ret
    
CheckBossQBlockBottom:
    mov esi, 0
CheckBossQBlockBottomLoop:
    cmp esi, MAX_BOSS_QBLOCKS
    jge NoBossQBlockBottomCollision
    
    movzx eax, bossQBlockX[esi]
    mov cl, al
    add al, QBLOCK_WIDTH
    mov ch, al
    
    movzx eax, bossQBlockY[esi]
    mov dl, al
    
    mov al, xPos
    cmp al, cl
    jl NextBossQBlockBottom
    cmp al, ch
    jge NextBossQBlockBottom
    
    mov al, yPos
    dec al
    mov ah, dl
    inc ah
    cmp al, ah
    jne NextBossQBlockBottom
    
    call CheckBlockHit
    pop edx
    pop ecx
    pop ebx
    mov al, 1
    ret
    
NextBossQBlockBottom:
    inc esi
    jmp CheckBossQBlockBottomLoop
    
NoBossQBlockBottomCollision:
    pop edx
    pop ecx
    pop ebx
    mov al, 0
    ret
CheckQBlockBottomCollision ENDP

DrawGround PROC
    mov eax, green + (blue * 16)
    call SetTextColor
    mov dl, 0
    mov dh, 24
    call Gotoxy
    mov edx, OFFSET ground
    call WriteString
    ret
DrawGround ENDP

DrawPlatforms PROC
    cmp currentArea, BOSS_AREA
    je NoPlatforms
    
    mov eax, green + (blue * 16)
    call SetTextColor
    
    mov ecx, MAX_PLATFORMS
    mov ebx, 0
PlatformLoop:
    mov al, platformX[ebx]
    mov dl, al
    mov al, platformY[ebx]
    mov dh, al
    call Gotoxy
    mov edx, OFFSET platformStr
    call WriteString
    inc ebx
    loop PlatformLoop
    
NoPlatforms:
    ret
DrawPlatforms ENDP

;============ COLLISION DETECTION ============

CheckCeilingCollision PROC
    push ebx
    push ecx
    push edx
    
    cmp currentArea, BOSS_AREA
    je CheckBossCeiling
    
    mov esi, 0
CheckQBlockCeiling:
    cmp esi, MAX_QBLOCKS
    jge CheckPlatformCeiling
    
    mov al, qBlockHit[esi]
    cmp al, 1
    je NextQBlockCeiling
    
    movzx eax, qBlockX[esi]
    mov cl, al
    add al, QBLOCK_WIDTH
    mov ch, al
    
    movzx eax, qBlockY[esi]
    mov dl, al
    
    mov al, xPos
    cmp al, cl
    jl NextQBlockCeiling
    cmp al, ch
    jge NextQBlockCeiling
    
    mov al, yPos
    dec al
    mov ah, dl
    inc ah
    cmp al, ah
    jne NextQBlockCeiling
    
    push esi
    mov ebx, esi
    mov qBlockHit[ebx], 1
    inc coins
    call PlayCoinSound
    add score, 10
    
    cmp coins, BOSS_COINS_NEEDED
    jne NoUnlockCeiling
    cmp bossUnlocked, 1
    je NoUnlockCeiling
    mov bossUnlocked, 1
    call ShowBossUnlockedMessage
    
NoUnlockCeiling:
    mov dl, qBlockX[ebx]
    inc dl
    mov dh, qBlockY[ebx]
    sub dh, 2
    call Gotoxy
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov al, 'O'
    call WriteChar
    mov al, '+'
    call WriteChar
    mov al, '1'
    call WriteChar
    mov al, '0'
    call WriteChar
    
    mov eax, 500
    call Delay
    
    mov dl, qBlockX[ebx]
    inc dl
    mov dh, qBlockY[ebx]
    sub dh, 2
    call Gotoxy
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    
    pop esi
    pop edx
    pop ecx
    pop ebx
    mov al, 1
    ret
    
NextQBlockCeiling:
    inc esi
    jmp CheckQBlockCeiling
    
CheckBossCeiling:
    mov esi, 0
CheckBossQBlockCeiling:
    cmp esi, MAX_BOSS_QBLOCKS
    jge CheckPlatformCeiling
    
    mov al, bossQBlockHit[esi]
    cmp al, 1
    je NextBossQBlockCeiling
    
    movzx eax, bossQBlockX[esi]
    mov cl, al
    add al, QBLOCK_WIDTH
    mov ch, al
    
    movzx eax, bossQBlockY[esi]
    mov dl, al
    
    mov al, xPos
    cmp al, cl
    jl NextBossQBlockCeiling
    cmp al, ch
    jge NextBossQBlockCeiling
    
    mov al, yPos
    dec al
    mov ah, dl
    inc ah
    cmp al, ah
    jne NextBossQBlockCeiling
    
    push esi
    mov ebx, esi
    mov bossQBlockHit[ebx], 1
    inc coins
    call PlayCoinSound
    add score, 15
    
    mov dl, bossQBlockX[ebx]
    inc dl
    mov dh, bossQBlockY[ebx]
    sub dh, 2
    call Gotoxy
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov al, 'O'
    call WriteChar
    mov al, '+'
    call WriteChar
    mov al, '1'
    call WriteChar
    mov al, '5'
    call WriteChar
    
    mov eax, 500
    call Delay
    
    mov dl, bossQBlockX[ebx]
    inc dl
    mov dh, bossQBlockY[ebx]
    sub dh, 2
    call Gotoxy
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    
    pop esi
    pop edx
    pop ecx
    pop ebx
    mov al, 1
    ret
    
NextBossQBlockCeiling:
    inc esi
    jmp CheckBossQBlockCeiling
    
CheckPlatformCeiling:
    mov ecx, MAX_PLATFORMS
    mov ebx, 0
CeilingCheckLoop:
    movzx eax, platformX[ebx]
    mov cl, al
    
    movzx eax, platformY[ebx]
    mov dl, al
    
    movzx eax, platformW[ebx]
    mov dh, al
    
    mov al, xPos
    cmp al, cl
    jl SkipCeilingCheck
    add cl, dh
    cmp al, cl
    jge SkipCeilingCheck
    
    mov al, yPos
    dec al
    mov cl, dl
    inc cl
    cmp al, cl
    jne SkipCeilingCheck
    
    pop edx
    pop ecx
    pop ebx
    mov al, 1
    ret
    
SkipCeilingCheck:
    inc ebx
    cmp ebx, MAX_PLATFORMS
    jl CeilingCheckLoop
    
    pop edx
    pop ecx
    pop ebx
    mov al, 0
    ret
CheckCeilingCollision ENDP

; *** FIXED: Boss platform collision now allows jumping ***
CheckPlatformCollision PROC
    mov onPlatform, 0
    mov isInAir, 1
    
    cmp yPos, 23
    jge OnTheGround
    
    cmp currentArea, BOSS_AREA
    je CheckBossPlatforms
    
    call CheckQBlockTopCollision
    cmp onPlatform, 1
    je CollisionDone
    
    cmp currentArea, SECRET_AREA
    jne CheckNormalPipes
    call CheckSecretPipeTopCollision
    cmp onPlatform, 1
    je CollisionDone
    jmp CheckPlatforms
    
CheckNormalPipes:
    call CheckPipeTopCollision
    cmp onPlatform, 1
    je CollisionDone
    jmp CheckPlatforms
    
OnTheGround:
    mov onPlatform, 1
    mov isInAir, 0
    jmp CollisionDone
    
CheckBossPlatforms:
    call CheckBossQBlockTopCollision
    cmp onPlatform, 1
    je CollisionDone
    
    mov ecx, MAX_BOSS_PLATFORMS
    mov ebx, 0
BossPlatformCheckLoop:
    movzx eax, bossPlatformX[ebx]
    mov cl, al
    
    movzx eax, bossPlatformY[ebx]
    mov dl, al
    
    movzx eax, bossPlatformW[ebx]
    mov dh, al
    
    mov al, xPos
    cmp al, cl
    jl SkipThisBossPlatform
    add cl, dh
    cmp al, cl
    jge SkipThisBossPlatform
    
    ; *** FIXED: Only land if falling onto platform ***
    mov al, yPos
cmp al, dl          ; If yPos = platformY - 1 (standing on platform)
je BossPlatformCollisionFound
inc al
cmp al, dl          ; If yPos + 1 = platformY (falling onto platform)
je BossPlatformCollisionFound

    
BossPlatformCollisionFound:
    mov al, dl
    dec al
    mov yPos, al
    mov onPlatform, 1
    mov isInAir, 0
    jmp CollisionDone
    
SkipThisBossPlatform:
    inc ebx
    cmp ebx, MAX_BOSS_PLATFORMS
    jl BossPlatformCheckLoop
    jmp CollisionDone
    
CheckPlatforms:
    mov ecx, MAX_PLATFORMS
    mov ebx, 0
PlatformCheckLoop:
    movzx eax, platformX[ebx]
    mov cl, al
    
    movzx eax, platformY[ebx]
    mov dl, al
    
    movzx eax, platformW[ebx]
    mov dh, al
    
    mov al, xPos
    cmp al, cl
    jl SkipThisPlatform
    add cl, dh
    cmp al, cl
    jge SkipThisPlatform
    
    mov al, yPos
    cmp al, dl
    je PlatformCollisionFound
    add al, 1
    cmp al, dl
    jne SkipThisPlatform
    
PlatformCollisionFound:
    mov al, dl
    dec al
    mov yPos, al
    mov onPlatform, 1
    mov isInAir, 0
    jmp CollisionDone
    
SkipThisPlatform:
    inc ebx
    cmp ebx, MAX_PLATFORMS
    jl PlatformCheckLoop
    
CollisionDone:
    ret
CheckPlatformCollision ENDP

;============ PLAYER MOVEMENT ============

DrawPlayerAtPos PROC
    mov dl, xPos
    mov dh, yPos
    call Gotoxy
    mov eax, green + (blue * 16)
    call SetTextColor
    mov al,"M"
    call WriteChar
    ret
DrawPlayerAtPos ENDP

ErasePlayerAtPos PROC
    mov dl, xPos
    mov dh, yPos
    call Gotoxy
    mov eax, white + (blue * 16)
    call SetTextColor
    mov al," "
    call WriteChar
    ret
ErasePlayerAtPos ENDP

PerformJumpWithMovement PROC
    call PlayJumpSound
    
    mov ecx, 6
JumpUpPhase:
    call CheckCeilingCollision
    cmp al, 1
    je JumpBlocked
    
    call ErasePlayerAtPos
    
    cmp moveDir, 1
    jne CheckMoveRight
    cmp xPos, 0
    jbe SkipMoveLeft
    dec xPos
SkipMoveLeft:
    jmp PerformVerticalJump
    
CheckMoveRight:
    cmp moveDir, 2
    jne PerformVerticalJump
    cmp xPos, 79
    jae SkipMoveRight
    inc xPos
SkipMoveRight:

PerformVerticalJump:
    dec yPos
    call DrawPlayerAtPos
    mov eax, 40
    call Delay
    loop JumpUpPhase
    
JumpBlocked:
    mov ecx, 6
JumpDownPhase:
    call CheckPlatformCollision
    cmp onPlatform, 1
    je JumpLanded
    
    call ErasePlayerAtPos
    
    cmp moveDir, 1
    jne CheckMoveRightDown
    cmp xPos, 0
    jbe SkipMoveLeftDown
    dec xPos
SkipMoveLeftDown:
    jmp PerformVerticalFall
    
CheckMoveRightDown:
    cmp moveDir, 2
    jne PerformVerticalFall
    cmp xPos, 79
    jae SkipMoveRightDown
    inc xPos
SkipMoveRightDown:

PerformVerticalFall:
    inc yPos
    call DrawPlayerAtPos
    mov eax, 40
    call Delay
    loop JumpDownPhase
    
JumpLanded:
    ret
PerformJumpWithMovement ENDP

DrawCoin PROC
    mov dl, xCoinPos
    mov dh, yCoinPos
    call Gotoxy
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov al,'O'
    call WriteChar
    ret
DrawCoin ENDP

PlaceCoin PROC
    mov eax, 80
    call RandomRange
    mov xCoinPos, al
    
    mov eax, 20
    call RandomRange
    add al, 3
    mov yCoinPos, al
    ret
PlaceCoin ENDP

CheckCoinCollection PROC
    cmp currentArea, NORMAL_AREA
    jne NoCoinCollected
    
    mov al, xPos
    cmp al, xCoinPos
    jne NoCoinCollected
    
    mov al, yPos
    cmp al, yCoinPos
    jne NoCoinCollected
    
    inc coins
    call PlayCoinSound
    add score, 10
    
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, 37
    mov dh, 0
    call Gotoxy
    movzx eax, coins
    call WriteDec
    mov al, ' '
    call WriteChar
    
    mov dl, 8
    mov dh, 0
    call Gotoxy
    movzx eax, score
    call WriteDec
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    
    cmp coins, BOSS_COINS_NEEDED
    jne NoUnlockCoin
    cmp bossUnlocked, 1
    je NoUnlockCoin
    mov bossUnlocked, 1
    call ShowBossUnlockedMessage
    
NoUnlockCoin:
    call PlaceCoin
    
NoCoinCollected:
    ret
CheckCoinCollection ENDP

MoveLeftOnly PROC
    cmp xPos, 0
    jbe MoveLeftEnd
    
    cmp currentArea, NORMAL_AREA
    jne SkipPipeCheck
    mov al, xPos
    dec al
    call CheckPipeCollisionHorizontal
    cmp al, 1
    je MoveLeftEnd
    
SkipPipeCheck:
    call ErasePlayerAtPos
    dec xPos
    call CheckPlatformCollision
    cmp isInAir, 1
    jne StillOnGround
    
FallLoop:
    cmp yPos, 23
    jge MoveLeftEnd
    call ErasePlayerAtPos
    inc yPos
    call DrawPlayerAtPos
    mov eax, 50
    call Delay
    call CheckPlatformCollision
    cmp onPlatform, 1
    je MoveLeftEnd
    jmp FallLoop
    
StillOnGround:
    call DrawPlayerAtPos
    
MoveLeftEnd:
    ret
MoveLeftOnly ENDP

MoveRightOnly PROC
    cmp xPos, 79
    jae MoveRightEnd
    
    cmp currentArea, NORMAL_AREA
    jne SkipPipeCheck
    mov al, xPos
    inc al
    call CheckPipeCollisionHorizontal
    cmp al, 1
    je MoveRightEnd
    
SkipPipeCheck:
    call ErasePlayerAtPos
    inc xPos
    call CheckPlatformCollision
    cmp isInAir, 1
    jne StillOnGround
    
FallLoop:
    cmp yPos, 23
    jge MoveRightEnd
    call ErasePlayerAtPos
    inc yPos
    call DrawPlayerAtPos
    mov eax, 50
    call Delay
    call CheckPlatformCollision
    cmp onPlatform, 1
    je MoveRightEnd
    jmp FallLoop
    
StillOnGround:
    call DrawPlayerAtPos
    
MoveRightEnd:
    ret
MoveRightOnly ENDP

CheckForCombo PROC
    mov eax, 100
    call Delay
    call ReadChar
    mov inputChar, al
    ret
CheckForCombo ENDP

ApplyGravity PROC
    call CheckPlatformCollision
    cmp isInAir, 1
    jne GravityDone
    
    cmp yPos, 23
    jge GravityDone
    
    call ErasePlayerAtPos
    inc yPos
    call DrawPlayerAtPos
    
GravityDone:
    ret
ApplyGravity ENDP

;============ BOSS LEVEL PROCEDURES ============

; *** FIXED: Now includes call to DrawPortals ***
DrawBossLevel PROC
    mov eax, gray + (blue * 16)
    call SetTextColor
    mov dh, 2
    mov dl, 0
DrawTopWall:
    cmp dl, 76
    jge TopWallDone
    call Gotoxy
    mov al, '#'
    call WriteChar
    inc dl
    jmp DrawTopWall
    
TopWallDone:
    mov eax, red + (blue * 16)
    call SetTextColor
    mov dh, 24
    mov dl, 0
DrawLava:
    cmp dl, 76
    jge LavaDone
    call Gotoxy
    mov al, '^'
    call WriteChar
    inc dl
    jmp DrawLava
    
LavaDone:
    mov dh, 25
    mov dl, 0
DrawLava2:
    cmp dl, 76
    jge Lava2Done
    call Gotoxy
    mov al, '^'
    call WriteChar
    inc dl
    jmp DrawLava2
    
Lava2Done:
    call DrawBridgeWithGaps
    call DrawBossPlatforms
    call DrawBossCoins
    call DrawQuestionBlocks
    call DrawPortals        ; *** FIXED: Now draws boss portals! ***
    call DrawAxe
    ret
DrawBossLevel ENDP

DrawBridgeWithGaps PROC
    mov eax, brown + (blue * 16)
    call SetTextColor
    mov dh, 23
    mov dl, 0
DrawBridgeLoop:
    cmp dl, 76
    jge BridgeDone
    push edx
    call IsBridgeGap
    pop edx
    cmp al, 1
    je SkipBridgeChar
    call Gotoxy
    mov al, '='
    call WriteChar
SkipBridgeChar:
    inc dl
    jmp DrawBridgeLoop
BridgeDone:
    ret
DrawBridgeWithGaps ENDP

IsBridgeGap PROC
    push ebx
    push ecx
    
    mov ecx, MAX_BRIDGE_GAPS
    mov ebx, 0
CheckGapLoop:
    movzx eax, bridgeGapX[ebx]
    mov cl, al
    movzx eax, bridgeGapW[ebx]
    add al, cl
    mov ch, al
    
    mov al, dl
    cmp al, cl
    jl NextGap
    cmp al, ch
    jge NextGap
    
    pop ecx
    pop ebx
    mov al, 1
    ret
    
NextGap:
    inc ebx
    cmp ebx, MAX_BRIDGE_GAPS
    jl CheckGapLoop
    
    pop ecx
    pop ebx
    mov al, 0
    ret
IsBridgeGap ENDP

DrawBossCoins PROC
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov ecx, MAX_BOSS_COINS
    mov ebx, 0
BossCoinLoop:
    mov al, bossCoinCollected[ebx]
    cmp al, 1
    je SkipBossCoin
    
    mov dl, bossCoinX[ebx]
    mov dh, bossCoinY[ebx]
    call Gotoxy
    mov al, 'O'
    call WriteChar
    
SkipBossCoin:
    inc ebx
    loop BossCoinLoop
    ret
DrawBossCoins ENDP

CheckBossCoinCollection PROC
    mov ecx, MAX_BOSS_COINS
    mov ebx, 0
BossCoinCheckLoop:
    mov al, bossCoinCollected[ebx]
    cmp al, 1
    je NextBossCoin
    
    mov al, bossCoinX[ebx]
    cmp al, xPos
    jne NextBossCoin
    
    mov al, bossCoinY[ebx]
    cmp al, yPos
    jne NextBossCoin
    
    mov bossCoinCollected[ebx], 1
    inc coins
    call PlayCoinSound
    add score, 20
    
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, 37
    mov dh, 0
    call Gotoxy
    movzx eax, coins
    call WriteDec
    mov al, ' '
    call WriteChar
    
    mov dl, 8
    mov dh, 0
    call Gotoxy
    movzx eax, score
    call WriteDec
    mov al, ' '
    call WriteChar
    mov al, ' '
    call WriteChar
    ret
    
NextBossCoin:
    inc ebx
    dec ecx
    cmp ecx, 0
    je BossCoinCheckDone
    jmp BossCoinCheckLoop
    
BossCoinCheckDone:
    ret
CheckBossCoinCollection ENDP

CheckBridgeGapFall PROC
    cmp yPos, 23
    jne NoGapFall
    
    mov dl, xPos
    call IsBridgeGap
    cmp al, 1
    jne NoGapFall
    inc yPos
    
NoGapFall:
    ret
CheckBridgeGapFall ENDP

DrawBossPlatforms PROC
    mov eax, gray + (blue * 16)
    call SetTextColor
    mov ecx, MAX_BOSS_PLATFORMS
    mov ebx, 0
BossPlatformLoop:
    mov al, bossPlatformX[ebx]
    mov dl, al
    mov al, bossPlatformY[ebx]
    mov dh, al
    call Gotoxy
    mov edx, OFFSET bossPlatformStr
    call WriteString
    inc ebx
    loop BossPlatformLoop
    ret
DrawBossPlatforms ENDP

DrawAxe PROC
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, axeX
    mov dh, axeY
    call Gotoxy
    mov al, 'X'
    call WriteChar
    ret
DrawAxe ENDP

DrawBowser PROC
    cmp bowserActive, 1
    jne NoBowser
    
    mov eax, red + (blue * 16)
    call SetTextColor
    mov dl, bowserX
    mov dh, bowserY
    call Gotoxy
    mov al, 'B'
    call WriteChar
    
NoBowser:
    ret
DrawBowser ENDP

MoveBowser PROC
    cmp bowserActive, 1
    jne NoMoveBowser
    
    mov dl, bowserX
    mov dh, bowserY
    call Gotoxy
    mov al, ' '
    call WriteChar
    
    mov al, bowserDir
    cmp al, 0
    je MoveBowserLeft
    
MoveBowserRight:
    mov al, bowserX
    add al, 2
    cmp al, bowserRightBound
    jge ChangeBowserToLeft
    add bowserX, 2
    jmp NoMoveBowser
    
ChangeBowserToLeft:
    mov bowserDir, 0
    jmp NoMoveBowser
    
MoveBowserLeft:
    mov al, bowserX
    sub al, 2
    cmp al, bowserLeftBound
    jle ChangeBowserToRight
    sub bowserX, 2
    jmp NoMoveBowser
    
ChangeBowserToRight:
    mov bowserDir, 1
    
NoMoveBowser:
    ret
MoveBowser ENDP

ShootBowserFireball PROC
    mov ecx, MAX_BOWSER_FIREBALLS
    mov ebx, 0
FindInactiveFireball:
    mov al, bowserFireballActive[ebx]
    cmp al, 0
    je FoundInactive
    inc ebx
    loop FindInactiveFireball
    ret
    
FoundInactive:
    mov bowserFireballActive[ebx], 1
    mov al, bowserX
    sub al, 2
    mov bowserFireballX[ebx], al
    mov al, bowserY
    mov bowserFireballY[ebx], al
    mov bowserFireballDir[ebx], 0
    ret
ShootBowserFireball ENDP

MoveBowserFireballs PROC
    mov ecx, MAX_BOWSER_FIREBALLS
    mov ebx, 0
MoveFireballLoop:
    mov al, bowserFireballActive[ebx]
    cmp al, 0
    je SkipFireball
    
    mov dl, bowserFireballX[ebx]
    mov dh, bowserFireballY[ebx]
    call Gotoxy
    mov al, ' '
    call WriteChar
    
    mov al, bowserFireballX[ebx]
    sub al, 3
    cmp al, 0
    jle DeactivateFireball
    sub bowserFireballX[ebx], 3
    jmp SkipFireball
    
DeactivateFireball:
    mov bowserFireballActive[ebx], 0
    
SkipFireball:
    inc ebx
    loop MoveFireballLoop
    ret
MoveBowserFireballs ENDP

DrawBowserFireballs PROC
    mov eax, red + (blue * 16)
    call SetTextColor
    mov ecx, MAX_BOWSER_FIREBALLS
    mov ebx, 0
DrawFireballLoop:
    mov al, bowserFireballActive[ebx]
    cmp al, 0
    je SkipDrawFireball
    
    mov dl, bowserFireballX[ebx]
    mov dh, bowserFireballY[ebx]
    call Gotoxy
    mov al, '*'
    call WriteChar
    
SkipDrawFireball:
    inc ebx
    loop DrawFireballLoop
    ret
DrawBowserFireballs ENDP

DrawFireObstacles PROC
    mov eax, red + (blue * 16)
    call SetTextColor
    mov ecx, MAX_FIRE_OBSTACLES
    mov ebx, 0
FireObstacleLoop:
    mov al, fireObstacleActive[ebx]
    cmp al, 0
    je SkipFireObstacle
    
    mov dl, fireObstacleX[ebx]
    mov dh, fireObstacleY[ebx]
    
    mov al, fireObstaclePhase[ebx]
    and al, 3
    cmp al, 0
    je DrawPhase0
    cmp al, 1
    je DrawPhase1
    cmp al, 2
    je DrawPhase2
    jmp DrawPhase3
    
DrawPhase0:
    call Gotoxy
    mov al, 'o'
    call WriteChar
    jmp NextFireObstacle
    
DrawPhase1:
    dec dh
    call Gotoxy
    mov al, 'o'
    call WriteChar
    jmp NextFireObstacle
    
DrawPhase2:
    dec dh
    dec dh
    call Gotoxy
    mov al, 'o'
    call WriteChar
    jmp NextFireObstacle
    
DrawPhase3:
    dec dh
    call Gotoxy
    mov al, 'o'
    call WriteChar
    
NextFireObstacle:
    inc ebx
    loop FireObstacleLoop
    ret
    
SkipFireObstacle:
    inc ebx
    loop FireObstacleLoop
    ret
DrawFireObstacles ENDP

UpdateFireObstacles PROC
    mov ecx, MAX_FIRE_OBSTACLES
    mov ebx, 0
UpdateFireLoop:
    add fireObstaclePhase[ebx], 2
    inc ebx
    loop UpdateFireLoop
    ret
UpdateFireObstacles ENDP

CheckBowserFireballCollision PROC
    mov ecx, MAX_BOWSER_FIREBALLS
    mov ebx, 0
CheckFireballLoop:
    mov al, bowserFireballActive[ebx]
    cmp al, 0
    je SkipFireballCheck
    
    mov al, xPos
    cmp al, bowserFireballX[ebx]
    jne SkipFireballCheck
    
    mov al, yPos
    cmp al, bowserFireballY[ebx]
    jne SkipFireballCheck
    
    call ShowDeathMessage
    dec lives
    cmp lives, 0
    jle BossGameOver
    
    mov xPos, 10
    mov yPos, 23
    ret
    
SkipFireballCheck:
    inc ebx
    loop CheckFireballLoop
    ret
    
BossGameOver:
    call SaveHighScore
    
    call Clrscr
    mov eax, red + (blue * 16)
    call SetTextColor
    mov dl, 35
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET gameOverMsg
    call WriteString
    mov eax, 3000
    call Delay
    jmp main
CheckBowserFireballCollision ENDP

CheckFireObstacleCollision PROC
    mov ecx, MAX_FIRE_OBSTACLES
    mov ebx, 0
CheckFireObstLoop:
    mov al, fireObstacleActive[ebx]
    cmp al, 0
    je SkipFireObstCheck
    
    mov al, xPos
    cmp al, fireObstacleX[ebx]
    jne SkipFireObstCheck
    
    mov al, yPos
    mov cl, fireObstacleY[ebx]
    sub cl, 2
    cmp al, cl
    jl SkipFireObstCheck
    
    mov cl, fireObstacleY[ebx]
    cmp al, cl
    jg SkipFireObstCheck
    
    call ShowDeathMessage
    dec lives
    cmp lives, 0
    jle FireObstGameOver
    
    mov xPos, 10
    mov yPos, 23
    ret
    
SkipFireObstCheck:
    inc ebx
    loop CheckFireObstLoop
    ret
    
FireObstGameOver:
    call SaveHighScore
    
    call Clrscr
    mov eax, red + (blue * 16)
    call SetTextColor
    mov dl, 35
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET gameOverMsg
    call WriteString
    mov eax, 3000
    call Delay
    jmp main
CheckFireObstacleCollision ENDP

StartBossLevel PROC
    call GetPlayerName
    call Clrscr
    
    mov score, 0
    mov coins, 0
    mov lives, 5
    mov time, 180
    mov timerCounter, 0
    mov xPos, 10
    mov yPos, 23
    mov moveDir, 0
    mov onPlatform, 0
    mov isInAir, 1
    mov currentArea, BOSS_AREA
    mov frameCounter, 0
    mov bossFrameCounter, 0
    mov portalCooldown, 0        ; *** Reset portal cooldown ***
    
    mov bowserActive, 1
    mov bowserX, 70
    mov bowserY, 23
    mov bowserDir, 0
    mov bowserHealth, 1
    mov bowserFireballCounter, 0
    
    mov ecx, MAX_BOSS_COINS
    mov ebx, 0
ResetBossCoins:
    mov bossCoinCollected[ebx], 0
    inc ebx
    loop ResetBossCoins
    
    mov ecx, MAX_BOSS_QBLOCKS
    mov ebx, 0
ResetBossQBlocks:
    mov bossQBlockHit[ebx], 0
    inc ebx
    loop ResetBossQBlocks
    
    mov ecx, MAX_BOWSER_FIREBALLS
    mov ebx, 0
ResetBowserFireballs:
    mov bowserFireballActive[ebx], 0
    inc ebx
    loop ResetBowserFireballs
    
    mov eax, white + (blue * 16)
    call SetTextColor
    call Randomize
    call PlayBackgroundMusic
    
    call DrawHUD
    call DrawBossLevel
    
BossGameLoop:
    call UpdateTimer
    call CheckDeathPit
    call CheckBridgeGapFall
    call ApplyGravity
    
    ; *** CHECK BOSS PORTALS ***
    call CheckPortalTeleport
    
    inc bossFrameCounter
    mov al, bossFrameCounter
    and al, 00000011b
    cmp al, 0
    jne SkipBossLogic
    
    call MoveBowser
    call MoveBowserFireballs
    call UpdateFireObstacles
    
    inc bowserFireballCounter
    cmp bowserFireballCounter, 8
    jl SkipBowserShoot
    mov bowserFireballCounter, 0
    call ShootBowserFireball
    
SkipBowserShoot:
SkipBossLogic:
    call DrawBossLevel
    call DrawBowser
    call DrawBowserFireballs
    call DrawFireObstacles
    call DrawPlayerAtPos
    
    call CheckBossCoinCollection
    call CheckBowserFireballCollision
    call CheckFireObstacleCollision
    
    mov al, xPos
    cmp al, axeX
    jne NoAxeHit
    mov al, yPos
    cmp al, axeY
    jne NoAxeHit
    
    call SaveHighScore
    
    call Clrscr
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, 30
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET youWinMsg
    call WriteString
    
    mov dl, 30
    mov dh, 11
    call Gotoxy
    mov edx, OFFSET bossDefeatedMsg
    call WriteString
    
    mov dl, 30
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET finalScoreMsg
    call WriteString
    movzx eax, score
    call WriteDec
    
    mov eax, 3000
    call Delay
    jmp main
    
NoAxeHit:
    mov eax, 120
    call Delay
    call ReadKey
    jz BossGameLoop
    
    mov inputChar, al
    
    cmp inputChar, "x"
    je BossEndGameLoop
    cmp inputChar, "p"
    je BossPauseMenu
    cmp inputChar, "w"
    je BossHandleW
    cmp inputChar, "a"
    je BossHandleA
    cmp inputChar, "d"
    je BossHandleD
    jmp BossGameLoop
    
BossHandleW:
    call CheckForCombo
    cmp inputChar, "a"
    je BossJumpLeft
    cmp inputChar, "d"
    je BossJumpRight
    
    mov moveDir, 0
    call PerformJumpWithMovement
    call Clrscr
    call DrawHUD
    call DrawBossLevel
    jmp BossGameLoop
    
BossJumpLeft:
    mov moveDir, 1
    call PerformJumpWithMovement
    call Clrscr
    call DrawHUD
    call DrawBossLevel
    jmp BossGameLoop
    
BossJumpRight:
    mov moveDir, 2
    call PerformJumpWithMovement
    call Clrscr
    call DrawHUD
    call DrawBossLevel
    jmp BossGameLoop
    
BossHandleA:
    call MoveLeftOnly
    jmp BossGameLoop
    
BossHandleD:
    call MoveRightOnly
    jmp BossGameLoop
    
BossPauseMenu:
    call Clrscr
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, PAUSE_COL
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET pauseMsg
    call WriteString
    
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, PAUSEOPT_COL
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET pauseOptionsMsg
    call WriteString
    
BossPauseWaitKey:
    call ReadChar
    cmp al, "r"
    je BossEndPause
    cmp al, "e"
    je BossEndGameLoop
    jmp BossPauseWaitKey
    
BossEndPause:
    call Clrscr
    call DrawHUD
    call DrawBossLevel
    jmp BossGameLoop
    
BossEndGameLoop:
    call Clrscr
    ret
StartBossLevel ENDP

;============ GAME START AND MENU ============

StartGame PROC
    call GetPlayerName
    call Clrscr
    
    mov score, 0
    mov coins, 0
    mov lives, 5
    mov time, 180
    mov timerCounter, 0
    mov xPos, 20
    mov yPos, 23
    mov moveDir, 0
    mov onPlatform, 0
    mov isInAir, 1
    mov currentArea, NORMAL_AREA
    mov frameCounter, 0
    mov portalCooldown, 0
    
    mov ecx, MAX_QBLOCKS
    mov ebx, 0
ResetQBlocks:
    mov qBlockHit[ebx], 0
    inc ebx
    loop ResetQBlocks
    
    mov ecx, MAX_ENEMIES
    mov ebx, 0
ResetEnemies:
    mov enemyActive[ebx], 1
    inc ebx
    loop ResetEnemies
    
    mov eax, white + (blue * 16)
    call SetTextColor
    call Randomize
    call PlayBackgroundMusic
    call PlaceCoin
    
    call DrawHUD
    call DrawGround
    call DrawClouds
    call DrawPlatforms
    call DrawPipes
    call DrawQuestionBlocks
    call DrawPortals
    
GameLoop:
    call UpdateTimer
    call CheckDeathPit
    
    cmp currentArea, SECRET_AREA
    je SecretAreaLoop
    
    call ApplyGravity
    call CheckPortalTeleport
    
    inc frameCounter
    mov al, frameCounter
    and al, 00000011b
    cmp al, 0
    jne SkipEnemyMove
    call MoveEnemies
    
SkipEnemyMove:
    call DrawEnemies
    call DrawCoin
    call CheckCoinCollection
    call DrawPortals
    call DrawPlayerAtPos
    call CheckEnemyCollision
    
    mov eax, 120
    call Delay
    call ReadKey
    jz GameLoop
    
    mov inputChar, al
    
    cmp inputChar, "x"
    je EndGameLoop
    cmp inputChar, "p"
    je PauseMenu
    cmp inputChar, "s"
    je HandleS
    cmp inputChar, "w"
    je HandleW
    cmp inputChar, "a"
    je HandleA
    cmp inputChar, "d"
    je HandleD
    jmp GameLoop
    
SecretAreaLoop:
    call UpdateTimer
    call Clrscr
    call DrawHUD
    call DrawSecretArea
    call ApplyGravity
    call DrawPlayerAtPos
    call CheckSecretCoinCollection
    
    mov eax, 120
    call Delay
    call ReadKey
    jz SecretAreaLoop
    
    mov inputChar, al
    
    cmp inputChar, "x"
    je EndGameLoop
    cmp inputChar, "p"
    je PauseMenu
    cmp inputChar, "s"
    je HandleSSecret
    cmp inputChar, "w"
    je HandleWSecret
    cmp inputChar, "a"
    je HandleASecret
    cmp inputChar, "d"
    je HandleDSecret
    jmp SecretAreaLoop
    
HandleS:
    call CheckPipeEntry
    cmp currentArea, SECRET_AREA
    jne StayNormal
    jmp SecretAreaLoop
    
StayNormal:
    jmp GameLoop
    
HandleSSecret:
    call CheckPipeEntry
    cmp currentArea, NORMAL_AREA
    jne StaySecret
    
    call Clrscr
    call DrawHUD
    call DrawGround
    call DrawClouds
    call DrawPlatforms
    call DrawPipes
    call DrawQuestionBlocks
    call DrawPortals
    call DrawEnemies
    call DrawCoin
    call DrawPlayerAtPos
    jmp GameLoop
    
StaySecret:
    jmp SecretAreaLoop
    
HandleW:
    call CheckForCombo
    cmp inputChar, "a"
    je JumpLeft
    cmp inputChar, "d"
    je JumpRight
    
    mov moveDir, 0
    call PerformJumpWithMovement
    call CheckCoinCollection
    call Clrscr
    call DrawHUD
    call DrawGround
    call DrawClouds
    call DrawPlatforms
    call DrawPipes
    call DrawQuestionBlocks
    call DrawPortals
    jmp GameLoop
    
JumpLeft:
    mov moveDir, 1
    call PerformJumpWithMovement
    call CheckCoinCollection
    call Clrscr
    call DrawHUD
    call DrawGround
    call DrawClouds
    call DrawPlatforms
    call DrawPipes
    call DrawQuestionBlocks
    call DrawPortals
    jmp GameLoop
    
JumpRight:
    mov moveDir, 2
    call PerformJumpWithMovement
    call CheckCoinCollection
    call Clrscr
    call DrawHUD
    call DrawGround
    call DrawClouds
    call DrawPlatforms
    call DrawPipes
    call DrawQuestionBlocks
    call DrawPortals
    jmp GameLoop
    
HandleWSecret:
    call CheckForCombo
    cmp inputChar, "a"
    je JumpLeftSecret
    cmp inputChar, "d"
    je JumpRightSecret
    
    mov moveDir, 0
    call PerformJumpWithMovement
    jmp SecretAreaLoop
    
JumpLeftSecret:
    mov moveDir, 1
    call PerformJumpWithMovement
    jmp SecretAreaLoop
    
JumpRightSecret:
    mov moveDir, 2
    call PerformJumpWithMovement
    jmp SecretAreaLoop
    
HandleA:
    call MoveLeftOnly
    call CheckCoinCollection
    jmp GameLoop
    
HandleD:
    call MoveRightOnly
    call CheckCoinCollection
    jmp GameLoop
    
HandleASecret:
    call MoveLeftOnly
    jmp SecretAreaLoop
    
HandleDSecret:
    call MoveRightOnly
    jmp SecretAreaLoop
    
PauseMenu:
    call Clrscr
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, PAUSE_COL
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET pauseMsg
    call WriteString
    
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, PAUSEOPT_COL
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET pauseOptionsMsg
    call WriteString
    
PauseWaitKey:
    call ReadChar
    cmp al, "r"
    je EndPause
    cmp al, "e"
    je EndGameLoop
    jmp PauseWaitKey
    
EndPause:
    call Clrscr
    cmp currentArea, SECRET_AREA
    je RedrawSecret
    
    call DrawHUD
    call DrawGround
    call DrawClouds
    call DrawPlatforms
    call DrawPipes
    call DrawQuestionBlocks
    call DrawPortals
    jmp GameLoop
    
RedrawSecret:
    call DrawSecretArea
    call DrawHUD
    jmp SecretAreaLoop
    
EndGameLoop:
    call Clrscr
    ret
StartGame ENDP

ShowHighScores PROC
    call DisplayHighScoresFromFile
    ret
ShowHighScores ENDP

ShowInstructions PROC
    call Clrscr
    mov eax, white + (blue * 16)
    call SetTextColor
    mov dl, INSTR_COL
    mov dh, 13
    call Gotoxy
    mov edx, OFFSET instructionsMsg
    call WriteString
    mov eax, 2000
    call Delay
    ret
ShowInstructions ENDP

ExitProgram PROC
    call StopAllSounds
    exit
ExitProgram ENDP

ShowMainMenu PROC
MenuInputLoop:
    call Clrscr
    mov eax, white + (blue * 16)
    call SetTextColor
    
    mov dl, MENU1_COL
    mov dh, 10
    call Gotoxy
    mov edx, OFFSET menu1
    call WriteString
    
    mov dl, MENU2_COL
    mov dh, 12
    call Gotoxy
    mov edx, OFFSET menu2
    call WriteString
    
    mov dl, MENU3_COL
    mov dh, 14
    call Gotoxy
    mov edx, OFFSET menu3
    call WriteString
    
    mov dl, MENU4_COL
    mov dh, 16
    call Gotoxy
    mov edx, OFFSET menu4
    call WriteString
    
    mov dl, MENU5_COL
    mov dh, 18
    call Gotoxy
    mov edx, OFFSET menu5
    call WriteString
    
    mov eax, yellow + (blue * 16)
    call SetTextColor
    mov dl, PROMPT_COL
    mov dh, 20
    call Gotoxy
    mov edx, OFFSET inputPrompt
    call WriteString
    
    call ReadChar
    mov userChoice, al
    
    cmp al, '1'
    je ValidMenu
    cmp al, '2'
    je ValidMenu
    cmp al, '3'
    je ValidMenu
    cmp al, '4'
    je ValidMenu
    cmp al, '5'
    je ValidMenu
    
    mov eax, red + (blue * 16)
call SetTextColor
    mov dl, INVALID_COL
    mov dh, 22
    call Gotoxy
    mov edx, OFFSET invalidMsg
    call WriteString
    mov eax, 1000
    call Delay
    jmp MenuInputLoop
    
ValidMenu:
    mov al, userChoice
    ret
ShowMainMenu ENDP

END main