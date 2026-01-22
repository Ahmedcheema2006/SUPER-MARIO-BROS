
# SUPER MARIO BROS - x86 Assembly Game Project

A fully functional 2D platformer built entirely in **x86 Assembly** using MASM32 and the Irvine32 library.

## Gameplay Link
*[Add your gameplay video/demo link here]*

***

## Project Description

Super Mario Bros is a complete recreation of the classic platformer developed as a final project for the Computer Organization and Assembly Language course. Built from scratch in x86 Assembly, the game features multi-level gameplay, enemy AI, boss battles, physics-based movement, collision detection, a creative bidirectional portal teleportation system, audio integration, and persistent high score tracking. The objective is to navigate platforms, defeat enemies, collect coins, and defeat Bowser in the boss level. The project demonstrates low-level programming concepts including memory management, procedural design, Windows API integration, and real-time rendering.

***

## Features

- **Custom Green Mario** - Roll number-based color customization 
- **Bidirectional Portal System** - Innovative teleportation using blue/orange portal pairs
- **Three Game Levels** - Normal platforming, secret underground area, boss arena
- **Enemy AI** - Goomba patrol patterns with boundary detection and stomp mechanics
- **Boss Battle** - Fight Bowser with fireball attacks, lava hazards, and bridge gaps
- **Physics Engine** - Gravity, jumping, platform collision, and smooth landing
- **Question Blocks** - Hit blocks from below to collect coins
- **Pipe System** - Enter pipes to access secret underground bonus area
- **Audio Integration** - Background music, coin collection, and jump sound effects via Windows Multimedia API
- **Score System** - File-based high score persistence with player names
- **HUD Display** - Real-time score, coins, lives, timer, and level indicator
- **Lives System** - Start with 5 lives, respawn on death
- **Timer Mechanic** - 180-second countdown per level

***

## Project Structure

