; constants for the 16-bit move index table (see engine/16/move_table.asm),
; from pokecrystal16 (https://github.com/vulcandth/pokecrystal16):
; _ENTRIES: number of entries in the table; 8-bit IDs $01, $02, ..., _ENTRIES stand for table entries
; _LOCKED_ENTRIES: number of entries in a reserved ID array; valid IDs stored in it are kept from being
;                  freed when the table is garbage collected to make room for new entries
; _CACHE_SIZE: number of entries in a fast-retrieval cache table (a power of two, or zero for none)
; _SAVED_RECENT_INDEXES: circular buffer of recently-allocated IDs, keeping them from being freed, so code
;                        can allocate several IDs at once
; _MINIMUM_RESERVED_INDEX: the lowest 8-bit ID that is a special value, not handled through the table: such
;                          IDs stand for $FF00 + ID (so $FF, often a terminator, stays $FF: -1)

DEF MOVE_TABLE_ENTRIES                EQU 254
DEF MOVE_TABLE_LOCKED_ENTRIES         EQU   4
DEF MOVE_TABLE_CACHE_SIZE             EQU  16
DEF MOVE_TABLE_SAVED_RECENT_INDEXES   EQU  16
DEF MOVE_TABLE_MINIMUM_RESERVED_INDEX EQU $FF

; locked move IDs (see LockMoveID)
	const_def
	const LOCKED_MOVE_ID_1
DEF NUM_LOCKED_MOVE_IDS EQU const_value
	assert NUM_LOCKED_MOVE_IDS <= MOVE_TABLE_LOCKED_ENTRIES
