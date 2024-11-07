###################################################
#
#
# Add silence at the beginning of a sound file for all files in a folder 
# 
# updated 11/06/2024 SL
# 
####################################################


form Add silence at the beginning
    sentence inputdir C:/Users/
    sentence outputdir C:/Users/
    positive duration_of_silence # Duration of silence (in seconds)
endform

# Create a 100ms silence
mySilence = Create Sound from formula... 100ms_silence 1 0 duration_of_silence 44100 0


# Create a list of files in the input directory
list = Create Strings as file list: "list", "'inputdir$'*wav"
n = Get number of strings

# Loop through the files
for i to n
	selectObject: list
	filename$ = Get string: i
	fileID = Read from file: "'inputdir$'" + filename$
	og_name$ = selected$ ("Sound")
	plus mySilence
	Concatenate

	# Here I tend to keep the old names
	#new_name$ = selected$ ("Sound")
	Save as WAV file: "'outputdir$'/'og_name$'.wav"
	Remove
endfor

removeObject: list