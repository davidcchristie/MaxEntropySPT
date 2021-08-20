# MaxEntropySPT
Generate Maximum Entropy wave spectrum from Datawell SPT files

This Matlab package uses a semi-analytic method to calculate the maximum entropy directional spectra from Datawell SPT files.  For further information, see "Description.txt".

In Matlab, run the script "ConvertSPTFiles.m".  You will be given options to select individual SPT file(s) (i.e. single or multiple files in a given directory) or a whole directory.  You also choose a location to save the output files.  The files are then read, 2D spectra calcuated and saved as ascii.

The UserSettings.m file allows the user to change the directional discretisation and accuracy, and has options for storing information about the frequency and directional bins in separate files.

Also included is ExtractZip, which just allows you to extract zipped directories easily from within Matlab (handy for downloaded spectral files).

David Christie acknowledges the support of SEEC (Smart Efficient Energy Centre) at Bangor University, part-funded by the European Regional Development Fund (ERDF), administered by the Welsh Government.

Cite as:
David Christie (2020) MaxEntropySPT 
