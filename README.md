# MaxEntropySPT
Generate Maximum Entropy wave spectrum from Datawell SPT files

This Matlab package uses a semi-analytic method to calculate the maximum entropy directional spectra from Datawell SPT files.  For further information, see "Description.txt".

In Matlab, run the script "ConvertSPTFiles.m".  You will be given options to select individual SPT file(s) (i.e. single or multiple files in a given directory) or a whole directory.  You also choose a location to save the output files.  The files are then read, 2D spectra calcuated and saved.

The UserSettings.m file allows the user to change the directional discretisation and accuracy, and has options for storing information about the frequency and directional bins in separate files.
