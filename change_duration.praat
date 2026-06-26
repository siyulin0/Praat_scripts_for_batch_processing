###################################################
#
#
# This script can be used to change durations for files in the same folder
#
# updated 06/26/2026 SL
# 
####################################################


form Bulk proportional duration change
    sentence Input_folder /Users/yourname/Desktop/input/
    sentence Output_folder /Users/yourname/Desktop/output/
    positive Duration_factor 1.5
    positive Time_step 0.01
    positive Pitch_floor 75
    positive Pitch_ceiling 600
endform

# Make sure folders end with / on Mac/Linux
# On Windows, use something like: C:/Users/yourname/Desktop/input/

Create Strings as file list: "fileList", input_folder$ + "*.wav"
fileList = selected("Strings")
nFiles = Get number of strings

for i from 1 to nFiles
    selectObject: fileList
    fileName$ = Get string: i

    Read from file: input_folder$ + fileName$
    sound = selected("Sound")
    soundName$ = selected$("Sound")
    originalDuration = Get total duration

    # Create Manipulation object
    To Manipulation: time_step, pitch_floor, pitch_ceiling
    manipulation = selected("Manipulation")

    # Create a constant DurationTier:
    # duration_factor > 1 lengthens; < 1 shortens
    Create DurationTier: "durationTier", 0, originalDuration
    durationTier = selected("DurationTier")
    Add point: 0, duration_factor
    Add point: originalDuration, duration_factor

    # Replace duration tier and resynthesize
    selectObject: manipulation, durationTier
    Replace duration tier

    selectObject: manipulation
    Get resynthesis (overlap-add)
    newSound = selected("Sound")

    Rename: soundName$ + "_dur" + fixed$(duration_factor, 2)
    Save as WAV file: output_folder$ + selected$("Sound") + ".wav"

    removeObject: sound, manipulation, durationTier, newSound
endfor

removeObject: fileList
