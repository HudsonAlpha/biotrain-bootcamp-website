# 2026 HudsonAlpha BioTrain Computational Biology Bootcamp
![2025 Bootcamp Photo](IMG_0527.jpg)

## Info 

**Webpage Updates**
- 05/23/2026: Updated Intro Slides
- 05/19/2026: Ashlyn added new demos
- 05/06/2026: Deployed website for 2025.
- Changes from last year: New hands-on demos - no longer using data carpentry

**Logistics**: The Bootcamp is Wednesday, May 27 from 8 am - 12:30 pm and on Thursday, May 28 from 8 am - 12:30 pm. (two half-days) in the Chan Auditorium on the second floor of the Paul Propst Center (800 Hudson Way).

**Objective/Rationale:** This two day workshop is intended to provide HudsonAlpha BioTrain interns and graduate rotation students an introduction to computational biology through a discussion on why computers are necessary in genomics, short unix shell and R tutorials followed by hands-on exercises, and tips on how to ask for help, keeping a computational lab notebook, and finding additional learning resources.

**Prerequisites**:
- Curiosity about computational biology and a basic understanding of the ideas of files and directories (folders).
- Access to a laptop (talk to Michele if you need to borrow one).
- Ability to use your favorite web browser to download and install the necessary software and data (see below).

**Presenters:**
- [Stephanie Felker](mailto:sfelker@hudsonalpha.org) (she/her), Post-Doc in the Rick Myers Lab HudsonAlpha
- [Ashlyn Anderson](mailto:aanderson@hudsonalpha.org), (she/her) PhD Student in the Nick Cochran Lab at HudsonAlpha

