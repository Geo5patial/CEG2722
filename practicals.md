# CEG2722 PRACTICAL 5 (Working in Linux)

By default the Linux terminal executes commands in your home directory. We created a script which will copy all the data you need for all the practicals (1-6). After login to your account run the following command lines.
```bash
wget https://raw.githubusercontent.com/koulali/CEG2722/gh-pages/startup/make_ceg2722.sh
chmod +x make_ceg2722.sh
./make_ceg2722.sh
```

## Navigating the Linux filesystem and using wildcards to assemble a GNSS dataset

***Question 1.1***

*what contents are visible here when you first log on?*  

```bash

```

*Which are files, and which are subdirectories (use ls -F)?*  

```bash

```

*Are there any hidden files or subdirectories?*

```bash

```

The GNSS data used for the practicals is located under directories with the naming convention: `~/ceg2722/practicals/data/rinex/YYYY/DDD/`

where `YYYY` is the 4-digit year, and `DDD` is the 3-digit day of year (January 1st is 001).  Under each day, subdirectories `YYd`, `YYg`, `YYm` and `YYn` contain the observation, GLONASS orbit, meteorological and GPS orbit data files respectively, where `YY` is the 2-digit year.  

**Question 1.2**

*in what directory would you find data from the for 1st February 2014, and what is in its subdirectories?*

```bash

```

Change the directory to ~/ceg2722/, then create a directory with the name `qc`, then copy all the data for site `nslg` (in the `rinex` directory) for February 1st - 7th, 2014.

**Questions 1.3** 

*how would you do this using only wildcards and bracketed ranges?*  

```bash

```

**Questions 1.4** 

*Would it be more or less efficient and robust to use brace expansion?* 

```bash

```

**Questions 1.5** 

Change directory to ./qc/ 

*Roughly how large are the files?*

```bash

```

Now, you will next need to **uncompress** all the files with `gunzip`. For the observation (`.YYd`) files, a further RINEX-specific uncompaction step is needed using the utility `crx2rnx` which must be invoked for each file individually (i.e. not using wildcards; later we will learn about a more efficient way of doing this).  You should now have a set of normal RINEX observation (*.YYo) files. 

**Question 1.6**

*How much larger are the files now that they are uncompressed?*

```bash

```

Using less, take a look at one file of each type.

```bash

```

**Question 1.7**

Using `egrep`, check that all the **observation** files have:	

* line containing the word **ANTENNA** and the correct antenna height of zero;

  ```bash
  
  ```

* a line containing the word **REC** and the correct receiver type of Trimble NetR8;

  ```bash
  
  ```

* a line containing the word **ANT** and the correct antenna type of TRM59800.00 SCIS.

  ```bash
  
  ```

  

## GNSS data QC with `teqc`

