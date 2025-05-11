###################################################
#
#
# Change gender for all files in a folder 
# This script loads audio files from a specified folder, concatenates them into a single audio stream, applies the Change Gender function to the entire stream, then splits it back into individual files and saves each modified file to the output folder.
#
# updated 05/11/2025 SL
# 
####################################################


form Change gender
    sentence inputdir C:/Users/
    sentence outputdir C:/Users/
    comment Pitch measurement parameters
    positive pitch_floor 75
    positive pitch_ceiling 600
    comment Modification parameters
    positive formant_shift_ratio 1.2
    positive new_pitch_median 0.0 (= no change)
    positive pitch_range_factor 1.0 (= no change)
    positive duration_factor 1.0
endform

# Create a list of files in the input directory
list = Create Strings as file list: "list", inputdir$ + "*.wav"
n = Get number of strings
printline Found 'n' files to process

# Array to store sound IDs
sound_ids# = zero# (n)

# Loop through each file to read them
for i from 1 to n
    selectObject: list
    filename$ = Get string: i
    fullpath$ = inputdir$ + filename$
    sound_ids#[i] = Read from file: fullpath$
    printline Read file: 'filename$'
endfor

# Select all loaded sound objects using their IDs
selectObject: sound_ids#[1]
for i from 2 to n
    plusObject: sound_ids#[i]
endfor

# Concatenate the sounds with a recoverable TextGrid
Concatenate recoverably
printline Created concatenated sound with ID 'chainID'

# Apply ChangeGender function
selectObject: "Sound chain"
changeGenderID = Change gender: pitch_floor, pitch_ceiling, formant_shift_ratio, new_pitch_median, pitch_range_factor, duration_factor
printline Applied change gender effect

# Un-concatenate
selectObject: "TextGrid chain", "Sound chain_changeGender"
Extract all intervals: 1, 1
printline Extracted intervals

# Get the number of extracted sounds and store their IDs
numberOfExtractedSounds = numberOfSelected("Sound")
printline Number of extracted sounds: 'numberOfExtractedSounds'

extractedSoundIDs# = zero#(numberOfExtractedSounds)
for i from 1 to numberOfExtractedSounds
    extractedSoundIDs#[i] = selected("Sound", i)
    printline Found extracted sound ID: 'extractedSoundIDs#[i]'
endfor

# Clean up intermediate objects
selectObject: "Strings list"
Remove
selectObject: "Sound chain", "Sound chain_changeGender", "TextGrid chain"
Remove
printline Removed intermediate objects

# Now select and save each extracted sound using their stored IDs
for i from 1 to numberOfExtractedSounds
    id = extractedSoundIDs#[i]
    selectObject: id
    soundName$ = selected$("Sound")
    filePath$ = outputdir$ + soundName$ + ".wav"
    Save as WAV file: filePath$
    printline Saved 'soundName$' to 'filePath$'
endfor

select all
Remove
printline All processing complete - 'numberOfExtractedSounds' files saved to 'outputdir$'
