Automated crossdating with a modified version of the dendrochronology program CROS

Michael O. Schwartz  2014

All modern crossdating programs have a graphical user interface and cannot be used for automatic crossdating without modification. The source code of these program is not open-access and, therefore, cannot be modified for an automatic procedure. The legacy CROS program written in FORTRAN IV (Baillie and Pilcher 1973) contains algorithms or variants of these that have been incorporated into modern programs with a graphical interface (TSAP-Win and CDendro 9.5). The new CROS25.f90 code written in FOTRAN 2018, is a modified version of the CROS program and is designed for automated crossdating without manual keystroke input. The user trying to crossmatch an undated tree with a large regional set of dated series faces a cumbersome task: the user must manually repeat the input for each new run with an individual undated series even though the regional set of dated master series is identical to that of the previous run. In the automated procedure, the regional set of dated series file names is input only once, and it is used in all the following automated runs with a new undated series. This saves much time compared with manual keystroke commands.
	The CROS25.f90 source code (FORTRAN standard 2018) is compiled to programs named CROS25, CROS25gfor and CROS25linux using the Intel Fortran compiler 2011 for MacOS, gfortran 14.2 (2024) compiler for MacOS and the Intel Fortran compiler 2011 for Linux, respectively. The executables run on any MacOS (App Store download) and Linux 2024 operation system or virtual machine. The original Hollerith input is replaced by the TRIMS format file (*.rw) input. The TRIMS format files are conveniently produced with the TRICYLE program (Brewer et al. 2011). 
The various versions of the Tuscon chronology format (*.crn) in the International Tree Ring Database (ITRDB; https://www.ncdc.noaa.gov) are converted with TRICYLE into the TRIMS format (*.rw). In few cases, the ITRDB contains chronologies, in addition to individual tree-ring series (*.rwl). For the other cases, the individual tree-ring series files (*.rwl) are converted into chronologies (*.crn) via the external program CRONOL (Holmes 1999) or CDendro (Cybis 2020). The TRIMS format has a single column. The first and second records are irrelevant. The third record is the inner year. The fourth to second-last records are the tree-ring widths. The last record is irrelevant.
	The output of the individual crossdating consists of a header line followed by a line for each above threshold t-value. For matches below the t-value threshold of 3.5, only the header line is saved. The complete set of results is saved in a combined output file.
	The the single-column inputfile has the file name of the undated tree, followed by the file names of the dated trees, and ends with "STOP". The program, the inputfile and the chronology files are located in the current directory. The program is executed in the terminal with the command "./CROS25 < inputfile".
	There are two programs with a graphical interface that use the CROS algorithms or variants of thees (TSAP-Win and CDendro 9.5). These programs yield results that are similar to those of the CROS25 program. 


References

Baillie, M.G.L., Pilcher, J.R., 1973. A simple crossdating program for tree-ring research. Tree-Ring Bulletin 33, 7-14.
Brewer, P., Murphy, D., Jansma, E., 2011. TRiCYCLE: A universal conversion tool for digital tree-ring data. Tree-Ring Research 67:135-144.
Cybis, 2020. CDendro 9.5. http://www.cybis.se
Holmes, R.L., 1999. Users manual for program CRONOL. https://www.ldeo.columbia.edu/tree-ring-laboratory/resources/software.
RINNTECH, 2011. TSAP-WinTM time series analysis and presentation for dendrochronology and related applications Version 4.6.4 for Microsoft Windows - user reference. www.rinntech.de
![image](https://github.com/user-attachments/assets/0dfa3f4d-4e89-4e1d-9ea1-51d5a587bb63)

Automated crossdating with the dendrochronology program COFECHA

Michael O. Schwartz  2024

The widely used open-access COFECHA program requires manual keyboard input to crossmatch an undated tree-ring series with a dated master series. The COFECHA program, like its commercial alternatives, has no option to execute a sequence of runs with the exclusive input from a file. The user trying to crossmatch a set of undated tree-ring series with a large regional set of dated series faces a cumbersome task: the user must manually repeat the input for each new run with an individual undated series even though the regional set of dated master series is identical to that of the previous run. Unlike its commercial counterparts, the COFECHA program lends itself to running from an external script file. The most convenient script is a Windows AutoHotkey script such as the cofecha1.ahk script with 54 dated trees. Using a text editor, the regional set of dated series file names is input only once, and it is used in all the following automated runs with a new undated series. This saves much time compared with manual keystroke commands.


