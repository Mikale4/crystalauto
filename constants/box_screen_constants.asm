; the PC's box screen (see engine/pokemon/box_screen.asm)

; where the cursor is (wBoxScreenZone; and wBoxScreenHeld, where it's from)
	const_def 1
	const BOXZONE_HEADER ; 1: the box's name
	const BOXZONE_BOX    ; 2
	const BOXZONE_PARTY  ; 3

; background palettes
	const_def
	const BOXPAL_TEXT   ; 0
	const BOXPAL_MON    ; 1: the POKéMON's pic
	const BOXPAL_RED    ; 2: the icons' colors
	const BOXPAL_BLUE   ; 3
	const BOXPAL_GREEN  ; 4
	const BOXPAL_YELLOW ; 5
	const BOXPAL_PURPLE ; 6
	const BOXPAL_GRAY   ; 7
DEF NUM_BOX_ICON_COLORS EQU const_value - BOXPAL_RED

DEF BOX_COLS EQU 5
DEF BOX_ROWS EQU 4
	assert BOX_COLS * BOX_ROWS == MONS_PER_BOX
DEF BOXSCREEN_PARTY_COLS EQU 2
DEF BOXSCREEN_PARTY_ROWS EQU 3
	assert BOXSCREEN_PARTY_COLS * BOXSCREEN_PARTY_ROWS == PARTY_LENGTH

; the icons' part of the screen (the "canvas"): rows 8-17, a tile of its own each
DEF BOXSCREEN_CANVAS_Y EQU 8
DEF BOXSCREEN_CANVAS_TILES EQU SCREEN_WIDTH * (SCREEN_HEIGHT - BOXSCREEN_CANVAS_Y)
; where the icons are in it (pixels): 20 apart, so no tile has two
DEF BOXSCREEN_BOX_X EQU 4
DEF BOXSCREEN_BOX_Y EQU 4
DEF BOXSCREEN_PARTY_X EQU 112
DEF BOXSCREEN_PARTY_Y EQU 4
DEF BOXSCREEN_ICON_PITCH EQU 20
DEF BOXSCREEN_PARTY_PITCH_X EQU 24

; sprite tiles (vTiles0)
DEF BOXSCREEN_CURSOR_TILE EQU $00
DEF BOXSCREEN_HELD_TILE EQU $04 ; (two frames, 8 tiles)
