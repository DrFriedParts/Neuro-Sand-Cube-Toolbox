Neuro-Sand-Cube-Toolbox
=======================

Matlab toolbox for parsing and processing NSC log files.

Add to Matlab path, or use from its downloaded location.

1. Reads and parses NSC json log file format.
2. Outputs result as a MatLab cell array.
3. Writes result to a ```.MAT``` file for future reloading.

Parsing proceeds at a rate of about 20k bytes per second, so large logs could potentially take a few minutes to convert. Once you have converted a log file, you do not have to reconvert it to reuse it in the future. Just do a ```load('filename.MAT')``` instead.

## Quick start / example

```matlab
loadNSC('example.json');
```

