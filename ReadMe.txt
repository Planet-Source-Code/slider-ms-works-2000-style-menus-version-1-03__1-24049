v1.0.3 MS Works 2000 style menus
================================

Replicates MS Works 2000 horizontal and vertical menus. Displaying Disabled Items, Hover Items (Hot Tracking - v1.01), ToolTips (v1.02), Graduated Selection/HiLite (v1.03), Seperator Lines, etc all configurable.

Demonstration application included to demonstrate all the features of the controls. 

Please vote for this project & happy coding!



:::::::::::::::::::::
::NOTE TO PSC USERS::
:::::::::::::::::::::

PSC doesn't allow binary OCX or EXE files to be uploaded. Therefore to make this project work, the following steps are required:
1. Compile the prjMenu.vbp project. This will create the prjMenu.ocx you will need later.
2. Create a new empty project, import the prjMenu.ocx file. Save the project. Now open the .vbp file (from the empty project) in a text editor (i.e. Notepad). The file contains a line which says..	"Object={<somenumbers>}#3.0#0; prjMenu.ocx"
3. Copy this line (Ctrl+C). Now open the prjTestMenu.vbp file in a text editor and replace the line which says..	"Object={<somenumbers>}#3.0#0; prjMenu.ocx" with the line you have in the clipboard right now (Ctrl+V). 
If you have compiled the project and still can't get it to work start from scratch and try again because this is the way I did it to make it work. [courtesy of Fredrick Qvarfort ;)]



Revision Notes:-
================

v1.0.1 30/05/01    
---------------    
Added: MouseEnter and MouseLeave Events;    
Fixed: ShowHover Property did not Enable/Disable correctly (Thanks Thushan Fernando);    
Fixed: HoverItem not reset when mouse is moved too quickly;    
Fixed: HoverItem Event not generated for disabled MenuItems;    
Fixed: MenuItem object only returned the SelectedItem instead of the requested Index Pointer from the collection.    

v1.0.2  7/06/01    
---------------    
Added: ToolTip support

v1.0.2a 8/06/01    
---------------    
Fixed: ucHMenu gets lost in an endless loop if no MenuItems are created. Problem does not exist for ucVMenu. (Thanks Dave Buckner)    
Fixed: ucVMenu [HoverItem] encounters problems if no Menu Items exist (Thanks Dave Buckner for finding and fixing)    
Fixed: ucVMenu & ucHMenu Hover mode still worked even when disabled    
Fixed: Tooltips constantly redrew which caused flickekering    

v1.0.3 13/06/01    
---------------    
Added: Horizontal & Vertical (including the standard Flat/Normal) graduated selection Hilite    