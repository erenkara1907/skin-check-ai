-- Fix zone_enum to match the values used by the analyze-skin edge function
-- and the Flutter client (SkinZone enum).
--
-- DB had:    forehead, nose, cheek_left, cheek_right, chin, eye_area, lip_area
-- Needed:   forehead, nose, left_cheek, right_cheek, chin, under_eyes, jawline

-- Rename mismatched enum values
ALTER TYPE zone_enum RENAME VALUE 'cheek_left'  TO 'left_cheek';
ALTER TYPE zone_enum RENAME VALUE 'cheek_right' TO 'right_cheek';
ALTER TYPE zone_enum RENAME VALUE 'eye_area'    TO 'under_eyes';
ALTER TYPE zone_enum RENAME VALUE 'lip_area'    TO 'jawline';