The `teqc` program produced by [unavco](http://www.unavco.org/software/data-processing/teqc/teqc.html) performs translation (from raw binary format to the worldwide-standard RINEX format), editing (of metadata) and quality checking of GNSS data.  Today we will use it for the latter.  This is the kind of task that is automated by many servers providing GNSS data, although it is well worth repeating with your own dataset before processing.

To invoke `teqc` in QC mode for just one observation file, execute:

```bash
teqc +qcq +quiet obsfilename
```

`teqc` will automatically look for the correspondingly named GPS and GLONASS orbit files, and will produce a fairly detailed report to stdout.  It’s worth a look throughout, but the most important information is summarised in the line beginning **SUM**  at/near the end.  Included in this are the start/end time, the expected and actual number of observations, the `RMS` of the `mp1` and `mp2` estimates of pseudorange multipath affecting each frequency, and the average number of observations between each carrier phase cycle slip.

**Question 2.1 **: 

In your `~/ceg2722/qc/` directory, use for, `egrep` and perhaps other commands such as `sed` to carry out this QC on all of your **nslg**  observation files (from Q.1) and generate a “summary of summaries” file just containing the SUM lines of the individual reports (in correct time order, but with the word SUM deleted leaving just the statistics).

*Show the commands used, and this summary file.*

```bash

```

*Are there any days where the data quality might be suspect?*

## Computing positions with `teqc`

`teqc` can compute approximate positions for each epoch of data in a file, using the pseudorange observations and broadcast ephemeris:

```bash
teqc +qcq +quiet +eepx obsfilename
```

It will automatically look for the (GPS and/or GLONASS) orbit files corresponding to the observation file, in the same directory.  Instead of the QC report, lines are output to stdout consisting of the epoch (year, month, day, hour, minute, second) followed by the instantaneous X, Y and Z coordinates (in metres).

**Question 3.1 : **

*Using the same GNSS dataset as before, compute the positions of NSLG throughout 1st-7th February 2014, saving the output in a single file in your `~/ceg2722/qc/` directory  ( show the commands used, and the first five lines of this output file).*

```bash

```

## Extracting information from GIPSY output

Datasets containing many files often need to be grouped into a single file (like a zipfile on Windows but more flexible) for easy transfer between locations (e.g. sending by email, or upload to a cloud computing resource).  This is usually done using the tar (tape archive) utility, whose name dates back to the days before the Internet when data had to be streamed to/from a magnetic tape for transfer or backup.  The syntax is:

```bash
tar command-option [options] [files]
```

where *command-option* is most often -c (for create), -x (for extract) or -t (for list), or occasionally -A (for Append). *files* normally consists of *relative* pathnames, so that the contents of the archive can be extracted to a new location.  If any of files is a subdirectory, then tar acts recursively on its contents, e.g.

```bash
tar c -v -z -f myfiles.tgz ./morpdata/ readme.txt
```

which archives the contents of subdirectory ./morpdata/ (the leading ./ and trailing / are optional, but increase clarity) and the file readme.txt. The -z option invokes gzip / gunzip compression of the archive to save space, hence the .tgz file extension (sometimes .tar.gz is written instead), and -v sends verbose progress messages to stderr.

Unpacking a tarfile follows a similar syntax, e.g. for a normal (uncompressed) tarfile:

```bash
tar -x -v -f myfiles.tar thisfile
```

In the above example, only the file thisfile will be extracted (if indeed it exists in the myfiles.tar archive).  If no file were specified, the entire archive would be unpacked.

**Question 4.1**

Create a subdirectory `~/ceg2722/gipsy-output/` (the `~` without a username refers to *your* home directory) and extract the contents of the tarfile `~/ceg2722/data/nslg_feb2014_tdp.tgz` there.  It contains a number of output TDP (time dependent parameter) files from the GIPSY scientific GPS processing software for site NSLG (at the North Shields tide gauge).  

*How many files are there, and how many lines in each?*

```bash

```

**Question 4.2**

Take a look at one of the files with `micro` (text editor) or less. The time (in seconds since noon on January 1st 2000) is given in the first column, the nominal value of each parameter in the second, the actual estimated value and its confidence limit in the third and fourth, and the parameter description in the final column(s).  

*How many lines containing “**WETZTROP**” are there in each file?*

```bash

```

**Question 4.3**

Using a combination of `egrep`, `cut` and `paste` statements (and perhaps others), extract a time series of the X, Y and Z coordinates of NSLG (parameters STA X, STA Y, STA Z, given in km) in a single output file spanning February 1st-8th. Your output file should be formatted something like:

​	Time  X Xerr   Y Yerr   Z Zerr

*How many lines are there in this file?*

 ```bash

 ```

Building up a command sequence to do this is best done in stages, testing each step as you go (perhaps on just one TDP file, and using head to see only the top few lines of the result).  

## Comparing your teqc and GIPSY positions

The GIPSY dataset that you processed in Q.2 includes overlapping epochs to the teqc dataset, and can be assumed to be far more accurate.  Using a combination of bash commands and `awk` one-liners (or longer `awk` scripts), compute the difference (teqc minus GIPSY) in each of the X, Y and Z coordinates, for every epoch that is common to the two datasets.  Your output file should be of the form:	

​	time dX dY dZ

where time is in seconds since the start of February 1st, 2014, and dX, dY, dZ are the instantaneous coordinate differences in metres (be careful of units!).  Ensure that columns are appropriately aligned for readability.  Some useful information:  the GIPSY timetags are in the J2000 system, i.e. time in seconds since noon on January 1st, 2000.  In the J2000 system, 00:00:00 on February 1st 2014 is 444484800 s. 

**Question 5.1**

*Show the commands used, and the coordinate differences for the first five common epochs.*

```bash

```

**Question 5.2**

Now, with another short `awk` script or one-liner, compute the mean and root-mean-square of the dX, dY, dZ coordinate differences.  

*Show the commands used, and these statistics (to a suitable level of precision), for each of dX, dY, dZ.*

```bash

```

## Investigating a change in the `teqc` settings

By default, `teqc` will process all available data (GPS+GLONASS in the case of site NSLG), whereas GIPSY will only process GPS data.  

**Question 6.1**

Investigate the hypothesis that this is the cause of the coordinate differences that you observed in Q5, by repeating Q3 and Q5 but including the -R (switch off Russian satellites) option in the teqc positioning (*N.B the option -R should be placed just before the filename*).  

*Question: as for Q3 and Q5*

```bash

```







