
form Change gender
    sentence inputdir C:/Users
    sentence outputdir C:/Users
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
list = Create Strings as file list: "list", "'inputdir$'*wav"
n = Get number of strings

#loop through the files
for i to n
	selectObject: list
	filename$ = Get string: i
	fileID = Read from file: "'inputdir$'" + filename$
	og_name$ = selected$ ("Sound")
	Change gender: pitch_floor, pitch_ceiling, formant_shift_ratio, new_pitch_median, pitch_range_factor, duration_factor
	removeObject: fileID
	#if you want to keep the newly generated names, make the next line in use and do not use og_name$
	#new_name$ = selected$ ("Sound")
	Save as WAV file: "'outputdir$'/'og_name$'.wav"
endfor
removeObject: list
