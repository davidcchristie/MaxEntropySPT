# MaxEntropySPT
Generate Maximum Entropy wave spectrum from Datawell SPT files

This Matlab package uses a semi-analytic method to calculate the maximum entropy directional spectra from Datawell SPT files.  For further information, see "Description.txt".

In Matlab, run the script "ConvertSPTFiles.m".  You will be given options to select individual SPT file(s) (i.e. single or multiple files in a given directory) or a whole directory.  You also choose a location to save the output files.  The files are then read, 2D spectra calcuated and saved as ascii.  The units of the 2D spectrum will be "[XXX] per radian" where "[XXX]" corresponds to the units of the monochromatic spectrum.

The UserSettings.m file allows the user to change the directional discretisation and accuracy, and has options for storing information about the frequency and directional bins in separate files.

Also included is ExtractZip.m, which just allows you to extract zipped directories easily from within Matlab (handy for downloaded spectral files).  

David Christie acknowledges the support of SEEC (Smart Efficient Energy Centre) at Bangor University, part-funded by the European Regional Development Fund (ERDF), administered by the Welsh Government.

For more information, please email david.christie[*AT*]manchester.ac.uk

Cite as:
David C. Christie,
Efficient estimation of directional wave buoy spectra using a reformulated Maximum Shannon Entropy Method: Analysis and comparisons for coastal wave datasets,
Applied Ocean Research,
Volume 142,
2024,
103830,
ISSN 0141-1187,
https://doi.org/10.1016/j.apor.2023.103830

for the method or 

David Christie (2022) MaxEntropySPT 
with the github link for the code.