**Course Development**
Course content adapted from 2018 Bootcamp organized by [Brittany Lasseigene, PhD](https://www.lasseigne.org), Assistant Professor at the [University of Alabama in Birmingham](https://www.uab.edu/home/)

##  Wednesday, May 27, 2026:

**8:00am - 8:15am**: Computer set-up.

### Setup
[Detailed Windows Setup Instructions](#detailed-windows-setup-instructions)

[Mac: Changing your shell to bash](#setting-up-bash-shell-on-mac)

We will be generating data and folders in the workshop

Please ensure you have the following software and data on the computer you intend to use during the workshop:
1. Make sure you have access to a Bash shell: use [Git BASH](https://gitforwindows.org/) for Windows; Terminal is the built-in program for Mac, however we will need to change the shell by running the command `bash`
2. Install:
  * a) [R Programming Language](https://cloud.r-project.org/)
  * b) [RStudio Desktop](https://www.rstudio.com/products/rstudio/download/#download)
3. Using the bash shell, we will make data to experiment with and complete the modules with


**8:15am - 9:15am**: Bootcamp Introduction & An Introduction to Biology with Computers
(slides: [Biotrain-2026-Intro-Comp-Bio.pptx](Biotrain-2026-Intro-Comp-Bio.pptx))  
*Stephanie Felker*


**9:15am - 9:30am**: Break


**9:30 - 11:00am**: Hands-on Bioinformatics training
*Stephanie Felker*
* [UCSC Genome Browser](http://genome.ucsc.edu)
* [UniProt](https://www.uniprot.org)
* [ClinVar](https://www.ncbi.nlm.nih.gov/clinvar)
* [Phytozome](https://phytozome-next.jgi.doe.gov/)
* [EBI Link to Tools](https://www.ebi.ac.uk/services/data-resources-and-tools)


**11:15am - 11:30am**: Break


**11:30am - 12:15pm**: Working in the Terminal Keeping a Computational Lab Notebook 
*Stephanie Felker*
Maybe some R, if we have time

**12:15pm**: End of Day 1


##  Thursday, May 28, 2025:
**8:00 - 8:30**: Finish up work from Wednesday, R Review

**8:30am - 9:15am**: GWAS Demo
directory: [GWAS Demo](./Demos/GWAS)  *Ashlyn Anderson or Stephanie Felker*

**9:15am - 10:00am**: Single Cell Demo
directory: [Single Cell Demo](./Demos/single%20cell)  *Ashlyn Anderson*

**10:00am - 10:15am**: Break

**10:15am - 11:00am**: Dot Plot Demo
directory: [Dot Plot Demo](./Demos/dotplot)  *LaramieL Aközbek*

**11:00am - 11:45am**: Something Else Demo
directory: [Something Demo](./Demos/)  *Renan Souza*

**11:45-12:15**: Wrap up, time buffer


##  Other Resources:
Check these shell lessons out if you:
* want to combine existing shell commands: [Pipes and Filters](https://swcarpentry.github.io/shell-novice/04-pipefilter.html)
* perform the same action on many files in the shell: [Loops](https://swcarpentry.github.io/shell-novice/05-loop.html)
* need to save and reuse shell commands: [Shell Scripts](https://swcarpentry.github.io/shell-novice/06-script.html)


Check these R lessons out if you:
* [want to practice more R programming with the inflammation data set used during bootcamp](http://swcarpentry.github.io/r-novice-inflammation/)
* [are interested in R programming lessons for reproducible scientific analysis](https://datacarpentry.org/lessons/)

Other useful resources:
* [Codeacademy: Learn the Command Line](https://www.codecademy.com/learn/learn-the-command-line)
* [LinuxCommand.org](http://linuxcommand.org)
* [Coursera: Unix Workbench](https://www.coursera.org/learn/unix)
* [DataCamp: Introduction to R](https://www.datacamp.com/courses/free-introduction-to-r)
* [ExplainShell.com](https://explainshell.com/) - Breaks down and explains shell commands you enter
* [Hitchhiker's Guide to Python](https://docs.python-guide.org/)
* [Regular Expression Tester & Debugger](https://regex101.com/)
* [R for Data Science](https://r4ds.had.co.nz/)
* [The BioStar Handbook](https://www.biostarhandbook.com/)
* [Book: Bioinformatics Data Skills](http://shop.oreilly.com/product/0636920030157.do)
* [EBI Next-Generation Sequencing Practical Course](https://www.ebi.ac.uk/training/online/course/ebi-next-generation-sequencing-practical-course)


### Windows-Specific Tips & Gotchas
* Copy & Paste:
  * On windows, you are used to `ctrl+c` and `ctrl+v` to copy and paste. This will not work in Git-Bash window because `ctrl+c` and `ctrl+v` have different meanings in Unix
  * To copy:
    * Select text in the git-bash window with the mouse, and it will automatically be copied
    * Or, use the right-click menu
    * Use `ctrl+insert` (some laptops may not have this as a separate key)
  * To paste:
    * Click with the middle mouse button
    * Or, use the right-click menu
    * Use shift+insert (some laptops may not have this as a separate key)
* Git-Bash represents Windows-style paths (with backslashes, `\`), like `C:\Users\James`, in the Unix style (with forward slashes, `/`), like `/c/Users/James`
* The `ls` command should work on Git-Bash, but if not, use `dir`


### Detailed-Windows-Setup-Instructions
1. We will be installing the most recent versions of all the software listed. Most likely, the exact version numbers won't be important, but version numbers from May 2025 are listed below for clarity. Most versions of Windows will ask "do you want to allow this program to make changes to your computer" when you're installing software. We will use default options on the install wizards.
2. Download the [Git for Windows](https://gitforwindows.org/) installer (version 2.49.0). The download link should automatically choose the right installer for your version of Windows. Navigate to your Downloads folder and run the installer.
3. Git 2.45.1 Setup: Use the default options in the "Select Components" screen and "Select Start Menu Folder". Use the default options in the following several screens. *You may want to check "Additional Icons -> On the Desktop" to easily find this later.*
4. Install R: [R Programming Language](https://cloud.r-project.org/). Click links for "Download R for Windows" and then "install R for the first time" and then the "Download R 4.5.0 for Windows" link to download the file. Navigate to your Downloads folder and run the installer. You will need to allow the installer to make changes to your computer, and you do not need to change any of the default installation options.
5. Install RStudio: [RStudio Desktop](https://www.rstudio.com/products/rstudio/download/#download). Choose the download link "Download RStudio For Windows". (This should work on Windows systems from the past several years.)
6. Use the Start Menu or Desktop icon to open Git Bash
7. Download the course data during the walk-through.

### Setting up Bash Shell on Mac
1. A few years ago, MacOS changed the default shell to `zsh` instead of `bash`. The two are similar, but for clarity we will use bash.
2. Open the Terminal app
3. At the prompt, type `bash` and hit enter. Make sure to do this every time you open the terminal. 
4. If you want to change your default shell to bash, so that you don't have to type the bash command every time you use terminal, follow steps 5-8.
5. At the prompt, type `chsh -s /bin/bash` and hit enter. You should see "changing shell for <username>"
6. You will be asked to enter your password, then hit enter. If there are no errors, you will be back at the prompt.
7. Close Terminal and then re-open. You should see in the title bar of the window that it says "Terminal -- -bash"
8. **Note**: This change will persist for your user profile. If you want to change it back after the bootcamp, you will use the command `chsh -s /bin/zsh`
9. Download the course data during the walk-through.

### Setting up R and RStudio on MacOS
1. Click on the Mac icon at the top left of your menu bar and choose "About this Mac". Under "Processor" look for whether it says Intel or Silicon (M1-M3).  Then close the window.
**Macbooks model years <= 2019:** Intel processor
**Macbooks model years 2020-2021**: Either Intel or Silicon M1-M3 processor 
**Macbook model years >= 2025**: ARM M1-M3 processor
2. Go to the Apple menu and select "About this mac" and look under Processor. Note whether you have an Intel process or an M1-M3 (ARM) processor. 
3. Go to [R Programming Language](https://cloud.r-project.org/) and select "Download R for MacOS". Choose the first option `R-4.5.0-arm64.pkg ` if you have a Silicon (M1-M3) processor. Choose the second option `R-4.5.0-x86_64.pkg`if you have an older Intel processor. 
3. Open the pkg file from your Downloads folder and click through the installation wizard with default options. You may need to enter your password.
4. Go to [RStudio Desktop](https://www.rstudio.com/products/rstudio/download/#download). Click "Download RStudio for Mac".
5. Open the pkg file. You will see a window open up with an RStudio icon which you will drag into the applications folder.
6. Use the launchpad to open Rstudio. You may see a notification that Rstudio was downloaded from the internet. If so, click "open".