**Developer:**
- Muhammad Ahmed Cheema ([LinkedIn](https://www.linkedin.com/in/muhammad-ahmed-cheema-75b454327/))


**Course:** Computer Organization and Assembly Language  
**Platform:** x86 Assembly (MASM32)  
**Lines of Code:** 4500+

***

## Core Systems and Logic

### Portal Teleportation System (Creative Feature)
- **3 Portal Pairs per Level** - Blue (entry) and Orange (destination) portals
- **Bidirectional Travel** - Can teleport Blue→Orange OR Orange→Blue
- **2-Tile Radius Detection** - Automatic activation when near portal
- **Cooldown System** - 30-frame cooldown prevents rapid re-teleportation
- **Visual Animation** - 3-frame teleport effect (star → plus → Mario)
- **Bonus Points** - +10 (Normal), +15 (Boss Level)
- **Strategic Placement** - Ground level entries, platform destinations

### Level Design
- **Normal Level:** 5 platforms, 3 pipes, 4 clouds, multiple question blocks
- **Secret Area:** 8 bonus coins, exit pipe back to normal level
- **Boss Level:** 3 suspended platforms, bridge with gaps, lava floor, fire obstacles

### Movement & Physics
- **Controls:** WASD for movement, W for jump
- **Gravity System** - Continuous downward force when airborne
- **Platform Collision** - Land on platforms, pipes, and question blocks
- **Jump Mechanics** - 6-frame ascent and descent with directional control
- **Boundary Detection** - Screen edges and obstacle collision

### Enemy System
- **Goomba AI** - 4 enemies with left/right patrol patterns
- **Boundary Awareness** - Turn around at defined limits and pipe obstacles
- **Stomp Mechanic** - Jump on enemies from above for +100 points
- **Death on Contact** - Lose life if touching enemy without stomping

### Boss Battle
- **Bowser Movement** - Left/right patrol across arena
- **Fireball Attacks** - Shoots 3 projectiles that travel across screen
- **Fire Obstacles** - 4 animated vertical fire columns
- **Lava Death Zone** - Instant death at Y ≥ 24
- **Bridge Gaps** - 4 gaps in bridge requiring precise jumping
- **Axe Goal** - Reach axe to complete level and win game

### Scoring & Collectibles
- **Coins:** +10 points each, random spawn + question blocks
- **Enemy Defeat:** +100 points per stomp
- **Boss Coins:** +20 points (7 total in boss level)
- **Portal Usage:** +10-15 bonus points
- **Boss Unlock:** Collect 5 coins to access boss level
- **High Score File:** Top score saved to `scores.txt` with player name

### Audio System
- **Background Music** - Looping .wav playback via MCI commands
- **Coin Sound** - Plays on collection
- **Jump Sound** - Plays on jump action
- **Windows API Integration** - `mciSendStringA` for audio control

### Game States
- **Main Menu** - Start Game, High Scores, Instructions, Boss Level, Exit
- **Pause System** - Press P to pause, R to resume, E to exit
- **Death & Respawn** - Lose life on fall (Y ≥ 28) or enemy contact
- **Game Over** - Display final score and return to menu when lives = 0
- **Timer** - 180-second countdown, game over when time expires

***

## Prerequisites

- **Assembler:** MASM32 (Microsoft Macro Assembler)
- **Library:** Irvine32.inc ([Download](http://www.asmirvine.com/))
- **OS:** Windows (Console Application)
- **Audio Files:** background.wav, coin.wav, jump.wav

***

## How to Build & Run

### Using Visual Studio

1. Install MASM32 SDK
2. Create new Win32 Console Application project
3. Add `mario.asm` to project
4. Link Irvine32.lib, kernel32.lib, user32.lib, winmm.lib
5. Set SubSystem to Console
6. Build and Run (Ctrl+F5)

### Using Command Line

```bash
ml /c /Zi mario.asm
link mario.obj Irvine32.lib kernel32.lib user32.lib winmm.lib /SUBSYSTEM:CONSOLE
mario.exe
```

Ensure `.wav` audio files are in the same directory as the executable.

***

## Project Files

- **mario.asm** - Main game source code (4500+ lines)
- **scores.txt** - High score persistence file
- **background.wav** - Background music
- **coin.wav** - Coin collection sound
- **jump.wav** - Jump sound effect

***

## Technical Implementation

### Key Procedures
| Procedure | Purpose |
|-----------|---------|
| `DrawPortals` | Renders bidirectional portal system |
| `CheckPortalTeleport` | Detects proximity and activates teleportation |
| `ShowTeleportAnimation` | 3-frame visual teleport effect |
| `CheckPlatformCollision` | Platform landing detection |
| `MoveEnemies` | Goomba AI patrol logic |
| `MoveBowser` | Boss movement and fireball shooting |
| `PerformJumpWithMovement` | Physics-based jump with directional control |
| `SaveHighScore` | File I/O for score persistence |
| `UpdateTimer` | Real-time countdown timer |

### Assembly Concepts Demonstrated
- Procedural programming with 50+ procedures
- Memory management with data segment arrays
- Stack operations (push/pop) for register preservation
- Conditional branching and loop structures
- Windows API integration (Console, Multimedia)
- File I/O operations (CreateFile, WriteFile, ReadFile)
- Real-time input handling (ReadChar)
- Color text rendering (SetTextColor)
- Coordinate-based graphics (Gotoxy)

***

## Customization (Roll 0601)

### Green Mario Theme
```assembly
DrawPlayerAtPos PROC
    mov eax, green + (blue * 16)  ; Custom color
    call SetTextColor
    mov al, 'M'
    call WriteChar
    ret
DrawPlayerAtPos ENDP
```

### Portal Arrays
```assembly
; Normal Level Portals
portalBlueX    BYTE 8, 30, 7      ; Entry points
portalBlueY    BYTE 23, 23, 18
portalOrangeX  BYTE 42, 62, 17    ; Destinations
portalOrangeY  BYTE 12, 14, 10

; Boss Level Portals
bossPortalBlueX   BYTE 12, 35, 58
bossPortalBlueY   BYTE 23, 23, 23
bossPortalOrangeX BYTE 22, 47, 67
bossPortalOrangeY BYTE 17, 14, 17
```

***

## Controls

| Key | Action |
|-----|--------|
| **W** | Jump |
| **A** | Move Left |
| **D** | Move Right |
| **S** | Enter Pipe (when on enterable pipe) |
| **P** | Pause Game |
| **X** | Exit to Menu |

***

## Game Statistics

| Feature | Count |
|---------|-------|
| Total Portals | 12 (6 per level type) |
| Platforms | 8 (5 normal + 3 boss) |
| Enemies | 5 (4 Goombas + Bowser) |
| Question Blocks | 9 (5 normal + 4 boss) |
| Secret Coins | 8 |
| Lives | 5 |
| Time Limit | 180 seconds |

***

## Limitations

- Console-based rendering (80x26 character grid)
- No sprite graphics (ASCII characters only)
- Single-threaded execution
- Windows-only compatibility
- Fixed 16-color palette

***

## Conclusion

The Super Mario Bros project successfully demonstrates mastery of x86 Assembly language programming through a complete game implementation. It combines low-level system concepts, procedural design, memory management, Windows API integration, and creative gameplay mechanics (portal system). The project showcases the capability to build complex, interactive applications using only Assembly language and basic system libraries.

***

## Author

**Muhammad Ahmed Cheema**  
[LinkedIn Profile](https://www.linkedin.com/in/muhammad-ahmed-cheema-75b454327/)

This project was developed as the final project for the Computer Organization and Assembly Language course.

***

**© 2025 Ahmed Cheema. All rights reserved.**
