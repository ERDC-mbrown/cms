## Coastal Modeling System (CMS)

CMS is a coastal modeling system that couples a wave, circulation, and morphology model together to 
get better predictions in the near-shore

CMS is developed by the USACE - Coastal and Hydraulics Laboratory


To build CMS On linux you must have CMAKE software above 3.4
1) `cd trunk/source`

2) `cmake .`

3) `make`

This will leave you with an executable named 'cms' in your local working directory 

To clean all of the intermediate files and old executable, type 'make clean' from the 
"trunk/source" directory.
