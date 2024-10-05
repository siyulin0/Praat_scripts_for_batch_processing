###################################################
#
#
# Add silence at the end of a sound file for all files in a folder 
# 
# updated 10/04/2024 SL
# 
####################################################


form Set directories for input and output and duration of silence
    sentence inputdir C:/Users/
    sentence outputdir C:/Users/
    positive duration_of_silence # Duration of silence (in seconds)
endform

# Create a list of files in the input directory
list = Create Strings as file list: "list", "'inputdir$'*wav"
n = Get number of strings

# Loop through the files
for i to n
    selectObject: list
    filename$ = Get string: i
    fileID = Read from file: "'inputdir$'" + filename$
    og_name$ = selected$ ("Sound")
    mySound = selected ("Sound")
    
    # Create a silence sound of the specified duration
    mySilence = Create Sound from formula... silence 1 0 duration_of_silence 44100 0
    
    # Concatenate the silence at the beginning by selecting silence first
    select mySound
    plus mySilence
    Concatenate

    # Save the new sound with the original name in the output directory
    Save as WAV file: "'outputdir$'/'og_name$'.wav"
    Remove
endfor

removeObject: list
