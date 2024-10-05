###################################################
#
#
# Get the total duration of a sound file for all files in a folder 
# 
# updated 10/04/2024 SL
# 
####################################################


form Input Enter directory and output file name
    sentence outFile total_durations.txt
    sentence dirName C:/Users/
endform

# NB: if the named output file exists, it will be overwritten

outLine$ = "sound" + tab$ + "total_duration" + newline$
outLine$ > 'dirName$''outFile$'

Create Strings as file list... fileList 'dirName$'*.wav
nFiles = Get number of strings

for i to nFiles
    # Read in sound file
    select Strings fileList
    fileName$ = Get string... i
    Read from file... 'dirName$''fileName$'
    soundName$ = selected$ ("Sound")

    # Get the total duration of the sound file
    totalDuration = Get total duration

    # Output the total duration for the current file, preserving 6 decimal places
    outLine$ = soundName$ + tab$ + "'totalDuration:4'" + newline$
    outLine$ >> 'dirName$''outFile$'


    # Clean up
    
    select Sound 'soundName$'
    
    Remove

endfor

# Clean up
select Strings fileList
Remove
